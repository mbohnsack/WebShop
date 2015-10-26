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
  <title></title>
</head>
<body>
<form name="loginForm" method="post" action="loginServlet">
  Username: <input type="text" name="username"/> <br/>
  Password: <input type="password" name="password"/> <br/>
  <input type="hidden" name="targetpage" value="main.jsp"/> <br/>
  <input type="submit" value="Login" />
</form>
</body>
</html>
