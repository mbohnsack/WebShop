<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.DatabaseHelper" %>
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
        response.sendRedirect( url );
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
            <form id="form" method="post" enctype="multipart/form-data" action="../addKategorieServlet">
                <tr>
                    <th><h2>Kategorie anlegen</h2></th>
                </tr>
                <tr>
                    <td><label>Kategorie Name</label></td>
                    <td><input type="text" name="kategorieName"/></td>
                </tr>
                <tr>
                    <td><label>Übergeordenete Kategorie</label></td>
                    <td><select name="ueberKategorie">
                        <%
                            DatabaseHelper db2 = new DatabaseHelper();
                            ResultSet allKategories = db2.getAllKategories();
                        %>
                        <option value=""></option>
                        <%
                            while (allKategories.next()) {
                        %>

                        <option value="<%=allKategories.getString(1)%>"><%=allKategories.getString(1)%>
                        </option>
                        <%
                            }
                        %>
                    </select>
                    </td>
                </tr>

                <tr>
                    <td><label>Bild hochladen</label></td>
                    <td><label>
                        <div>Datei auswählen</div>
                        <input type="file" name="file"/></label></td>
                </tr>
                <tr>
                    <td>
                        <div class="submit"><input type="submit" value="Speichern"/></div>
                    </td>
                </tr>
            </form>
        </table>
    </div>

</div>
<%
        db2.disconnectDatabase();
    }
%>
</body>
</html>