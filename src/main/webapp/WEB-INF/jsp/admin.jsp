<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>课程管理</title>
	<link rel="icon" href="/static/images/favicon.ico">
	<link rel="shortcut icon" href="/static/images/favicon.ico">
	<link href="/static/css/common.css" rel="stylesheet">
	<style>
		.main-con{width: 1000px;margin: 0 auto;}
	
		form{display: block;padding: 20px 30px 0;overflow: hidden;}
		.down-model{float: left;display: block;line-height: 34px;padding: 0 8px;color: #fff;background-color: #28a0dc;border-radius: 5px;}
		.one-in{overflow: hidden;position: relative;float: left;width: 100px;height: 34px;margin-left: 10px;}
		.one-in .in-t{display: block;width: 100px;text-align: center;line-height: 34px;color: #fff;background-color: #28a0dc;border-radius: 5px;}
		.one-in .students-in{width: 100px;height: 34px;position: absolute;top: 0;left: 0;cursor: pointer;opacity: 0;}
		.upload-msg{float: left;line-height: 34px;margin-left: 10px;}
		.one-in input.error{border-color: red;}
		.one-in label.error{display: block;font-size: 12px;color: red;position: absolute;top: 38px;left: 130px;}
		.sub-btn{display: block;width: 120px;height: 34px;line-height: 34px;margin: 10px auto;color: #fff;background: #28a0dc;border: 0;cursor: pointer;}
	
	</style>
</head>
<body>
	<!-- header -->
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="main">
		<div class="main-con">
			<form id="file-form" action="/admin" method="POST" enctype="multipart/form-data">
				<a class="down-model" href="/static/excel/students.xls" target="_blank">下载模板</a>
				<div class="one-in">
					<label class="in-t">导入学员</label>
					<input class="students-in" type="file" name="students" id="students-in" placeholder="学员excel表格">
				</div>
				<p class="upload-msg">${fileUploadrMsg }</p>
			</form>
		</div>
	</div>
	
	<!-- footer -->
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	<!-- footer -->
	
	<script src="/static/js/jquery-1.12.3.min.js"></script>
    <script src="/static/js/jquery.validate.js"></script>
    <script>
    	$(function(){
    		$('.students-in').change(function(){
    			$('#file-form').submit();
    		});
    	});
    </script>
</body>
</html>