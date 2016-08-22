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
					<p class="color-gray">《思想道德修养与法律基础》教材于2006年出版后，为了充分体现中国特色社会主义[1]  理论成果和实践经验，课题组分别于2007年7月、2008年1月、2009年5月和2010年5月对教材进行了修订。2013年5月至7月，为了推动党的十八大[2]  精神进教材、进课堂、进头脑，体现上次修订以来中国特色社会主义理论和实践的创新成果，体现思想政治教育学科的新进展，中宣部、教育部组织课题组在广泛调研的基础上，再次对教材进行了修订。马克思主义理论研究和建设工程咨询委员会对教材修订稿进行了审议指导。</p>
					<a href="" class="color-33 pull-right ft-18">查看更多&gt;&gt;</a>
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
						<p class="test-status"><c:if test="${chapter.exam eq 0 }">已通过</c:if><c:if test="${chapter.exam eq null }"><a href="/exam?chapIndex=${chapIndex.index }" class="j-start-exam">未开始</a></c:if><c:if test="${chapter.exam eq -1 }"><a href="/exam?chapIndex=${chapIndex.index }" class="j-start-exam">未通过</a></c:if></p>
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
						oneChaps.eq(i).children('.test-status').children('a').text('未通过');
					}else if(exam == 0){
						oneChaps.eq(i).children('.test-status').text('已通过');
					}
				}
			}
		});
	</script>
</body>
</html>