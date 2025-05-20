package model;

public class Bike {
    private String bikeId;
    private String bikeName;
    private double price;
    private String availability; // Available / Unavailable

    public Bike(String bikeId, String bikeName, double price, String availability) {
        this.bikeId = bikeId;
        this.bikeName = bikeName;
        this.price = price;
        this.availability = availability;
    }

    // Getters
    public String getBikeId() {
        return bikeId;
    }

    public String getBikeName() {
        return bikeName;
    }

    public double getPrice() {
        return price;
    }

    public String getAvailability() {
        return availability;
    }

    // Setters
    public void setBikeId(String bikeId) {
        this.bikeId = bikeId;
    }

    public void setBikeName(String bikeName) {
        this.bikeName = bikeName;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }

    @Override
    public String toString() {
        return bikeId + "," + bikeName + "," + price + "," + availability;
    }
}
