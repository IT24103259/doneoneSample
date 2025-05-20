<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/custom_rides.txt";
    List<String[]> myRides = new ArrayList<>();

    try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",", -1); // allows empty notes or driver fields
            if (parts.length >= 7 && parts[1].equals(email)) {
                myRides.add(parts);
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Booked Rides</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #0e0e0e;
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
        }
        table {
            background-color: #1a1a1a;
        }
        th, td {
            color: #fff;
            vertical-align: middle;
        }
        .btn-edit {
            background-color: #ffc107;
            font-weight: bold;
            color: #000;
        }
        .btn-delete {
            background-color: #dc3545;
            font-weight: bold;
            color: #fff;
        }
    </style>
</head>
<body>

<h2 class="text-warning text-center mb-4">📋 My Booked Rides</h2>

<div class="container">
    <table class="table table-dark table-bordered table-hover text-center">
        <thead>
        <tr>
            <th>Pickup</th>
            <th>Drop</th>
            <th>Date</th>
            <th>Luggage</th>
            <th>Notes</th>
            <th>Status</th>
            <th>Driver</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (myRides.isEmpty()) {
        %>
        <tr>
            <td colspan="8" class="text-warning text-center">No rides booked yet.</td>
        </tr>
        <%
        } else {
            for (String[] r : myRides) {
                String pickup = r[2];
                String drop = r[3];
                String date = r[4];
                String luggage = r[5];
                String notes = r[6];
                String status = (r.length >= 8) ? "Confirmed" : "Pending";
                String driver = (r.length >= 8) ? r[7] : "-";
        %>
        <tr>
            <td><%= pickup %></td>
            <td><%= drop %></td>
            <td><%= date %></td>
            <td><%= luggage %></td>
            <td><%= notes %></td>
            <td class="<%= status.equals("Pending") ? "text-warning" : "text-success" %>"><%= status %></td>
            <td><%= driver %></td>
            <td>
                <form action="ride" method="post" style="display:inline-block;">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="rideDate" value="<%= date %>">
                    <button class="btn btn-edit btn-sm">Edit</button>
                </form>
                <form action="ride" method="post" style="display:inline-block;" onsubmit="return confirm('Are you sure?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="rideDate" value="<%= date %>">
                    <input type="hidden" name="pickup" value="<%= pickup %>">
                    <input type="hidden" name="drop" value="<%= drop %>">
                    <button class="btn btn-delete btn-sm">Delete</button>
                </form>
            </td>
        </tr>
        <%
                }
            }
        %>


        </tbody>
    </table>
</div>

</body>
</html>
