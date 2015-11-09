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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <div class="scrollVerwaltenTabelle">
      <h2>Kategorien Verwalten</h2>
      <table class="tableRightdiv">
        <tr class="underline">
          <th>Kategorie Name</th>
          <th>Übergeordnete Kategorie</th>
          <td></td>
        </tr>
        <%
          DatabaseHelper db = new DatabaseHelper();
          try {

            ResultSet allKategories = db.getAllKategories();
            ResultSetMetaData rsmd = allKategories.getMetaData();
            int columnCount = rsmd.getColumnCount();

            while (allKategories.next()){
        %>
        <tr class="underline">
            <%
                  for (int i = 1; i <= columnCount-1 ; i++){
                    %>
          <td><%=allKategories.getString(i)%></td>
            <%}%>
          <td><form method="post" action="kategorieAendern.jsp"><br/><button  name="aendern" type="submit" value="<%=allKategories.getString(1)%>">Ändern</button></form>
            <form method="post" action="../deleteKategorie">
              <button name="loeschen" type="submit" value="<%=allKategories.getString(1)%>">Löschen</button>
            </form></td>
        <tr class="csstd">
            <%

              }
               allKategories.close();
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

