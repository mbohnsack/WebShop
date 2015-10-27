<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 21.10.2015
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>

</head>

<%
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
        break;
      }
    }
  }



%>
<html lang="de">
<head>

  <link rel="stylesheet" type="text/css" href="style.css" />

</head>
<body>

<%if (myCookie == null) {
%>
No Cookie found with the name <%=cookieName%>
<%
}
else {
%>

<div id="seite">
  <div id="kopfbereich">
    <div align="center">VerwaltungsApp</div>
  </div>

  <div id="steuerung">
    <div class="navlinks">Willkommen, <%=myCookie.getValue()%> </br> du bist angemeldet als "Admin" <input value="Logout" type="submit"></div>

    <div class="navlinks"><a href=""><b>Buchungen anlegen</b></a></div>

    <div class="navlinks"><a href="" ><b>Pakete anlegen</b></a></div>
    <div class="navlinks"><a href="" ><b>Pakete verwalten</b></a></div>
    <div class="navlinks"><a href="info.html"><b>Produkte anlegen</b></a></div>
    <div class="navlinks"><a href="info.html"><b>Produkte verwalten</b></a></div>
    <div class="navlinks"><a href="info.html"><b>Kategorie anlegen</b></a></div>
    <div class="navlinks"><a href="info.html"><b>Kategorie verwalten</b></a></div>
    <div class="navlinks"><a href="info.html"><b>Mitarbeiter anlegen</b></a></div>
    <div class="navlinks"><a href="info.html"><b>Mitarbeiter verwalten</b></a></div>
  </div>

  <div id="rightdiv">

  </div>

</div>
<%
  }
%>
</body>
</html>
