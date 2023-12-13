package controllers;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.users;
import services.UserService;

@WebServlet(name = "css", urlPatterns = { "/register" })
public class RegisterUser extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
        	 String firstName = request.getParameter("firstName");
             String lastName = request.getParameter("lastName");
             String email = request.getParameter("email");
             String number = request.getParameter("number");
             String password = request.getParameter("password");
             String confirmPassword = request.getParameter("confirmPassword");
             String specialty = request.getParameter("specialty");

             if (firstName == null || lastName == null || email == null || number == null || password == null
                     || confirmPassword == null || specialty == null || password.isEmpty() || !password.equals(confirmPassword)) {
                 response.sendRedirect("error.jsp");
                 return;
             }

            System.out.println(firstName+lastName+specialty+email+password+number);
            
            users user = new users(firstName, lastName, specialty, email, password, number);
            UserService userService = new UserService();

            if (userService.registerUser(user)) {
                response.sendRedirect("Home.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            log("Error in RegisterUser servlet: " + e.getMessage(), e);
            response.sendRedirect("error.jsp");
        }
    }

    private static void log(String message, Exception e) {
        System.err.println(message);
        if (e != null) {
            e.printStackTrace();
        }
    }
}