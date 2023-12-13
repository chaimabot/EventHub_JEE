package models;

import java.util.Date;

public class Participes {
    private int eventID;
    private int idParticipant;
    private Date dateParticipation;

    public Participes() {
    }

    public Participes(int eventID, int idParticipant, Date dateParticipation) {
        this.eventID = eventID;
        this.idParticipant = idParticipant;
        this.dateParticipation = dateParticipation;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getIdParticipant() {
        return idParticipant;
    }

    public void setIdParticipant(int idParticipant) {
        this.idParticipant = idParticipant;
    }

    public Date getDateParticipation() {
        return dateParticipation;
    }

    public void setDateParticipation(Date dateParticipation) {
        this.dateParticipation = dateParticipation;
    }
}
