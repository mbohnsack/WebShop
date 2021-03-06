<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Zeigt die Detailansicht des jeweiligen Produktes an, wenn auf dessen Titel geklickt wird.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="head.html"/>
</head>
<body>
<div id="main_container">
    <%
        DatabaseHelper db = new DatabaseHelper();
        // Ruft den Parameter ID ab.
        Integer id = Integer.parseInt(request.getParameter("details"));
        ResultSet rs = db.getProductsById(id);
        List<Integer> i = new ArrayList();
        rs.next();
    %>
    <div id="header">
        <jsp:include page="header.jsp"/>
    </div>
    <div id="main_content">
        <div id="navigation_top">
            <jsp:include page="navigation_top.jsp"/>
        </div>
        <div class="crumb_navigation"> Navigation: <span
                class="current"><%= rs.getString(2) %> / <%= rs.getString(3) %> <%= rs.getString(7) %></span></div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp"/>
        </div>
        <div class="content">
            <div class="center_content">
                <% // Wenn das angeklickte Produkt ein Paket ist, stell nicht die Detailansicht sondern die einzelnen Produkte dar
                    if (rs.getString(3).equals("Paket")) {
                        ResultSet rs3 = db.getProdukteOfPaket(rs.getInt(1));
                        while (rs3.next()) {
                            i.add(rs3.getInt(4));
                        }
                        // Stell jedes Produkt in einer ProdBox dar
                        for (int g : i) {
                            ResultSet rs2 = db.getProductsById(g);
                            while (rs2.next()) {
                                request.setAttribute("id", rs2.getString(1));
                                request.setAttribute("herst", rs2.getString(3));
                                request.setAttribute("preis", rs2.getString(4));
                                request.setAttribute("bezeichn", rs2.getString(7));
                                request.setAttribute("sourcepage", "cathegories.jsp");
                %>
                <jsp:include page="prodBox.jsp"/>
                <% }
                }
                    // Wenn das angeklickte Produkt kein Paket sondern ein Produkt ist, stell die Detailansicht mit den speziellen Infos dar.
                } else {
                %>
                <div class="center_title_bar"><%= rs.getString(3) %> <%= rs.getString(7) %> (ID: <%= rs.getString(1) %>
                    )
                </div>
                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big">
                        <div class="product_img_big"><a
                                href="javascript:popImage('/produktBild?prodid=<%= rs.getString(1)%>&&number=1','Some Title')"
                                title="header=[Zoom] body=[&nbsp;] fade=[on]"><img style="width:92px; height: auto"
                                                                                   src="/produktBild?prodid=<%= rs.getString(1)%>&&number=1"
                                                                                   alt="" border="0"/></a>

                            <div class="thumbs"><a href="#" title="header=[Thumb1] body=[&nbsp;] fade=[on]"><img
                                    style="width:20px; height: 20px"
                                    src="/produktBild?prodid=<%= rs.getString(1)%>&&number=1" alt="" border="0"/></a> <a
                                    href="#" title="header=[Thumb2] body=[&nbsp;] fade=[on]"><img
                                    style="width:20px; height: 20px"
                                    src="/produktBild?prodid=<%= rs.getString(1)%>&&number=1" alt="" border="0"/></a> <a
                                    href="#" title="header=[Thumb3] body=[&nbsp;] fade=[on]"><img
                                    style="width:20px; height: 20px"
                                    src="/produktBild?prodid=<%= rs.getString(1)%>&&number=1" alt="" border="0"/></a>
                            </div>
                        </div>
                        <div class="details_big_box">
                            <div class="product_title_big"><%= rs.getString(8) %>
                            </div>
                            <div class="product_description"><%= rs.getString(5) %><br><br>
                                Details: <span class="blue"><%= rs.getString(6) %></span><br/></div>
                            <br>

                            <div class="specifications"> Buchungen(Anzahl): <span
                                    class="blue"><%= rs.getString(9) %></span><br/>
                            </div>
                            <div class="prod_price_big"><span class="price"><%= rs.getString(4) %>€</span></div>
                            <form id="cart" action="addToCartServlet" method="post">
                                <input type="hidden" name="produktID" value="<%= rs.getString(1) %>"/>
                                <input type="hidden" name="sourcepage" value="produkte.jsp"/>
                                <button name="addtocart" type="submit" value="add"><img src="images/cart.gif" alt=""
                                                                                        border="0"
                                                                                        class="left_bt"/>Zum Warenkorb
                                    hinzufügen
                                </button>
                            </form>

                        </div>
                    </div>
                    <div class="bottom_prod_box_big"></div>
                </div>
                <% } %>
            </div>
            <% db.disconnectDatabase(); %>
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
