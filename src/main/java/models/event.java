package models;

import java.util.Date;

public class event {
    private String title;
    private Date date;
    private String description;
    private String category;
    private int userID;

    public event(String title, String description, Date date, String category, int userID) {
        this.title = title;
        this.description = description;
        this.date = date;
        this.category = category;
        this.userID = userID;
    }

    public int getUserId() {
        return userID;
    }

    public void setUserId(int userID) {
        this.userID = userID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }



    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Event [title=" + title + ", date=" + date + ", description=" + description
                + ", category=" + category + ", userID=" + userID + "]";
    }
}
