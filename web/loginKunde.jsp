<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <jsp:include page="head.html" />
</head>
<body>
<div id="main_container">
  <div id="header">
    <jsp:include page="header.html" />
  </div>
  <div id="main_content">
    <div id="navigation_top">
      <jsp:include page="navigation_top.jsp" />
    </div>
    <div class="crumb_navigation"> Navigation: <span class="current">Anmelden</span> </div>
    <div class="navigation_left">
      <jsp:include page="navigation_left.jsp" />
    </div>

    <div class="content">

      <div class="center_content">
        <div class="center_title_bar">Anmelden</div>
        <div class="prod_box_big">
          <div class="top_prod_box_big"></div>
          <div class="center_prod_box_big">

            <form name="loginForm" method="post" action="../loginServlet">
              Username: <input type="text" name="username"/> <br/>
              Password: <input type="password" name="password"/> <br/>
              <input type="submit" value="Login" />
              <input type="hidden" name="targetpage" value="index.jsp"/> <br/>
              <input type="hidden" name="sourcepage" value="/loginKunde.jsp"/> <br/>
            </form>

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
</div>
</body>
</html>
