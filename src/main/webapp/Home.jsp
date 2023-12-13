<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<style>
.smaller-btn {
    font-size: 12px; 
    padding: 5px 10px; 
}
</style>
<head>
    <meta charset="UTF-8">
    <title>Home</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
    <jsp:include page="Header.jsp" />

    <div class="hero-wrap js-fullheight" style="background-image: url('images/bg_1.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container">
            <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-start" data-scrollax-parent="true">
                <div class="col-xl-10 ftco-animate" data-scrollax=" properties: { translateY: '70%' }">
                    <h1 class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"> Exceptional  <br><span>Event</span></h1>
                </div>
            </div>
        </div>
    </div>

    

    <div class="modal fade" id="inscrireEvent" tabindex="-1" role="dialog" aria-labelledby="inscrireEventLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Inscrire</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form method="POST" action="AddParticipantAndParticipe">
                       <input type="hidden" class="form-control" id="userID" name="userID">
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea class="form-control" name="descriptioninscription" rows="4"></textarea>
                        </div>
                        <div class="form-group">
                            <label for="date">Date</label>
                            <input type="date" class="form-control" id="dateinscription" name="dateinscription">
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

 <section class="ftco-section bg-light">
        <div class="container">
            <div class="row justify-content-center mb-5 pb-3">
                <div class="col-md-7 text-center heading-section ftco-animate">
                    <span class="subheading">Schedule</span>
                    <h2 class="mb-4"><span>Event</span> Schedule</h2>
                </div>
            </div>
            <div class="ftco-search">
                <form method="GET" action="AffichageEvent">
                    <div class="tab-pane fade show active" id="v-pills-1" role="tabpanel" aria-labelledby="day-1-tab">
                        <%
                            String url = "jdbc:mysql://localhost:3306/hubevent";
                            String user = "root";
                            String pwd = "";
                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection(url, user, pwd);
                                PreparedStatement eventQuery = con.prepareStatement("SELECT * FROM events");
                                ResultSet rs = eventQuery.executeQuery();

                                while (rs.next()) {
                                    String date = rs.getString("date");
                                    String title = rs.getString("title");
                                    String description = rs.getString("description");
                        %>
                        <div class="speaker-wrap ftco-animate d-flex">
                            <div class="img speaker-img"
                                style='background-image: url("images/image_1.jpg");'></div>
                            <div class="text pl-md-5">
                                <span class="time"><%= date %></span>
                                <h2><a href="#"><%= title %></a></h2>
                                <p><%= description %></p>
                                <%
                                    String login = (String) session.getAttribute("email");
                                    if (login != null) {
                                %>
                                <button type="button" class="btn btn-primary smaller-btn"
                                    data-toggle="modal" data-target="#inscrireEvent">Inscrire</button>
                                <%
                                    } else {
                                %>
                                <button type="button" class="btn btn-primary smaller-btn"
                                    data-toggle="modal" data-target="#loginModal">Inscrire</button>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <%
                                }
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





    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("dateinscription").value = today;
        });
    </script>


        <script src="js/jquery.min.js"></script>
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
        <script src="js/scrollax.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&sensor=false"></script>
        <script src="js/google-map.js"></script>
        <script src="js/main.js"></script>

    </body>

    </html>