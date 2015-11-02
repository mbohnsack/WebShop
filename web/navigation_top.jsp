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
    <li><a href="contact.jsp" id="kontakt" class="nav6">Kontakt</a></li>
    <li class="divider"></li>
    <li><a href="register.jsp" id="registrieren" class="nav4">Registrieren</a></li>
    <li class="divider"></li>
    <%
        // den loginname des angemeldeten Nutzers auslesen
        Boolean loginState = false;
        String user = "";

        String cookieName = "LoginCookie";
        Cookie cookies [] = request.getCookies ();
        Cookie myCookie = null;
        if (cookies != null)
        {
            for (int i = 0; i < cookies.length; i++)
            {
                if (cookies [i].getName().equals (cookieName))
                {
                    myCookie = cookies[i];
                    user = myCookie.getValue() + " abmelden";
                    loginState = true;
                    break;
                }
            }
        }
        else{
            loginState = false;

        }
    %>
    <% if(loginState){%>
        <li><a href="../general/logout.jsp" id="abmelden" class="nav4"><%= user%></a></li>
        <li class="divider"></li>
        <li><a href="kundeBearbeiten.jsp" id="konto" class="nav4">Daten &auml;ndern</a></li>
    <%}else{%>
        <li><a href="loginKunde.jsp" id="anmelden" class="nav4">anmelden</a></li>
    <%}%>


</ul>
<div class="right_menu_corner"></div>
</body>
</html>