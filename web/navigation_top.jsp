<%@ page import="project.loginCookie" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
<div class="left_menu_corner"></div>
<ul class="menu">
    <li><a href="index.jsp" id="startseite" class="nav1">Startseite</a></li>
    <li><a href="produkte.jsp" id="produkte" class="nav2">Produkte</a></li>
    <li><a href="pakete.jsp" id="pakete" class="nav2">Pakete</a></li>
    <li><a href="contact.jsp" id="kontakt" class="nav3">Kontakt</a></li>
    <li><a href="buchungenKunde.jsp" id="buchungen" class="nav3">Buchungen</a></li>

    <%
        // den loginname des angemeldeten Nutzers auslesen und wenn jemand angemeldet ist die buttons einblenden
        Boolean loginState = false;
        String user ="";

        loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");
        if (loginDaten!=null) {
            if(loginDaten.getRolle()=="Kunde"){
                loginState = true;
                user = loginDaten.getUsername();
            }
        } else{
            loginState = false;
        }
        if(loginState){%>
            <li><a href="general/logout.jsp" id="abmelden" class="nav5"><%= user%> abmelden</a></li>
            <li><a href="kundeBearbeiten.jsp" id="konto" class="nav6">Daten &auml;ndern</a></li>
        <%}else{%>
            <li><a href="loginKunde.jsp" id="anmelden" class="nav5">Anmelden</a></li>
              <li><a href="register.jsp" id="registrieren" class="nav4">Registrieren</a></li>

        <%}%>

</ul>
<div class="right_menu_corner"></div>
</body>
</html>