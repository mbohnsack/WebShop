<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <jsp:include page="head.html" />
</head>
<body>
<div id="main_container">
  <div id="header">
    <jsp:include page="header.jsp" />
  </div>
  <div id="main_content">
    <div id="navigation_top">
      <jsp:include page="navigation_top.jsp" />
    </div>
    <div class="crumb_navigation"> Navigation: <span class="current">Buchung bestätigen</span> </div>
    <div class="navigation_left">
      <jsp:include page="navigation_left.jsp" />
    </div>



    <div class="content">
      <div class="center_content">
        <div class="center_title_bar">Buchung bestätigen</div>
        <div class="prod_box_big">
          <div class="top_prod_box_big"></div>
          <div class="center_prod_box_big">




            <form name="updateForm" method="post" action="buchungAbsendenservelet">
              <div>Hier stehen die Produkte nochmal</div>

              <div class="form_row">
                <label class="contact_customMF"><strong>abholung</strong></label>
                <input type="date" value="TT.MM.JJJJ" name="anholung" />
              </div>

              <div class="form_row">
                <label class="contact_customMF"><strong>abgabe</strong></label>
                <input type="date" value="TT.MM.JJJJ" name="abgabe" />
              </div>

              <%
                DatabaseHelper db = new DatabaseHelper();
                String kundenmail="";

                String cookieName = "LoginCookie";
                Cookie cookies [] = request.getCookies ();
                Cookie myCookie = null;
                if (cookies != null)
                {
                  for (int i = 0; i < cookies.length; i++)
                  {
                    if (cookies [i].getName().equals (cookieName))
                    {
                      myCookie = cookies[i];
                      break;
                    }
                  }
                }
                String user = myCookie.getValue();

                if(myCookie!=null){
                  ResultSet kundenMailabfragen = db.getKundenDatenByLogin(user);
                  try{
                    while(kundenMailabfragen.next()){
                      kundenmail = kundenMailabfragen.getString(12);
                      System.out.println(kundenmail);
                    }

                  }catch(SQLException e){

                  }
                }else{
                  kundenmail = "Bitte email eingeben";
                }
                db.disconnectDatabase();
              %>

              <div class="form_row">
                <label class="contact_customMF"><strong>email</strong></label>
                <input type="text" name="email" placeholder="<%= kundenmail%>" />
              </div>


              <div class="form_row">
                <input type="submit" value="Ok" /> </div>
            </form>
          </div>
          <div class="bottom_prod_box_big"></div>
        </div>
      </div>
    </div>
</div>
</body>
</html>
