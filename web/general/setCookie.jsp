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
  String username =  request.getParameter("username");
  String targetPage =  request.getParameter("targetpage");
  String  sourcepage =  request.getParameter("sourcepage");


  loginCookie loginCookie = new loginCookie(username, sourcepage, targetPage);
  session.setAttribute("loginCookie",loginCookie);

  response.sendRedirect(targetPage);
%>


