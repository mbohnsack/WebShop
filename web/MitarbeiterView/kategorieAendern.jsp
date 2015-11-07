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
%>
<html lang="de">
<head>

  <link rel="stylesheet" type="text/css" href="style.css" />
  <link rel="stylesheet" type="text/css" href="metro.css" />
</head>
<body>

<%if (loginDaten == null) {
  String url = "/MitarbeiterView/login.jsp";
  response.sendRedirect( url );
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

      String kategorieName = request.getParameter("aendern");


      DatabaseHelper db = new DatabaseHelper();
      ResultSet kategorie = db.getKategorie(kategorieName);
      kategorie.next();

    %>
    <form style="margin:0 auto;max-width:60%;min-width:20%"  method="post" action="../updateKategorieServlet"><div ><h2>Produkt aendern</h2></div>
      <div ><label >Kategorie Name</label><input  type="text" name="kategorieName" value="<%=kategorie.getString(1)%>" /></div>
      <div ><label >Übergeordnete Kategorie</label><select name="ueberKategorie" selected="<%=kategorie.getString(2)%>">
        <option value=""></option>
        <%
          DatabaseHelper db2 = new DatabaseHelper();
          ResultSet allKategories = db2.getAllKategories();
          while (allKategories.next()){
            if(allKategories.getString(1).equals(kategorie.getString(2))){
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
      <div ><label >Bild hochladen</label><label><div >Datei auswählen</div><input type="file"  name="file" /><div>No file selected</div></label></div>
      <div class="submit"><button type="submit" name=produktid value="<%=kategorieName%>">Speichern</button></div>

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
