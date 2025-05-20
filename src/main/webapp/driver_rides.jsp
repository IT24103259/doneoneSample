<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<%
  String driverName = (String) session.getAttribute("username");
  if (driverName == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/custom_rides.txt";
  List<String[]> pendingRides = new ArrayList<>();

  try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
    String line;
    while ((line = reader.readLine()) != null) {
      String[] parts = line.split(",", -1); // safe for empty fields
      if (parts.length == 7 || parts.length == 8) {
        pendingRides.add(parts);
      }
    }
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Pending Ride Requests</title>
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
    .btn-accept {
      background-color: #28a745;
      font-weight: bold;
      color: #fff;
    }
  </style>
</head>
<body>

<h2 class="text-warning text-center mb-4">🛻 Pending Ride Requests</h2>

<div class="container">
  <table class="table table-dark table-bordered table-hover text-center">
    <thead>
    <tr>
      <th>Customer</th>
      <th>Email</th>
      <th>Pickup</th>
      <th>Drop</th>
      <th>Date</th>
      <th>Luggage</th>
      <th>Notes</th>
      <th>Status</th>
    </tr>
    </thead>
    <tbody>
    <%
      if (pendingRides.isEmpty()) {
    %>
    <tr><td colspan="8" class="text-warning">No pending rides available.</td></tr>
    <%
    } else {
      for (String[] r : pendingRides) {
    %>
    <tr>
      <td><%= r[0] %></td>
      <td><%= r[1] %></td>
      <td><%= r[2] %></td>
      <td><%= r[3] %></td>
      <td><%= r[4] %></td>
      <td><%= r[5] %></td>
      <td><%= r[6] %></td>
      <td>
        <%
          if (r.length == 7) {
        %>
        <form action="driver" method="post">
          <input type="hidden" name="email" value="<%= r[1] %>">
          <input type="hidden" name="rideDate" value="<%= r[4] %>">
          <button type="submit" class="btn btn-accept btn-sm">Accept</button>
        </form>
        <%
        } else {
        %>
        <span class="text-success fw-bold">Accepted by <%= r[7] %></span>
        <%
          }
        %>
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
