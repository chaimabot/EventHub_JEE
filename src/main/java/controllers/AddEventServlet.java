package controllers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.event;
import services.EventService;

@WebServlet(name = "cs", urlPatterns = { "/addevent", "*.AddEventServlet" })
public class AddEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String title = request.getParameter("title");
        String dateStr = request.getParameter("date");
        String description = request.getParameter("description");
        String category = request.getParameter("category");

        if (dateStr == null || title == null || dateStr.isEmpty() || title.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date;
        try {
            date = dateFormat.parse(dateStr);
        } catch (ParseException e) {
            log("Error parsing date", e);
            response.sendRedirect("error.jsp");
            return;
        }

        event event = new event(title, description, date, category, 1);

        EventService eventService = new EventService();
        boolean eventAdded = eventService.registerEvent(event, session);

        if (eventAdded) {
            response.sendRedirect("myevents.jsp");
        } else {
            response.sendRedirect("error.jsp");
        }
    }
}
