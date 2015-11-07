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
  <meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
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
    <div>
        <h2>Produkte Verwalten</h2>
        <table class="tableRightdiv">
          <tr>

            <td>ProduktID</td>
            <td>Kategorie</td>
            <td>Hersteller</td>
            <td>Mietzins in &euro;/24h</td>
            <td>Beschreibung</td>
            <td>Technische Details</td>
            <td>Produktname</td>
            <td>Informelle Beschreibung</td>
            <td>Anzahl der Buchungen</td>
            <td></td>
          </tr>
          <%
            DatabaseHelper db = new DatabaseHelper();
            try {
                ResultSet allProducts = db.getAllProducts();
                ResultSetMetaData rsmd = allProducts.getMetaData();
                int columnCount = rsmd.getColumnCount();

                while (allProducts.next()){
          %>
            <tr>
                <%
                  for (int i = 1; i <= columnCount ; i++){
                    %>
                <td><%=allProducts.getString(i)%></td>
            <%}%>
            <td><form method="post" action="produktAendern.jsp"><button name="aendern" type="submit" value="<%=allProducts.getString(1)%>">Ändern</button></form>
                  <form method="post" action="../deleteProduktServlet"><button name="loeschen" type="submit" value="<%=allProducts.getString(1)%>">Löschen</button></form>
            </td>
          <tr>
          <%

              }
               allProducts.close();
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

