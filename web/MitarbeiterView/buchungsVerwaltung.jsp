<%@ page import="project.loginCookie" %>
<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.util.List" %>
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
    <div class="scrollVerwaltenTabelle">
      <h2>Buchung verwalten</h2>
      <table class="tableRightdiv">
        <tr class="underline">
          <th>Kunden ID </th>
          <th>Abholungsdatum</th>
          <th>Rückgabedatum</th>
          <th>Buchungs ID</th>
          <th>Status</th>
          <th>gebuchte Produkte</th>
          <td></td>
        </tr>
        <%
          DatabaseHelper db = new DatabaseHelper();
          try {

            ResultSet austehendeBuchungen = db.getBuchungen();
            ResultSetMetaData rsmd = austehendeBuchungen.getMetaData();
            int columnCount = rsmd.getColumnCount();


            while (austehendeBuchungen.next()){
              int id = austehendeBuchungen.getInt(4);
        %>
        <tr class="underline">
            <%
                  for (int i = 1; i <= columnCount ; i++){
                    %>
          <td><%=austehendeBuchungen.getString(i)%></td>
            <%}%>
          <td class="underline" style="word-wrap:break-word;max-width:200px;">
            <%DatabaseHelper db2 = new DatabaseHelper();
              List<String> gebucht = db2.getGebuchteProdukte(id);
              for (String s : gebucht) { %>
            <%= s %><br>
            <%    } db2.disconnectDatabase();
            %>
          </td>
          <td class="underline">
            <form method="post" action="../updateBuchungStatusServlet">
              <input type="hidden" name="buchungsID" value="<%=austehendeBuchungen.getString(4)%>">
              <br/><button name="aendern" type="submit" value="angenommen">Annehmen</button>
              <button name="aendern" type="submit" value="abgelehnt">Ablehnen</button>
            </form>
          </td>

          </tr>
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
