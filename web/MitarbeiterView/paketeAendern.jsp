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

      int paketID = Integer.parseInt(request.getParameter("aendern"));


      DatabaseHelper db = new DatabaseHelper();
      ResultSet paket = db.getProductsById(paketID);
      paket.next();
    %>
    <br><br>
    <table border="0" style="margin-left: 32%">
    <form id="form" method="post" action="../updatePaketServlet">
      <tr>
        <th><h2>Paket ändern</h2></th>
      </tr>
      <tr>
        <td><label >Paket Name</label></td>
        <td><input  type="text" name="paketname" value="<%=paket.getString(7)%>"/></td>
      </tr>
      <tr>
        <td><label >Informelle Bezeichnung</label></td>
        <td><input  type="text" name="paketname2" value="<%=paket.getString(8)%>" /></td>
      </tr>
      <tr>
        <td><label >Paketbeschreibung</label></td>
        <td><textarea class="medium" name="paketbeschreibung" cols="40" rows="5"  ><%=paket.getString(5)%></textarea></td>
      </tr>
      <tr>
        <td><label >Technische Daten</label></td>
        <td><textarea class="medium" name="details" cols="40" rows="5" ><%=paket.getString(6)%></textarea></td>
      </tr>
      <tr>
        <td><label >Kategorie</label></td>
        <td><select  name="kategorie">

                <option selected value="Paket">Paket</option>

      </select></td>
        </tr>
      <tr>
        <td><label >Hersteller</label></td>
        <td><input  type="text" name="hersteller" value="<%=paket.getString(3)%>" /></td>
      </tr>
      <tr>
        <td><label >Mietzins in &euro;/24h</label></td>
        <td><input  type="text" name="preis" value="<%=paket.getString(4)%>"/></td>
      </tr>
      <tr>
        <td><label >Anzahl der Buchungen</label></td>
        <td><input  type="text" name="anzahlMBuchungen" value="<%=paket.getString(9)%>" /></td>
      </tr>
      <tr>
        <td><label >Produkte</label></td>
        <td>
          <div class="scroll" style="max-width:100%">
      <table border="1">
        <tr>
          <td>Produktname</td>
          <td>Prio</td>
        </tr>
        <%
          DatabaseHelper db3 = new project.DatabaseHelper();
          try{
            ResultSet rs= db3.getAllProductsSortedByName();
            int id;
            String bezeichnung;
            String hersteller;
            while(rs.next())
            {
              id= rs.getInt("prod_id");
              bezeichnung=rs.getString("prod_bezeichn");
              hersteller=rs.getString("prod_hersteller");

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
                      <input type="checkbox"  checked name="produkte" value="<%=id%>"/><%=hersteller %> <%=bezeichnung %><br/>
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
                        <input type="checkbox"  name="produkte" value=<%=id%>/><%=hersteller %> <%=bezeichnung %><br/>
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
      </table></div></td></tr>
      <%


        }catch(Exception e) {

        }

      %>
      <tr>
        <td>
      <div class="submit"><button type="submit" name=paketid value="<%=paketID%>">Ändern</button></div>
      <input type="hidden" name="inhaltid" value="<%=inhaltid%>"/></td></tr>
    </form>
    </table>
  </div>

</div>
<%
    db3.disconnectDatabase();

  }
%>
</body>
</html>

