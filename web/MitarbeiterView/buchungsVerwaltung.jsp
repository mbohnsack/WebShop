<%@ page import="project.loginCookie" %>
<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
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

%>
<html lang="de">
<head>

  <link rel="stylesheet" type="text/css" href="style.css" />

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
    <div>
      <table border="1" class="tableRightdiv">
        <tr>
          <td>Kunden ID </td>
          <td>Abholungsdatum</td>
          <td>Rückgabedatum</td>
          <td>Buchungs ID</td>
          <td>Status</td>
          <td></td>
        </tr>
        <%
          DatabaseHelper db = new DatabaseHelper();
          try {

            ResultSet austehendeBuchungen = db.getBuchungen();
            ResultSetMetaData rsmd = austehendeBuchungen.getMetaData();
            int columnCount = rsmd.getColumnCount();

            while (austehendeBuchungen.next()){
        %>
        <tr>
            <%
                  for (int i = 1; i <= columnCount ; i++){
                    %>
          <td><%=austehendeBuchungen.getString(i)%></td>
            <%}%>
          <td>
            <form method="post" action="../updateBuchungStatusServlet">
              <input type="hidden" name="buchungsID" value="<%=austehendeBuchungen.getString(1)%>"\>
              <button name="aendern" type="submit" value="angenommen">Annehmen</button>
              <button name="aendern" type="submit" value="abgelehnt">Ablehnen</button>
            </form>
          </td>
        <tr>
            <%

              }
               austehendeBuchungen.close();
               db.disconnectDatabase();
            } catch (Exception e) {
              e.printStackTrace();
            }

          %>

      </table>
    </div>

  </div>

</div>
<%
  }
%>
</body>
</html>
