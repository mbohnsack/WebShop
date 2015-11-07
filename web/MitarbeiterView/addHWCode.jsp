<%@ page import="project.DatabaseHelper" %>
<%@ page import="project.loginCookie" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: Malte
  Date: 05.11.2015
  Time: 13:22
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
%>
Bitte loggen Sie sich ein!
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
     <form style="margin:0 auto;max-width:60%;min-width:20%"  method="post" action="../addHWCodeServlet">
       <select name="produkt" >
         <%
           DatabaseHelper db2 = new DatabaseHelper();
           ResultSet allKategories = db2.getAllProducts();

         %>
         <option value=""></option>
         <%
           while (allKategories.next()){
         %>

         <option value="<%=allKategories.getString(1)%>"><%=allKategories.getString(7)%></option>
         <%
           }
         %>
       </select>
       <input type="text" name="hwcode">
       <div class="submit"><input type="submit" value="Hinzufügen"/></div>
     </form>
   </div>
  </div>

</div>
<%
  }
%>
</body>
</html>
