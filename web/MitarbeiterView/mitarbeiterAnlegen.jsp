<%@ page import="project.loginCookie" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 28.10.2015
  Time: 08:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int anzahl=0;%>
<%
  loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");

%>
<html lang="de">
<head>

  <link rel="stylesheet" type="text/css" href="style.css" />
  <link rel="stylesheet" type="text/css" href="metro.css" />
</head>
<body>

<%if (loginDaten == null) {
  String url = "/MitarbeiterView/login.jsp";
  response.sendRedirect( url );
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
   <form name="mitarbeiterform" method="post" action="../createMitarbeiter">
     Username: <input type="text" name="user" /><br/>
     Passwort: <input type="password" name="password"/><br/>
     Mitarbeitertyp:
     <select name="typ">
       <option value="mitarbeiter">Mitarbeiter</option>
       <option value="admin">Administrator</option>
       </select></br>
     <input type="submit" value="anlegen"/>
   </form>
  </div>

</div>
<%
  }
%>
</body>
</html>
