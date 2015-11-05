<%@ page import="project.loginCookie" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 27.10.2015
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //Cookie mit den Anmeldedaten auslesen und löschen
    loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");
    String targetPage = loginDaten.getTargetpage();
    if (targetPage.contentEquals("index.jsp")){
        targetPage = "../index.jsp";
    }

    //session beenden
    session.removeAttribute("loginCookie");
    // session.invalidate(); //Nich notwendig, auskommentiert, da es auch den cart löscht

    response.sendRedirect(targetPage);
%>

