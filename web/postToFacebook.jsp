<!DOCTYPE html>
<html>
<head>
  <title>Facebook Login JavaScript Example</title>
  <meta charset="UTF-8">
</head>
<body>










<script>
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'Please log ' +
              'into this app.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      document.getElementById('status').innerHTML = 'Please log ' +
              'into Facebook.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
    FB.init({
      appId      : '971763672885631',
      cookie     : true,  // enable cookies to allow the server to access
                          // the session
      xfbml      : true,  // parse social plugins on this page
      version    : 'v2.2' // use version 2.2
    });

    // Now that we've initialized the JavaScript SDK, we call
    // FB.getLoginStatus().  This function gets the state of the
    // person visiting this page and can return one of three states to
    // the callback you provide.  They can be:
    //
    // 1. Logged into your app ('connected')
    // 2. Logged into Facebook, but not your app ('not_authorized')
    // 3. Not logged into Facebook and can't tell if they are logged into
    //    your app or not.
    //
    // These three cases are handled in the callback function.

    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
      document.getElementById('status').innerHTML =
              'Thanks for logging in, ' + response.name + '!';
    });
  }
</script>
<script type="text/javascript">
  window.fbAsyncInit = function() {
    FB.init({appId: '971763672885631', status: true, cookie: true,
      xfbml: true});
  };
  (function() {
    var e = document.createElement('script'); e.async = true;4
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

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->

<fb:login-button scope="public_profile,email,manage_pages,publish_actions" onlogin="checkLoginState();">
</fb:login-button>

<div id="status">
</div>

<img src = "images/facebook_button.png" id = "share_button2" style="cursor:pointer">


</body>
</html>
