<%@page import="project.DatabaseHelper" %>
<%@page import="project.loginCookie" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="head.html"/>
</head>
<body>
<div id="main_container">
    <div id="header">
        <jsp:include page="header.jsp"/>
    </div>
    <div id="main_content">
        <div id="navigation_top">
            <jsp:include page="navigation_top.jsp"/>
        </div>
        <div class="crumb_navigation"> Navigation: <span class="current">Buchungs Einsicht</span></div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp"/>
        </div>


        <div class="content">
            <div class="center_content">
                <div class="center_title_bar">Buchungs Einsicht</div>
                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big"></div>


                    <%
                        // den loginname des angemeldeten Nutzers auslesen
                        String user = "";
                        loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");

                        // Kunde ist angemeldet -> Ok, alles anzeigen
                        if (loginDaten != null) {
                            if (loginDaten.getRolle() == "Kunde") {
                                user = loginDaten.getUsername();
                            }

                            // html daten
                    %><p>Hier stehen die Buchungen</p>
                    <button value="stornieren"></button>
                    <%


                    }

                    //Kunde ist NICHT angemeldet -> warnhinweis
                    else {
                    %><p>Sie sind nicht angemeldet</p>
                    <button name="register" type="submit" value="register"><a href="register.jsp"></a></button>
                    <%
                        }
                    %>


                    <div class="bottom_prod_box_big"></div>
                </div>
            </div>
        </div>

        <div id="navigation_right" class="navigation_right">
            <jsp:include page="navigation_right.jsp"/>
        </div>
        <div id="footer" class="footer">
            <jsp:include page="footer.jsp"/>
        </div>
    </div>
</div>
</body>
</html>
