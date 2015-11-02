
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
  String username = (String) request.getAttribute("username");
  String targetPage = (String) request.getAttribute("targetpage");
  if(username==null) username="";
  Cookie cookie = new Cookie ("LoginCookie",username);
  cookie.setMaxAge(120 * 60); //nach 2Stunden wird der Cookie gelöscht
  response.addCookie(cookie);

  Cookie logoutCookie = null;
  if(targetPage.equals("MitarbeiterView/main.jsp")){
    logoutCookie = new Cookie ("LoginCookieURL","../MitarbeiterView/loginKunde.jsp");
  }else if(targetPage.equals("index.jsp")) {
    logoutCookie = new Cookie("LoginCookieURL", "../index.jsp");
  }



  cookie.setMaxAge(120 * 60); //nach Stunden wird der Cookie gelöscht
  response.addCookie(logoutCookie);
%>

<html>
<head>
  <meta http-equiv="refresh" content="0; URL=<%=targetPage %>">
  <title>Cookie Saved</title>
</head>
<body>

</body>
</html>

