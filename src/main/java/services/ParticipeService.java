package services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Date;

import models.Participes;


public class ParticipeService {

    private static Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/hubevent";
            String dbUser = "root";
            String dbPassword = "";
            connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        } catch (ClassNotFoundException | SQLException e) {
            log("Error establishing database connection", e);
        }
    }

    public static Connection getConnection() {
        return connection;
    }

    public void addParticipation(Participes participe) {
        String query = "INSERT INTO participes (EventID, idParticipant, DateParticipation) VALUES (?, ?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, participe.getEventID());
            preparedStatement.setInt(2, participe.getIdParticipant());

            if (participe.getDateParticipation() != null) {
                preparedStatement.setDate(3, new java.sql.Date(participe.getDateParticipation().getTime()));
            } else {
                preparedStatement.setNull(3, Types.DATE);
            }

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                log("Participation added successfully", null);
            } else {
                log("Failed to add participation", null);
            }

        } catch (SQLException e) {
            log("Error executing SQL query for adding participation", e);
        }
    }

    private static void log(String message, Exception e) {
        System.err.println(message);
        if (e != null) {
            e.printStackTrace();
        }
    }
}
