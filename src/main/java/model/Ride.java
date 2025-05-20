package model;

public class Ride {
    private String customerName;
    private String customerEmail;
    private String pickup;
    private String drop;
    private String rideDate;
    private String luggage;
    private String notes;

    public Ride(String customerName, String customerEmail, String pickup, String drop,
                String rideDate, String luggage, String notes) {
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.pickup = pickup;
        this.drop = drop;
        this.rideDate = rideDate;
        this.luggage = luggage;
        this.notes = notes;
    }

    public String getCustomerName() { return customerName; }
    public String getCustomerEmail() { return customerEmail; }
    public String getPickup() { return pickup; }
    public String getDrop() { return drop; }
    public String getRideDate() { return rideDate; }
    public String getLuggage() { return luggage; }
    public String getNotes() { return notes; }

    @Override
    public String toString() {
        return customerName + "," + customerEmail + "," + pickup + "," + drop + "," +
                rideDate + "," + luggage + "," + notes.replace(",", " "); // prevent CSV break
    }
}
