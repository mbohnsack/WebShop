<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--

    Stellt die auf Facebook geteilte Seite mit den jeweiligen Produkten dar

-->
<head>
    <jsp:include page="head.html"/>
</head>
<body>
<div id="main_container">
    <div id="header">
        <jsp:include page="header.jsp"/>
    </div>
    <div id="main_content">
        <div id="navigation_top">
            <jsp:include page="navigation_top.jsp"/>
        </div>
        <div class="crumb_navigation"> Navigation: <span class="current">Produkte</span></div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp"/>
        </div>
        <div class="content">
            <%
                DatabaseHelper db = new DatabaseHelper();
                ResultSet rs = db.getAllProducts();
                // Request nach den Parametern, die mit der URL mitgegeben wurden und stellt dementsprechend die Produkte dar
                String bez = request.getParameter("prod_bezeichn");

                while (rs.next()) {
                    if (rs.getString(7).equals(bez)) {
                        request.setAttribute("id", rs.getString(1));
                        request.setAttribute("herst", rs.getString(3));
                        request.setAttribute("preis", rs.getString(4));
                        request.setAttribute("bezeichn", rs.getString(7));
            %>
            <jsp:include page="prodBox.jsp"/>
            <% }
            }
                db.disconnectDatabase();%>
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
