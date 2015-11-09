<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>

</head>
<body>
<%!
    public static List<String> checkUntKat (String kategorie) {
        try {
            // Ergbnis ist jetzt eine List mit der Unterkategorie der Kategorie, Unterkategorie der Unterkategorie usw. bis
            // es keine unterkategorie mehr gibt
            String unterKategorie = kategorie;
            List<String> li = new ArrayList();
            DatabaseHelper datab = new DatabaseHelper();
            //schleife läuft solange unterkategorie nicht null ist
            while(unterKategorie!=null){

                ResultSet results = datab.getUnterkategorieRS(unterKategorie);

                results.next();
                unterKategorie = results.getString(1);      //holt sich den kategoriename
                li.add(unterKategorie);                     // schreib den Kategorienamen in die list li
               results.close();
            }
            datab.disconnectDatabase();
            //gibt die liste mit allen unterkategorien zurück
            return li;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


%>
    <div class="title_box">Kategorien</div>
    <ul class="left_menu">

        <%
            DatabaseHelper db = new DatabaseHelper();
            ResultSet rs = db.getAllKategories();

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
                   List<String> liste = checkUntKat(kate);
                   for (String s : liste) {

               %>
                       <li class="even">
                       <form id="category2" style="margin-bottom: 0" method="post" action="categories.jsp">
                       <button style="cursor:pointer;" name="category" type="submit" value="<%= s%>">&nbsp;&nbsp;<%= s%></button>
        </form>
        </li>
                       <%
                   }
               }

                   }
                           }db.disconnectDatabase();

                 %>


    </ul>
    <div class="title_box">Paket</div>
    <div class="border_box">
        <div class="product_title"><a href="details.html">Motorola 156 MX-VL</a></div>
        <div class="product_img"><a href="details.html"><img src="images/platzhalter.jpg" alt="" border="0" /></a></div>
        <div class="prod_price"><span class="reduce">350$</span> <span class="price">270$</span></div>
    </div>
</div>
</body>
</html>