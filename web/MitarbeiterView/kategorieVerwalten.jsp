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
    <div class="scroll">
      <table border="1" class="tableRightdiv">
        <tr>
          <td>Kategorie Name</td>
          <td>Übergeordnete Kategorie</td>
          <td>Bild</td>
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
        <tr>
            <%
                  for (int i = 1; i <= columnCount ; i++){
                    %>
          <td><%=allKategories.getString(i)%></td>
            <%}%>
          <td><form method="post" action="kategorieAendern.jsp"><button name="aendern" type="submit" value="<%=allKategories.getString(1)%>">Ändern</button></form>	</td>
        <tr>
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

