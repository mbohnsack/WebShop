<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Hipster Rental Corp.</title>
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
        <div class="crumb_navigation"> Navigation: <span class="current">Kontakt</span> </div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.html" />
        </div>
        <div class="content">

        <div class="center_content">
            <div class="center_title_bar">Kontaktiere uns!</div>
            <div class="prod_box_big">
                <div class="top_prod_box_big"></div>
                <div class="center_prod_box_big">
                    <div class="contact_form">
                        <div class="form_row">
                            <label class="contact"><strong>Name:</strong></label>
                            <input type="text" class="contact_input" />
                        </div>
                        <div class="form_row">
                            <label class="contact"><strong>Email:</strong></label>
                            <input type="text" class="contact_input" />
                        </div>
                        <div class="form_row">
                            <label class="contact"><strong>Telefon:</strong></label>
                            <input type="text" class="contact_input" />
                        </div>
                        <div class="form_row">
                            <label class="contact"><strong>Firma:</strong></label>
                            <input type="text" class="contact_input" />
                        </div>
                        <div class="form_row">
                            <label class="contact"><strong>Nachricht:</strong></label>
                            <textarea class="contact_textarea" ></textarea>
                        </div>
                        <div class="form_row"> <a href="#" class="contact">Senden</a> </div>
                    </div>
                </div>
                <div class="bottom_prod_box_big"></div>
            </div>
        </div>
            </div>
            <div id="navigation_right" class="navigation_right">
                <jsp:include page="navigation_right.html" />
            </div>
        <div id="footer" class="footer">
            <jsp:include page="footer.html" />
        </div>
    </div>
</body>
</html>
