<%--
  Created by IntelliJ IDEA.
  User: filip
  Date: 07.11.2015
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
        ResultSet rs = db.getAllPakete();
        while (rs.next()) {
          request.setAttribute("id", rs.getString(1));
          request.setAttribute("herst", rs.getString(3));
          request.setAttribute("preis", rs.getString(4));
          request.setAttribute("bezeichn", rs.getString(7));
          request.setAttribute("sourcepage","pakete.jsp");
      %>
      <jsp:include page="prodBox.jsp"/>
      <% }
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
