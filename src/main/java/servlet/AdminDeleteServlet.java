package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/adminDelete")
public class AdminDeleteServlet extends HttpServlet {
    private static final String USERS_FILE = "C:/Users/LOQ/Desktop/done one/doneone/data/users.txt";
    private static final String REVIEWS_FILE = "C:/Users/LOQ/Desktop/done one/doneone/data/reviews.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");

        if ("user".equals(type)) {
            String userId = request.getParameter("userId");
            List<String> updated = new ArrayList<>();

            try (BufferedReader reader = new BufferedReader(new FileReader(USERS_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.startsWith(userId + ",")) {
                        updated.add(line);
                    }
                }
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(USERS_FILE))) {
                for (String u : updated) {
                    writer.write(u);
                    writer.newLine();
                }
            }

        } else if ("review".equals(type)) {
            String username = request.getParameter("username");
            String reviewText = request.getParameter("reviewText");
            List<String> updated = new ArrayList<>();

            try (BufferedReader reader = new BufferedReader(new FileReader(REVIEWS_FILE))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (!line.equals(username + "," + reviewText)) {
                        updated.add(line);
                    }
                }
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(REVIEWS_FILE))) {
                for (String r : updated) {
                    writer.write(r);
                    writer.newLine();
                }
            }
        }

        response.sendRedirect("admin.jsp");
    }
}
