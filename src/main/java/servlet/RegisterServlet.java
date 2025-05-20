package servlet;

import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/users.txt"; // update this

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form values
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Create unique user ID
        String userId = "U" + System.currentTimeMillis();

        // Save to file
        String newLine = userId + "," + username + "," + password + "," + email + "," + role;

        Files.write(Paths.get(FILE_PATH), (newLine + System.lineSeparator()).getBytes(), StandardOpenOption.CREATE, StandardOpenOption.APPEND);

        // Redirect to login page after successful registration
        response.sendRedirect("login.jsp");
    }
}
