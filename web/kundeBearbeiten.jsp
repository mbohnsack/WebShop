<%@page import="project.DatabaseHelper" %>
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
         <div class="navigation_left">
            <jsp:include page="navigation_left.html" />
        </div>

        <%
            DatabaseHelper db = new DatabaseHelper();
            ResultSet kundenDaten = db.getKundenDaten(1);
        %>

        <div class="content">
            <div class="center_content">
                <div class="center_title_bar">Eigene Daten �ndern</div>
                <div class="center_title_bar_customMF">Die aktuellen Daten werden in den Feldern angezeigt und nur bei �berschreiben ge�ndert. Geben Sie Ihr aktuelles Passwort ein und klicken Sie OK, um die �nderungen zu �bernehmen.</div>

                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big">

                        <form name="updateForm" method="post" action="updateKundeServlet">
                            <% while(kundenDaten.next()){ %>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Login</strong></label>
                                <input type="text" name="login" placeholder="<%= kundenDaten.getString(2) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Vorname</strong></label>
                                <input type="text" name="vorname" placeholder="<%= kundenDaten.getString(5) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Name</strong></label>
                                <input type="text" name="name" placeholder="<%= kundenDaten.getString(4) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>email</strong></label>
                                <input type="text" name="email" placeholder="<%= kundenDaten.getString(12) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Strasse</strong></label>
                                <input type="text" name="strasse" placeholder="<%= kundenDaten.getString(6) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Hausnummer</strong></label>
                                <input type="text" name="hausn" placeholder="<%= kundenDaten.getString(7) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>PLZ</strong></label>
                                <input type="text" name="plz" placeholder="<%= kundenDaten.getString(8) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Ort</strong></label>
                                <input type="text" name="ort" placeholder="<%= kundenDaten.getString(9) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Telefon</strong></label>
                                <input type="text" name="tele" placeholder="<%= kundenDaten.getString(10) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Mobil</strong></label>
                                <input type="text" name="mobil" placeholder="<%= kundenDaten.getString(11) %>" />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Passwort Neu</strong></label>
                                <input type="password" name="pwNeu"  />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Passwort Neu best�tigen</strong></label>
                                <input type="password" name="pwNeuBest"  />
                            </div>
                            <div class="form_row">
                                <label class="contact_customMF"><strong>Passwort Alt</strong></label>
                                <input type="password" name="pw" />
                            </div>
                            <% } %>

                            <div class="form_row">
                                <input type="submit" value="Ok" /> </div>
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
