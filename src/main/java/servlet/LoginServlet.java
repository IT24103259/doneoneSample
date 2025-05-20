package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/users.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get credentials from form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String email = null;
        String role = null;
        boolean found = false;

        // Read from users.txt and match credentials
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5 && parts[1].equals(username) && parts[2].equals(password)) {
                    email = parts[3];
                    role = parts[4].trim(); // trim to avoid space issues
                    found = true;
                    break;
                }
            }
        }

        if (found) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("email", email);
            session.setAttribute("role", role);

            if ("driver".equalsIgnoreCase(role)) {
                response.sendRedirect("driver_rides.jsp");
            } else if ("admin".equalsIgnoreCase(role)) {
                response.sendRedirect("admin.jsp");
            } else {
                response.sendRedirect("index.jsp");
            }
        } else {
            response.setContentType("text/html");
            response.getWriter().println("<h3 style='color:red;text-align:center;'>Invalid username or password!</h3>");
        }
    }
}
