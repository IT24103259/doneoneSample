<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String username = (String) session.getAttribute("username");
  String oldReview = (String) session.getAttribute("editReviewText");

  if (username == null || oldReview == null) {
    response.sendRedirect("review.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Edit Review</title>
  <meta charset="UTF-8">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #0e0e0e;
      color: #fff;
      font-family: 'Segoe UI', sans-serif;
      padding: 60px;
    }
    .card {
      background-color: #1a1a1a;
      border-radius: 12px;
      padding: 30px;
      max-width: 600px;
      margin: auto;
    }
    .btn-update {
      background-color: #ffc107;
      color: #000;
      font-weight: bold;
    }
  </style>
</head>
<body>

<div class="card">
  <h3 class="text-warning text-center mb-4">✏️ Edit Your Review</h3>
  <form action="editReview" method="post">
    <textarea name="newReviewText" class="form-control mb-3" rows="4" required><%= oldReview %></textarea>
    <input type="hidden" name="oldReviewText" value="<%= oldReview %>">
    <button type="submit" class="btn btn-update w-100">Update Review</button>
  </form>
</div>

</body>
</html>
