<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>测试</title>
	<link rel="icon" href="/static/images/favicon.ico">
	<link rel="shortcut icon" href="/static/images/favicon.ico">
	<link href="/static/css/common.css" rel="stylesheet">
	<style>
		.complete-exam{display: none;}
		.jian-option-item{background-position: -32px 0;padding-left: 0;}
		.j-next-topic{display: none;}
		.answer-right{color: green;text-align: center;padding-top: 10px;}
		.answer-wrong{color: red;text-align: center;padding-top: 10px;}
	</style>
</head>
<body>
	<div class="main">
		<div class="main-con">
			<img class="exam-bg" src="/static/images/bg.png">
			<div class="exam-box">
				<div class="exam-head">
					<p class="exam-chap-title ft-24 ft-yahei">${chapters.chapName }</p>
				</div>
				<p class="exam-msg ft-30 ft-yahei">
					测试
					<span class="ft-18 ft-yahei">（需答对80%才算及格）</span>
				</p>
				
				<!-- 判断题 -->
				<c:forEach var="examItem" items="${examPan }" varStatus="i">
					<div class="one-topic" topic-type="${examItem.type }" answer="${examItem.answer }">
						<c:if test="${examItem.type eq 0 }">
							<p class="quextion-msg">${i.index+1 }、${examItem.question }(判断题)</p>
							<p code="1" class="option-item j-option-item">正确</p>
							<p code="0" class="option-item j-option-item">错误</p>
						</c:if>
					</div>
				</c:forEach>
				
				<!-- 单选题 -->
				<c:forEach var="examItem" items="${examDan }" varStatus="i">
					<div class="one-topic" topic-type="${examItem.type }" answer="${examItem.answer }">
						<c:if test="${examItem.type eq 1 }">
							<p class="quextion-msg">${i.index+1 }、${examItem.question }(单选题)</p>
							<c:forEach var="optionItem" items="${examItem.option.split('&&') }" varStatus="j">
								<p code="${code[j.index] }" class="option-item j-option-item">${code[j.index] }、${optionItem }</p>
							</c:forEach>
						</c:if>
					</div>
				</c:forEach>
				
				<!-- 不定项选择题 -->
				<c:forEach var="examItem" items="${examDuo }" varStatus="i">
					<div class="one-topic" topic-type="${examItem.type }" answer="${examItem.answer }">
						<c:if test="${examItem.type eq 2 }">
							<p class="quextion-msg">${i.index+1 }、${examItem.question }(不定项选择题)</p>
							<c:forEach var="optionItem" items="${examItem.option.split('&&') }" varStatus="j">
								<p code="${code[j.index] }" class="option-item j-option-item">${code[j.index] }、${optionItem }</p>
							</c:forEach>
						</c:if>
					</div>
				</c:forEach>
				
				<!-- 简答题 -->
				<c:forEach var="examItem" items="${examJian }" varStatus="i">
					<div class="one-topic" topic-type="${examItem.type }" answer="${examItem.answer }">
						<c:if test="${examItem.type eq 3 }">
							<p class="quextion-msg">${i.index+1 }、${examItem.question }(简答题--不计测试成绩)</p>
							<c:forEach var="optionItem" items="${examItem.option.split('&&') }" varStatus="j">
								<p code="${code[j.index] }" class="option-item jian-option-item j-option-item">${optionItem }</p>
							</c:forEach>
						</c:if>
					</div>
				</c:forEach>
				<div class="foot-btn">
					<p class="next-topic j-topic-sub">提交</p>
					<p class="next-topic j-next-topic">下一题</p>
					<p class="complete-exam j-complete-exam">完成</p>
				</div>
			</div>
		</div>
	</div>
	
	<!-- footer -->
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	<!-- footer -->

	<script>
		$(function(){
			$('.j-option-item').click(function(){
				//多选题
				if($(this).closest('.one-topic').attr('topic-type') == 2){
					$(this).toggleClass('option-active');
				}else{
					//判断和单选
					$(this).siblings('.j-option-item').removeClass('option-active');
					$(this).toggleClass('option-active');
				}
			});
			
			$('.one-topic').eq(0).addClass('topic-now');
			if($('.one-topic').length == 1){
				$('.next-topic').hide();
				$('.complete-exam').css('display','block');
			}
			//提交
			$('.j-topic-sub').click(function(){
				if($('.topic-now').find('.option-active').length < 1 && $('.topic-now').attr('topic-type') != 3){
					alert('请完成当前题目！');
				}else{
					if($('.topic-now').attr('topic-type') == 2){
						var code = '';
						$('.topic-now').find('.option-active').each(function(){
							code += $(this).attr('code');
						});
						if(code == $('.topic-now').attr('answer')){
							console.log("right");
							$('.topic-now').append('<p class="answer-right">回答正确！</p>');
						}else{
							console.log("wrong");
							$('.topic-now').append('<p class="answer-wrong">回答错误！答案：'+$('.topic-now').attr('answer')+'</p>');
						}
						
					}else{
						if($('.topic-now').attr('answer') == $('.topic-now').find('.option-active').attr('code')){
							console.log("right");
							$('.topic-now').append('<p class="answer-right">回答正确！</p>');
						}else{
							var rightA = $('.topic-now').attr('answer');
							if(rightA == 0){
								rightA = "错误";
							}else if(rightA == 1){
								rightA = "正确";
							}
							console.log("wrong");
							$('.topic-now').append('<p class="answer-wrong">回答错误！答案：'+rightA+'</p>');
						}
					}
					$('.topic-now').find('.j-option-item').unbind();
					$('.j-topic-sub').hide();
					if($('.one-topic').index($('.topic-now')) == $('.one-topic').length-1){
						$('.complete-exam').show();
					}else{
						$('.j-next-topic').show();
					}
				}
			});
			//下一题
			$('.j-next-topic').click(function(){
				var nowTopic = $('.one-topic').index($('.topic-now'));
				$('.topic-now').removeClass('topic-now');
				$('.one-topic').eq(nowTopic+1).addClass('topic-now');
				if($('.topic-now').attr('topic-type') == 3){
					if(nowTopic == $('.one-topic').length-2){
						$('.j-next-topic').hide();
						$('.j-topic-sub').hide();
						$('.complete-exam').show();
					}
				}else{
					$('.j-next-topic').hide();
					$('.j-topic-sub').show();
				}
			});
			//初始化操作按钮
			if($('.topic-now').attr('topic-type') == 3){
				if($('.one-topic').index($('.topic-now')) == $('.one-topic').length-1){
					$('.j-next-topic').hide();
					$('.j-topic-sub').hide();
					$('.complete-exam').show();
				}else{
					$('.j-next-topic').show();
					$('.j-topic-sub').hide();
				}
			}else{
				$('.j-next-topic').hide();
				$('.j-topic-sub').show();
			}
			
			//完成测试,提交
			$('.j-complete-exam').click(function(){
				if($('.topic-now').find('.option-active').length < 1 && $('.topic-now').attr('topic-type') != 3){
					alert('请完成当前题目！');
				}else{
					var totalRight = 0;
					$('.one-topic').each(function(){
						if($(this).attr('topic-type') == 2){
							var code = '';
							$(this).find('.option-active').each(function(){
								code += $(this).attr('code');
							});
							if(code == $(this).attr('answer')){
								totalRight += 1;
							}
						}else if($(this).attr('topic-type') == 3){
							totalRight += 1;
						}else{
							if($(this).attr('answer') == $(this).find('.option-active').attr('code')){
								totalRight += 1;
							}
						}
					});
					var jianNum = $('.one-topic[topic-type=3]').length;
					if(((totalRight-jianNum)/($('.one-topic').length-jianNum)) >= 0.8){
						var result = 0;
					}else{
						var result = -1;
					}
					var chapter = window.location.href.split('?')[1].split('=')[1];
					if(isLogin()){
						$.ajax({
							url: '/examGrade',
							data: {"chap":chapter,"result": result},
	        				dataType: "json",
	        				success: function(data){
	        					if(data.status){
	        						if(result == 0){
	        							alert("恭喜您，通过测试！");
	        						}else{
	        							alert("很遗憾，您未通过测试，再接再厉吧！");
	        						}
	        						window.parent.closeStudy();
	        					}else{
	        						alert("操作失败，请重新提交！");
	        					}
	        				}
						});
					}else{
						if(result == 0){
							alert("恭喜您，通过测试！");
							localStorage.setItem("exam"+chapter,0);
						}else{
							alert("很遗憾，您未通过测试，再接再厉吧！");
							localStorage.setItem("exam"+chapter,-1);
						}
						
						window.parent.closeStudy();
					}
				}
			});
			
		});
	</script>
</body>
</html>