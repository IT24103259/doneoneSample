<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, java.io.*, model.Booking" %>
<%
    String bookingFile = "C:/Users/LOQ/Desktop/done one/doneone/data/booking_and_payment.txt";

    // ✅ Try session email first
    String currentEmail = (String) session.getAttribute("email");

    // ✅ Fallback to request param if needed
    if (currentEmail == null || currentEmail.trim().isEmpty()) {
        currentEmail = request.getParameter("email");
    }

    List<Booking> bookings = new ArrayList<>();

    if (currentEmail != null && !currentEmail.trim().isEmpty()) {
        try (BufferedReader reader = new BufferedReader(new FileReader(bookingFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 9 && parts[1].equalsIgnoreCase(currentEmail)) {
                    bookings.add(new Booking(
                            parts[0], parts[1], parts[2],
                            Double.parseDouble(parts[3]),
                            Integer.parseInt(parts[4]),
                            Double.parseDouble(parts[5]),
                            parts[6], parts[7], parts[8]
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #0e0e0e;
            color: #fff;
            padding: 40px;
            font-family: 'Segoe UI', sans-serif;
        }
        .table {
            background-color: #1a1a1a;
            border-radius: 10px;
            overflow: hidden;
        }
        .btn-edit {
            background-color: #17a2b8;
            color: white;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-warning mb-4">📋 My Bookings</h2>

    <% if (bookings.isEmpty()) { %>
    <p>No bookings found for <strong><%= currentEmail != null ? currentEmail : "null" %></strong></p>
    <% } else { %>
    <table class="table table-dark table-bordered">
        <thead>
        <tr>
            <th>Bike</th>
            <th>Days</th>
            <th>Total</th>
            <th>Card</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Booking b : bookings) { %>
        <tr>
            <td><%= b.getBikeName() %></td>
            <td><%= b.getRentDays() %></td>
            <td>LKR <%= b.getTotalAmount() %></td>
            <td><%= b.getCardName() %></td>
            <td>
                <a href="booking?action=edit&email=<%= b.getCustomerEmail() %>&bike=<%= b.getBikeName() %>" class="btn btn-sm btn-edit">Edit</a>
                <a href="booking?action=delete&email=<%= b.getCustomerEmail() %>&bike=<%= b.getBikeName() %>" class="btn btn-sm btn-delete" onclick="return confirm('Are you sure you want to delete this booking?');">Delete</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>

    <!-- Back to Booking -->
    <div class="mt-3">
        <a href="booking.jsp?email=<%= currentEmail %>" class="btn btn-outline-light">⬅ Back to Booking</a>
    </div>
</div>
<div class="text-center mt-5">
    <a href="index.jsp" class="btn btn-outline-warning">← Back to Home</a>
</div>

</body>
</html>
