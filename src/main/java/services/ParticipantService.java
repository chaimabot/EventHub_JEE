package services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Participant;
import models.users;

public class ParticipantService {

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
    public int getIdParticipantByUserID(users userID) {
        String query = "SELECT idParticipant FROM participant WHERE userID = ?";
        ResultSet resultSet = null;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, userID.getUserID()); 
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("idParticipant");
            } else {
                return -1; 
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public void addParticipant(Participant participant) {
        String query = "INSERT INTO participants (description, userID) VALUES (?, ?)";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, participant.getDescription());
            preparedStatement.setInt(2, participant.getUserID());

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                log("Participant added successfully", null);
            } else {
                log("Failed to add participant", null);
            }

        } catch (SQLException e) {
            log("Error executing SQL query for adding participant", e);
        }
    }

    

    private static void log(String message, Exception e) {
        System.err.println(message);
        if (e != null) {
            e.printStackTrace();
        }
    }
}
