<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>首页</title>
	<link rel="icon" href="/static/images/favicon.ico">
	<link rel="shortcut icon" href="/static/images/favicon.ico">
	<link href="/static/css/common.css" rel="stylesheet">
	<link href="/static/css/index.css" rel="stylesheet">
</head>
<body>
	<!-- header -->
	<%@include file="/WEB-INF/jsp/common/header.jsp"%>
	<div class="main">
		<div class="main-con">
			<div class="book">
				<div class="book-msg pull-left">
					<h1 class="ft-28 color-33">《思想道德修养与法律基础》</h1>
					<div class="msg-box">
						<p class="class-msg color-gray">本课程是全院各专业三年制高职学生必修的一门公共基础课，旨在对学生进行思想品德教育和法制教育，帮助学生树立正确的世界观、人生观、道德观和法制观，塑造高尚人格，选择正确的行为，走好人生道路，成为有理想、有道德、有文化、有纪律的社会主义建设者。</p>
						<p class="class-msg color-gray">本课程从当代大学生面临和关心的实际问题出发，以理想信念教育为核心，爱国主义教育为重点，思想道德建设为基础，综合素质培养为宗旨进行该课程教学。通过理论学习和实践体验，帮助大学生形成崇高的理想信念，弘扬伟大的爱国主义精神，确立正确的人生观和价值观，塑造健康心理，牢固树立社会主义荣辱观，培养良好的思想道德素质和法律素质，进一步提高分辨是非、善恶、美丑和加强自我修养能力，为逐渐成为德智体美全面发展的社会主义事业的合格建设者和接班人，打下扎实的思想道德和法律基础。实践活动是重要的教学环节，有助于激发学习兴趣，增强学生对理论的感性认识，促使知识向素质转化</p>
					</div>
					<a class="show-more color-33 pull-right ft-18">查看更多&gt;&gt;</a>
				</div>
				<img src="/static/images/book-cover.jpg" class="book-cover pull-right">
			</div>
			<div class="chapter">
				<div class="chap-title">
					<p class="chap-title-text pull-left color-blue">课程章节</p>
					<p class="pull-left color-darkgrey">学习进度</p>
					<p class="pull-right color-darkgrey">章节测试</p>
				</div>
				<c:forEach var="chapter" items="${chapters }" varStatus="chapIndex">
					<div class="one-chap">
						<span class="icon-chap <c:if test="${chapter.study gt 0 }">icon-half</c:if><c:if test="${chapter.study eq 0 }">icon-no</c:if><c:if test="${chapter.study eq null }">icon-no</c:if><c:if test="${chapter.study eq -1 }">icon-had</c:if>"></span>
						<a href="/study?chapIndex=${chapIndex.index }" class="chap-name j-study-chap" target="_blank">${chapter.chapName }</a>
						<p class="study-status"><c:if test="${chapter.study gt 0 }">进行中</c:if><c:if test="${chapter.study eq null }">未开始</c:if><c:if test="${chapter.study eq -1 }">已完成</c:if></p>
						<p class="test-status">
							<c:if test="${chapter.exam eq 0 }">已通过</c:if>
							<c:if test="${chapter.exam eq null }">
								<a href="/exam?chapIndex=${chapIndex.index }" class="j-start-exam">
									<span class="exam-status-text">未开始</span>
									<span class="exam-hover">开始测试</span>
								</a>
							</c:if>
							<c:if test="${chapter.exam eq -1 }">
								<a href="/exam?chapIndex=${chapIndex.index }" class="j-start-exam">
									<span class="exam-status-text">未通过</span>
									<span class="exam-hover">重新测试</span>
								</a>
							</c:if>
						</p>
					</div>
				</c:forEach>
				<%-- <div class="one-chap">
					<span class="icon-chap <c:if test="${chap9 gt 0 }">icon-half</c:if> <c:if test="${xulun eq 0 }">icon-no</c:if> <c:if test="${xulun eq -1 }">icon-had</c:if>"></span>
					<a href="chap9" class="chap-name" target="_blank">结束语 立志做社会主义“四有”新人</a>
					<p class="test-status">已完成</p>
				</div> --%>
			</div>
		</div>
	</div>
	
	<!-- footer -->
	<%@include file="/WEB-INF/jsp/common/footer.jsp"%>
	<!-- footer -->
	
	<!-- modal-bg -->
	<div class="modal-bg"></div>
	<div class="modal">
		<div class="modal-con">
			<iframe class="study-iframe" scrolling="no"></iframe>
		</div>
	</div>
	
	<script>
		function closeStudy () {
			window.location.reload();
		}
		$(function(){
			var screenH = $('body').height();
			if(screenH <= 620){
				$('.modal-con').css({'height':(screenH-20)+'px','width': '820px','overflow':'auto'});
			}else{
				$('.modal-con').css({'margin':((screenH-600)/2)+'px auto'});
			}
			
			//展示更多
			$('.show-more').click(function(){
				$(this).remove();
				$('.msg-box').css({'overflow':'auto','height':'auto','padding-bottom':'25px'});
				$('.book').css('height','auto');
			});
			
			//学习
			$('.j-study-chap').click(function(){
				$('.modal-bg').show();
				$('.modal').show();
				$('iframe').attr('src',$(this).attr('href'));
				$('body').css('overflow','hidden');
				return false;
			});
			
			//测试
			$('.j-start-exam').click(function(){
				if($(this).closest('.one-chap').children('.icon-chap').hasClass('icon-had')){
					$('.modal-bg').show();
					$('.modal').show();
					$('iframe').attr('src',$(this).attr('href'));
					$('body').css('overflow','hidden');
					return false;
				}else{
					alert("请先完成本章学习！");
					return false;
				}
			});
			
			//未登录时读取本地的学习、测试结果缓存
			if(!isLogin()){
				var oneChaps = $('.one-chap');
				for(var i = 0;i < oneChaps.length;i++){
					var chap = localStorage.getItem('chap'+i);
					if(chap == 1){
						oneChaps.eq(i).children('.icon-chap').removeClass('icon-no').addClass('icon-half');
						oneChaps.eq(i).children('.study-status').text('进行中');
					}else if(chap == -1){
						oneChaps.eq(i).children('.icon-chap').removeClass('icon-no').addClass('icon-had');
						oneChaps.eq(i).children('.study-status').text('已完成');
					}
					var exam = localStorage.getItem('exam'+i);
					if(exam == -1){
						var con = $('<span class="exam-status-text">未通过</span><span class="exam-hover">重新测试</span>');
						oneChaps.eq(i).children('.test-status').children('a').html(con);
					}else if(exam == 0){
						oneChaps.eq(i).children('.test-status').text('已通过');
					}
				}
			}
		});
	</script>
</body>
</html>