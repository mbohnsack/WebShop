<%--
  Created by IntelliJ IDEA.
  User: Chris
  Date: 26.10.2015
  Time: 09:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" %>
<%
  String cookieName = "username";
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
%>
<html>
<head>
  <title>Show Saved Cookie</title>
</head>
<body>


<%
  if (myCookie == null) {
%>
No Cookie found with the name <%=cookieName%>
<%
} else {
%>
<p>Welcome: <%=myCookie.getValue()%>.
    <%
}
%>
</body>