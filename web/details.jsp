<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: filip
  Date: 28.10.2015
  Time: 12:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <jsp:include page="head.html" />
</head>
<body>
<div id="main_container">
  <%
    DatabaseHelper db = new DatabaseHelper();
    Integer id = Integer.parseInt(request.getParameter("details"));
    ResultSet rs = db.getProductsById(id);
     while(rs.next()){
  %>
  <div id="header">
    <jsp:include page="header.jsp" />
  </div>
  <div id="main_content">
    <div id="navigation_top">
      <jsp:include page="navigation_top.jsp" />
    </div>
    <div class="crumb_navigation"> Navigation: <span class="current"><%= rs.getString(2) %> / <%= rs.getString(3) %> <%= rs.getString(7) %></span> </div>
    <div class="navigation_left">
      <jsp:include page="navigation_left.jsp" />
    </div>
    <div class="content">
      <div class="center_content">

        <div class="center_title_bar"><%= rs.getString(3) %> <%= rs.getString(7) %> (ID: <%= rs.getString(1) %>)</div>
        <div class="prod_box_big">
          <div class="top_prod_box_big"></div>
          <div class="center_prod_box_big">
            <div class="product_img_big"> <a href="javascript:popImage('images/big_pic.jpg','Some Title')" title="header=[Zoom] body=[&nbsp;] fade=[on]"><img src="images/laptop.gif" alt="" border="0" /></a>
              <div class="thumbs"> <a href="#" title="header=[Thumb1] body=[&nbsp;] fade=[on]"><img src="images/thumb1.gif" alt="" border="0" /></a> <a href="#" title="header=[Thumb2] body=[&nbsp;] fade=[on]"><img src="images/thumb1.gif" alt="" border="0" /></a> <a href="#" title="header=[Thumb3] body=[&nbsp;] fade=[on]"><img src="images/thumb1.gif" alt="" border="0" /></a> </div>
            </div>
            <div class="details_big_box">
              <div class="product_title_big"><%= rs.getString(8) %></div>
              <div class="product_description"><%= rs.getString(5) %><br><br>
                Details: <span class="blue"><%= rs.getString(6) %></span><br /> </div><br>
              <div class="specifications"> Verfügbarkeit(Anzahl): <span class="blue">Verfügbar (<%= rs.getString(9) %>)</span><br />
              </div>
              <div class="prod_price_big"><span class="price"><%= rs.getString(4) %>€</span></div>
              <a href="#" class="addtocart">add to cart</a></div>
          </div>
          <div class="bottom_prod_box_big"></div>
        </div>
        </div>
<% } %>
    </div>
      <div id="navigation_right" class="navigation_right">
        <jsp:include page="navigation_right.jsp" />
      </div>
      <div id="footer" class="footer">
        <jsp:include page="footer.jsp" />
      </div>
    </div>
  </div>
</body>
</html>
