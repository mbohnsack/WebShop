<%@ page import="project.DatabaseHelper" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
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
            ResultSet rs = db.getAllKategorienWithUnterkategorien();

            while(rs.next()){
                DatabaseHelper db2 = new DatabaseHelper();

                 %>
        <li class="odd">
            <form id="category" style="margin-bottom: 0" method="post" action="categories.jsp">
                <button style="cursor:pointer;" name="category" type="submit" value="<%= rs.getString(1)%>"><%= rs.getString(1)%></button>
            </form>
        </li>

        <% ResultSet unterkat = db2.getUnterkategorieRS(rs.getString(1));

                    while (unterkat.next()) {
                        DatabaseHelper db5 = new DatabaseHelper();
                        int anzahl = db5.getAnzahlProdukteInKategorie(unterkat.getString(1));
                        if (anzahl > 0) {
        %>

        <li class="even">
            <form id="category2" style="margin-bottom: 0" method="post" action="categories.jsp">
                <button style="cursor:pointer;" name="category" type="submit" value="<%= unterkat.getString(1)%>">&nbsp;&nbsp;<%= unterkat.getString(1)%></button>
            </form>
        </li>

        <% } db5.disconnectDatabase(); } db2.disconnectDatabase(); } db.disconnectDatabase();

            DatabaseHelper db3 = new DatabaseHelper();
            ResultSet rs2 = db3.getAllKategories();
            while(rs2.next()){
                DatabaseHelper db4 = new DatabaseHelper();
                int anzahl = db4.getAnzahlProdukteInKategorie(rs2.getString(1));
                if (anzahl > 0 && db4.getUebergeordneteKategorie(rs2.getString(1)).equals("n. v.") && db4.getUnterkategorie(rs2.getString(1)).isEmpty()) {
        %>
        <li class="odd">
            <form id="category3" style="margin-bottom: 0" method="post" action="categories.jsp">
                <button style="cursor:pointer;" name="category" type="submit" value="<%= rs2.getString(1)%>"><%= rs2.getString(1)%></button>
            </form>
        </li>

        <%
            }
        db4.disconnectDatabase(); }
         db3.disconnectDatabase();%>

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