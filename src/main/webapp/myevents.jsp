<%@ page language="java"%>
<%@ page import="java.sql.*"%>
<%            
String login = (String) session.getAttribute("email");
%>
<!DOCTYPE html>
<html>
<head>
    <style>
        .participants-button {
            font-size: 14px; 
            padding: 5px 10px; 
        }
    </style>
    
</head>

<body>
    <jsp:include page="Header.jsp" />
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                    <div class="modal fade" id="addEventModal" tabindex="-1" role="dialog" aria-labelledby="addEventModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add an Event</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="POST" action="addevent" >
                    <div class="form-group">
                        <label for="eventTitle">Event Title</label>
                        <input type="text" class="form-control" name="title" >
                    </div>
                    <div class="form-group">
                        <label for="eventDate">Event Date</label>
                        <input type="date" class="form-control" name="date" >
                    </div>
                    <div class="form-group">
                        <label for="eventDescription">Event Description</label>
                        <textarea class="form-control" name="description" rows="4"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="eventCategory">Event Category</label>
                        <input type="text" class="form-control" name="category">
                    </div>
                                <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">Save</button>
            </div>
                  </form>
            </div>

        </div>
    </div>
</div>



<div class="modal fade" id="Participants" tabindex="-1" role="dialog" aria-labelledby="participantsModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">List of Participants</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <ul class="list-group">
                    <li class="list-group-item"><a href="#" data-toggle="modal" data-target="#participantInfoModal">Participant 1</a></li>
                    <li class="list-group-item"><a href="#" data-toggle="modal" data-target="#participantInfoModal">Participant 2</a></li>
                    <li class="list-group-item"><a href="#" data-toggle="modal" data-target="#participantInfoModal">Participant 3</a></li>
                </ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="participantInfoModal" tabindex="-1" role="dialog" aria-labelledby="participantInfoModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Participant Information</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Name: Chayma Bounawara</p>
                <p>Email: mostafachaima90@gmail.com</p>
                <p>Specialty : DSI</p>
                <p>Description : Im legend</p>
                <p>Number : 58043132</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onClick="handleButtonClick()" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>



                    <br><br><br><br><br>
                <section>
                    <div class="container">
                        <div class="row justify-content-center mb-5 pb-3">
                            <div class="col-md-7 text-center heading-section ftco-animate">
                                <span class="subheading">Hi!</span>
                                <h2 class="mb-4"><span>My</span> Events</h2>
                            </div>
                        </div>

                        <div class="row justify-content-center mb-5 pb-3">
                            <div class="col-md-6 text-center">
                                <button type="button" class="btn btn-primary" data-toggle="modal" onClick="checkLogin()">Add Event</button>
                            </div>
                        </div>

                        <div class="tab-wrap">

    <div class="tab-pane fade show active" id="v-pills-1" role="tabpanel" aria-labelledby="day-1-tab">
        <%
        String url = "jdbc:mysql://localhost:3306/hubevent";
        String user = "root";
        String pwd = "";
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, user, pwd);

    PreparedStatement userQuery = con.prepareStatement("SELECT userID FROM users WHERE email = ?");
    userQuery.setString(1, login);
    ResultSet userResult = userQuery.executeQuery();
    
    if (userResult.next()) {
        int userID = userResult.getInt("userID");

        PreparedStatement eventQuery = con.prepareStatement("SELECT * FROM events WHERE userID = ?");
        eventQuery.setInt(1, userID);
        ResultSet rs = eventQuery.executeQuery();

        while (rs.next()) {
%>
            <div class="speaker-wrap ftco-animate d-flex">
                <div class="img speaker-img" style='background-image: url("images/image_1.jpg");'></div>
                <div class="text pl-md-5">
                    <span class="time"><%= rs.getString("date") %></span>
                    <h2><a href="#"><%= rs.getString("title") %></a></h2>
                    <p><%= rs.getString("description") %></p>
                </div>



<script>
    function confirmDelete(eventID) {
        var confirmation = confirm('Are you sure you want to delete this event?');
        if (confirmation) {
            window.location.href = 'deleteevent?id=' + eventID;
        }
    }
</script>

<div class="col-md-1">
                 <button type="button" class="btn btn-primary smaller-btn participants-button" data-toggle="modal" data-target="#Participants">
    <i class="fas fa-users"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-people-fill" viewBox="0 0 16 16">
  <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6m-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1zM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5"/>
</svg></i> 
</button>

<button type="button" class="btn btn-warning smaller-btn" data-toggle="modal" data-target="#editEventModal<%= rs.getInt("eventID") %>">
    <i class="fas fa-edit"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
</svg></i> 
</button>

<button type="button" onclick="confirmDelete(<%= rs.getInt("eventID") %>)" class="btn btn-danger smaller-btn" data-toggle="modal" data-target="#editEventModal<%= rs.getInt("eventID") %>">
    <i class="fas fa-trash"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash3-fill" viewBox="0 0 16 16">
  <path d="M11 1.5v1h3.5a.5.5 0 0 1 0 1h-.538l-.853 10.66A2 2 0 0 1 11.115 16h-6.23a2 2 0 0 1-1.994-1.84L2.038 3.5H1.5a.5.5 0 0 1 0-1H5v-1A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5m-5 0v1h4v-1a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5M4.5 5.029l.5 8.5a.5.5 0 1 0 .998-.06l-.5-8.5a.5.5 0 1 0-.998.06Zm6.53-.528a.5.5 0 0 0-.528.47l-.5 8.5a.5.5 0 0 0 .998.058l.5-8.5a.5.5 0 0 0-.47-.528ZM8 4.5a.5.5 0 0 0-.5.5v8.5a.5.5 0 0 0 1 0V5a.5.5 0 0 0-.5-.5"/>
</svg></i></button>
   </div>        
</div>

</div> 


<div class="modal fade" id="editEventModal<%= rs.getInt("eventID") %>" tabindex="-1" role="dialog" aria-labelledby="editEventModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Event</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="POST" action="editevent">
                    <div class="form-group">
                        <label for="eventTitle">Event Title</label>
                        <input type="text" class="form-control" name="title" value="<%= rs.getString("title") %>">
                    </div>
                    <div class="form-group">
                        <label for="eventDate">Event Date</label>
                        <input type="date" class="form-control" name="date" value="<%= rs.getString("date") %>">
                    </div>
                    <div class="form-group">
                        <label for="eventDescription">Event Description</label>
                        <textarea class="form-control" name="description" rows="4"><%= rs.getString("description") %></textarea>
                    </div>
                    <div class="form-group">
                        <label for="categoryEvent">category</label>
                        <input type="text" class="form-control" name="category" value="<%= rs.getString("category") %>">
                    </div>
                    <input type="hidden" name="eventID" value="<%= rs.getInt("EventID") %>">
                    <input type="hidden" name="userID" value="<%= rs.getInt("UserID") %>">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
                
<%
        }
        rs.close();
        eventQuery.close();
    } else {
%>
        <p>No user found for the given login information.</p>
<%
    }

    userResult.close();
    userQuery.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}
%>

    </div>
</form>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
     <script>
        function checkLogin() {
            <% if (login == null) { %>
                $(document).ready(function () {
                    $('#loginModal').modal('show');
                });
            <% } else { %>
                $(document).ready(function () {
                    $('#addEventModal').modal('show');
                });
            <% } %>
        }
    </script>

    <script src="js/jquery-migrate-3.0.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/jquery.stellar.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/aos.js"></script>
    <script src="js/jquery.animateNumber.min.js"></script>
    <script src="js/bootstrap-datepicker.js"></script>
    <script src="js/jquery.timepicker.min.js"></script>
    <script src="js/scrollax.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&sensor=false"></script>
    <script src="js/google-map.js"></script>
    <script src="js/main.js"></script></body>
</html>
