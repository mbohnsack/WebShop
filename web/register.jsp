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
        <div class="crumb_navigation"> Navigation: <span class="current">Registrieren</span></div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp"/>
        </div>
        <div class="content">
            <div class="center_content">
                <div class="center_title_bar">Registrieren</div>
                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big">
                    <div class="contact_form">
                        <form name="registerForm" method="post" action="../registerKundeServlet">
                            <div class="form_row">
                                <label class="contact"><strong>Benutzername</strong></label>
                                <input type="text" class="contact_input" name="benutzername" placeholder="MaxM62"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Nachname</strong></label>
                                <input type="text" class="contact_input" name="nname" placeholder="Mustermann"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Vorname</strong></label>
                                <input type="text" class="contact_input" name="vname" placeholder="Max"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Email</strong></label>
                                <input type="text" class="contact_input" name="email" placeholder="max.mustermann@gmx.com"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Strasse</strong></label>
                                <input type="text" class="contact_input" name="strasse" placeholder="Musterstrasse"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Hausnummer</strong></label>
                                <input type="text" class="contact_input" name="hausnr" placeholder="42"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>PLZ</strong></label>
                                <input type="text" class="contact_input" name="plz" placeholder="42424"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Ort</strong></label>
                                <input type="text" class="contact_input" name="ort" placeholder="Da Hood"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Telefon</strong></label>
                                <input type="text" class="contact_input" name="telefon" placeholder="0123456789"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Mobil</strong></label>
                                <input type="text" class="contact_input" name="mobil" placeholder="0987654321"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Passwort</strong></label>
                                <input type="text" class="contact_input" name="passwort"/>
                            </div>
                            <div class="form_row">
                                <label class="contact"><strong>Passwort wiederholen</strong></label>
                                <textarea class="contact_textarea" name="passwortwd"></textarea>
                            </div>
                            <div class="form_row"><input type="submit" value="Registrieren"/></div>
                        </form>
                    </div>
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
