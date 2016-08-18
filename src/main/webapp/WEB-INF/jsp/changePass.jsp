<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>修改密码</title>
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
			<form id="cp-form" action="">
				<p class="back-error">${errorMsg }</p>
				<div class="one-in">
					<label class="in-t">原密码</label>
					<input class="in-pass" type="password" name="oldpass" id="old-pass" placeholder="请输入原密码">
				</div>
				<div class="one-in">
					<label class="in-t">新密码</label>
					<input class="in-pass" type="password" name="newpass" id="new-pass" placeholder="请输入新密码">
				</div>
				<div class="one-in">
					<label class="in-t">重复新密码</label>
					<input class="in-pass" type="password" name="renewpass" id="renew-pass" placeholder="请重复新密码">
				</div>
			</form>
			<input type="submit" value="提交" class="sub-btn">
		</div>
	</div>
	
	<!-- footer -->
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	<!-- footer -->
	
	<script src="/static/js/jquery-1.12.3.min.js"></script>
    <script src="/static/js/jquery.validate.js"></script>
    <script>
    	$(function(){
    		$('#cp-form').validate({
				rules:{
				  	oldpass:{
						required:true,
						minlength: 6,
						maxlength: 20
				    },
					newpass:{
						required:true,
						minlength: 6,
						maxlength: 20
				    },
				    renewpass:{
						required:true,
						minlength: 6,
						maxlength: 20,
						equalTo: '#new-pass'
				    }
				},
				messages:{
					oldpass:{
				  		required:"请输入用户名！",
				  		minlength:"密码至少6位！",
				  		maxlength:"密码最多20位！"
					},
				 	newpass:{
				  		required:"请输入密码！",
				  		minlength:"密码至少6位！",
				  		maxlength:"密码最多20位！"
				 	},
				 	renewpass:{
				  		required:"请输入密码！",
				  		minlength:"密码至少6位！",
				  		maxlength:"密码最多20位！",
				  		equalTo: "两次输入的密码不一致"
				 	}
				}
    		});
    		
    		$('.sub-btn').click(function(){
    			if($('#cp-form').valid()){
    				var oldPass = $('#old-pass').val();
    				var newPass = $('#new-pass').val();
    				var renewPass = $('#renew-pass').val();
    				$.ajax({
    					type: 'POST',
    					url: '/change',
						data: {"oldPass":oldPass,"newPass": newPass,"renewPass":renewPass},
        				dataType: "json",
        				success: function(data){
        					if(data.status){
        						alert(data.msg);
        						window.location.href = "/logout";
        					}else{
        						alert(data.msg);
        					}
        				}
    				});
    			}
    		});
    	});
    </script>
</body>
</html>