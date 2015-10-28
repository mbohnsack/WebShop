<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 21.10.2015
  Time: 11:16
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
    <form style="margin:0 auto;max-width:60%;min-width:20%"  method="post"><div ><h2>Produkt aendern</h2></div>
      <div ><label >Produkt Name</label><input  type="text" name="produktname" /></div>
      <div ><label >Produkt Name2</label><input  type="text" name="produktname2" /></div>
      <div ><label >Produktbeschreibung</label><textarea class="medium" name="produktbeschreibung" cols="20" rows="5" ></textarea></div>
      <div ><label >Technische Daten</label><textarea class="medium" name="details" cols="20" rows="5" ></textarea></div>

      <div ><label >Kategorie</label><div ><span><select name="kategorie" value="">
        <%

          ResultSet allProducts = db.;
          while (allProducts.next()){
        %>
        <option value="kategotieID">option 1</option></select><i></i></span></div>
        <%
          }
        %>

      </div>
      <div ><label >Hersteller</label><input  type="text" name="hersteller" /></div>
      <div ><label >Preis</label><input  type="text" name="preis" /></div>
      <div ><label >Anzahl möglicher Buchungen</label><input  type="text" name="input1" /></div>
      <div ><label >Bild hochladen</label><label><div >Datei auswählen</div><input type="file"  name="file" /><div>No file selected</div></label></div>
      <div class="submit"><input type="submit" value="Speichern"/></div>
    </form>
    </form>

  </div>

</div>
<%
  }
%>
</body>
</html>
