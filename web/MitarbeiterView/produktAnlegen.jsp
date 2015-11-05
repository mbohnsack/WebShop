
<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.DatabaseHelper" %>
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
%>
<html lang="de">
<head>

  <link rel="stylesheet" type="text/css" href="style.css" />
  <link rel="stylesheet" type="text/css" href="metro.css" />
</head>
<body>

<%if (loginDaten == null) {
%>
No Cookie found with the name
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
    <form style="margin:0 auto;max-width:60%;min-width:20%"  method="post" enctype="multipart/form-data" action="../addProduktServlet"><div >
      <h2>Produkt anlegen</h2></div>
      <div ><label >Produkt Name</label><input  type="text" name="produktname" /></div>
      <div ><label >Produkt Name2</label><input  type="text" name="produktname2" /></div>
      <div ><label >Produktbeschreibung</label><textarea class="medium" name="produktbeschreibung" cols="20" rows="5" ></textarea></div>
      <div ><label >Technische Daten</label><textarea class="medium" name="details" cols="20" rows="5" ></textarea></div>
      <div ><label >Kategorie</label><div ><select name="kategorie" >
          <%
              DatabaseHelper db2 = new DatabaseHelper();
              ResultSet allKategories = db2.getAllKategories();

              while (allKategories.next()){
                %>
                   <option value="<%=allKategories.getString(1)%>"><%=allKategories.getString(1)%></option>
                <%
              }
          %>
      </select>
      </div>
      <div ><label >Hersteller</label><input  type="text" name="hersteller" /></div>
      <div ><label >Preis</label><input  type="text" name="preis" /></div>
      <div ><label >Bild hochladen</label><label><div >Datei auswählen</div><input type="file"  name="file" /></label></div>
      <div class="submit"><input type="submit" value="Speichern"/></div>
    </div>
    </form>

  </div>

</div>
<%
    db2.disconnectDatabase();
  }
%>
</body>
</html>
