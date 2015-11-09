<%@page import="project.DatabaseHelper" %>
<%@page import="project.loginCookie" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!--
    Form, wo die aktuellen Daten des Kunden angezeigt werden und dieser die Möglichkeit hat, den Account zu aendern oder zu loeschen.
-->
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
        <div class="crumb_navigation"> Navigation: <span class="current">Daten ändern</span></div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp"/>
        </div>

        <%
            // den loginname des angemeldeten Nutzers auslesen
            String user = "";
            loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");
            if (loginDaten != null) {
                if (loginDaten.getRolle() == "Kunde") {
                    user = loginDaten.getUsername();
                }
            }

            // hier wird der username in die Kundenummer gewandelt
            DatabaseHelper db = new DatabaseHelper();
            ResultSet zwischenSet = db.getKundenDatenByLogin(user);
            int kdnr = 0;
            while (zwischenSet.next()) {
                kdnr = Integer.parseInt(zwischenSet.getString(1));
                System.out.println(kdnr);
            }
            ResultSet kundenDaten = db.getKundenDatenByNr(kdnr);
        %>
        <div class="content">
            <div class="center_content">
                <div class="center_title_bar">Eigene Daten ändern</div>
                <div class="center_title_bar_customMF">Die aktuellen Daten werden in den Feldern angezeigt und nur bei
                    Überschreiben geändert. Geben Sie Ihr aktuelles Passwort ein und klicken Sie OK, um die Änderungen
                    zu übernehmen.
                </div>
                <div class="center_title_bar" style="color: red">${message}</div>
                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big">

                        <form name="updateForm" method="post" action="updateKundeServlet">
                            <% while (kundenDaten.next()) { %>

                            <div class="form_row"><label><strong>Pflichtangaben</strong></label></div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Login*</strong></label>
                                <input type="text" name="login" placeholder="<%= kundenDaten.getString(2) %>"/>
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Vorname*</strong></label>
                                <input type="text" name="vorname" placeholder="<%= kundenDaten.getString(5) %>"/>
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Name*</strong></label>
                                <input type="text" name="name" placeholder="<%= kundenDaten.getString(4) %>"/>
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>E-Mail*</strong></label>
                                <input type="email" name="email" placeholder="<%= kundenDaten.getString(12) %>"/>
                            </div>

                            <div class="form_row"><label><strong>Optionale Angaben</strong></label></div>
                            <div class="form_row">
                                <label class="contact_customMF">Strasse</label>
                                <input type="text" name="strasse" placeholder="<%= kundenDaten.getString(6) %>"/>
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF">Hausnummer</label>
                                <input type="text" name="hausn" placeholder="<%= kundenDaten.getString(7) %>"/>
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF">PLZ</label>
                                <input type="text" name="plz" placeholder="<%= kundenDaten.getString(8) %>"/>
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF">Ort</label>
                                <input type="text" name="ort" placeholder="<%= kundenDaten.getString(9) %>"/>
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF">Telefon</label>
                                <input type="tele" name="tele" placeholder="<%= kundenDaten.getString(10) %>"/>
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF">Mobil</label>
                                <input type="tele" name="mobil" placeholder="<%= kundenDaten.getString(11) %>"/>
                            </div>

                            <div class="form_row">
                                <label class="contact_customMF">Firma/Organisation</label>
                                <input type="text" name="orga" placeholder="<%= kundenDaten.getString(13) %>"/>
                            </div>


                            <div class="form_row">
                                <label class="contact_customMF"><strong>Passwort Neu</strong></label>
                                <input type="password" name="pwNeu"/>
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Passwort Neu bestätigen</strong></label>
                                <input type="password" name="pwNeuBest"/>
                            </div>


                            <div class="form_row"><label><strong>Passwortabfrage</strong></label></div>

                            <div class="form_row">
                                <label class="contact_customMF"><strong>Passwort Alt*</strong></label>
                                <input type="password" name="pw" required/>
                            </div>
                            <% }
                                db.disconnectDatabase();%>

                            <div class="form_row">
                                <input type="submit" value="Daten übernehmen"/></div>
                        </form>

                        <form method="post" action="deleteKundeServlet">
                            <button style="float:left; margin-left:109px;"  name="deleteKunde" type="submit" value="<%= user%>">Konto Löschen</button>
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
