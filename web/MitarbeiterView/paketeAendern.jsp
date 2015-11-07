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
  int inhaltid = 0;

%>
<html lang="de">
<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="style.css" />
  <link rel="stylesheet" type="text/css" href="metro.css" />
</head>
<body>

<%if (loginDaten== null) {
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
    <%

      int paketID = Integer.parseInt(request.getParameter("aendern"));


      DatabaseHelper db = new DatabaseHelper();
      ResultSet paket = db.getProductsById(paketID);
      paket.next();
    %>
    <form id="form" method="post" action="../updatePaketServlet"><div >
      <h2>Paket aendern</h2></div>
      <div ><label >Produkt Name</label><input  type="text" name="paketname" value="<%=paket.getString(7)%>"/></div>
      <div ><label >Produkt Name2</label><input  type="text" name="paketname2" value="<%=paket.getString(8)%>" /></div>
      <div ><label >Produktbeschreibung</label><textarea class="medium" name="paketbeschreibung" cols="20" rows="5"  ><%=paket.getString(5)%></textarea></div>
      <div ><label >Technische Daten</label><textarea class="medium" name="details" cols="20" rows="5" ><%=paket.getString(6)%></textarea></div>

      <div ><label >Kategorie</label><select  name="kategorie">

                <option selected value="Paket">Paket</option>

      </select>
      </div>
      <div ><label >Hersteller</label><input  type="text" name="hersteller" value="<%=paket.getString(3)%>" /></div>
      <div ><label >Preis</label><input  type="text" name="preis" value="<%=paket.getString(4)%>"/></div>
      <div ><label >Anzahl der Buchungen</label><input  type="text" name="anzahlMBuchungen" value="<%=paket.getString(9)%>" /></div>
      <label >Produkte</label>
      <table border="1">
        <tr>
          <td>Produktname</td>
          <td>Prio</td>
        </tr>
        <%
          DatabaseHelper db3 = new project.DatabaseHelper();
          try{
            ResultSet rs= db3.getAllProducts();
            int id;
            String bezeichnung;
            while(rs.next())
            {
              id= rs.getInt("prod_id");
              bezeichnung=rs.getString("prod_bezeichn");

              boolean checked = false;
        %>

        <tr>
          <td>
            <%
              DatabaseHelper db4 = new project.DatabaseHelper();
                ResultSet rsPaketProdukte= db4.getProdukteOfPaket(paketID);
                while(rsPaketProdukte.next())
                {
                  int idPaketPordukt= rsPaketProdukte.getInt(4);
                  inhaltid = rsPaketProdukte.getInt(5);

                  int prio = rsPaketProdukte.getInt(3);

                  if(idPaketPordukt==id){
            %>
                      <input type="checkbox"  checked name="produkte" value="<%=id%>"/><%=bezeichnung %><br/>
                      </td>
                      <td>
                        <select name="<%=id%>" value="<%=prio%>" >
                          <option value="1">1</option>
                          <option value="2">2</option>
                          <option value="3">3</option>
                        </select>
                      </td>
            <%
                    checked=true;

                  }

                  }
              if (checked==false){
            %>
                        <input type="checkbox"  name="produkte" value=<%=id%>/><%=bezeichnung %><br/>
                      </td>
                      <td>
                        <select name="<%=id%>" >
                          <option value="1">1</option>
                          <option value="2">2</option>
                          <option value="3">3</option>
                        </select>
                      </td>
            <%
                  }
                }



            %>

        </tr>
      </table>
      <%


        }catch(Exception e) {

        }

      %>

      <div class="submit"><button type="submit" name=paketid value="<%=paketID%>">Ändern</button></div>
      <input type="hidden" name="inhaltid" value="<%=inhaltid%>"/>
    </form>

  </div>

</div>
<%
    db3.disconnectDatabase();

  }
%>
</body>
</html>

