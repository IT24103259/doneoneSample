package servlet;

import model.Bike;
import model.Booking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private static final String BIKE_FILE = "C:/Users/LOQ/Desktop/done one/doneone/data/bikes.txt";
    private static final String BOOKING_FILE = "C:/Users/LOQ/Desktop/done one/doneone/data/booking_and_payment.txt";

    // ✅ Handle new booking or update
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String bikeName = request.getParameter("bikeName");
        int rentDays = Integer.parseInt(request.getParameter("days"));
        String cardName = request.getParameter("cardName");
        String cardNumber = request.getParameter("cardNumber");
        String expiry = request.getParameter("expiry");
        boolean isEdit = Boolean.parseBoolean(request.getParameter("editMode"));

        // Get price
        double pricePerDay = 0.0;
        List<Bike> bikes = BikeServlet.loadBikes(BIKE_FILE);
        for (Bike b : bikes) {
            if (b.getBikeName().equalsIgnoreCase(bikeName)) {
                pricePerDay = b.getPrice();
                break;
            }
        }

        double totalAmount = pricePerDay * rentDays;

        Booking booking = new Booking(customerName, customerEmail, bikeName,
                pricePerDay, rentDays, totalAmount,
                cardName, cardNumber, expiry);

        // If editing: remove the original line (match exact email + bikeName)
        List<String> updatedBookings = new ArrayList<>();
        if (isEdit) {
            try (BufferedReader reader = new BufferedReader(new FileReader(BOOKING_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 3 && !(parts[1].equalsIgnoreCase(customerEmail) && parts[2].equalsIgnoreCase(bikeName))) {
                        updatedBookings.add(line);
                    }
                }
            }
        } else {
            // If new booking, read existing lines to preserve them
            try (BufferedReader reader = new BufferedReader(new FileReader(BOOKING_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    updatedBookings.add(line);
                }
            }
        }

        // Write updated data
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(BOOKING_FILE))) {
            for (String line : updatedBookings) {
                writer.write(line);
                writer.newLine();
            }
            writer.write(booking.toString());
            writer.newLine();
        }

        response.sendRedirect("my_bookings.jsp?email=" + customerEmail);
    }

    // ✅ Handle Delete or Edit
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        String bikeName = request.getParameter("bike");

        if ("delete".equalsIgnoreCase(action)) {
            List<String> updatedBookings = new ArrayList<>();

            try (BufferedReader reader = new BufferedReader(new FileReader(BOOKING_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 3 && !(parts[1].equalsIgnoreCase(email) && parts[2].equalsIgnoreCase(bikeName))) {
                        updatedBookings.add(line);
                    }
                }
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(BOOKING_FILE))) {
                for (String line : updatedBookings) {
                    writer.write(line);
                    writer.newLine();
                }
            }

            response.sendRedirect("my_bookings.jsp?email=" + email);
        }

        if ("edit".equalsIgnoreCase(action)) {
            // Redirect back to booking.jsp with booking info
            response.sendRedirect("booking.jsp?edit=1&email=" + email + "&bike=" + bikeName);
        }
    }
}
