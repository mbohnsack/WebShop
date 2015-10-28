<%@page import="project.DatabaseHelper" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Hipster Rental Corp.</title>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="style.css" />
    <!--[if IE 6]>
    <link rel="stylesheet" type="text/css" href="iecss.css" />
    <![endif]-->
    <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="index.js"></script>
</head>
<body>
<div id="main_container">
    <div id="header">
        <jsp:include page="header.html" />
    </div>
    <div id="main_content">
        <div id="navigation_top">
            <jsp:include page="navigation_top.html" />
        </div>
        <div class="crumb_navigation"> Navigation: <span class="current">Produkte</span> </div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.html" />
        </div>

        <div class="content">
        <%

            DatabaseHelper db = new DatabaseHelper();
            ResultSet rs = db.getProductsById(1);

        %>
            <TABLE BORDER="1">
                <% while(rs.next()){ %>
                <TR>
                    <TD> <%= rs.getString(1) %></td>
                    <TD> <%= rs.getString(2) %></TD>
                </TR>
                <% } %>
            </TABLE>
            Testdaten


        </div>
        <div id="navigation_right" class="navigation_right">
            <jsp:include page="navigation_right.html" />
        </div>
        <div id="footer" class="footer">
            <jsp:include page="footer.html" />
        </div>
</div>
    </div>
</body>
</html>