<%@ page import="project.DatabaseHelper" %>
<%@ page import="project.cart" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="project.loginCookie" %>
<%@ page import="java.util.ArrayList" %>
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
    <div class="crumb_navigation"> Navigation: <span class="current">Zusammenfassung Buchung</span></div>
    <div class="navigation_left">
      <jsp:include page="navigation_left.jsp"/>
    </div>

    <div class="content">
      <div class="center_content">
        <div class="center_title_bar">Zusammenfassung Buchung</div>
        <div class="prod_box_big">
          <div class="top_prod_box_big"></div>
          <div class="center_prod_box_big">

            <div><strong style="font-size: 110%">Ihre Buchung ist mit folgenden Daten bei uns eingegangen:</strong></div>


            <br><p style="font-size: 110%">Buchungs Code: ${buchCode}</p><br/>
            <%
              DatabaseHelper db = new DatabaseHelper();


              // generelle buchungsinformationen hier
              Integer buchungsnummer = (Integer)request.getAttribute("buchCode");
              ResultSet buchungsDaten = db.getBuchungById(buchungsnummer);

              %>
            <table style="width: 90%" align="center"><tr>
              <%
              while(buchungsDaten.next()){ %>

              <td style="font-size: 110%">Abhol-Datum: <%= buchungsDaten.getString(2)%></td>
              <td style="font-size: 110%">Abgabe-Datum: <%= buchungsDaten.getString(3)%></td>
              <td style="font-size: 110%">Buchungs-Status: <%= buchungsDaten.getString(5)%></td>

            <% } %>
            </tr></table><br/>
            <%

              // produktliste nochmal ausm cart holen und anzeigen
              double gesamtpreis = 0;
              cart shoppingCart;
              shoppingCart = (cart) session.getAttribute("cart");
              List<Integer> produktids = new ArrayList<Integer>();
              if(shoppingCart != null){
                //unchecked
                produktids = shoppingCart.getCartItems();
              }
            %>

            <table style="width: 75%" style="background-color: #a6847d" align="center">
              <th align="left">Artikel</th><th align="left">Preis</th>
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

              <tr><td align="left"><strong>Gesamtpreis</strong></td><td align="left"><strong><%= gesamtpreis%>&euro;</strong></td></tr>
              <tr><td align="left">Rabatt</td><td align="left">nix&euro;</td></tr>
              <tr><td align="left"><strong>Endsumme</strong></td><td align="left"><strong><%= gesamtpreis%>&euro;</strong></td> </tr>
            </table>
            <%
              db.disconnectDatabase();
              shoppingCart.clearCart();
              //TODO Rabatt
            %>

            <br/><br/>
            <form name="facebook" method="post" action="">
              <button>Buchung auf Facebook publizieren</button>
            </form>
            <form name="shoppen" method="post" action="index.jsp">
              <button>weiter shoppen</button>
            </form>
            <%
              //TODO facebook
            %>


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

