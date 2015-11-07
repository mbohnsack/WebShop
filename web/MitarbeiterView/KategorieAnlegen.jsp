<%@ page import="java.sql.ResultSetMetaData" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="project.DatabaseHelper" %>
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
        <form style="margin:0 auto;max-width:60%;min-width:20%"  method="post" enctype="multipart/form-data" action="../addKategorieServlet"><div ><h2>Produkt anlegen</h2></div>
            <div ><label >Kategorie Name</label><input  type="text" name="kategorieName" /></div>
            <div ><label >Übergeordenete Kategorie</label><div ><select name="ueberKategorie" >
                <%
                    DatabaseHelper db2 = new DatabaseHelper();
                    ResultSet allKategories = db2.getAllKategories();
                %>
                <option value=""></option>
                <%
                    while (allKategories.next()){
                %>

                <option value="<%=allKategories.getString(1)%>"><%=allKategories.getString(1)%></option>
                <%
                    }
                %>
            </select>
            </div>
            </div>
            <div ><label >Bild hochladen</label><label><div >Datei auswählen</div><input type="file"  name="file" /><div>No file selected</div></label></div>
            <div class="submit"><input type="submit" value="Speichern"/></div>
        </form>

    </div>

</div>
<%
        db2.disconnectDatabase();
    }
%>
</body>
</html>