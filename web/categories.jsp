<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
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
  <jsp:include page="head.html" />
</head>
<body>
<div id="main_container">
  <div id="header">
    <jsp:include page="header.jsp" />
  </div>
  <div id="main_content">
    <%
      DatabaseHelper db = new DatabaseHelper();
    String produktCat = request.getParameter("category");
    int anzahl = db.getAnzahlProdukteInKategorie(produktCat);
    ResultSet rs = db.getProductsByKategorie(produktCat);
      %>
    <div id="navigation_top">
      <jsp:include page="navigation_top.jsp" />
    </div>
    <div class="crumb_navigation"> Navigation: <span class="current">Kategorie / <%= produktCat%></span> </div>
    <div class="navigation_left">
      <jsp:include page="navigation_left.jsp" />
    </div>
    <div id="content" class="content">
      <%
           for (int i = 0; i<anzahl; i++) {
           while(rs.next()){
      %>
      <div class="prod_box">
        <div class="top_prod_box"></div>
        <div class="center_prod_box">
          <form id="details" action="details.jsp" method="post" style="height:42px;"><button style="margin:0; background:none; border:0; cursor:pointer;" name="details" type="submit" value="<%= rs.getString(1) %>"><div class="product_title"><%= rs.getString(3) %> <%= rs.getString(7) %></div></button></form>
          <div class="product_img"><a href="details.jsp"><img style="width:92px; height: 92px" src="images/p1.jpg" alt="" border="0" /></a></div>
          <div class="prod_price"><span class="price"><%= rs.getString(4) %> €</span></div>
        </div>
        <div class="bottom_prod_box"></div>
        <div class="prod_details_tab"> <a href="#" title="header=[Add to cart] body=[&nbsp;] fade=[on]"><img src="images/cart.gif" alt="" border="0" class="left_bt" /></a> </div>
      </div>
      <% } }%>
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
