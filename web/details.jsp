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
  <div id="header">
    <jsp:include page="header.html" />
  </div>
  <div id="main_content">
    <div id="navigation_top">
      <jsp:include page="navigation_top.html" />
    </div>
    <div class="crumb_navigation"> Navigation: <span class="current">Details</span> </div>
    <div class="navigation_left">
      <jsp:include page="navigation_left.html" />
    </div>
    <div class="content">

      <div class="center_content">
        <div class="center_title_bar">Motorola 156 MX-VL</div>
        <div class="prod_box_big">
          <div class="top_prod_box_big"></div>
          <div class="center_prod_box_big">
            <div class="product_img_big"> <a href="javascript:popImage('images/big_pic.jpg','Some Title')" title="header=[Zoom] body=[&nbsp;] fade=[on]"><img src="images/laptop.gif" alt="" border="0" /></a>
              <div class="thumbs"> <a href="#" title="header=[Thumb1] body=[&nbsp;] fade=[on]"><img src="images/thumb1.gif" alt="" border="0" /></a> <a href="#" title="header=[Thumb2] body=[&nbsp;] fade=[on]"><img src="images/thumb1.gif" alt="" border="0" /></a> <a href="#" title="header=[Thumb3] body=[&nbsp;] fade=[on]"><img src="images/thumb1.gif" alt="" border="0" /></a> </div>
            </div>
            <div class="details_big_box">
              <div class="product_title_big">My Cinema-U3000/DVBT, USB 2.0 TV BOX External, White</div>
              <div class="specifications"> Verfügbarkeit: <span class="blue">In stoc</span><br />
                Garantie: <span class="blue">24 luni</span><br />
                Tip transport: <span class="blue">Mic</span><br />
                Pretul include <span class="blue">TVA</span><br />
              </div>
              <div class="prod_price_big"><span class="price">270$</span></div>
              <a href="#" class="addtocart">add to cart</a> <a href="#" class="compare">compare</a> </div>
          </div>
          <div class="bottom_prod_box_big"></div>
        </div>
        </div>

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
