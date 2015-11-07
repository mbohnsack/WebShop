<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="project.loginCookie" %>

<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 21.10.2015
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@page  language="java" %>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%
  loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");


%>
<html lang="de">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="stylesheet" type="text/css" href="style.css" />
  <link rel="stylesheet" type="text/css" href="metro.css" />
</head>
<body>

<%if (loginDaten == null) {
%>
No Cookie found with the name
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
    <div class="scrollVerwaltenTabelle">
      <h2>Mitarbeiter Verwalten</h2>
      <table class="tableRightdiv">
        <tr class="underline">

          <th>Mitarbeiter Username</th>
          <th>Rolle</th>
          <th></th>
          <td></td>
        </tr>
        <%
          DatabaseHelper db = new DatabaseHelper();
          try {
            ResultSet allMitarbeiter = db.getAllMitarbeiter();
            while (allMitarbeiter.next()){
        %>
        <tr class="underline">
          <td><%=allMitarbeiter.getString(2)%></td>
          <td><%=allMitarbeiter.getString(1)%></td>
          <td><form method="post" action="mitarbeiterAendern.jsp"><br/><button name="aendern" type="submit" value="<%=allMitarbeiter.getString(2)%>">Ändern</button></form>	</td>
          <td><form method="post" action="../deleteMitarbeiterServelt"><br/><button name="loeschen" type="submit" value="<%=allMitarbeiter.getString(2)%>">Löschen</button></form>	</td>
        <tr>
            <%

              }
               allMitarbeiter.close();
            } catch (Exception e) {
              e.printStackTrace();
            }

          %>

      </table>
    </div>
  </div>

</div>
<%
    db.disconnectDatabase();
  }
%>
</body>
</html>

