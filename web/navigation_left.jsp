<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body>

    <div class="title_box">Kategorien</div>
    <ul class="left_menu">
        <%
        DatabaseHelper db = new DatabaseHelper();
        ResultSet rs = db.getAllKategories();
            while(rs.next()){
                DatabaseHelper db2 = new DatabaseHelper();
                int anzahl = db2.getAnzahlProdukteInKategorie(rs.getString(1));
                if (anzahl > 0) {
        %>
        <li class="odd"><form id="category" style="margin-bottom: 0" method="post" action="categories.jsp"><button style="cursor:pointer;" name="category" type="submit" value="<%= rs.getString(1)%>"><%= rs.getString(1)%></button></form></li>
       <!-- <li class="even"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="Lautsprecher">Lautsprecher</button></form></li>
   --> <% } } db.disconnectDatabase();%>
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