<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.xml.crypto.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <jsp:include page="head.html" />
</head>
<body>
<%!
    public static void checkUntKat (String kategorie, javax.servlet.jsp.JspWriter myOut, int ebene) {
        try {
            // Ergbnis ist jetzt eine Liste mit der Unterkategorie der Kategorie, Unterkategorie der Unterkategorie usw. bis
            // es keine unterkategorie mehr gibt
            String unterKategorie = kategorie;

            DatabaseHelper datab = new DatabaseHelper();
            DatabaseHelper datab2=new DatabaseHelper();
            //schleife l�uft solange unterkategorie nicht null ist
           // while(unterKategorie!=null) {

                ResultSet results = datab.getUnterkategorieRS(unterKategorie);
                if (!results.isBeforeFirst()) {
                    unterKategorie = null;
                } else {

                while(results.next()) {
                    unterKategorie = results.getString(1);      //holt sich den kategoriename
                    if (datab.besitztProdukt(unterKategorie)) {
                    }
                    try {
                        String einruecken = "";
                        for (int ez = 0; ez < ebene - 1; ez++) {
                            einruecken += "&nbsp;&nbsp;";
                        }
                        myOut.println("<li class='even'> <form id='category2' style='margin-bottom: 0' method='post' action='categories.jsp'> <button style='cursor:pointer;' name='category' type='submit' value=" + unterKategorie
                                + ">" + einruecken + unterKategorie + " </button></form></li>");

                    } catch (Exception e) {

                    }
                }
                    checkUntKat(unterKategorie,myOut,ebene+1);
                }
            datab.disconnectDatabase();
            datab2.disconnectDatabase();
            } catch (SQLException e1) {
            e1.printStackTrace();
        }
            //gibt die liste mit allen unterkategorien zur�ck


    }

%>
    <div class="title_box">Kategorien</div>
    <ul class="left_menu">

        <%
            DatabaseHelper db = new DatabaseHelper();
            DatabaseHelper db2 = new DatabaseHelper();
            ResultSet rs = db2.getAllKategories();

            while(rs.next()){
                String kate = rs.getString(1);
                String ueberKat = db.getUebergeordneteKategorie(kate);
                int anzahl = db.getAnzahlProdukteInKategorie(kate);
                if (ueberKat.equals("n. v.") && (anzahl > 0 || !db.getUnterkategorie(kate).isEmpty())) { %>
                    <li class="odd">
                    <form id="category" style="margin-bottom: 0" method="post" action="categories.jsp">
                    <button style="cursor:pointer;" name="category" type="submit" value="<%= kate%>"><%= kate%></button>
                    </form>
                    </li>
               <% if (!db.getUnterkategorie(kate).isEmpty()) {
                   checkUntKat(kate, out, 2);

                   }
                           }

               }
                   db.disconnectDatabase();
                   db2.disconnectDatabase();
                 %>


    </ul>
    <div class="title_box">Special!!!!</div>
    <div class="border_box">
        <div class="product_title"></div>
        <div class="product_img"><img width="120px" height="120px" src="images/rabatt40.jpg" alt="" border="0" /></div>
        <div class="prod_price"></div>
    </div>
</div>
</body>
</html>