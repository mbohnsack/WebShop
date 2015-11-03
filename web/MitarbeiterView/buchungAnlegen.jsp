<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.loginCookie" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 27.10.2015
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int anzahl=0;%>
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
    <form name="buchungform" method="post" action="../createBuchung">
      Kundenmail: <input type="text" name="kunde" /><br/>
      Abholdatum: <input type="date" name="abholung"/><br/>
      Abgabedatum: <input type="date" name="abgabe" /><br/>
      <%
        project.DatabaseHelper db = new project.DatabaseHelper();
        try{
          ResultSet rs= db.getAllProducts();
          int id;
          String bezeichnung;

      %>
      Produkte: <br/>
      <%
        while(rs.next())
        {
          id= rs.getInt("prod_id");
          bezeichnung=rs.getString("prod_bezeichn");
      %>
      <input type="checkbox"  name="produkte" value=<%=id %>/><%=bezeichnung %><br/>
      <%
        }
      %>
    </select>

      <%
        }
        catch(Exception e){}
      %>
      <input type="submit" name="pruefen" value="pruefen"/> <<input type="submit" name="buchen" value="Buchen"/>
    </form>

  </div>

</div>
<%
    db.disconnectDatabase();
  }
%>
</body>
</html>

