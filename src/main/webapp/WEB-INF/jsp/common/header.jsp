<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="header">
	<div class="head-con clearfix color-white">
		<div class="pull-left">
			<p class="p-title ft-28">慕课</p>
			<p class="s-title">四川电力职业技术学院</p>
		</div>
		<div class="login-sta pull-right clearfix">
			<c:if test="${sessionScope.username ne null }">
				<p class="pull-left">您好,${sessionScope.username}</p>
				<a href="/logout" class="pull-left">退出</a>
			</c:if>
  			<c:if test="${sessionScope.username eq null }">
  				<a class="pull-left" href="/login">登录</a>
  			</c:if>
		</div>
	</div>
</div>