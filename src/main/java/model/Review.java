package model;

public class Review {
    private String username;
    private String reviewText;

    public Review(String username, String reviewText) {
        this.username = username;
        this.reviewText = reviewText;
    }

    public String getUsername() {
        return username;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    @Override
    public String toString() {
        return username + "," + reviewText.replace(",", " "); // avoid CSV issues
    }
}
