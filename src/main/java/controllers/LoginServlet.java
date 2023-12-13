package controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.users;
import services.UserService;

@WebServlet(name = "loginServlet", urlPatterns = { "/loginServlet" })
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("loginemail");
        String password = request.getParameter("pswd");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            response.sendRedirect("Header.jsp?error=empty_fields");
            return;
        }

        HttpSession session = request.getSession();
        UserService userService = new UserService();
        users user = userService.getUserByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("email", email);
            response.sendRedirect("Home.jsp");
        } else {
            response.sendRedirect("error.jsp?error=authentication_failed");
        }
    }
}
