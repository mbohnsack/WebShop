<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 21.10.2015
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String cookieName = "username";
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
        <div class="navlinks"><a href="../test.html" ><b>Home</b></a></div>
        <div class="navlinks"><a href="kontakt.html"><b>Kontakt</b></a></div>
        <div class="navlinks"><a href="beispiele.html"><b>Beispiele</b></a></div>
        <div class="navlinks"><a href="info.html"><b>Infos</b></a></div>

      </div>

      <div id="inhalt">
        hier kommt nun der Inhalt Ihrer Website11
        bla bla
      </div>

    </div>
  <%
  }
  %>
</body>


</html>
