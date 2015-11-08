<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="head.html" />
</head>
<body>
<div id="fb-root"></div>
<script type="text/javascript">
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
        $('#share_button').click(function(e){
            e.preventDefault();
            FB.ui(
                    {
                        method: 'feed',
                        name: 'Hipster Rental Corp.',
                        link: ' http://localhost:8080/index.jsp',
                        picture: 'http://is4.mzstatic.com/image/thumb/Purple6/v4/f9/0f/a7/f90fa75f-fdfb-f494-95b5-ffe2b0d6f4b6/source/1024x1024sr.jpg',
                        caption: 'Alles rund um Musik. Jetzt anfragen!',
                        description: 'Sie brauchen für eine bestimmte Zeit professionelles DJ-Equipment, Mikrofone oder einfach eine fette Anlage?',
                        message: ''
                    });
        });
    });
</script>

<div id="main_container">
    <div id="header">
        <jsp:include page="header.jsp" />
    </div>
    <div id="main_content">
        <div id="navigation_top">
            <jsp:include page="navigation_top.jsp" />
        </div>
        <div class="crumb_navigation"> Navigation: <span class="current">Startseite</span> </div>
        <div class="navigation_left">
            <jsp:include page="navigation_left.jsp" />
        </div>
        <div id="content" class="content">
            <jsp:include page="content.jsp" />
        </div>
        <div id="navigation_right" class="navigation_right">
            <jsp:include page="navigation_right.jsp" />
        </div>
        <div id="footer" class="footer">
            <jsp:include page="footer.jsp" />
        </div>
    </div>
</div>
</body>
</html>
