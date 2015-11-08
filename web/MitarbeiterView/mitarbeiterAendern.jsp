<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.loginCookie" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 21.10.2015
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <%

            String username = request.getParameter("aendern");


            DatabaseHelper db = new DatabaseHelper();
            String mitarbeiterRolle = db.getMitarbeiterRolle(username);

        %>
        <br><br>
        <table border="0" style="margin-left: 32%">
            <form style="margin:0 auto;max-width:60%;min-width:20%" method="post" action="../updateMitarbeiterServlet">
                <tr>
                    <th><h2>Mitarbeiter ändern</h2></th>
                </tr>
                <tr>
                    <td><label>Username</label></td>
                    <td><input disabled type="text" name="username" value="<%=username%>"/></td>
                </tr>
                <tr>
                    <td><label>Rolle</label></td>
                    <td><select name="rolle" selected="<%=mitarbeiterRolle%>">
                        <option value="mitarbeiter">Mitarbeiter</option>
                        <option value="admin">Administrator</option>

                    </select></td>
                </tr>
                <tr>
                    <td>
                        <div class="submit">
                            <button type="submit">Speichern</button>
                        </div>
                    </td>
                </tr>

            </form>
        </table>
    </div>

</div>
<%
        db.disconnectDatabase();
    }
%>
</body>
</html>
