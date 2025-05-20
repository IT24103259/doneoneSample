<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Myth Bikes</title>
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

        .register-card {
            background-color: #1a1a1a;
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 0 25px rgba(255, 193, 7, 0.15);
        }

        .register-card h2 {
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

        .register-btn {
            background-color: #ffc107;
            color: #000;
            font-weight: bold;
            width: 100%;
            margin-top: 20px;
        }

        .login-text {
            margin-top: 25px;
            text-align: center;
            font-size: 14px;
        }

        .login-text a {
            color: #ffc107;
            text-decoration: underline;
            font-weight: bold;
        }

        .login-text a:hover {
            color: #ffcc33;
        }
    </style>
</head>
<body>

<div class="register-card">
    <h2>Create Account</h2>
    <form action="register" method="post">
        <div class="mb-3">
            <label for="username" class="form-label">User Name</label>
            <input type="text" name="username" id="username" class="form-control" placeholder="Enter your username" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" name="email" id="email" class="form-control" placeholder="Enter your email" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="Enter your password" required>
        </div>

        <div class="mb-4">
            <label for="role" class="form-label">I am a:</label>
            <select name="role" id="role" class="form-control" required>
                <option value="">-- Select --</option>
                <option value="customer">Customer</option>
                <option value="driver">Driver</option>
            </select>
        </div>

        <button type="submit" class="btn register-btn">Register</button>

        <div class="login-text">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </form>
</div>

</body>
</html>

