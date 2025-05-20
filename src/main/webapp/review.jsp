<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String reviewFile = "C:/Users/LOQ/Desktop/done one/doneone/data/reviews.txt";
    List<String[]> reviews = new ArrayList<>();

    try (BufferedReader reader = new BufferedReader(new FileReader(reviewFile))) {
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",", 2); // username, review text
            if (parts.length == 2) {
                reviews.add(parts);
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Reviews</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #0e0e0e;
            color: #fff;
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
        }
        .card {
            background-color: #1a1a1a;
            border-radius: 12px;
            padding: 30px;
            max-width: 600px;
            margin: 20px auto;
        }
        .btn-post {
            background-color: #ffc107;
            color: #000;
            font-weight: bold;
        }
        .btn-edit {
            background-color: #17a2b8;
            font-weight: bold;
            color: #fff;
        }
        .btn-delete {
            background-color: #dc3545;
            font-weight: bold;
            color: #fff;
        }
    </style>
</head>
<body>

<div class="card">
    <h3 class="text-warning mb-4 text-center">💬 Leave a Review</h3>
    <form action="review" method="post">
        <textarea name="reviewText" class="form-control mb-3" rows="3" placeholder="Share your experience..." required></textarea>
        <button type="submit" class="btn btn-post w-100">Submit Review</button>
    </form>
</div>
<div class="text-center mt-5">
    <a href="index.jsp" class="btn btn-outline-warning">← Back to Home</a>
</div>

<div class="container mt-5">
    <h4 class="text-warning mb-3 text-center">📋 All Reviews</h4>
    <table class="table table-dark table-bordered text-center">
        <thead>
        <tr>
            <th>User</th>
            <th>Review</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (reviews.isEmpty()) {
        %>
        <tr><td colspan="3" class="text-warning">No reviews yet.</td></tr>
        <%
        } else {
            for (String[] r : reviews) {
        %>
        <tr>
            <td><%= r[0] %></td>
            <td><%= r[1] %></td>
            <td>
                <%
                    if (r[0].equals(username)) {
                %>
                <form action="review" method="post" style="display:inline-block;">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="oldText" value="<%= r[1] %>">
                    <button class="btn btn-edit btn-sm">Edit</button>
                </form>
                <form action="review" method="post" style="display:inline-block;" onsubmit="return confirm('Are you sure you want to delete this review?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="reviewText" value="<%= r[1] %>">
                    <button class="btn btn-delete btn-sm">Delete</button>
                </form>
                <%
                    } else {
                        out.print("-");
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
