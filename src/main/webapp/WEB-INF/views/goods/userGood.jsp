<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${user.name}发布的物品</title>
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/css/swiper.min.css"/>">
<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
</head>
<body>
	<jsp:include page="../home/header.jsp" />

	<div class="container"
		style="position: relative; transform: translate(0, 0)">
		<div class="col-md-9" style="float: left">
			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">用户信息</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px">
				<div class="col-md-2" style="padding-left: 0px; padding-right: 0px;">
					<img src="<c:url value="${user.photoUrl}"/>" width="128px"
						height="128px">
				</div>
				
				<div class="col-md-10">
					<div class="col-md-12" style="height: 60px;">
						<h3>
							<B>${user.name}</B>
						</h3>
					</div>
					
					<div class="col-md-2" style="padding-right: 0px">
						<p style="color: #666666; height: 20px">
							<B>昵称：</B>
						</p>
						<p style="color: #666666; height: 20px">
							<B>性别：</B>
						</p>
					</div>
					
					<div class="col-md-2" style="padding-left: 0px">
						<p style="color: #666666; height: 20px">${user.name}</p>
						<p style="color: #666666; height: 20px">${user.gender}</p>
					</div>
					
					<div class="col-md-2" style="padding-right: 0px">
						<p style="color: #666666; height: 20px">
							<B>手机号：</B>
						</p>
						<p style="color: #666666; height: 20px">
							<B>邮箱：</B>
						</p>
					</div>
					
					<div class="col-md-3" style="padding-left: 0px">
						<p style="color: #666666; height: 20px">${user.mobile}</p>
						<p style="color: #666666; height: 20px">${user.email}</p>
					</div>
				</div>
			</div>

			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">发布的物品</B>
				</div>
			</div>
			
			<div class="col-md-12 r2" style="background-color: #f9f9f9;">
				<div class="col-md-12"
					style="margin-top: 15px; margin-bottom: 15px; padding: 15px 15px 15px 5px; background-color: #ffffff">
					<c:choose>
						<c:when test="${userGoods.size() == 0}">
							<div align="center">
								<h4>抱歉，此用户未发布物品！</h4>
							</div>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="userGood" items="${userGoods}">
								<a
									href="/secondshop/goods/goodInfo?goodId=${userGood.id}">
									<div class="c col-md-4">
										<div class="a col-md-12">
											<img src="<c:url value="${userGood.photoUrl}"/>" width="100%" height="200px">
											<p></p>
											<p style="height: 25px">${userGood.name}</p>
											<p style="color: red; text-align: right">
												<B>价格：${userGood.prise}￥</B>
											</p>
										</div>
									</div>
								</a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		
		<div id="re-bar" class="col-md-3 r"
			style="background-color: #f9f9f9; padding-bottom: 15px;">
			<div class="col-md-12 r"
				style="text-align: center; margin-top: 10px; background-color: #e4e4e4; padding: 5px">
				<B style="font-size: 20px; color: #a2a2a2">最新发布的物品</B>
			</div>
			
			<div class="col-md-12"
				style="margin-top: 20px; padding-left: 0px; padding-right: 0px">
				<c:forEach var="Good" items="${goods}">
					<a
						href="/secondshop/goods/goodInfo?goodId=${Good.id}">
						<div class="col-md-12 b"
							style="padding-left: 0px; padding-right: 0px">
							<div class="col-md-6"
								style="padding-top: 15px; padding-bottom: 15px">
								<img src="<c:url value="${Good.photoUrl}"/>" height="100px"
									; width="100px">
							</div>
							
							<div class="col-md-6"
								style="padding-top: 15px; padding-bottom: 15px; height: 130px">
								<p style="height: 75px">${Good.name}</p>
								<p align="right" style="color: red">￥${Good.prise}</p>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
	</div>

	<jsp:include page="../home/footer.jsp" />

	<script>
		var bar_width = document.getElementById("re-bar").scrollWidth;
		$(function() {
			$(window).scroll(function() {
				if ($(document).scrollTop() >= 20) {
					$("#re-bar").css({
						"position" : "fixed",
						"top" : 50 + $(document).scrollTop() + "px",
						"width" : bar_width,
						"right" : 15
					});
				} else {
					$("#re-bar").css({
						"position" : "fixed",
						"top" : 70 + "px",
						"width" : bar_width,
						"right" : 15
					});
				}
			})
		});
	</script>
	<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
	<script
		src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>