<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, java.util.*, model.Bike, servlet.BikeServlet" %>
<%
    String filePath = "C:/Users/LOQ/Desktop/done one/doneone/data/bikes.txt";
    String bookingFile = "C:/Users/LOQ/Desktop/done one/doneone/data/booking_and_payment.txt";

    List<Bike> bikes = BikeServlet.loadBikes(filePath);

    String email = request.getParameter("email");
    String editBike = request.getParameter("bike");
    boolean isEdit = "1".equals(request.getParameter("edit"));

    // 📛 Force correct email (must include '@')
    if (email == null || email.equals("null") || !email.contains("@")) {
%>
<script>
    let userEmail = prompt("Please enter your full email (e.g., name@gmail.com):");
    if (userEmail && userEmail.includes("@")) {
        window.location.href = "booking.jsp?email=" + encodeURIComponent(userEmail);
    } else {
        alert("You must enter a valid email to continue.");
        window.location.href = "index.jsp";
    }
</script>
<%
        return;
    }

    // Prefill vars
    String preName = "";
    String preCard = "";
    String preBike = "";
    int preDays = 0;

    if (isEdit && editBike != null) {
        try (BufferedReader reader = new BufferedReader(new FileReader(bookingFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 9 && parts[1].equalsIgnoreCase(email) && parts[2].equalsIgnoreCase(editBike)) {
                    preName = parts[0];
                    preBike = parts[2];
                    preDays = Integer.parseInt(parts[4]);
                    preCard = parts[6];
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Rent a Bike</title>
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
    <h2 class="mb-4 text-warning">🚴 Rent a Bike</h2>
    <form action="booking" method="post">
        <!-- 0. Customer Info -->
        <div class="mb-3">
            <input type="text" name="customerName" class="form-control" value="<%= preName %>" placeholder="Your Full Name" required>
        </div>
        <div class="mb-3">
            <input type="email" name="customerEmail" class="form-control" value="<%= email %>" readonly required>
        </div>

        <!-- 1. Select Bike -->
        <div class="mb-3">
            <label class="form-label text-warning">Choose Available Bike</label>
            <select class="form-control" name="bikeName" required>
                <option value="">-- Select Bike --</option>
                <%
                    for (Bike b : bikes) {
                        if ("Available".equals(b.getAvailability())) {
                            String selected = b.getBikeName().equals(preBike) ? "selected" : "";
                %>
                <option value="<%= b.getBikeName() %>" data-price="<%= b.getPrice() %>" <%= selected %>>
                    <%= b.getBikeName() %> - LKR <%= b.getPrice() %> / day
                </option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <!-- 2. Rent Duration -->
        <div class="mb-3">
            <label class="form-label text-warning">Rent Duration (Days)</label>
            <input type="number" name="days" class="form-control" id="days" value="<%= preDays %>" min="1" required>
        </div>

        <!-- 💰 Total Preview -->
        <div class="mb-3">
            <label class="form-label text-warning">Total Amount</label><br>
            <span id="totalDisplay" class="text-info fw-bold fs-5">LKR 0.00</span>
        </div>

        <!-- 3. Card Details -->
        <h5 class="text-warning">💳 Payment Details</h5>
        <div class="mb-2">
            <input type="text" class="form-control" name="cardName" value="<%= preCard %>" placeholder="Name on Card" required>
        </div>
        <div class="mb-2">
            <input type="text" class="form-control" name="cardNumber" placeholder="Card Number" required>
        </div>
        <div class="mb-2">
            <input type="text" class="form-control" name="expiry" placeholder="MM/YY" required>
        </div>
        <div class="mb-3">
            <input type="text" class="form-control" name="cvv" placeholder="CVV" required>
        </div>

        <!-- Hidden Fields -->
        <input type="hidden" name="editMode" value="<%= isEdit %>">

        <!-- Submit -->
        <button type="submit" class="btn btn-book w-100"><%= isEdit ? "Update Booking" : "Pay and Book" %></button>

        <div class="text-center mt-3">
            <a href="my_bookings.jsp?email=<%= email %>" class="btn btn-outline-warning">📋 My Bookings</a>
        </div>
    </form>
</div>

<!-- 💡 Live Total Calculation -->
<script>
    const bikeSelect = document.querySelector('select[name="bikeName"]');
    const daysInput = document.getElementById('days');
    const totalDisplay = document.getElementById('totalDisplay');

    function updateTotal() {
        const selectedOption = bikeSelect.options[bikeSelect.selectedIndex];
        const pricePerDay = parseFloat(selectedOption.getAttribute('data-price')) || 0;
        const days = parseInt(daysInput.value);
        const total = !isNaN(days) ? (pricePerDay * days) : 0;

        totalDisplay.textContent = `LKR ${total.toFixed(2)}`;
    }

    bikeSelect.addEventListener("change", updateTotal);
    daysInput.addEventListener("input", updateTotal);
</script>

</body>
</html>
