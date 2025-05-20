package servlet;

import model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/editReview")
public class EditReviewServlet extends HttpServlet {
    private static final String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/reviews.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = (String) request.getSession().getAttribute("username");
        String oldText = request.getParameter("oldReviewText");
        String newText = request.getParameter("newReviewText");

        if (username == null || oldText == null || newText == null) {
            response.sendRedirect("review.jsp");
            return;
        }

        List<Review> all = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] p = line.split(",", 2);
                if (p.length == 2) {
                    if (p[0].equals(username) && p[1].equals(oldText)) {
                        all.add(new Review(username, newText));
                    } else {
                        all.add(new Review(p[0], p[1]));
                    }
                }
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Review r : all) {
                writer.write(r.toString());
                writer.newLine();
            }
        }

        response.sendRedirect("review.jsp");
    }
}
