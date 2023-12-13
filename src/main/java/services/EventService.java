package services;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.event;
import models.users;

public class EventService {
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


    public List<event> getEventsByID(String login) {
        List<event> events = new ArrayList<>();
        String query1 = "SELECT * FROM users WHERE Email = ?";
        int userId=0;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement1 = connection.prepareStatement(query1)) {

            preparedStatement1.setString(1, login);
            try (ResultSet resultSet1 = preparedStatement1.executeQuery()) {
                if (resultSet1.next()) {
                    userId = resultSet1.getInt("UserID");
                } else {
                    return events;
                }
            }
        } catch (SQLException e) {
            log("Error executing SQL query", e);
            return events;
        }
System.out.println(userId);
        String query2 = "SELECT * FROM events WHERE UserID=?";
        
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement2 = connection.prepareStatement(query2)) {

            preparedStatement2.setInt(1, userId);
            try (ResultSet resultSet2 = preparedStatement2.executeQuery()) {
                while (resultSet2.next()) {
                    int eventId = resultSet2.getInt("EventID");
                    String title = resultSet2.getString("title");
                    String description = resultSet2.getString("description");
                    Date date = resultSet2.getDate("date");
                    String category = resultSet2.getString("category");

                    events.add(new event(title,description,date,category,userId));
                }

            }
        } catch (SQLException e) {
            log("Error executing SQL query", e);
        }

        return events;
    }

    public void deleteEvent(int eventID) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM events WHERE eventID = ?")) {

            preparedStatement.setInt(1, eventID);
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                log("Event deleted successfully. EventID: " + eventID, null);
            } else {
                log("Event not found for deletion. EventID: " + eventID, null);
            }
        } catch (SQLException e) {
            log("Error executing SQL query for event deletion", e);
        }
    }
    

    public users getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE Email = ?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int userID = resultSet.getInt("UserID");
                String firstName = resultSet.getString("firstName");
                String lastName = resultSet.getString("lastName");
                String password = resultSet.getString("password");
                String specialty = resultSet.getString("specialty");
                String number = resultSet.getString("number");

                return new users(userID, firstName, lastName, specialty, email, password, number);
            } else {
                return null;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean registerEvent(event evnt, HttpSession session) {

        String login = (String) session.getAttribute("email");
        int userId = 1;
        System.out.println("userId" + userId + login);

        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hubevent","root","")) {
            if (connection != null && !connection.isClosed()) {
                String query = "SELECT * FROM users WHERE Email = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                    preparedStatement.setString(1, login);
                    try (ResultSet resultSet = preparedStatement.executeQuery()) {
                        if (resultSet.next()) {
                            userId = resultSet.getInt("UserID");
                        }
                    }
                }
                String insertQuery = "INSERT INTO events (title, description, date, category, UserID) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {
                    insertStatement.setString(1, evnt.getTitle());
                    insertStatement.setString(2, evnt.getDescription());

                    if (evnt.getDate() != null) {
                        insertStatement.setDate(3, new java.sql.Date(evnt.getDate().getTime()));
                    } else {
                        insertStatement.setNull(3, Types.DATE);
                    }

                    insertStatement.setString(4, evnt.getCategory());
                    insertStatement.setInt(5, userId);

                    int rowsAffected = insertStatement.executeUpdate();
                    return rowsAffected > 0;
                }
            } else {
                return false;
            }
        } catch (SQLException e) {
            log("Error executing SQL query", e);
            return false;
        }
    }

    public List<event> getAllEvents() {
        List<event> events = new ArrayList<>();

        String query = "SELECT * FROM events";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                int eventId = resultSet.getInt("EventID");
                String title = resultSet.getString("title");
                String description = resultSet.getString("description");
                Date date = resultSet.getDate("date");
                String category = resultSet.getString("category");
                int userId = resultSet.getInt("UserID");

                events.add(new event(title, description, date, category, userId));
            }

        } catch (SQLException e){
            log("Error executing SQL query", e);
        }

        return events;
    }


    private static void log(String message, Exception e) {
        System.err.println(message);
        if (e != null) {
            e.printStackTrace();
        }
    }

    public boolean updateEvent(int eventID, String title, String description, Date date, String category) {
        String query = "UPDATE events SET title=?, description=?, date=?, category=? WHERE EventID=?";

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, title);
            preparedStatement.setString(2, description);
            preparedStatement.setDate(3, new java.sql.Date(date.getTime()));
            preparedStatement.setString(4, category);
            preparedStatement.setInt(5, eventID);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            log("Error executing SQL query", e);
            return false;
        }
    }
}
