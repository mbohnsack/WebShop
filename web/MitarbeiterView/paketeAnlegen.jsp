<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.loginCookie" %>
<%@ page import="project.DatabaseHelper" %>
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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
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

    <div class="rightdiv">
        <br><br>
        <table border="0" style="margin-left: 18%">
            <tr id="form" method="post" action="../addPaketServlet">
            <tr>
                <th><h2>Paket anlegen</h2></th>
            </tr>
            <tr>
                <td><label>Paketname</label></td>
                <td><input type="text" name="paketname"/></td>
            </tr>
            <tr>
                <td><label>Informeller Paketname</label></td>
                <td><input type="text" name="paketname2"/></td>
            </tr>
            <tr>
                <td><label>Paketbeschreibung</label></td>
                <td><textarea class="medium" name="paketbeschreibung" cols="40" rows="5"></textarea></td>
            </tr>
            <tr>
                <td><label>Technische Daten</label></td>
                <td><textarea class="medium" name="details" cols="40" rows="5"></textarea></td>
            </tr>
            <tr>
                <td><label>Kategorie</label></td>

                <td>
                    <select name="kategorie">

                        <option value="Paket">Paket</option>

                    </select>
                </td>
            <tr>
                <td><label>Hersteller</label></td>
                <td><input type="text" name="hersteller" value="Paket" readonly/></td>
            </tr>
            <tr>
                <td><label>Mietzins in &euro;/24h</label></td>
                <td><input type="text" name="preis"/></td>
            </tr>
            <tr>
                <td>
                    <label>Produkte</label>
                <td>
                    <div class="scroll" style="max-width:100%">
                        <table border="1">
                            <tr>
                                <td>Produktname</td>
                                <td>Prio</td>
                            </tr>
                            <%
                                DatabaseHelper db = new project.DatabaseHelper();
                                try {
                                    ResultSet rs = db.getAllProductsSortedByName();
                                    int id;
                                    String bezeichnung;
                                    String hersteller;
                                    while (rs.next()) {
                                        id = rs.getInt("prod_id");
                                        bezeichnung = rs.getString("prod_bezeichn");
                                        hersteller = rs.getString("prod_hersteller");
                            %>

                            <tr>
                                <td>
                                    <input type="checkbox" name="produkte"
                                           value=<%=id%>/><%= hersteller %> <%=bezeichnung %><br/>
                                </td>
                                <td>
                                    <select name="<%=id%>">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                    </select>
                                </td>
                            </tr>

                            <%
                                }
                            %>
                        </table>
                    </div>
                </td>
            </tr>
            <%
                } catch (Exception e) {
                }
            %>
            <tr>
                <td>
                    <input class="submit" type="submit" name="anlegen" value="Anlegen"/>

            </td></tr>
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


