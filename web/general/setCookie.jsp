<%@ page import="project.loginCookie" %>
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
  String  sourcepage = null;

  if(targetPage.equals("MitarbeiterView/main.jsp")){
    sourcepage = "../MitarbeiterView/login.jsp";
  }else if(targetPage.equals("index.jsp")) {
    sourcepage = "../index.jsp";
  }

  loginCookie loginCookie = new loginCookie(username,targetPage,sourcepage);
  session.setAttribute("loginCookie",loginCookie);

  response.sendRedirect(targetPage);
%>


