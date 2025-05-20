package model;

public class Booking {
    private String customerName;
    private String customerEmail;
    private String bikeName;
    private double pricePerDay;
    private int rentDays;
    private double totalAmount;
    private String cardName;
    private String cardNumber; // optional: masked
    private String expiry;

    public Booking(String customerName, String customerEmail, String bikeName,
                   double pricePerDay, int rentDays, double totalAmount,
                   String cardName, String cardNumber, String expiry) {
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.bikeName = bikeName;
        this.pricePerDay = pricePerDay;
        this.rentDays = rentDays;
        this.totalAmount = totalAmount;
        this.cardName = cardName;
        this.cardNumber = cardNumber;
        this.expiry = expiry;
    }

    // Getters
    public String getCustomerName() {
        return customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public String getBikeName() {
        return bikeName;
    }

    public double getPricePerDay() {
        return pricePerDay;
    }

    public int getRentDays() {
        return rentDays;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public String getCardName() {
        return cardName;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public String getExpiry() {
        return expiry;
    }

    // To save in file
    @Override
    public String toString() {
        return customerName + "," + customerEmail + "," + bikeName + "," + pricePerDay + "," + rentDays + "," +
                totalAmount + "," + cardName + "," + maskCard(cardNumber) + "," + expiry;
    }

    private String maskCard(String cardNumber) {
        if (cardNumber.length() >= 4) {
            return "**** **** **** " + cardNumber.substring(cardNumber.length() - 4);
        } else {
            return "****";
        }
    }
}
