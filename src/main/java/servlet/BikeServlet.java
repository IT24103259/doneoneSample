package servlet;

import model.Bike;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/bike")
public class BikeServlet extends HttpServlet {
    private static final String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/bikes.txt";

    // 🧾 Load all bikes
    public static List<Bike> loadBikes(String filePath) {
        List<Bike> bikeList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 4) {
                    String id = parts[0];
                    String name = parts[1];
                    double price = Double.parseDouble(parts[2]);
                    String availability = parts[3];
                    bikeList.add(new Bike(id, name, price, availability));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bikeList;
    }

    // 🟨 Handle Add + Edit
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bikeId = request.getParameter("bikeId");
        String bikeName = request.getParameter("bikeName");
        double price = Double.parseDouble(request.getParameter("price"));
        String availability = request.getParameter("availability");
        boolean isEdit = Boolean.parseBoolean(request.getParameter("editMode"));

        Bike updatedBike = new Bike(bikeId, bikeName, price, availability);
        List<Bike> bikeList = loadBikes(FILE_PATH);
        List<Bike> updatedList = new ArrayList<>();

        if (isEdit) {
            // 🛠 Update mode
            for (Bike b : bikeList) {
                if (b.getBikeId().equals(bikeId)) {
                    updatedList.add(updatedBike);
                } else {
                    updatedList.add(b);
                }
            }
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
                for (Bike b : updatedList) {
                    writer.write(b.toString());
                    writer.newLine();
                }
            }
        } else {
            // ➕ Add mode
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(updatedBike.toString());
                writer.newLine();
            }
        }

        response.sendRedirect("bike.jsp");
    }

    // ❌ Delete bike
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String bikeId = request.getParameter("id");

        if ("delete".equalsIgnoreCase(action) && bikeId != null) {
            List<Bike> allBikes = loadBikes(FILE_PATH);
            List<Bike> updatedList = new ArrayList<>();

            for (Bike b : allBikes) {
                if (!b.getBikeId().equals(bikeId)) {
                    updatedList.add(b);
                }
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
                for (Bike b : updatedList) {
                    writer.write(b.toString());
                    writer.newLine();
                }
            }
        }

        response.sendRedirect("bike.jsp");
    }
}
