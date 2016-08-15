<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html">
<html>
  <head>
    <title>index</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
	<c:if test="${sessionScope.username ne null }">${sessionScope.username}，您好！&emsp;&emsp;&emsp;<a href="/logout">退出</a></c:if>
  	<c:if test="${sessionScope.username eq null }"><a href="/login">登录</a></c:if>
  
    This is my JSP page. <br>
    ${username }<br>
    nested obj:<%=session.getAttribute("username")%><br>
    nested obj:<%=session.getAttribute("login")%><br>
    
    el:${sessionScope.username}<br>
    el:${sessionScope.login}<br>
    nested obj:<%=session.getId()%><br>
    login:
    <c:if test="${sessionScope.username ne null }">${sessionScope.username}</c:if>
    <c:if test="${sessionScope.username eq null }">unlogin</c:if>
  </body>
</html>
