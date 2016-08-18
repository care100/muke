<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="footer">

</div>
<script src="/static/js/jquery-1.12.3.min.js"></script>
<script>
	//是否登录
	function isLogin(){
		return document.cookie.substr(document.cookie.indexOf("login=")+6,1) == 0 ? false : true;
	}

	$(function(){
		/* $.ajax({
			type: "post",
            url: "/chapster",
            data: {"productId":2325,"abc":{"def": 888}},
            dataType: "json",
            beforeSend: function(){
            	console.log("before");
            },
            success: function(data){
            	console.log(data);
            	console.log(JSON.stringify(data));
            },
            error: function(){
            	console.log("error");
            }
		}); */
	});
</script>