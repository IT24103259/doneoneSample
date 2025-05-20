package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/driver")
public class DriverServlet extends HttpServlet {
    private static final String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/custom_rides.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rideEmail = request.getParameter("email");
        String rideDate = request.getParameter("rideDate");
        String driverName = (String) request.getSession().getAttribute("username");

        if (rideEmail == null || rideDate == null || driverName == null) {
            response.sendRedirect("driver_rides.jsp");
            return;
        }

        List<String> updatedRides = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", -1);
                if (parts.length == 7 && parts[1].equals(rideEmail) && parts[4].equals(rideDate)) {
                    // append driver name
                    line += "," + driverName;
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

        response.sendRedirect("driver_rides.jsp");
    }
}
