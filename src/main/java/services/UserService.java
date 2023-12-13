package services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import models.users;

public class UserService {
    private static Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hubevent", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        return connection;
    }

    public users getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE Email = ?";
        ResultSet resultSet = null;

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, email);
            resultSet = preparedStatement.executeQuery();

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
    
    public boolean registerUser(users user) {
        if (checkEmailExists(user.getEmail())) {
            return false; 
        }

        String query = "INSERT INTO users(firstName, lastName, specialty, Email, password, number) VALUES (?, ?, ?, ?, ?, ?)";
        		try (Connection connection = getConnection()) {
        		    if (connection != null) {
        		        System.out.println("Connexion à la base de données établie avec succès.");
        		    } else {
        		        System.out.println("La connexion à la base de données a échoué.");
        		    }
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, user.getFirstName());
            preparedStatement.setString(2, user.getLastName());
            preparedStatement.setString(3, user.getSpecialty());
            preparedStatement.setString(4, user.getEmail());
            preparedStatement.setString(5, user.getPassword()); 
            preparedStatement.setString(6, user.getNumber());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
            }
            catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean checkEmailExists(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE Email = ?";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int count = resultSet.getInt(1);
                return count > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}