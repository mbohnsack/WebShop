<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%--
    Anzeige der Box eines Produkts, dass die jeweiligen Infos enthält.
    Erhält die Parameter vom jeweiligen Klick.
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
                    value=<%= request.getAttribute("herst") %>>
                <div class="product_title"><%= request.getAttribute("herst") %>
                </div>
            </button>
        </form>
        <div class="product_img"><img style="width:92px; height: 92px"
                                      src="/kategorieBild?name=<%= request.getAttribute("herst")%>" alt=""
                                      border="0"/></div>
    </div>
    <div class="bottom_prod_box"></div>
    <div class="prod_details_tab">

        <form id="cart" action="addToCartServlet" method="post">
            <input type="hidden" name="produktID" value="<%= request.getAttribute("herst") %>"/>
            <%
                String sourcepage = (String) request.getAttribute("sourcepage");
                request.setAttribute("sourcepage", sourcepage);
            %>
            <input type="hidden" name="sourcepage" value="<%= sourcepage%>"/>
        </form>
    </div>
</div>
</body>
</html>
