<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Bike, servlet.BikeServlet" %>
<%
    String filePath = "C:/Users/LOQ/Desktop/done one/doneone/data/bikes.txt";
    List<Bike> bikeList = BikeServlet.loadBikes(filePath);

    String editId = request.getParameter("id");
    String action = request.getParameter("action");
    Bike editBike = null;

    if ("edit".equalsIgnoreCase(action) && editId != null) {
        for (Bike b : bikeList) {
            if (b.getBikeId().equals(editId)) {
                editBike = b;
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bike Management - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #0e0e0e;
            color: #ffffff;
            font-family: 'Segoe UI', sans-serif;
            padding: 50px;
        }

        h2 {
            color: #ffc107;
            margin-bottom: 30px;
        }

        .form-control {
            background-color: #333;
            border: 1px solid #555;
            color: #fff;
        }

        .form-control::placeholder {
            color: #aaa;
        }

        .submit-btn {
            background-color: #ffc107;
            color: #000;
            font-weight: bold;
            width: 100%;
        }

        table {
            margin-top: 40px;
        }

        table th, table td {
            color: #fff;
            vertical-align: middle;
        }

        .btn-edit, .btn-delete {
            padding: 4px 10px;
            font-size: 14px;
            border-radius: 6px;
            font-weight: 600;
        }

        .btn-edit {
            background-color: #17a2b8;
            color: #fff;
        }

        .btn-delete {
            background-color: #dc3545;
            color: #fff;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>🚲 Bike Management – Admin Panel</h2>

    <!-- 🛠️ Add Bike Form -->
    <form action="bike" method="post">
        <input type="hidden" name="editMode" value="<%= (editBike != null) %>">
        <div class="row mb-3">
            <div class="col-md-3">
                <input type="text" name="bikeId" class="form-control" placeholder="Bike ID"
                       value="<%= (editBike != null) ? editBike.getBikeId() : "" %>" <%= (editBike != null ? "readonly" : "") %> required>
            </div>
            <div class="col-md-3">
                <input type="text" name="bikeName" class="form-control" placeholder="Bike Name"
                       value="<%= (editBike != null) ? editBike.getBikeName() : "" %>" required>
            </div>
            <div class="col-md-3">
                <input type="number" name="price" class="form-control" placeholder="Price (Rs.)"
                       value="<%= (editBike != null) ? editBike.getPrice() : "" %>" required>
            </div>
            <div class="col-md-3">
                <select name="availability" class="form-control" required>
                    <option value="">Availability</option>
                    <option value="Available" <%= (editBike != null && editBike.getAvailability().equals("Available")) ? "selected" : "" %>>Available</option>
                    <option value="Unavailable" <%= (editBike != null && editBike.getAvailability().equals("Unavailable")) ? "selected" : "" %>>Unavailable</option>
                </select>
            </div>
        </div>
        <button type="submit" class="btn submit-btn">
            <%= (editBike != null) ? "Update Bike" : "Add Bike" %>
        </button>
    </form>


    <!-- 📋 Bike List (Later we load using Servlet) -->
    <table class="table table-dark table-hover table-bordered">
        <thead>
        <tr>
            <th>Bike ID</th>
            <th>Name</th>
            <th>Price (Rs.)</th>
            <th>Availability</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (bikeList != null && !bikeList.isEmpty()) {
                for (Bike bike : bikeList) {
        %>
        <tr>
            <td><%= bike.getBikeId() %></td>
            <td><%= bike.getBikeName() %></td>
            <td><%= bike.getPrice() %></td>
            <td><%= bike.getAvailability() %></td>
            <td>
                <a href="bike.jsp?action=edit&id=<%= bike.getBikeId() %>" class="btn btn-edit">Edit</a>
                <a href="bike?action=delete&id=<%= bike.getBikeId() %>" class="btn btn-delete" onclick="return confirm('Are you sure?');">Delete</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5" class="text-center text-warning">No bikes found.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
<div class="text-center mt-4">
    <a href="admin.jsp" class="btn btn-outline-warning">← Back to Admin Panel</a>
</div>
</body>
</html>
