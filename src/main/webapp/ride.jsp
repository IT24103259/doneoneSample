<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String name = (String) session.getAttribute("username");
  String email = (String) session.getAttribute("email");

  if (name == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Book a Custom Ride</title>
  <meta charset="UTF-8">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #0e0e0e;
      color: #fff;
      font-family: 'Segoe UI', sans-serif;
      padding: 50px;
    }
    .card {
      background-color: #1a1a1a;
      border-radius: 15px;
      padding: 30px;
      max-width: 600px;
      margin: auto;
    }
    .btn-book {
      background-color: #ffc107;
      font-weight: bold;
      color: #000;
    }
  </style>
</head>
<body>

<div class="card">
  <h2 class="mb-4 text-warning">🚗 Book a Custom Ride</h2>
  <form action="ride" method="post">
    <div class="mb-3">
      <label class="form-label text-warning">Your Name</label>
      <input type="text" class="form-control" name="customerName" value="<%= name %>" readonly>
    </div>
    <div class="mb-3">
      <label class="form-label text-warning">Email</label>
      <input type="email" class="form-control" name="customerEmail" value="<%= email %>" readonly>
    </div>
    <div class="mb-3">
      <label class="form-label text-warning">Pickup Location</label>
      <input type="text" class="form-control" name="pickup" required>
    </div>
    <div class="mb-3">
      <label class="form-label text-warning">Drop-off Location</label>
      <input type="text" class="form-control" name="drop" required>
    </div>
    <div class="mb-3">
      <label class="form-label text-warning">Ride Date</label>
      <input type="date" class="form-control" name="rideDate" required>
    </div>
    <div class="mb-3">
      <label class="form-label text-warning">Luggage</label>
      <select class="form-control" name="luggage">
        <option value="No">No</option>
        <option value="Yes">Yes</option>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label text-warning">Special Notes</label>
      <textarea class="form-control" name="notes" rows="3" placeholder="Any preferences or notes..."></textarea>
    </div>

    <button type="submit" class="btn btn-book w-100">Book Ride</button>

    <div class="text-center mt-4">
      <a href="my_rides.jsp" class="btn btn-outline-warning">📋 My Booked Rides</a>
    </div>
    <div class="text-center mt-5">
      <a href="index.jsp" class="btn btn-outline-warning">← Back to Home</a>
    </div>

  </form>
</div>

</body>
</html>
