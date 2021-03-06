<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%--
    Form zum Registrieren eines neuen Kunden.
--%>
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
                <div class="center_title_bar" style="color: red">${message}</div>
                <div class="prod_box_big">
                    <div class="top_prod_box_big"></div>
                    <div class="center_prod_box_big">
                        <div class="contact_form">
                            <form name="registerForm" method="post" action="registerKundeServlet">

                                <em style="float:left">Pflichtfelder sind mit * markiert.</em>

                                <div class="form_row">
                                    <label class="contact"><strong>Benutzername*</strong></label>
                                    <input type="text" class="contact_input" name="benutzername" placeholder="MaxM62"
                                           required/>
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Nachname*</strong></label>
                                    <input type="text" class="contact_input" name="nname" placeholder="Mustermann"
                                           required/>
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Vorname*</strong></label>
                                    <input type="text" class="contact_input" name="vname" placeholder="Max" required/>
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Email*</strong></label>
                                    <input type="email" class="contact_input" name="email"
                                           placeholder="max.mustermann@gmx.com" required/>
                                </div>


                                <div class="form_row">
                                    <label class="contact">Strasse</label>
                                    <input type="text" name="strasse"/>
                                </div>
                                <div class="form_row">
                                    <label class="contact">Hausnummer</label>
                                    <input type="text" name="hausnr"/>
                                </div>
                                <div class="form_row">
                                    <label class="contact">PLZ</label>
                                    <input type="text" name="plz"/>
                                </div>
                                <div class="form_row">
                                    <label class="contact">Ort</label>
                                    <input type="text" name="ort"/>
                                </div>
                                <div class="form_row">
                                    <label class="contact">Telefon</label>
                                    <input type="text" name="telefon"/>
                                </div>
                                <div class="form_row">
                                    <label class="contact">Mobil</label>
                                    <input type="text" name="mobil"/>
                                </div>
                                <div class="form_row">
                                    <label class="contact">Firma/Organisation</label>
                                    <input type="text" name="orga"/>
                                </div>


                                <div class="form_row">
                                    <label class="contact"><strong>Passwort*</strong></label>
                                    <input type="password" class="contact_input" name="passwort" required/>
                                </div>
                                <div class="form_row">
                                    <label class="contact"><strong>Passwort wiederholen*</strong></label>
                                    <input type="password" class="contact_input" name="passwortBest" required/>
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
