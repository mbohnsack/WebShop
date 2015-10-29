<%@page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="head.html" />
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


            for (int i = 0; i<db.getAnzahlProdukte(); i++) {
                ResultSet rs = db.getProductsById(i+1); %>
            <div class="prod_box">
                <div class="top_prod_box"></div>
                <div class="center_prod_box">
                    <% while(rs.next()){ %>
                    <div class="product_title"><%= rs.getString(3) %> <%= rs.getString(7) %></div>
                    <div class="product_img"><a href="details.jsp"><img style="width:92px; height: 92px" src="images/p1.jpg" alt="" border="0" /></a></div>
                    <div class="prod_price"><span class="price"><%= rs.getString(4) %></span></div>
                    <% } %>
                </div>
                <div class="bottom_prod_box"></div>
                <div class="prod_details_tab"> <a href="#" title="header=[Add to cart] body=[&nbsp;] fade=[on]"><img src="images/cart.gif" alt="" border="0" class="left_bt" /></a> <a href="#" title="header=[Specials] body=[&nbsp;] fade=[on]"><img src="images/favs.gif" alt="" border="0" class="left_bt" /></a> <a href="#" title="header=[Gifts] body=[&nbsp;] fade=[on]"><img src="images/favorites.gif" alt="" border="0" class="left_bt" /></a> <a href="details.html" class="prod_details">details</a> </div>
            </div>
            <% } %>

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