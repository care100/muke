<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>课程管理</title>
	<link href="/static/css/common.css" rel="stylesheet">
	<style>
		form{display: block;width: 600px;margin: 0 auto;padding: 50px 30px 0;}
		.back-error{}
		.one-in{overflow: hidden;height: 66px;padding-bottom: 30px;position: relative;}
		.one-in .in-t{display: block;width: 120px;text-align: right;line-height: 36px;float: left;}
		.one-in .in-pass{display: block;width: 300px;float: left;height: 36px;box-sizing: border-box;border: 1px solid #ccc;line-height: 34px;margin-left: 10px;}
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
				<p class="back-error">${errorMsg }</p>
				<div class="one-in">
					<label class="in-t">导入学员</label>
					<p>${fileUploadrMsg }</p>
					<input class="students-in" type="file" name="students" id="students-in" placeholder="学员excel表格">
					<a href="/static/excel/students.xls" target="_blank">下载模板</a>
				</div>
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