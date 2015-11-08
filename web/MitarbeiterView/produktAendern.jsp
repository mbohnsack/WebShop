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
    <meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
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
            <%

                int produktId = Integer.parseInt(request.getParameter("aendern"));


                DatabaseHelper db = new DatabaseHelper();
                ResultSet product = db.getProductsById(produktId);
                product.next();
                System.out.println(product.getString(1));
            %>
            <form style="margin:0 auto;max-width:60%;min-width:20%" method="post" action="../updateProduktServlet">
                <div>
                    <tr>
                        <th><h2>Produkt aendern</h2>
                </div>
                </th>
                </tr>
                <tr>
                    <td><label>Produkt Name</label></td>
                    <td><input type="text" name="produktname" value="<%=product.getString(7)%>"/></td>
                </tr>
                <tr>
                    <td><label>Informelle Bezeichnung</label></td>
                    <td><input type="text" name="produktname2" value="<%=product.getString(8)%>"/></td>
                </tr>
                <tr>
                    <td><label>Produktbeschreibung</label>
                    <td><textarea class="medium" name="produktbeschreibung" cols="40"
                                  rows="5"><%=product.getString(5)%></textarea></td>
                </tr>
                <tr>
                    <td><label>Technische Details</label>
                    <td><textarea class="medium" name="details" cols="40" rows="5"><%=product.getString(6)%></textarea>
                    </td>
                <tr>
                    <td><label>Kategorie</label></td>
                    <td>
                        <div><select name="kategorie" selected="<%=product.getString(2)%>">
                            <%
                                DatabaseHelper db2 = new DatabaseHelper();
                                ResultSet allKategories = db2.getAllKategories();
                                while (allKategories.next()) {
                                    if (allKategories.getString(1).equals(product.getString(2))) {
                            %>
                            <option value="<%=allKategories.getString(1)%>"
                                    selected="selected"><%=allKategories.getString(1)%>
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
                        </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Hersteller</label></td>
                    <td><input type="text" name="hersteller" readonly value="<%=product.getString(3)%>"/></td>
                <tr>
                    <td><label>Mietzins in &euro;/24h</label></td>
                    <td><input type="text" name="preis" value="<%=product.getString(4)%>"/></td>
                <tr>
                    <td><label>Anzahl der Buchungen</label></td>
                    <td><input type="text" name="anzahlMBuchungen" value="<%=product.getString(9)%>"/></td>
                <tr>
                    <td>
                        <div class="submit">
                            <button type="submit" name=produktid value="<%=produktId%>">Speichern</button>
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
