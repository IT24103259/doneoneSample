<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*, model.User" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Load user from users.txt
    String filePath = "C:/Users/LOQ/Desktop/done one/doneone/data/users.txt";
    User user = null;

    try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
        String line;
        while ((line = reader.readLine()) != null) {
            String[] parts = line.split(",");
            if (parts.length == 5 && parts[1].equals(username)) {
                user = new User(parts[0], parts[1], parts[2], parts[3], parts[4]);
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
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
            padding: 30px;
            border-radius: 15px;
            max-width: 600px;
            margin: auto;
        }
        .btn-update {
            background-color: #ffc107;
            color: #000;
            font-weight: bold;
        }
        .btn-delete {
            background-color: #dc3545;
            color: #fff;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="card">
    <h2 class="mb-4 text-warning">👤 My Profile</h2>
    <form action="user" method="post">
        <input type="hidden" name="userId" value="<%= user.getUserId() %>">

        <div class="mb-3">
            <label class="form-label text-light">Username</label>
            <input type="text" class="form-control" name="username" value="<%= user.getUsername() %>" readonly>
        </div>

        <div class="mb-3">
            <label class="form-label text-light">Email</label>
            <input type="email" class="form-control" name="email" value="<%= user.getEmail() %>" required>
        </div>

        <div class="mb-3">
            <label class="form-label text-light">Password</label>
            <input type="text" class="form-control" name="password" value="<%= user.getPassword() %>" required>
        </div>

        <input type="hidden" name="role" value="<%= user.getRole() %>">

        <button type="submit" name="action" value="update" class="btn btn-update w-100 mb-2">Update</button>
        <button type="submit" name="action" value="delete" class="btn btn-delete w-100" onclick="return confirm('Are you sure you want to delete your account?')">Delete Account</button>
    </form>
</div>

</body>
</html>
