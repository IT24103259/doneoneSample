package servlet;

import model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {
    private static final String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/reviews.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String username = (String) request.getSession().getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("delete".equals(action)) {
            deleteReview(username, request.getParameter("reviewText"));
        } else if ("edit".equals(action)) {
            HttpSession session = request.getSession();
            session.setAttribute("editReviewText", request.getParameter("oldText"));
            response.sendRedirect("edit_review.jsp");
            return;
        } else {
            // Default: Add new review
            String text = request.getParameter("reviewText");
            Review newReview = new Review(username, text);
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(newReview.toString());
                writer.newLine();
            }
        }

        response.sendRedirect("review.jsp");
    }

    private void deleteReview(String username, String reviewText) throws IOException {
        List<Review> all = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] p = line.split(",", 2);
                if (p.length == 2 && !(p[0].equals(username) && p[1].equals(reviewText))) {
                    all.add(new Review(p[0], p[1]));
                }
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Review r : all) {
                writer.write(r.toString());
                writer.newLine();
            }
        }
    }
}
