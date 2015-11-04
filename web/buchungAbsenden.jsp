<%@ page import="project.DatabaseHelper" %>
<%@ page import="project.cart" %>
<%@ page import="project.loginCookie" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="head.html"/>
</head>
<body>
<div id="main_container">
    <div id="header">
        <jsp:include page="header.jsp"/>
    </div>
    <div id="main_content">
        <div id="navigation_top">
            <jsp:include page="navigation_top.jsp"/>
        </div>
        <div class="crumb_navigation"> Navigation: <span class="current">Buchung best&auml;tigen</span></div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp"/>
        </div>

        <div class="content">
            <div class="center_content">
                <div class="center_title_bar">Buchung best&auml;tigen</div>
                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big">

                        <div><strong>Produkte zu buchen: </strong></div>
                        <br/>
                        <%
                            cart shoppingCart;
                            shoppingCart = (cart) session.getAttribute("cart");
                            List<Integer> produktids = shoppingCart.getCartItems();

                            DatabaseHelper db = new DatabaseHelper();

                            for (Integer produkt : produktids) {
                                ResultSet produktDaten = db.getProductsById(produkt.intValue());
                                try {
                                    while (produktDaten.next()) {
                        %><span><p>Artikel: <%= produktDaten.getString("prod_bezeichn")%>
                        Preis: <%= produktDaten.getString("prod_preis")%>&euro;</p></span><%
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }



                        Boolean loginState = false;
                        String user ="";

                        loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");
                        if (loginDaten!=null) {
                            if(loginDaten.getRolle()=="Kunde"){
                                loginState = true;
                                user = loginDaten.getUsername();
                            }
                        } else{
                            loginState = false;
                        }


                        %>

                        <form name="updateForm" method="post" action="buchungAbsendenservelet">

                            <div class="form_row">
                                <label class="contact_customMF"><strong>abholung</strong></label>
                                <input type="date" value="TT.MM.JJJJ" name="anholung"/>
                            </div>

                            <div class="form_row">
                                <label class="contact_customMF"><strong>abgabe</strong></label>
                                <input type="date" value="TT.MM.JJJJ" name="abgabe"/>
                            </div>



                        <%


                        // wenn ein KD im Portal angemeldet ist
                        if(loginState){

                            String email = "";
                            ResultSet rs = db.getKundenDatenByLogin(user);
                            while(rs.next()){
                                email = rs.getString(12);
                            }
                            db.disconnectDatabase();
                            %>

                            <div class="form_row">
                            <label class="contact_customMF"><strong>email</strong></label>
                            <input type="text" name="email" placeholder="<%= email%>"/>
                            </div>

                            <%

                        }
                        //wenn KEIN KD angemeldet ist
                        else{
                            %>
                            <br/><p>Sie sind nicht angemeldet, bitte geben Sie Ihre Daten ein.</p><br/>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Vorname</strong></label>
                                <input type="text" name="vorname" placeholder="Max"/>
                            </div>

                            <div class="form_row">
                                <label class="contact_customMF"><strong>Nachname</strong></label>
                                <input type="text" name="nachname" placeholder="Mustermann"/>
                            </div>

                            <div class="form_row">
                                <label class="contact_customMF"><strong>email</strong></label>
                                <input type="text" name="email" placeholder="x@y.de"/>
                                </div>

                            <%
                        }
                    %>





                            <div class="form_row">
                                <input type="submit" value="Ok"/></div>
                        </form>
                    </div>
                    <div class="bottom_prod_box_big"></div>
                </div>
            </div>
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
