<%@ page import="project.DatabaseHelper" %>
<%@ page import="project.cart" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
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
        double gesamtPreis = 0;

        cart shoppingCart;
        session = request.getSession();
        shoppingCart = (cart) session.getAttribute("cart");
        if (shoppingCart == null) {
            shoppingCart = new cart();
            session.setAttribute("cart", shoppingCart);
        }
        List<Integer> produktids = shoppingCart.getCartItems();

        DatabaseHelper db = new DatabaseHelper();

        for (Integer produkt : produktids) {
            ResultSet produktDaten = db.getProductsById(produkt.intValue());
            try {
                while (produktDaten.next()) {
    %><span><p><%= produktDaten.getString("prod_bezeichn")%>
     | <%= produktDaten.getString("prod_preis")%>&euro;</p></span><%

                gesamtPreis = gesamtPreis + Double.parseDouble(produktDaten.getString("prod_preis"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    db.disconnectDatabase();
%>


    <br/>
    <span class="border_cart"></span> Gesamt: <span class="price"><%= gesamtPreis%>&euro;</span>
    <form name="buchen" method="post" action="buchungAbsenden.jsp">
        <button>Jetzt buchen</button>
    </form>

    <form name="leeren" method="post" action="cartLeerenServlet">
        <button>Korb leeren</button>
    </form>


</div>
</body>
</html>