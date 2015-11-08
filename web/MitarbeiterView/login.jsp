<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 26.10.2015
  Time: 09:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="de">
<head>
  <link rel="stylesheet" type="text/css" href="style.css" />
  <title>Login</title>
</head>
<body bgcolor="#a9a9a9">
<div>
  <div id="login" align="center">
    <label>Mitarbeiter Verwaltungs Application </label><br/><br/><br/>
    <form name="loginForm" method="post" action="../loginServlet">
      <table align="center">
        <tr>
          <td>Username:</td>
          <td><input type="text" name="username"/></td>
        </tr>
        <tr>
          <td>Password:</td>
          <td><input type="password" name="password"/></td>
        </tr>
        <tr>
          <td align="right" colspan="2"> <input type="submit" value="Login" /></td>
        </tr>
      </table>
      <input  type="hidden" name="targetpage" value="MitarbeiterView/main.jsp"/> <br/>
      <input type="hidden" name="sourcepage" value="../MitarbeiterView/login.jsp"/> <br/>

    </form>
  </div>
</div>
</body>
</html>
