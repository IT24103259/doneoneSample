<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !"admin".equalsIgnoreCase(role)) {
        response.sendRedirect("index.jsp");
        return;
    }

    String userFile = "C:/Users/LOQ/Desktop/done one/doneone/data/users.txt";
    String bookingFile = "C:/Users/LOQ/Desktop/done one/doneone/data/booking_and_payment.txt";
    String reviewFile = "C:/Users/LOQ/Desktop/done one/doneone/data/reviews.txt";

    List<String[]> users = new ArrayList<>();
    List<String[]> bookings = new ArrayList<>();
    List<String[]> reviews = new ArrayList<>();

    try (BufferedReader reader = new BufferedReader(new FileReader(userFile))) {
        String line;
        while ((line = reader.readLine()) != null) {
            users.add(line.split(","));
        }
    }

    try (BufferedReader reader = new BufferedReader(new FileReader(bookingFile))) {
        String line;
        while ((line = reader.readLine()) != null) {
            bookings.add(line.split(","));
        }
    }

    try (BufferedReader reader = new BufferedReader(new FileReader(reviewFile))) {
        String line;
        while ((line = reader.readLine()) != null) {
            reviews.add(line.split(",", 2));
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #0e0e0e;
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
            padding: 30px;
        }
        h2 {
            color: #ffc107;
        }
        table {
            background-color: #1a1a1a;
            margin-bottom: 40px;
        }
        th, td {
            color: #fff;
            text-align: center;
        }
    </style>
</head>
<body>

<h2 class="text-center mb-4">📊 Admin Dashboard</h2>

<div class="text-center mb-4">
    <a href="bike.jsp" class="btn btn-warning fw-bold">➕ Add / Manage Bikes</a>
</div>

<!-- Users -->
<h4>👥 Registered Users</h4>
<table class="table table-dark table-bordered">
    <thead><tr><th>ID</th><th>Username</th><th>Password</th><th>Email</th><th>Role</th><th>Action</th></tr></thead>
    <tbody>
    <%
        for (String[] u : users) {
    %>
    <tr>
        <td><%= u[0] %></td>
        <td><%= u[1] %></td>
        <td><%= u[2] %></td>
        <td><%= u[3] %></td>
        <td><%= u[4] %></td>
        <td>
            <form action="adminDelete" method="post" onsubmit="return confirm('Delete this user?');">
                <input type="hidden" name="type" value="user">
                <input type="hidden" name="userId" value="<%= u[0] %>">
                <button class="btn btn-sm btn-danger">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<!-- Bookings -->
<h4>🧾 Booking Records</h4>
<table class="table table-dark table-bordered">
    <thead><tr><th>Customer</th><th>Email</th><th>Bike</th><th>Price</th><th>Days</th><th>Total</th><th>Card</th><th>Card#</th><th>Expiry</th></tr></thead>
    <tbody>
    <%
        for (String[] b : bookings) {
    %>
    <tr>
        <td><%= b[0] %></td>
        <td><%= b[1] %></td>
        <td><%= b[2] %></td>
        <td><%= b[3] %></td>
        <td><%= b[4] %></td>
        <td><%= b[5] %></td>
        <td><%= b[6] %></td>
        <td><%= b[7] %></td>
        <td><%= b[8] %></td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<!-- Rides -->
<h4>🚗 All Customer Ride Requests</h4>
<table class="table table-dark table-bordered">
    <thead>
    <tr>
        <th>Customer</th><th>Email</th><th>Pickup</th><th>Drop</th><th>Date</th>
        <th>Luggage</th><th>Notes</th><th>Status</th><th>Driver</th>
    </tr>
    </thead>
    <tbody>
    <%
        String rideFile = "C:/Users/LOQ/Desktop/done one/doneone/data/custom_rides.txt";
        try (BufferedReader reader = new BufferedReader(new FileReader(rideFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] r = line.split(",", -1);
                String status = (r.length >= 8) ? "Confirmed" : "Pending";
                String driver = (r.length >= 8) ? r[7] : "-";
                String statusClass = "Confirmed".equals(status) ? "text-success" : "text-warning";
    %>
    <tr>
        <td><%= r[0] %></td>
        <td><%= r[1] %></td>
        <td><%= r[2] %></td>
        <td><%= r[3] %></td>
        <td><%= r[4] %></td>
        <td><%= r[5] %></td>
        <td><%= r[6] %></td>
        <td class="<%= statusClass %>"><%= status %></td>
        <td><%= driver %></td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>

<!-- Reviews -->
<h4>💬 Customer Reviews</h4>
<table class="table table-dark table-bordered">
    <thead><tr><th>User</th><th>Review</th><th>Action</th></tr></thead>
    <tbody>
    <%
        for (String[] r : reviews) {
    %>
    <tr>
        <td><%= r[0] %></td>
        <td><%= r[1] %></td>
        <td>
            <form action="adminDelete" method="post" onsubmit="return confirm('Delete this review?');">
                <input type="hidden" name="type" value="review">
                <input type="hidden" name="username" value="<%= r[0] %>">
                <input type="hidden" name="reviewText" value="<%= r[1] %>">
                <button class="btn btn-sm btn-danger">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<div class="text-center mt-4">
    <a href="index.jsp" class="btn btn-outline-warning">← Back to Home</a>
</div>

</body>
</html>
