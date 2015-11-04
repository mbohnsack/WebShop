<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: filip
  Date: 04.11.2015
  Time: 09:19
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="head.html"/>
</head>
<body>
<div class="prod_box">
    <div class="top_prod_box"></div>
    <div class="center_prod_box">
        <form id="details" action="details.jsp" method="post" style="height:42px;">
            <button style="margin:0; background:none; border:0; cursor:pointer;" name="details" type="submit"
                    value=<%= request.getAttribute("id") %>>
                <div class="product_title"><%= request.getAttribute("herst") %> <%= request.getAttribute("bezeichn") %>
                </div>
            </button>
        </form>
        <div class="product_img"><a href="details.jsp"><img style="width:92px; height: 92px" src="images/p1.jpg" alt=""
                                                            border="0"/></a></div>
        <div class="prod_price"><span class="price"><%= request.getAttribute("preis") %> €</span></div>

    </div>
    <div class="bottom_prod_box"></div>
    <div class="prod_details_tab">

        <form id="cart" action="addToCartServlet" method="post">
            <input type="hidden" name="produktID" value="<%= request.getAttribute("id") %>"/>
            <input type="hidden" name="sourcepage" value="produkte.jsp"/>
            <button name="addtocart" type="submit" value="add"><img src="images/cart.gif" alt="" border="0"
                                                                    class="left_bt"/></button>
        </form>
    </div>
</div>
</body>
</html>
