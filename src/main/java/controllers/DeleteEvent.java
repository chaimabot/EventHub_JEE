package controllers;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.EventService;


@WebServlet("/deleteevent")
public class DeleteEvent extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventIDParam = request.getParameter("id");

        if (eventIDParam != null && !eventIDParam.isEmpty()) {
            try {
                int eventID = Integer.parseInt(eventIDParam);

                EventService eventService = new EventService();
                eventService.deleteEvent(eventID);

                response.sendRedirect("myevents.jsp");
            } catch (NumberFormatException e) {
                response.getWriter().println("L'ID de l'événement n'est pas un nombre valide.");
            }
        } else {
            response.getWriter().println("L'ID de l'événement n'est pas spécifié.");
        }
    }
}



