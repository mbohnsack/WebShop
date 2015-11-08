<%@ page import="project.loginCookie" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 28.10.2015
  Time: 08:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int anzahl = 0;%>
<%
    loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");

%>
<html lang="de">
<head>

    <link rel="stylesheet" type="text/css" href="style.css"/>
    <link rel="stylesheet" type="text/css" href="metro.css"/>
</head>
<body>

<%
    if (loginDaten == null) {
        String url = "/MitarbeiterView/login.jsp";
        response.sendRedirect(url);
    } else {
%>

<div id="seite">
    <div id="kopfbereich">
        <div align="center">VerwaltungsApp</div>
    </div>

    <div id="steuerung">
        <jsp:include page="default/navigation.jsp"/>
    </div>

    <div id="rightdiv">
        <br><br>
        <table border="0" style="margin-left: 38%">
            <form name="mitarbeiterform" method="post" action="../createMitarbeiter">
                <tr>
                    <th><h2>Mitarbeiter anlegen</h2></th>
                </tr>
                <tr>
                    <td>Username</td>
                    <td><input type="text" name="user"/></td>
                </tr>
                <tr>
                    <td>Passwort</td>
                    <td><input type="password" name="password"/></td>
                </tr>
                <tr>
                    <td>Mitarbeitertyp</td>
                    <td>
                        <select name="typ">
                            <option value="mitarbeiter">Mitarbeiter</option>
                            <option value="admin">Administrator</option>
                        </select></td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" value="anlegen"/></td>
                </tr>
            </form>
        </table>
    </div>

</div>
<%
    }
%>
</body>
</html>
