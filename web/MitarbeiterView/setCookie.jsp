
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 26.10.2015
  Time: 09:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%
  String username=request.getParameter("username");
  if(username==null) username="";


  Date now = new Date();
  String timestamp = now.toString();
  Cookie cookie = new Cookie ("username",username);
  cookie.setMaxAge(365 * 24 * 60 * 60);
  response.addCookie(cookie);

%>

<html>
<head>
  <title>Cookie Saved</title>
</head>
<body>
<p><a href="testCookie.jsp">Next Page to view the cookie value</a><p>

</body>

