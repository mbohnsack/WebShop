<%@page import="project.DatabaseHelper" %>
<%@page import="project.loginCookie" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Date" %>


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
    <div class="crumb_navigation"> Navigation: <span class="current">Buchungen</span> </div>
    <div class="navigation_left">
      <jsp:include page="navigation_left.jsp" />
    </div>

    <%!
      // Methode um die ID aus der Mail zu holen
      int getKundenIdByMail(String mail) {
        DatabaseHelper db = new DatabaseHelper();
        ResultSet kundenDaten = db.getKundenDatenByMail(mail);

          try {
            kundenDaten.next();
            return kundenDaten.getInt("kun_nummer");
          }catch (SQLException e) {
            e.printStackTrace();
          }
        return -1;
      }
    %>

    <div class="content">
      <div class="center_content">
        <div class="center_title_bar">Buchungen</div>
        <div class="prod_box_big">
          <div class="top_prod_box_big"></div>
          <div class="center_prod_box_big">
            <p style="color: red">${message}</p>

            <%
              //TODO wenn der KD nicht angemeldet ist gibt es mehrere KundenID's mit der gleichen mail also nur eine buchung pro ID
              //abfrage muss über mail erfolgen

              DatabaseHelper db = new DatabaseHelper();
              int kunId = -2;
              String user = "";
              loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");

              // *******
              // Wenn KD angemeldet ist seine KD nummer auslesen
              // ******
              if (loginDaten!=null) {
                if(loginDaten.getRolle()=="Kunde"){
                  user = loginDaten.getUsername();
                }
                ResultSet kundenDaten = db.getKundenDatenByLogin(user);
                while(kundenDaten.next()){
                  kunId = Integer.parseInt(kundenDaten.getString(1));
                }

              }else{
                // *******
                // Wenn kein KD angemeldet email abfragn und daraus kun_nummer machen
                // ******
                if (request.getParameter("submit") != null)
                {
                  String email = request.getParameter("email");
                  kunId = getKundenIdByMail(email);
                  if(kunId == -1){
                    %><p style="color: red">Die eingegebene Mail ist nicht im System.</p><%
                  }
                }

                // Das email eingabe formular
            %>

            <p>Sie sind nicht angemeldet. Bitte Email eingeben um Buchungen anzuzeigen.</p>
            <form name="mailEingabe" method="post" >
              <input type="email" name="email"  required/>
              <input type="submit" name="submit" value="Ok"/>
            </form><br/>

            <%
              }

              // Tabelle mit den Buchungen (wird nur angezeigt wenn die KD nummer abgefragt wurde
              if(kunId != -1 && kunId != -2){
                ResultSet buchungsDaten = db.getBuchungenByKunId(kunId);

            %>
            <table style="width: 90%" align="center">
              <tr><th align="left">Buchungs-Nummer</th><th align="left">Abhol-Datum</th><th align="left">Abgabe-Datum</th>
                <th align="left">Buchungs-Status</th><th align="left">Strornieren</th></tr>
              <tr>
            <%
                while(buchungsDaten.next()){
                  // Datum prüfen
                  Date abholdatum = buchungsDaten.getDate(2);
                  Date now = new java.sql.Date(System.currentTimeMillis());
            %>

            <td align="left"><%= buchungsDaten.getString(1)%></td>
            <td align="left"><%= buchungsDaten.getString(2)%></td>
            <td align="left"><%= buchungsDaten.getString(3)%></td>
            <td align="left"><%= buchungsDaten.getString(5)%></td>
            <td align="left">
              <%
                //storno knopf nur anzeigen, wenn das datum in der zukunft liegt
                if (abholdatum.after(now) && buchungsDaten.getString(5).contentEquals("ausstehend")){
              %>
            <form name="storno" action="buchungStorno" method="post">
              <input type="hidden" name="buchungsID" value="<%= buchungsDaten.getString(1)%>"/>
              <input type="hidden" name="aendern" value="storniert"/>
              <button name="storno" type="submit">stornieren</button>
            </form>
              <%
                }
              %>
            </td>

            <%
              }%>
            </tr></table><br/>
            <%
              db.disconnectDatabase();
              }
            %>
          </div>
          <div class="bottom_prod_box_big"></div>
        </div>
      </div>
    </div>

    <div id="navigation_right" class="navigation_right"><jsp:include page="navigation_right.jsp" />
    </div>
    <div id="footer" class="footer">
      <jsp:include page="footer.jsp" />
    </div>
  </div>
</div>
</body>
</html>
