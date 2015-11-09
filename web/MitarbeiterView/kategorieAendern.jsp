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

            String kategorieName = request.getParameter("aendern");


            DatabaseHelper db = new DatabaseHelper();
            ResultSet kategorie = db.getKategorie(kategorieName);
            kategorie.next();

        %>
        <br><br>
        <table border="0" style="margin-left: 32%">
            <form style="margin:0 auto;max-width:60%;min-width:20%" method="post" enctype="multipart/form-data" action="../updateKategorieServlet">
                <tr>
                    <th><h2>Kategorie ändern</h2></th>
                </tr>
                <tr>
                    <td><label>Kategorie Name</label></td>
                    <td><input type="text" name="kategorieName" value="<%=kategorie.getString(1)%>"/></td>
                </tr>
                <tr>
                    <td><label>Übergeordnete Kategorie</label></td>
                    <td><select name="ueberKategorie" selected="<%=kategorie.getString(2)%>">
                        <option value=""></option>
                        <%
                            DatabaseHelper db2 = new DatabaseHelper();
                            ResultSet allKategories = db2.getAllKategories();
                            while (allKategories.next()) {
                                if (allKategories.getString(1).equals(kategorie.getString(2))) {
                        %>
                        <option value="<%=allKategories.getString(1)%>" selected="selected"><%=allKategories.getString(1)%>
                        </option>
                        <%
                        } else {
                        %>
                        <option value="<%=allKategories.getString(1)%>"><%=allKategories.getString(1)%>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select></td>
                </tr>
                <tr>
                    <td><label>Bild hochladen</label></td>
                    <td><label><input type="file" name="file"/></label></td>
                </tr>
                <tr>
                    <td>
                        <div class="submit">
                            <button type="submit" name=produktid value="<%=kategorieName%>">Speichern</button>
                        </div>
                    </td>
                </tr>

            </form>
        </table>
    </div>

</div>
<%
        db.disconnectDatabase();
        db2.disconnectDatabase();
    }
%>
</body>
</html>
