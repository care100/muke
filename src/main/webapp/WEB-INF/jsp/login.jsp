<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html">
<html>
<head>
	<title>登录</title>
	<link rel="icon" href="/static/images/favicon.ico">
	<link rel="shortcut icon" href="/static/images/favicon.ico">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="/static/css/common.css" rel="stylesheet">
	<style>
		.head-con{text-align: center;}
		.back-error{color: red;font-size: 12px;line-height: 32px;padding-left: 130px;}
		form{width: 600px;margin: 0 auto;padding: 50px 30px;}
		form label{display: block;position: relative;height: 35px;padding-bottom: 25px;}
		form label span{display: block;float: left;width: 120px;text-align: right;line-height: 34px;}
		form label input{display: block;float: left;width: 300px!important;height: 35px;margin-left: 10px;border: 1px solid #ccc;line-height: 32px;}
		form label input:focus{border-color:#28a0dc;}
		form label input.error{border-color: red;}
		form label label.error{display: block;font-size: 12px;color: red;position: absolute;top: 38px;left: 130px;}
		.sub-btn{display: block;width: 120px;height: 34px;line-height: 34px;margin: 10px auto;color: #fff;background: #28a0dc;border: 0;cursor: pointer;}
	</style>
</head>
 <body>
	<div class="header">
		<div class="head-con clearfix color-white">
			<div class="">
				<p class="p-title ft-28">慕课-思修</p>
				<p class="s-title">四川电力职业技术学院</p>
			</div>
		</div>
	</div>
    <form action="/login" method="post">
    	<p class="back-error">${errorMsg }</p>
    	<label class="clearfix">
    		<span>用户名：</span>
    		<input type="text" name="username" placeholder="请输入用户名">
    	</label>
    	<label class="clearfix">
    		<span>密码：</span>
    		<input type="password" name="password" placeholder="请输入密码">
    	</label>
    	<input type="submit" value="登录" class="sub-btn">
    </form>
    <script src="/static/js/jquery-1.12.3.min.js"></script>
    <script src="/static/js/jquery.validate.js"></script>
    <script>
    	$(function(){
    		$('form').validate({
				rules:{
				  	username:{
						required:true
				    },
					password:{
						required:true,
						minlength: 6,
						maxlength: 20
				    }
				},
				messages:{
					username:{
				  		required:"请输入用户名！"
					},
				 	password:{
				  		required:"请输入密码！",
				  		minlength:"密码至少6位！",
				  		maxlength:"密码最多20位！"
				 	}
				}
    		});
    	});
    </script>
</body>
</html>
