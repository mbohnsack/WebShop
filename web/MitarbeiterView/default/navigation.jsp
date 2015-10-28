<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 27.10.2015
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
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
%>
<div class="naviLabel">
  Willkommen, <%=myCookie.getValue()%> </br>
  <a href="../general/logout.jsp"><b>Logout</b></a>
</div>
<label class="naviLabel">Buchungen</label>
<div class="navlinks"><a href="buchungAnlegen.jsp"><b>Buchungen anlegen</b></a></div>
<div class="navlinks"><a href="buchungsVerwaltung.jsp"><b>Buchungen verwalten</b></a></div>
<label class="naviLabel">Pakete</label>
<div class="navlinks"><a href="paketeAnlegen.jsp" ><b>Pakete anlegen</b></a></div>
<div class="navlinks"><a href="paketeVerwalten.jsp" ><b>Pakete verwalten</b></a></div>
<label class="naviLabel">Produkte</label>
<div class="navlinks"><a href="produktAnlegen.jsp"><b>Produkte anlegen</b></a></div>
<div class="navlinks"><a href="produktVerwalten.jsp"><b>Produkte verwalten</b></a></div>
<label class="naviLabel">Kategorie</label>
<div class="navlinks"><a href="KategorieAnlegen.jsp"><b>Kategorie anlegen</b></a></div>
<div class="navlinks"><a href="kategorieVerwalten.jsp"><b>Kategorien verwalten</b></a></div>
<label class="naviLabel">Mitarbeiter</label>
<div class="navlinks"><a href="mitarbeiterAnlegen.jsp"><b>Mitarbeiter anlegen</b></a></div>
<div class="navlinks"><a href="mitarbeiterVerwalten.jsp"><b>Mitarbeiter verwalten</b></a></div>
