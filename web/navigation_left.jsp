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
        %>
        <li class="odd"><form id="category" style="margin-bottom: 0" method="post" action="categories.jsp"><button style="cursor:pointer;" name="category" type="submit" value="<%= rs.getString(1)%>"><%= rs.getString(1)%></button></form></li>
       <!-- <li class="even"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="Lautsprecher">Lautsprecher</button></form></li>
        <li class="odd"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="Verstärker">Verst&auml;rker</button></form></li>
        <li class="even"><form style="margin-bottom: 0"  method="post" action="categories.jsp"><button name="category" type="submit" value="DJ-Equipment">DJ-Equipment</button></form></li>
        <li class="odd"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="Mischpulte">Mischpulte</button></form></li>
        <li class="even"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="CD-Player">CD-Player</button></form></li>
        <li class="odd"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="Mikrofone">Mikrofone</button></form></li>
        <li class="even"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="Lichteffekte">Lichteffekte</button></form></li>
        <li class="odd"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="Nebelmaschinen">Nebelmaschinen</button></form></li>
        <li class="even"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="Beamer">Beamer</button></form></li>
        <li class="odd"><form style="margin-bottom: 0" method="post" action="categories.jsp"><button name="category" type="submit" value="Zubehör">Zubeh&ouml;r</button></form></li>
   --> <% } %>
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