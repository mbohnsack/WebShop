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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="style.css" />
  <link rel="stylesheet" type="text/css" href="metro.css" />

</head>
<body>

  <%if (loginDaten == null) {

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
        <br>
          <b>Willkommen in der MitarbeiterApp. Hier haben Sie die Möglichkeiten ihre Daten anzulegen und zu verwalten.</b><br>
        <br>
          In der linken Navigationsleiste können Sie <b>Buchungen, Pakete, Produkte oder Kategorien</b> anlegen bzw. verwalten.<br>
        <br>
        <br>
        <b>Buchungen:</b><br>
            - <b>Buchungen anlegen:</b> Hier legen Sie manuell Buchungen (z.B. eine telefonische Buchung) an.<br>
            - <b>Buchungen verwalten:</b> Hier werden alle Buchungen, die auf dem Status ausstehend sind, aufgelistet. Mitarbeiter haben dabei die Möglichkeit diese an- bzw. abzulehnen.<br>
        <br>
        <br>
        <b>Pakete:</b><br>
            - <b>Pakete anlegen:</b> Pakete, also mehrere Produkte, die zusammengefasst werden, können hier angelegt werden.<br>
            - <b>Pakete verwalten:</b> Alle Pakete sind hier aufgelistet und können verändert werden.<br>
            - <b>Foto hinzufügen:</b> Hier kann ein Foto für das jeweilige Paket hinzugefügt werden.<br>
        <br>
        <br>
        <b>Produkte:</b><br>
            - <b>Produkte anlegen:</b> Alle Produkte, die auf der Seite erscheinen, werden hier entsprechend angelegt.<br>
            - <b>Produkte verwalten:</b> Alle Produkte werden aufgelistet und können verändert werden.<br>
            - <b>Foto hinzufügen:</b> Hier können Fotos für das jeweilige Produkte hinzugefügt werden.<br>
            - <b>Hardwarecode hinzufügen:</b> Hier muss die 10-stellige alphanumerische ID manuell eingetragen werden. Diese wird meist vom physischen Produkte abgelesen.<br>
        <br>
        <br>
        <b>Kategorie:</b><br>
            - <b>Kategorie anlegen:</b> Verschiedene (Unter-)Kategorien können hier angelegt werden, zu denen dann die Produkte zugeordnet werden können.<br>
            - <b>Kategorien verwalten:</b> Alle Kategorien werden aufgelistet und können bearbeitet werden.<br>
          <br>
          <br>
          <b>Mitarbeiter (nur mit der Rolle Admin sichtbar):</b><br>
          - <b>Mitarbeiter anlegen:</b> Hier können Mitarbeiter-Konten angelegt werden.<br>
          - <b>Mitarbeiter verwalten:</b> Alle Mitarbeiter werden hier aufgelistet und man kann sie bearbeiten.<br>

      </div>

    </div>
  <%
  }
  %>
</body>
</html>
