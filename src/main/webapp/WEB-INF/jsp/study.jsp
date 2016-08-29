<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html">
<html>
<head>
	<meta charset="UTF-8">
    <title>绪论</title>
    <link rel="icon" href="/static/images/favicon.ico">
	<link rel="shortcut icon" href="/static/images/favicon.ico">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="/static/css/common.css" rel="stylesheet">
</head>
<body>
	<div class="study-main">
		<div class="loading-box">
			<img src="/static/images/loading.gif" class="loading-img">
		</div>
		
		<p class="close-btn">×</p>
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,0,0" width="800" height="600" id="sixiu" align="middle">
			<param name="allowScriptAccess" value="sameDomain" />
			<param name="allowFullScreen" value="false" />
			<param name="movie" value="/static/flash/${flash }.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#ffffff" />
			<embed src="/static/flash/${flash }.swf" quality="high" bgcolor="#ffffff" width="800" height="600" name="sixiu" align="middle" allowScriptAccess="sameDomain" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/go/getflashplayer_cn" />
		</object>
	</div>
	
	<!-- footer -->
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	<!-- footer -->
	
	<script src="/static/js/study.js?1"></script>
	<script>
		window.onload = function(){
			$('.loading-box').hide();
		};
	</script>
</body>
</html>
