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
    <li class="divider"></li>
    <li><a href="produkte.jsp" id="produkte" class="nav2">Produkte</a></li>
    <li class="divider"></li>
    <li><a href="contact.jsp" id="kontakt" class="nav3">Kontakt</a></li>
    <li class="divider"></li>
    <li><a href="register.jsp" id="registrieren" class="nav4">Registrieren</a></li>
    <li class="divider"></li>
    <li><a href="buchungsEinsichtKunde.jsp" id="buchungsEinsicht" class="nav5">Buchungs Einsicht</a></li>
    <li class="divider"></li>
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
            <li><a href="../general/logout.jsp" id="abmelden" class="nav6"><%= user%> abmelden</a></li>
            <li class="divider"></li>
            <li><a href="kundeBearbeiten.jsp" id="konto" class="nav7">Daten &auml;ndern</a></li>
        <%}else{%>
            <li><a href="loginKunde.jsp" id="anmelden" class="nav5">Anmelden</a></li>
              <li class="divider"></li>
              <li><a href="register.jsp" id="registrieren" class="nav4">Registrieren</a></li>

            <li><a href="loginKunde.jsp" id="anmelden" class="nav6">anmelden</a></li>
        <%}%>

</ul>
<div class="right_menu_corner"></div>
</body>
</html>