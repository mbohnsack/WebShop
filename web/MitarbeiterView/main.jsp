<%@ page import="project.loginCookie" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 21.10.2015
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");

  String cookieName = "loginCookie";
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
  <link rel="stylesheet" type="text/css" href="metro.css" />

</head>
<body>

  <%if (myCookie == null) {
    %>
    Bitte loggen Sie sich ein!
    <%
  }
  else {
  %>

    <div id="seite">
      <div id="kopfbereich">
        <div align="center">VerwaltungsApp</div>
      </div>

      <div id="steuerung">
          <jsp:include page="default/navigation.jsp" />
      </div>

      <div id="rightdiv">
          Willkommen in der MitarbeiterApp hier haben Sie die Möglichkeiten ihre Daten anzulegen und zu verwalten.

      </div>

    </div>
  <%
  }
  %>
</body>
</html>
