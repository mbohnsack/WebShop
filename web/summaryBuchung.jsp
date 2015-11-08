<%@ page import="project.DatabaseHelper" %>
<%@ page import="project.cart" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="project.loginCookie" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <jsp:include page="head.html"/>
</head>
<body>
<%
  DatabaseHelper datab = new DatabaseHelper();
  List<Integer> prodid = new ArrayList<Integer>();
  cart shopcart;
  List<String> jedProd = new ArrayList<String>();
  shopcart = (cart) session.getAttribute("cart");
  if(shopcart != null){
    //unchecked
    prodid = shopcart.getCartItems();
  }
  for (Integer prod : prodid) {
    ResultSet prodData = datab.getProductsById(prod);
      while (prodData.next()) {
         jedProd.add(prodData.getString(7));
      } }
%>
<div id="fb-root"></div>
<script>
  window.fbAsyncInit = function() {
    FB.init({appId: '971763672885631', status: true, cookie: true,
      xfbml: true});
  };
  (function() {
    var e = document.createElement('script'); e.async = true;
    e.src = document.location.protocol +
            '//connect.facebook.net/en_US/all.js';
    document.getElementById('fb-root').appendChild(e);
  }());
</script>
<script type="text/javascript">
  $(document).ready(function(){
    $('#share_button2').click(function(e){
      e.preventDefault();

      FB.ui(
              {
                method: 'feed',
                name: 'Hipster Rental Corp.',
                link: ' http://localhost:8080/facebookShare.jsp?<%
                  for (String s : jedProd) { %>prod_bezeichn=<%=s%><%}%>',
                picture: 'http://is4.mzstatic.com/image/thumb/Purple6/v4/f9/0f/a7/f90fa75f-fdfb-f494-95b5-ffe2b0d6f4b6/source/1024x1024sr.jpg',
                caption: 'Alles rund um Musik. Jetzt anfragen!',
                description: 'Hi Leute, ich habe gerade folgende Artikel bei Hipster Rental Corp. gebucht: ',
                message: ''
              });
    });
  });
</script>
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

                // gesamtpreis parameter aus vorhergehender formularstruktur
                double mietzinsTag = gesamtpreis;

                // 40% Rabatt nach dauer berechnen
                Date abholdatum = (Date) request.getAttribute("abholdatum");
                Date abgabedatum = (Date) request.getAttribute("abgabedatum");

                long startTime = abholdatum.getTime();
                long endTime = abgabedatum.getTime();
                long diffTime = endTime - startTime;
                long diffDays = diffTime / (1000 * 60 * 60 * 24);

                // tage * mietzins -> preis ohne rabatt
                double summeOhneRabatt = diffDays * mietzinsTag;
                double rabattVierzig = 0;

                //ab dem zweiten tag gibts 40% rabatt
                double summeVierzig = summeOhneRabatt;
                if (diffDays > 1){
                  summeVierzig = (mietzinsTag * (diffDays - 1)) *0.6 + mietzinsTag;
                  rabattVierzig = summeOhneRabatt - summeVierzig;
                }

                double endsumme =  summeOhneRabatt - rabattVierzig;
                double summeZwanzig = 0;

                // 20% Rabatt nach anzahl kundenbestellungen berechnen
                String nutzerName = (String) request.getAttribute("nutzerName");
                String userName = (String) request.getAttribute("userName");
                Integer buchungenKunde = db.getBuchungsZahlByLogin(nutzerName);
                Integer buchungenKunde2 = db.getBuchungsZahlByLogin(userName);
                System.out.println(buchungenKunde);
                System.out.println(buchungenKunde2);
                int anzahl = 0;
                if (buchungenKunde >= buchungenKunde2){
                  anzahl = buchungenKunde;
                }else{
                  anzahl = buchungenKunde2;
                }

                if(anzahl >= 3){
                  summeZwanzig = endsumme * 0.2;
                  endsumme = endsumme - summeZwanzig;
                }

              %>

              <tr><td align="left"><strong>Mietzins/Tag</strong></td><td align="left"><strong><%= mietzinsTag%>&euro;</strong></td></tr>
              <tr></tr>
              <tr><td align="left">Mietdauer</td><td align="left"><%= diffDays%> Tage</td></tr>
              <tr><td align="left">Summe ohne Rabatt</td><td align="left"><%= summeOhneRabatt%>&euro;</td></tr>
              <tr><td align="left">- Rabatt 40% ab Tag 2</td><td align="left">- <%= rabattVierzig%>&euro;</td></tr>
              <tr><td align="left">- 20% Treuebonus</td><td align="left">-<%= summeZwanzig%> &euro;</td></tr>
              <tr><td align="left"><strong>Endsumme</strong></td><td align="left"><strong><%= endsumme%>&euro;</strong></td> </tr>
            </table>
            <%
              db.disconnectDatabase();
              shoppingCart.clearCart();

            %>

            <br/><br/>
              <img src = "images/facebook_button.png" id = "share_button2" style="cursor:pointer">
            <form name="shoppen" method="post" action="index.jsp">
              <button>weiter shoppen</button>
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

