<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*" %>
<%
    String username = null;
    String email = null;
    String role = null;

    if (session != null) {
        username = (String) session.getAttribute("username");
        email = (String) session.getAttribute("email");
        role = (String) session.getAttribute("role");
    }

    boolean isLoggedIn = (username != null);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Myth Bikes – RideShare Home</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background-color: #0e0e0e;
            color: #ffffff;
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            background-color: #ffc107;
            padding: 18px 0;
        }

        .navbar-brand {
            font-size: 32px;
            font-weight: 900;
            color: #000 !important;
        }

        .nav-link {
            color: #000 !important;
            font-weight: 700;
            font-size: 18px;
            margin-left: 20px;
            transition: 0.3s;
        }

        .nav-link:hover {
            text-decoration: underline;
            color: #222 !important;
        }

        .hero-section {
            flex: 1;
            padding: 100px 10%;
            display: flex;
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
        }

        .hero-title {
            font-size: 76px;
            font-weight: 900;
            line-height: 1.1;
            color: #ffc107;
        }

        .tagline {
            font-size: 22px;
            color: #ddd;
            margin-top: 25px;
        }

        .bike-img {
            width: 580px;
            max-width: 100%;
            border-radius: 20px;
            opacity: 0.95;
            filter: brightness(95%);
            box-shadow: 0 0 60px rgba(255, 255, 255, 0.08);
        }

        footer {
            background-color: #1a1a1a;
            color: #aaa;
            padding: 12px 0;
            text-align: center;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .hero-section {
                flex-direction: column;
                text-align: center;
                padding: 50px 20px;
            }
            .bike-img {
                margin-top: 30px;
            }
            .hero-title {
                font-size: 50px;
            }
            .nav-link {
                font-size: 16px;
                margin-left: 10px;
            }
        }
    </style>
</head>
<body>

<!-- 🔒 Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content bg-dark text-white">
            <div class="modal-header">
                <h5 class="modal-title text-warning">🔒 Login Required</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <p>Please login to access this feature.</p>
                <a href="login.jsp" class="btn btn-outline-warning">Go to Login</a>
            </div>
        </div>
    </div>
</div>

<script>
    function openLoginModal() {
        const modal = new bootstrap.Modal(document.getElementById('loginModal'));
        modal.show();
    }
</script>

<!-- 🟨 Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">Myth Bikes</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="<%= isLoggedIn ? "review.jsp" : "#" %>" onclick="<%= isLoggedIn ? "" : "openLoginModal(); return false;" %>">Review</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= isLoggedIn ? "ride.jsp" : "#" %>" onclick="<%= isLoggedIn ? "" : "openLoginModal(); return false;" %>">Book a Ride</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= isLoggedIn ? "booking.jsp" : "#" %>" onclick="<%= isLoggedIn ? "" : "openLoginModal(); return false;" %>">Rent a Bike</a>
                </li>
                <% if (isLoggedIn) { %>
                <li class="nav-item">
                    <a class="nav-link" href="profile.jsp">My Profile</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout.jsp">Logout</a>
                </li>
                <li class="nav-item">
                    <span class="nav-link text-success">👋 Hello, <%= username %></span>
                </li>
                <% } else { %>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- 🖤 Hero Section -->
<div class="hero-section">
    <div>
        <h1 class="hero-title">Bicycle Rentals<br>& Ride Sharing</h1>
        <p class="tagline">Your all-in-one platform to rent a bike and book a ride!</p>
    </div>
    <div>
        <img src="homebike.jpg" alt="Bike" class="bike-img">
    </div>
</div>

<!-- 🧾 Footer -->
<footer>
    <small>&copy; 2025 Ride Sharing | SE1020 Group 10</small>
</footer>

</body>
</html>
