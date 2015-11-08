<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="head.html" />
</head>
<body>
<div class="center_title_bar">Am h&auml;ufigsten gebuchte Produkte</div>
<%
    DatabaseHelper db = new DatabaseHelper();
    ResultSet rs = db.getTopProducts();

        while(rs.next()){
            request.setAttribute("id", rs.getString(1));
            request.setAttribute("herst", rs.getString(3));
            request.setAttribute("preis", rs.getString(4));
            request.setAttribute("bezeichn", rs.getString(7));
            request.setAttribute("sourcepage","index.jsp");


    %><jsp:include page="prodBox.jsp" /><%

    }db.disconnectDatabase();

%>
</body>
</html>