<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--
Zeigt den Inhalt der Kategorien an.
-->
<html>
<head>
    <jsp:include page="head.html"/>
</head>
<body>
<div id="main_container">
    <div id="header">
        <jsp:include page="header.jsp"/>
    </div>
    <div id="main_content">
        <%
            DatabaseHelper db = new DatabaseHelper();
            String produktCat = request.getParameter("category");
            ResultSet rs = null;
            int anzahl = db.getAnzahlProdukteInKategorie(produktCat);
        %>
        <div id="navigation_top">
            <jsp:include page="navigation_top.jsp"/>
        </div>
        <div class="crumb_navigation"> Navigation: <span class="current">Kategorie / <%= produktCat%></span></div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp"/>
        </div>
        <div id="content" class="content">
            <% // Wenn das Angeklickte nicht nur Produkte sondern auch Unterkategorien enthält
                if (!db.getUnterkategorie(produktCat).isEmpty()) {

                    List<String> ukat;
                    ukat = db.getUnterkategorie(produktCat);
                    // Fuer jedes Produkt in der Unterkategorie eine ProdBox darstellen mit den Infos
                    for (String temp : ukat) {
                        request.setAttribute("herst", temp);
            %>
            <jsp:include page="prodBox.jsp"/>
            <% }
            }   // Stellt die Produkte einer Kategorie in einer ProdBox dar
                rs = db.getProductsByKategorie(produktCat);
                for (int i = 0; i < anzahl; i++) {
                    while (rs.next()) {
                        try {
                            request.setAttribute("id", rs.getString(1));
                            request.setAttribute("herst", rs.getString(3));
                            request.setAttribute("preis", rs.getString(4));
                            request.setAttribute("bezeichn", rs.getString(7));
                            request.setAttribute("sourcepage", "cathegories.jsp");

                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
            %>
            <jsp:include page="prodBox.jsp"/>
            <% }
            }
                db.disconnectDatabase();
            %>
        </div>
        <div id="navigation_right" class="navigation_right">
            <jsp:include page="navigation_right.jsp"/>
        </div>
        <div id="footer" class="footer">
            <jsp:include page="footer.jsp"/>
        </div>
    </div>
</div>
</body>
</html>
