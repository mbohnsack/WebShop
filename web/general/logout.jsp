<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 27.10.2015
  Time: 19:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  //Cookie abrufen um auf die LoginURL zuzugreifen
  String cookieName = "LoginCookieURL";
  Cookie cookies [] = request.getCookies ();
  Cookie myCookie = null;
  if (cookies != null)
  {
    for (int i = 0; i < cookies.length; i++)
    {
      if (cookies [i].getName().equals (cookieName))
      {
        myCookie = cookies[i];
        break;
      }
    }
  }
  String targetPage = myCookie.getValue();

  //Cookie mit den Anmeldedaten auslesen und löschen
  cookieName = "LoginCookie";
  if (cookies != null)
  {
    for (int i = 0; i < cookies.length; i++)
    {
      if (cookies [i].getName().equals (cookieName))
      {
        myCookie = cookies[i];
        break;
      }
    }
  }
  //Kill Cookie
  myCookie.setMaxAge(0);
  myCookie.setPath("/");
  response.addCookie(myCookie);
%>
<html>
<head>
  <meta http-equiv="refresh" content="0; URL=<%=targetPage%>">
    <title></title>
</head>
<body>

</body>
</html>