
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 26.10.2015
  Time: 09:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Cookie erzeugen --%>
<%
  String username=request.getParameter("username");
  if(username==null) username="";
  Cookie cookie = new Cookie ("username",username);
  cookie.setMaxAge(365 * 24 * 60 * 60);
  response.addCookie(cookie);

%>

<html>
<head>
  <title>Cookie Saved</title>
</head>
<body>
<--! automatische Weiterleitung -->
<meta http-equiv="refresh" content="0; URL=main.jsp">
</body>

