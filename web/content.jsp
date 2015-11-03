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
        DatabaseHelper db2 = new DatabaseHelper();
%>
<div class="prod_box">
    <div class="top_prod_box"></div>
    <div class="center_prod_box">
        <form id="details" action="details.jsp" method="post" style="height:42px;"><button style="margin:0; background:none; border:0; cursor:pointer;" name="details" type="submit" value="<%= rs.getString(1) %>"><div class="product_title"><%= rs.getString(3) %> <%= rs.getString(7) %> (<%= db2.getAnzahlBuchungById(rs.getInt(1)) %>)</div>
        </button></form>
        <div class="product_img"><a href="details.jsp"><img style="width:92px; height: 92px" src="images/p1.jpg" alt="" border="0" /></a></div>
        <div class="prod_price"><span class="price"><%= rs.getString(4) %> €</span></div>
    </div>
    <div class="bottom_prod_box"></div>
    <div class="prod_details_tab"><form id="cart" action="cart.jsp" method="post"><button name="addtocart" type="submit" value="add"><img src="images/cart.gif" alt="" border="0" class="left_bt" /></button></form></div>
</div>
<% db2.disconnectDatabase();}db.disconnectDatabase(); %>
</body>
</html>