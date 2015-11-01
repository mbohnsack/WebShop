<%@page import="project.DatabaseHelper" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.ResultSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Kunde Daten bearbeiten</title>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
    <link rel="stylesheet" type="text/css" href="style.css" />
    <!--[if IE 6]>
    <link rel="stylesheet" type="text/css" href="iecss.css" />
    <![endif]-->
    <script src="http://code.jquery.com/jquery-latest.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="index.js"></script>
</head>
<body>
<div id="main_container">
    <div id="header">
        <jsp:include page="header.html" />
    </div>
    <div id="main_content">
        <div id="navigation_top">
            <jsp:include page="navigation_top.html" />
        </div>
        <div class="crumb_navigation"> Navigation: <span class="current">Registrieren</span> </div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.html" />
        </div>

        <%
            // es wird geprüft ob der KD angemeldet ist
            // if loginState == false; -> "Sie sind nicht angemeldet Seite."


            DatabaseHelper db = new DatabaseHelper();
            ResultSet kundenDaten = db.getKundenDaten(1);
                // Hier kommt die KD Nummer ausm Cookie
                //Kundendaten für KD NR 1 !! werden ausgelesen
                // hier muss noch die nummer des aktuell angemeldeten KD rein
        %>

        <div class="content">
            <div class="center_content">
                <div class="center_title_bar">Eigene Daten ändern</div>
                <label >Die aktuellen Daten werden in den Feldern angezeigt und nur bei überschreiben geändert. Kundennummer und Login können nicht geändert werden.Geben Sie Ihr Passwort ein und clicken Sie OK, um die Änderungen zu übernehmen.</label>

                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big">




                        <form name="updateForm" method="post" action="updateKundeServlet">
                            <% while(kundenDaten.next()){ %>


                            <div class="form_row">
                                <label class="contact"><strong>Kd.Nr.:<%= kundenDaten.getString(1) %></strong></label>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Login:<%= kundenDaten.getString(2) %></strong></label>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Vorname</strong></label>
                                <input type="text" name="vorname" placeholder="<%= kundenDaten.getString(5) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Name</strong></label>
                                <input type="text" name="name" placeholder="<%= kundenDaten.getString(4) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>email</strong></label>
                                <input type="text" name="email" placeholder="<%= kundenDaten.getString(12) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Strasse</strong></label>
                                <input type="text" name="strasse" placeholder="<%= kundenDaten.getString(6) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Hausnummer</strong></label>
                                <input type="text" name="hausn" placeholder="<%= kundenDaten.getString(7) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>PLZ</strong></label>
                                <input type="text" name="plz" placeholder="<%= kundenDaten.getString(8) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Ort</strong></label>
                                <input type="text" name="ort" placeholder="<%= kundenDaten.getString(9) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Telefon</strong></label>
                                <input type="text" name="tele" placeholder="<%= kundenDaten.getString(10) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Mobil</strong></label>
                                <input type="text" name="mobil" placeholder="<%= kundenDaten.getString(11) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Passwort Neu</strong></label>
                                <input type="password" name="pwNeu"  />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Passwort Neu bestätigen</strong></label>
                                <input type="password" name="pwNeuBest"  />
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Passwort Alt</strong></label>
                                <input type="password" name="pw" />
                            </div>


                            <% } %>




                            <div class="form_row">
                                <input type="submit" value="Ok" /> </div>
                            <!-- startseite oder ein anderes Formular wird aufgerufen-->
                            <!--<div class="form_row"> <input type="submit" value="Daten aktualisieren" /> </div> -->
                            <!-- Daten werden in DB geschrieben "Erfolgreich" Formular wird angezeigt -->
                        </>






                    </div>
                    <div class="bottom_prod_box_big"></div>
                </div>
            </div></div>






            <div id="navigation_right" class="navigation_right">
            <jsp:include page="navigation_right.html" />
        </div>
    </div>
        <div id="footer" class="footer">
            <jsp:include page="footer.html" />
        </div>
</div>
</body>
</html>
