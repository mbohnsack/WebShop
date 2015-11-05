<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.loginCookie" %>
<%@ page import="project.DatabaseHelper" %>
<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 27.10.2015
  Time: 16:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int anzahl=0;%>
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
    <div>
      <form  style="margin:0 auto;max-width:60%;min-width:20%"  method="post" action="../addPaketServlet">
        <div ><label >Paketname</label><input  type="text" name="paketname" /></div>
        <div ><label >Paketname 2</label><input  type="text" name="paketname2" /></div>
        <div ><label >Paketbeschreibung</label><textarea class="medium" name="paketbeschreibung" cols="20" rows="5" ></textarea></div>
        <div ><label >Technische Daten</label><textarea class="medium" name="details" cols="20" rows="5" ></textarea></div>
        <div ><label >Kategorie</label>
          <select name="kategorie" >
          <%
            DatabaseHelper db2 = new DatabaseHelper();
            ResultSet allKategories = db2.getAllKategories();

            while (allKategories.next()){
          %>
          <option value="<%=allKategories.getString(1)%>"><%=allKategories.getString(1)%></option>
          <%
            }
            db2.disconnectDatabase();
          %>
        </select>
        </div>
          <div ><label >Hersteller</label><input  type="text" name="hersteller" value="Paket" readonly/></div>
          <div ><label >Preis</label><input  type="text" name="preis" /></div>

        <label >Produkte</label>
          <table border="1">
            <tr>
              <td>Produktname</td>
              <td>Prio</td>
            </tr>
                <%
                DatabaseHelper db = new project.DatabaseHelper();
                try{
                  ResultSet rs= db.getAllProducts();
                  int id;
                  String bezeichnung;
                  while(rs.next())
                  {
                    id= rs.getInt("prod_id");
                    bezeichnung=rs.getString("prod_bezeichn");
                 %>

                  <tr>
                  <td>
                  <input type="checkbox"  name="produkte" value=<%=id%>/><%=bezeichnung %><br/>
                  </td>
                    <td>
                      <select name="<%=id%>" >
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                      </select>
                    </td>
                  </tr>

                <%
                  }
                %>
          </table>
        <%
          }
          catch(Exception e){}
        %>
        <input class="submit" type="submit" name="anlegen" value="Anlegen" />
      </form>

  </div>

</div>
<%
    db.disconnectDatabase();
  }
%>
</body>
</html>


