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
        <div class="crumb_navigation"> Navigation: <span class="current">Buchung best&auml;tigen</span></div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp"/>
        </div>

        <div class="content">
            <div class="center_content">
                <div class="center_title_bar">Buchung best&auml;tigen</div>
                <div class="center_title_bar" style="color: red">${message}</div>
                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big">

                        <div><strong>Bitte bestštigen Sie die Buchung durch Eingabe Ihren Daten. </strong></div>
                        <br/>
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
                        <table style="width: 75%" style="background-color: #a6847d" align="center">
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
                        <tr><td align="left">Rabatt</td>
                                <td align="left">nix&euro;</td> </tr>
                        <tr><td align="left"><strong>Endsumme</strong></td>
                            <td align="left"><strong><%= gesamtpreis%>&euro;</strong></td> </tr>
                        </table>
                            <%
                                db.disconnectDatabase();
                                //TODO Rabatt
                                //TODO Buchungszeitraum !!! Feiertage
                                /*

                                    zB---- http://www.java-forum.org/thema/jollyday-pruefen-ob-datum-feiertag.126785/ ------

                                    Calendar testDate = GregorianCalendar.getInstance();
                                    testDate.set(2011, 11, 25);

                                    HolidayManager manager = HolidayManager
                                            .getInstance(HolidayCalendar.GERMANY);

                                    Set<Holiday> holidays = manager.getHolidays(2011, "bw");
                                    for (Holiday h : holidays) {
                                        System.out.println(h.getDate() + " " + h.getDescription());
                                    }
                                    System.out.println(manager.isHoliday(testDate, "bw"));


                                 */
                            %>

                        <br/>
                        <div class="form_row"><label><strong>Pflichtangaben</strong></label></div>
                        <form name="buchungKDform" method="post" action="buchungAbsendenservelet">

                            <div class="form_row">
                                <label class="contact_customMF"><strong>abholung</strong></label>
                                <input type="date"  name="abholung" required/>
                            </div>

                            <div class="form_row">
                                <label class="contact_customMF" ><strong>abgabe</strong></label>
                                <input type="date"  name="abgabe" required/>
                            </div>



                          <%
                              // Wenn der KD angemeldet ist brauch er nix anzugeben
                              session = request.getSession();
                              loginCookie loginDaten = (loginCookie)
                                      session.getAttribute("loginCookie");

                              // wenn der KD angemeldet ist
                              if (loginDaten != null) {
                                %>
                                <div><p align="left"> Mit Knopfdruck best&auml;tigen Sie Ihre Bestellung.
                                    Unter "Buchungen" k&ouml;nnen Sie alle Buchungen einsehen und ggf. stornieren.
                                </p></div>
                            
                            <%
                            //wenn der KD NICHT angemeldet ist
                            }else{%>

                                <div class="form_row">
                                    <label class="contact_customMF"><strong>email</strong></label>
                                    <input type="email" name="email"  required/>
                                </div>

                                <div class="form_row">
                                    <label class="contact"><strong>Nachname</strong></label>
                                    <input type="text" class="contact_input" name="nname"  required/>
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Vorname</strong></label>
                                    <input type="text" class="contact_input" name="vname"  required/>
                                </div>


                                <div class="form_row"><label><strong>Optionale Angaben</strong></label></div>
                                <div class="form_row">
                                    <label class="contact"><strong>Strasse</strong></label>
                                    <input type="text"  name="strasse" />
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Hausnummer</strong></label>
                                    <input type="text" name="hausnr" />
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>PLZ</strong></label>
                                    <input type="text"  name="plz" />
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Ort</strong></label>
                                    <input type="text"  name="ort" />
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Telefon</strong></label>
                                    <input type="text"  name="telefon"/>
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Mobil</strong></label>
                                    <input type="text"  name="mobil"/>
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Firma/Organisation</strong></label>
                                    <input type="text"  name="orga" />
                                </div>

                            <%}%>

                            <div class="form_row">
                                <input type="submit" value="Jetzt buchen"/>
                            </div>
                        </form>

                        <form name="shoppen" method="post" action="index.jsp">
                            <button>weiter shoppen</button>
                        </form>
                        <form name="cartLeeren" method="post" action="cartLeerenServlet">
                            <button>Buchung/Warenkorb leeren und zur Startseite</button>
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
