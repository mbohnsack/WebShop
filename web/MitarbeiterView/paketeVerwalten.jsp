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
      <h2>Pakete Verwalten</h2>
      <table class="tableRightdiv">
        <tr>

          <th>ProduktID</th>
          <th>Kategorie</th>
          <th>Hersteller</th>
          <th>Preis</th>
          <th>Beschreibung</th>
          <th>Details</th>
          <th>Produktname</th>
          <th>Beschreibung</th>
          <th>Anzahl der Buchungen</th>
          <th></th>
        </tr>
        <%
          DatabaseHelper db = new DatabaseHelper();
          try {
            ResultSet allPakete = db.getAllPakete();
            ResultSetMetaData rsmd = allPakete.getMetaData();
            int columnCount = rsmd.getColumnCount();

            while (allPakete.next()){
        %>
        <tr class="underline">
            <%
                  for (int i = 1; i <= columnCount ; i++){
                    %>
          <td><%=allPakete.getString(i)%></td>
            <%}%>
          <td><form method="post" action="paketeAendern.jsp"><br/><button name="aendern" type="submit" value="<%=allPakete.getString(1)%>">Ändern</button></form>	</td>
        <tr class="underline">
            <%

              }
               allPakete.close();
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

