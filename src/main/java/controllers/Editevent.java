package controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import services.EventService;

@WebServlet("/editevent")
public class Editevent extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String eventIDStr = request.getParameter("eventID");
        String title = request.getParameter("title");
        String dateStr = request.getParameter("date");
        String description = request.getParameter("description");
        String category = request.getParameter("category");

        if (eventIDStr == null || title == null || dateStr == null || description == null || category == null ||
                eventIDStr.isEmpty() || title.isEmpty() || dateStr.isEmpty() || description.isEmpty() || category.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        int eventID = Integer.parseInt(eventIDStr);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date;
        try {
            date = dateFormat.parse(dateStr);
        } catch (ParseException e) {
            log("Error parsing date", e);
            response.sendRedirect("error.jsp");
            return;
        }

        EventService eventService = new EventService();
        boolean eventUpdated = eventService.updateEvent(eventID, title, description, date, category);

        if (eventUpdated) {
            response.sendRedirect("myevents.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
