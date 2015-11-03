<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.loginCookie" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 21.10.2015
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  loginCookie loginDaten = (loginCookie) session.getAttribute("loginCookie");

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
<html lang="de">
<head>

  <link rel="stylesheet" type="text/css" href="style.css" />
  <link rel="stylesheet" type="text/css" href="metro.css" />
</head>
<body>

<%if (myCookie == null) {
%>
No Cookie found with the name <%=cookieName%>
<%
}
else {
%>

<div id="seite">
  <div id="kopfbereich">
    <div align="center">VerwaltungsApp</div>
  </div>

  <div id="steuerung">
    <jsp:include page="default/navigation.jsp" />
  </div>

  <div id="rightdiv">
  <%

    int produktId = Integer.parseInt(request.getParameter("aendern"));


    DatabaseHelper db = new DatabaseHelper();
    ResultSet product = db.getProductsById(produktId);
    product.next();
    System.out.println(product.getString(1));
  %>
    <form style="margin:0 auto;max-width:60%;min-width:20%"  method="post" action="../updateProduktServlet"><div ><h2>Produkt aendern</h2></div>
      <div ><label >Produkt Name</label><input  type="text" name="produktname" value="<%=product.getString(7)%>"/></div>
      <div ><label >Produkt Name2</label><input  type="text" name="produktname2" value="<%=product.getString(8)%>" /></div>
      <div ><label >Produktbeschreibung</label><textarea class="medium" name="produktbeschreibung" cols="20" rows="5"  ><%=product.getString(5)%></textarea></div>
      <div ><label >Technische Daten</label><textarea class="medium" name="details" cols="20" rows="5" ><%=product.getString(6)%></textarea></div>

      <div ><label >Kategorie</label><select name="kategorie" selected="<%=product.getString(2)%>">
        <%
          DatabaseHelper db2 = new DatabaseHelper();
          ResultSet allKategories = db2.getAllKategories();
          while (allKategories.next()){
            if(allKategories.getString(1).equals(product.getString(2))){
        %>
        <option value="<%=allKategories.getString(1)%>" selected="selected"><%=allKategories.getString(1)%></option>
        <%
            }else{
        %>
        <option value="<%=allKategories.getString(1)%>"><%=allKategories.getString(1)%></option>
        <%
          }
          }
        %>
      </select>
      </div>
      <div ><label >Hersteller</label><input  type="text" name="hersteller" value="<%=product.getString(3)%>" /></div>
      <div ><label >Preis</label><input  type="text" name="preis" value="<%=product.getString(4)%>"/></div>
      <div ><label >Anzahl der Buchungen</label><input  type="text" name="anzahlMBuchungen" value="<%=product.getString(9)%>" /></div>
      <div ><label >Bild hochladen</label><label><div >Datei auswählen</div><input type="file"  name="file" /><div>No file selected</div></label></div>
      <div class="submit"><button type="submit" name=produktid value="<%=produktId%>">Speichern</button></div>

    </form>

  </div>

</div>
<%
    db.disconnectDatabase();
    db2.disconnectDatabase();
  }
%>
</body>
</html>
