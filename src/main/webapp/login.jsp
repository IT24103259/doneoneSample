<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Myth Bikes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #0e0e0e;
            color: #ffffff;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .login-card {
            background-color: #1a1a1a;
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 0 25px rgba(255, 193, 7, 0.15);
        }

        .login-card h2 {
            color: #ffc107;
            font-size: 36px;
            font-weight: bold;
            text-align: center;
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

        .login-btn {
            background-color: #ffc107;
            color: #000;
            font-weight: bold;
            width: 100%;
            margin-top: 20px;
        }

        .register-text {
            margin-top: 25px;
            text-align: center;
            font-size: 14px;
        }

        .register-text a {
            color: #ffc107;
            text-decoration: underline;
            font-weight: bold;
        }

        .register-text a:hover {
            color: #ffcc33;
        }
    </style>
</head>
<body>

<div class="login-card">
    <h2>Hi! Login</h2>
    <form action="login" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">User Name</label>
            <input type="text" name="username" id="username" class="form-control" placeholder="Enter your username" required>
        </div>

        <div class="mb-4">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
        </div>

        <button type="submit" class="btn login-btn">Login</button>

        <div class="register-text">
            Don’t have an account? <a href="register.jsp">Register here</a>
        </div>
    </form>
</div>

</body>
</html>
