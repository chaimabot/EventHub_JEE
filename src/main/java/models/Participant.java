package models;

public class Participant {
    private int idParticipant;
    private String description;
    private int userID;  

    public Participant() {
    }

    public Participant(String description, int userID) {
        this.description = description;
        this.userID = userID;
    }

    public int getIdParticipant() {
        return idParticipant;
    }

    public void setIdParticipant(int idParticipant) {
        this.idParticipant = idParticipant;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    @Override
    public String toString() {
        return "Participant [idParticipant=" + idParticipant + ", description=" + description + ", userID=" + userID + "]";
    }
}
