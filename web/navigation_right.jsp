<%@ page import="java.util.ArrayList" %>
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
    <div class="cart_title">Warenkorb</div>

        <%/*
            List bestellListe = (List)request.getAttribute("bestellListe");

            for(int i=1; i<bestellListe.size();i++){

        }



        */%>

        <span class="border_cart"></span> Gesamt: <span class="price">350$</span>

        <form name="buchen" method="post" action="buchungAbsenden.jsp">
            <button>Jetzt buchen</button>
        </form>


    <div class="cart_icon"><a href="#" title="header=[Checkout] body=[&nbsp;] fade=[on]"><img src="images/shoppingcart.png" alt="" width="48" height="48" border="0" /></a></div>
</div>


</body>
</html>