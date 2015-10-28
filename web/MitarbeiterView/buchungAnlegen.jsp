<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 27.10.2015
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<form name="buchungform" method="post" action="../createBuchung">
  Abholdatum: <input type="date" name="abholung"><br/>
  Abgabedatum: <input type="date" name="abgabe"><br/>
  <%

    //String tables = "<table><tr><td>hiii</td></tr></table>";
//out.print(names);
    try{
      project.DatabaseHelper db = new project.DatabaseHelper();
      ResultSet rs= db.getAllProducts();
      String id;
      String bezeichnung;

  %>
  <select name="produktwahl">
  <%
    while(rs.next())
    {
      id= rs.getString("prod_id");
      bezeichnung=rs.getString("prod_bezeichn");
  %>
  <option value= "<%=id  %>" ><%=bezeichnung %></option>
  </select>
</form>
</body>
</html>
