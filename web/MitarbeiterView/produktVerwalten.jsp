<%@ page import="DatabaseHelper" %>
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
    <table border="1">
      <tr>
        <td> </td>
        <td>Produktname</td>
        <td>Produktbezeichnung</td>
        <td>Kategorie</td>
        <td>Hersteller</td>
        <td>Anzahl der möglichen Buchungen</td>
      </tr>
      <%

        try {
          DatabaseHelper db = new DatabaseHelper();
          ResultSet allProducts = db.getAllProducts();
          ResultSetMetaData rsmd = allProducts.getMetaData();
          int columnCount = rsmd.getColumnCount();
          while (allProducts.next()){
            for (int i = 1; i <= columnCount ; i++){
              System.out.println(allProducts.getString(i));
            }

          }
        } catch (Exception e) {
          e.printStackTrace();
        }

      %>
      <tr>
        <td>wert1</td>
        <td>wert2</td>
      </tr>
    </table>

  </div>

</div>
<%
  }
%>
</body>
</html>

