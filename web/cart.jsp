<%--
  Created by IntelliJ IDEA.
  User: filip
  Date: 02.11.2015
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <jsp:include page="head.html" />
</head>
<body>
<div id="main_container">
  <div id="header">
    <jsp:include page="header.html" />
  </div>
  <div id="main_content">
    <div id="navigation_top">
      <jsp:include page="navigation_top.jsp" />
    </div>
    <div class="crumb_navigation"> Navigation: <span class="current">Produkte</span> </div>
    <div class="navigation_left">
      <jsp:include page="navigation_left.jsp" />
    </div>

    <div class="content">


    </div>

      <div id="navigation_right" class="navigation_right">
        <jsp:include page="navigation_right.html" />
      </div>
      <div id="footer" class="footer">
        <jsp:include page="footer.html" />
      </div>
    </div>
  </div>
</body>
</html>
