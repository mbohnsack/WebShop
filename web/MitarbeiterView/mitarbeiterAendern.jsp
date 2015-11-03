<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 21.10.2015
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
  <link rel="stylesheet" type="text/css" href="metro.css" />
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
    <jsp:include page="default/navigation.jsp" />
  </div>

  <div id="rightdiv">
    <%

      String username = request.getParameter("aendern");


      DatabaseHelper db = new DatabaseHelper();
      String mitarbeiterRolle = db.getMitarbeiterRolle(username);

    %>
    <form style="margin:0 auto;max-width:60%;min-width:20%"  method="post" action="../updateMitarbeiterServlet"><div ><h2>Mitarbeitern ändern</h2></div>
      <div ><label >Username</label><input readonly type="text" name="username" value="<%=username%>" /></div>
      <div ><label >Rolle</label><select name="rolle" selected="<%=mitarbeiterRolle%>">
        <option value="mitarbeiter">Mitarbeiter</option>
        <option value="admin">Administrator</option>

      </select>
      </div>
      <div class="submit"><button type="submit">Speichern</button></div>

    </form>

  </div>

</div>
<%
    db.disconnectDatabase();
  }
%>
</body>
</html>
