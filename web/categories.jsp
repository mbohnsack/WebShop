<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: filip
  Date: 28.10.2015
  Time: 12:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            System.out.println(db.getUnterkategorie(produktCat));
        %>
        <div id="navigation_top">
            <jsp:include page="navigation_top.jsp"/>
        </div>
        <div class="crumb_navigation"> Navigation: <span class="current">Kategorie / <%= produktCat%></span></div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp"/>
        </div>
        <div id="content" class="content">
            <%
                if (!db.getUnterkategorie(produktCat).isEmpty()) {

                    List<String> ukat;
                    ukat = db.getUnterkategorie(produktCat);

                    for (String temp : ukat) {
                        request.setAttribute("herst", temp);
            %>
            <jsp:include page="prodBox.jsp"/>
            <% }}
                  rs = db.getProductsByKategorie(produktCat);
                    for (int i = 0; i < anzahl; i++) {
                        while (rs.next()) {
                            request.setAttribute("id", rs.getString(1));
                            request.setAttribute("herst", rs.getString(3));
                            request.setAttribute("preis", rs.getString(4));
                            request.setAttribute("bezeichn", rs.getString(7));
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
