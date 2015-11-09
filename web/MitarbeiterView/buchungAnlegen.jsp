<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.loginCookie" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 27.10.2015
  Time: 16:46
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
%>
No Cookie found with the name
<%
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
            <form id="form" name="buchungform" method="post" action="../createBuchung">
                <tr>
                    <th><h2>Buchung anlegen</h2></th>
                </tr>
                <tr>
                    <td>Kunden E-Mail</td>
                    <td><input type="text" name="kunde"/></td>
                </tr>
                <tr>
                    <td>Abholdatum</td>
                    <td><input type="date" name="abholung"/></td>
                <tr>
                    <td>Abgabedatum</td>
                    <td><input type="date" name="abgabe"/></td>
                </tr>
                <tr>
                    <%
                        project.DatabaseHelper db = new project.DatabaseHelper();
                        try {
                            ResultSet rs = db.getAllProductsSortedByName();
                            int id;
                            String bezeichnung;
                            String hersteller;

                    %>

                    <td>Produkte</td>
                    <td>

                        <%
                            while (rs.next()) {
                                id = rs.getInt("prod_id");
                                bezeichnung = rs.getString("prod_bezeichn");
                                hersteller = rs.getString("prod_hersteller");
                        %>
                        <input type="checkbox" name="produkte" value="<%=id %>"/><%=hersteller %> <%=bezeichnung %><br/>
                        <%
                            }
                        %>
                    </td>
                </tr>
                </select>

                <%
                    } catch (Exception e) {
                    }
                %>
                <td><input type="submit" name="submit" value="pruefen"/>&nbsp;<input type="submit" name="submit"
                                                                                     value="Buchen"/></td>
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

