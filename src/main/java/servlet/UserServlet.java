package servlet;

import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    private static final String FILE_PATH = "C:/Users/LOQ/Desktop/done one/doneone/data/users.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String userId = request.getParameter("userId");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        List<User> allUsers = loadUsers();

        if ("update".equals(action)) {
            List<User> updatedUsers = new ArrayList<>();
            for (User u : allUsers) {
                if (u.getUserId().equals(userId)) {
                    updatedUsers.add(new User(userId, username, password, email, role));
                } else {
                    updatedUsers.add(u);
                }
            }
            saveUsers(updatedUsers);
            HttpSession session = request.getSession();
            session.setAttribute("email", email); // update session email
            response.sendRedirect("profile.jsp");

        } else if ("delete".equals(action)) {
            List<User> updatedUsers = new ArrayList<>();
            for (User u : allUsers) {
                if (!u.getUserId().equals(userId)) {
                    updatedUsers.add(u);
                }
            }
            saveUsers(updatedUsers);
            request.getSession().invalidate(); // log out
            response.sendRedirect("index.jsp");
        }
    }

    private List<User> loadUsers() throws IOException {
        List<User> list = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] p = line.split(",");
                if (p.length == 5) {
                    list.add(new User(p[0], p[1], p[2], p[3], p[4]));
                }
            }
        }
        return list;
    }

    private void saveUsers(List<User> users) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (User u : users) {
                writer.write(u.getUserId() + "," + u.getUsername() + "," + u.getPassword() + "," + u.getEmail() + "," + u.getRole());
                writer.newLine();
            }
        }
    }
}
