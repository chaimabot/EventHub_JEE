 package controllers;

import java.io.IOException;
import java.util.Date;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Participant;
import models.Participes;
import models.users;
import services.ParticipantService;
import services.ParticipeService;
import services.UserService;

@WebServlet("/AddParticipantAndParticipe")
public class AddParticipantAndParticipe extends HttpServlet {
    private ParticipantService participantService = new ParticipantService();
    private ParticipeService participeService = new ParticipeService();
    private UserService userService = new UserService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            HttpSession session = request.getSession();
            String login = (String) session.getAttribute("email");
            System.out.println("UserID: " + login);

            if (login != null) {
                users user = userService.getUserByEmail(login);

                int userID = user.getUserID();
                System.out.println("UserID: " + userID);

                request.setAttribute("userID", userID);

                int idParticipant = participantService.getIdParticipantByUserID(user);
                System.out.println("IDParticipant: " + idParticipant);

                request.setAttribute("idParticipant", idParticipant);

                String description = request.getParameter("descriptioninscription");
                System.out.println("Description: " + description);

                Participant participant = new Participant(description, userID);

                participantService.addParticipant(participant);

                int eventID = 1;
                System.out.println("EventID: " + eventID);

                Participes participes = new Participes(eventID, idParticipant, new Date());
                participeService.addParticipation(participes);
            } else {
                response.sendRedirect("Home.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}




