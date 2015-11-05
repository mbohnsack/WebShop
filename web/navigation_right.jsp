<%@ page import="project.DatabaseHelper" %>
<%@ page import="project.cart" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body>

<div class="shopping_cart">
    <div class="cart_title">Warenkorb</div><br/>

    <%
        double gesamtpreis = 0;
        cart shoppingCart;
        shoppingCart = (cart) session.getAttribute("cart");
        List<Integer> produktids = new ArrayList<Integer>();
        if(shoppingCart != null){
            //unchecked
            produktids = shoppingCart.getCartItems();
        }


        DatabaseHelper db = new DatabaseHelper();

    %>
    <table style="width: 98%" style="background-color: #a6847d" align="center">
        <th align="left">Artikel</th><th align="left">Preis</th><th align="left">Entf</th>
        <%

            for (Integer produkt : produktids) {

        %>
        <tr>
            <%
                ResultSet produktDaten = db.getProductsById(produkt);
                try {
                    while (produktDaten.next()) {
                        gesamtpreis = gesamtpreis + Double.parseDouble(produktDaten.getString("prod_preis"));
            %>
            <td align="left"><%= produktDaten.getString("prod_bezeichn")%></td>
            <td align="left"><%= produktDaten.getString("prod_preis")%>&euro;</td>
            <td align="left">
                <form id="cart" action="removeFromCart" method="post">
                    <input type="hidden" name="produktID" value="<%= produktids.indexOf(produkt) %>"/>
                    <input type="hidden" name="sourcepage" value="buchungAbsenden.jsp"/>
                    <button name="removeFromCart" type="submit">-</button>
                </form>
            </td>

            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </tr>
        <%
            }
        %>

        <tr><td align="left"><strong>Gesamtpreis</strong></td>
            <td align="left"><strong><%= gesamtpreis%>&euro;</strong></td> </tr>
    </table>
    <%
        db.disconnectDatabase();
    %>


    <table style="width: 98%" style="background-color: #a6847d" align="center">
        <tr>
            <td>
                <form name="buchen" method="post" action="buchungAbsenden.jsp">
                    <button>buchen</button>
                </form>
            </td>
            <td>
                <form name="leeren" method="post" action="cartLeerenServlet">
                    <button>Korb leeren</button>
                </form>

            </td>
        </tr>

    </table>





</div>
</body>
</html>