package servlet;

import model.Ride;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/ride")
public class RideServlet extends HttpServlet {
    private static final String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/custom_rides.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteRide(request, response);
        } else if ("edit".equals(action)) {
            String rideDate = request.getParameter("rideDate");
            HttpSession session = request.getSession();
            session.setAttribute("editRideDate", rideDate);
            response.sendRedirect("ride.jsp");
        } else {
            saveRide(request, response);
        }
    }

    private void deleteRide(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String rideDate = request.getParameter("rideDate");
        String email = (String) request.getSession().getAttribute("email");
        String pickup = request.getParameter("pickup");
        String drop = request.getParameter("drop");

        List<String> updatedRides = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                // Match by multiple fields to ensure exact ride
                if (parts.length >= 5 &&
                        parts[1].equals(email) &&
                        parts[2].equalsIgnoreCase(pickup) &&
                        parts[3].equalsIgnoreCase(drop) &&
                        parts[4].equals(rideDate)) {
                    continue; // skip the ride to delete
                }
                updatedRides.add(line);
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (String r : updatedRides) {
                writer.write(r);
                writer.newLine();
            }
        }

        response.sendRedirect("my_rides.jsp");
    }


    private void saveRide(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String pickup = request.getParameter("pickup");
        String drop = request.getParameter("drop");
        String rideDate = request.getParameter("rideDate");
        String luggage = request.getParameter("luggage");
        String notes = request.getParameter("notes");

        Ride ride = new Ride(customerName, customerEmail, pickup, drop, rideDate, luggage, notes);

        // Check if this is an edit
        HttpSession session = request.getSession();
        String previousDate = (String) session.getAttribute("editRideDate");
        session.removeAttribute("editRideDate");

        List<String> updatedRides = new ArrayList<>();
        boolean updated = false;

        if (previousDate != null) {
            try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 5 && parts[1].equals(customerEmail) && parts[4].equals(previousDate)) {
                        updatedRides.add(ride.toString()); // replace old
                        updated = true;
                    } else {
                        updatedRides.add(line);
                    }
                }
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                for (String r : updatedRides) {
                    writer.write(r);
                    writer.newLine();
                }
            }

        } else {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(ride.toString());
                writer.newLine();
            }
        }

        response.sendRedirect("my_rides.jsp");
    }
}
