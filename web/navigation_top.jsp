<%@ page import="project.loginCookie" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="head.html"/>
</head>
<body>
<div class="left_menu_corner"></div>
<ul class="menu">
    <!-- Zeigt immer die Menüs Startseite, Produkte, Pakete und Buchungen an -->
    <li><a href="index.jsp" id="startseite" class="nav1">Startseite</a></li>
    <li><a href="produkte.jsp" id="produkte" class="nav2">Produkte</a></li>
    <li><a href="pakete.jsp" id="pakete" class="nav2">Pakete</a></li>
    <li><a href="buchungenKunde.jsp" id="buchungen" class="nav3">Buchungen</a></li>

    <%
        // den loginname des angemeldeten Nutzers auslesen und wenn jemand angemeldet ist, die buttons Daten ändern & abmelden einblenden
        Boolean loginState = false;
        String user = "";

        loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");
        if (loginDaten != null) {
            if (loginDaten.getRolle() == "Kunde") {
                loginState = true;
                user = loginDaten.getUsername();
            }
        } else {
            loginState = false;
        }
        if (loginState) {%>
    <li><a href="general/logout.jsp" id="abmelden" class="nav5"><%= user%> abmelden</a></li>
    <li><a href="kundeBearbeiten.jsp" id="konto" class="nav6">Daten &auml;ndern</a></li>
    <%} else {%>
    <li><a href="loginKunde.jsp" id="anmelden" class="nav5">Anmelden</a></li>
    <li><a href="register.jsp" id="registrieren" class="nav4">Registrieren</a></li>

    <%}%>

</ul>
<div class="right_menu_corner"></div>
</body>
</html>