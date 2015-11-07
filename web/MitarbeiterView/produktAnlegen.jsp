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
            <form id="form" method="post" enctype="multipart/form-data" action="../addProduktServlet">
                <tr>
                    <th><h2>Produkt anlegen</h2></th>
                </tr>
                <tr>
                    <td><label>Produkt Name</label></td>
                    <td><input type="text" name="produktname"/></td>
                </tr>
                <tr>
                    <td><label>Informelle Bezeichnung</label></td>
                    <td><input type="text" name="produktname2"/></td>
                </tr>
                <tr>
                    <td><label>Produktbeschreibung</label></td>
                    <td><textarea class="medium" name="produktbeschreibung" cols="40" rows="5"></textarea></td>
                </tr>
                <tr>
                    <td><label>Technische Details</label></td>
                    <td><textarea class="medium" name="details" cols="40" rows="5"></textarea></td>
                </tr>
                <tr>
                    <td><label>Kategorie</label></td>
                    <td>
                        <div><select name="kategorie">
                            <%
                                DatabaseHelper db2 = new DatabaseHelper();
                                ResultSet allKategories = db2.getAllKategories();

                                while (allKategories.next()) {
                            %>
                            <option value="<%=allKategories.getString(1)%>"><%=allKategories.getString(1)%>
                            </option>
                            <%
                                }
                            %>
                        </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Hersteller</label></td>
                    <td><input type="text" name="hersteller"/></td>
                </tr>
                <tr>
                    <td><label>Mietzins in &euro;/24h</label></td>
                    <td><input type="text" name="preis"/></td>
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
