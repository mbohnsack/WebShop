<%@ page import="project.DatabaseHelper" %>
<%@ page import="project.cart" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="project.loginCookie" %>
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
    <div class="crumb_navigation"> Navigation: <span class="current">Zusammenfassung Buchung</span></div>
    <div class="navigation_left">
      <jsp:include page="navigation_left.jsp"/>
    </div>

    <div class="content">
      <div class="center_content">
        <div class="center_title_bar">Zusammenfassung Buchung</div>
        <div class="prod_box_big">
          <div class="top_prod_box_big"></div>
          <div class="center_prod_box_big">

            <div><strong>Ihre Buchung ist mit folgenden Daten bei uns eingegangen:</strong></div>


            <p>Buchungs Code lautet: ${message}</p>
            <-- alle produkte mit preis -->
            <-- datum -->


            <form name="facebook" method="post" action="">
              <button>Buchung auf Facebook publizieren</button>
            </form>
            <form name="shoppen" method="post" action="index.jsp">
              <button>weiter shoppen</button>
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

