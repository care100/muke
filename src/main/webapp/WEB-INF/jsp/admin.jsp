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
		.main-con{margin: 0 20px;padding-bottom: 30px;}
		#search-form{float: left;padding: 20px 30px 0;overflow: hidden;}
		.search-box{float: left;}
		.search-t{line-height: 34px;padding-right: 10px;}
		.search-stu{margin-right: 10px;}
		#file-form{display: block;clear: right;padding: 20px 30px 0;overflow: hidden;float: right;}
		.down-model{float: left;display: block;line-height: 34px;padding: 0 8px;color: #fff;background-color: #28a0dc;border-radius: 5px;}
		.one-in{overflow: hidden;position: relative;float: left;width: 100px;height: 34px;margin-left: 10px;}
		.one-in .in-t{display: block;width: 100px;text-align: center;line-height: 34px;color: #fff;background-color: #28a0dc;border-radius: 5px;}
		.one-in .students-in{width: 100px;height: 34px;position: absolute;top: 0;left: 0;cursor: pointer;opacity: 0;}
		.upload-msg{float: left;line-height: 34px;margin-left: 10px;}
		.one-in input.error{border-color: red;}
		.one-in label.error{display: block;font-size: 12px;color: red;position: absolute;top: 38px;left: 130px;}
		.sub-btn{display: block;width: 120px;height: 34px;line-height: 34px;margin: 10px auto;color: #fff;background: #28a0dc;border: 0;cursor: pointer;}
	
		.s-t-title{font-size: 20px;line-height: 56px;color: #6a6a6a;padding-left: 30px;clear: left;}
		table{border-collapse: collapse;border: 1px solid #ccc;font-size: 14px;width: 100%;}
		th{line-height: 32px;border: 1px solid #ccc;padding: 0 3px;color: #6a6a6a;}
		td{line-height: 32px;border: 1px solid #ccc;text-align: center;padding: 0 3px;color: #999;}
		.study-no{color: #ff8888;}
		.study-ing{color: #8888ff;}
		.exam-no{color: #ff8888;}
		.exam-fail{color: #8888ff;}
	</style>
</head>
<body>
	<!-- header -->
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="main">
		<div class="main-con">
			<form id="search-form" action="/admin" method="GET">
				<div class="search-box">
					<label class="search-t">学号/姓名:</label>
					<input class="search-stu" type="text" name="student" placeholder="学号或姓名" value="${searchKey }">
				</div>
				<button class="down-model">查询</button>
				<p class="upload-msg">${searchMsg }</p>
			</form>
			<form id="file-form" action="/admin" method="POST" enctype="multipart/form-data">
				<a class="down-model" href="/static/excel/students.xls" target="_blank">下载模板</a>
				<div class="one-in">
					<label class="in-t">导入学员</label>
					<input class="students-in" type="file" name="students" id="students-in" placeholder="学员excel表格">
				</div>
				<p class="upload-msg j-upload-msg">${fileUploadrMsg }</p>
			</form>
			<p class="s-t-title">学员学习和测试情况</p>
			<table>
				<thead>
					<tr>
						<th rowspan="2">学号</th>
						<th rowspan="2">姓名</th>
						<th colspan="2">绪论</th>
						<th colspan="2">第一章</th>
						<th colspan="2">第二章</th>
						<th colspan="2">第三章</th>
						<th colspan="2">第四章</th>
						<th colspan="2">第五章</th>
						<th colspan="2">第六章</th>
						<th colspan="2">第七章</th>
						<th colspan="2">第八章</th>
					</tr>
					<tr>
						<th>学习进度</th>
						<th>测试进度</th>
						<th>学习进度</th>
						<th>测试进度</th>
						<th>学习进度</th>
						<th>测试进度</th>
						<th>学习进度</th>
						<th>测试进度</th>
						<th>学习进度</th>
						<th>测试进度</th>
						<th>学习进度</th>
						<th>测试进度</th>
						<th>学习进度</th>
						<th>测试进度</th>
						<th>学习进度</th>
						<th>测试进度</th>
						<th>学习进度</th>
						<th>测试进度</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="oneStatus" items="${status }" varStatus="oneIndex">
						<tr>
							<td>${oneStatus.student_id }</td>
							<td>${oneStatus.name }</td>
							<c:if test="${oneStatus.xulun eq null }"><td class="study-no">未开始</td></c:if><c:if test="${oneStatus.xulun gt 0 }"><td class="study-ing">进行中</td></c:if><c:if test="${oneStatus.xulun eq -1 }"><td>已完成</td></c:if>
							<c:if test="${oneStatus.xulun_exam eq null }"><td class="exam-no">未开始</td></c:if><c:if test="${oneStatus.xulun_exam eq -1 }"><td class="exam-fail">未通过</td></c:if><c:if test="${oneStatus.xulun_exam eq 0 }"><td>已通过</td></c:if>
							<c:if test="${oneStatus.chap1 eq null }"><td class="study-no">未开始</td></c:if><c:if test="${oneStatus.chap1 gt 0 }"><td class="study-ing">进行中</td></c:if><c:if test="${oneStatus.chap1 eq -1 }"><td>已完成</td></c:if>
							<c:if test="${oneStatus.chap1_exam eq null }"><td class="exam-no">未开始</td></c:if><c:if test="${oneStatus.chap1_exam eq -1 }"><td class="exam-fail">未通过</td></c:if><c:if test="${oneStatus.chap1_exam eq 0 }"><td>已通过</td></c:if>
							<c:if test="${oneStatus.chap2 eq null }"><td class="study-no">未开始</td></c:if><c:if test="${oneStatus.chap2 gt 0 }"><td class="study-ing">进行中</td></c:if><c:if test="${oneStatus.chap2 eq -1 }"><td>已完成</td></c:if>
							<c:if test="${oneStatus.chap2_exam eq null }"><td class="exam-no">未开始</td></c:if><c:if test="${oneStatus.chap2_exam eq -1 }"><td class="exam-fail">未通过</td></c:if><c:if test="${oneStatus.chap2_exam eq 0 }"><td>已通过</td></c:if>
							<c:if test="${oneStatus.chap3 eq null }"><td class="study-no">未开始</td></c:if><c:if test="${oneStatus.chap3 gt 0 }"><td class="study-ing">进行中</td></c:if><c:if test="${oneStatus.chap3 eq -1 }"><td>已完成</td></c:if>
							<c:if test="${oneStatus.chap3_exam eq null }"><td class="exam-no">未开始</td></c:if><c:if test="${oneStatus.chap3_exam eq -1 }"><td class="exam-fail">未通过</td></c:if><c:if test="${oneStatus.chap3_exam eq 0 }"><td>已通过</td></c:if>
							<c:if test="${oneStatus.chap4 eq null }"><td class="study-no">未开始</td></c:if><c:if test="${oneStatus.chap4 gt 0 }"><td class="study-ing">进行中</td></c:if><c:if test="${oneStatus.chap4 eq -1 }"><td>已完成</td></c:if>
							<c:if test="${oneStatus.chap4_exam eq null }"><td class="exam-no">未开始</td></c:if><c:if test="${oneStatus.chap4_exam eq -1 }"><td class="exam-fail">未通过</td></c:if><c:if test="${oneStatus.chap4_exam eq 0 }"><td>已通过</td></c:if>
							<c:if test="${oneStatus.chap5 eq null }"><td class="study-no">未开始</td></c:if><c:if test="${oneStatus.chap5 gt 0 }"><td class="study-ing">进行中</td></c:if><c:if test="${oneStatus.chap5 eq -1 }"><td>已完成</td></c:if>
							<c:if test="${oneStatus.chap5_exam eq null }"><td class="exam-no">未开始</td></c:if><c:if test="${oneStatus.chap5_exam eq -1 }"><td class="exam-fail">未通过</td></c:if><c:if test="${oneStatus.chap5_exam eq 0 }"><td>已通过</td></c:if>
							<c:if test="${oneStatus.chap6 eq null }"><td class="study-no">未开始</td></c:if><c:if test="${oneStatus.chap6 gt 0 }"><td class="study-ing">进行中</td></c:if><c:if test="${oneStatus.chap6 eq -1 }"><td>已完成</td></c:if>
							<c:if test="${oneStatus.chap6_exam eq null }"><td class="exam-no">未开始</td></c:if><c:if test="${oneStatus.chap6_exam eq -1 }"><td class="exam-fail">未通过</td></c:if><c:if test="${oneStatus.chap6_exam eq 0 }"><td>已通过</td></c:if>
							<c:if test="${oneStatus.chap7 eq null }"><td class="study-no">未开始</td></c:if><c:if test="${oneStatus.chap7 gt 0 }"><td class="study-ing">进行中</td></c:if><c:if test="${oneStatus.chap7 eq -1 }"><td>已完成</td></c:if>
							<c:if test="${oneStatus.chap7_exam eq null }"><td class="exam-no">未开始</td></c:if><c:if test="${oneStatus.chap7_exam eq -1 }"><td class="exam-fail">未通过</td></c:if><c:if test="${oneStatus.chap7_exam eq 0 }"><td>已通过</td></c:if>
							<c:if test="${oneStatus.chap8 eq null }"><td class="study-no">未开始</td></c:if><c:if test="${oneStatus.chap8 gt 0 }"><td class="study-ing">进行中</td></c:if><c:if test="${oneStatus.chap8 eq -1 }"><td>已完成</td></c:if>
							<c:if test="${oneStatus.chap8_exam eq null }"><td class="exam-no">未开始</td></c:if><c:if test="${oneStatus.chap8_exam eq -1 }"><td class="exam-fail">未通过</td></c:if><c:if test="${oneStatus.chap8_exam eq 0 }"><td>已通过</td></c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
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
    		
    		if($('.j-upload-msg').text() == "上传成功！"){
    			setTimeout(function(){
    				window.location.href = "/admin";
    			},1000);
    		}
    	});
    </script>
</body>
</html>