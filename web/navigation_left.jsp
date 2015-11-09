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
               <% /*if (!db.getUnterkategorie(kate).isEmpty()) {
                   List<String> liste = checkUntKat(kate);
                   for (String s : liste) {
                       System.out.println("bla");
               %>
                       <li class="even">
                       <form id="category2" style="margin-bottom: 0" method="post" action="categories.jsp">
                       <button style="cursor:pointer;" name="category" type="submit" value="<%= s%>">&nbsp;&nbsp;<%= s%></button>
        </form>
        </li>
                       <%
                      }
                    }

                   }*/
                           }

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