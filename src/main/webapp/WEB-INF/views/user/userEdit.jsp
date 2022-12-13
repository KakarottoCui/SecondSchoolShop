<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改用户信息</title>
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
</head>
<body>
	<jsp:include page="../home/header.jsp" />

	<div class="container"
		style="position: relative; transform: translate(0, 0)">
		<div class="col-md-9" style="float: left;">
			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">修改信息</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding: 30px; margin-bottom: 15px">
				<form:form method="post" commandName="user" items="${user}"
					id="register" enctype="multipart/form-data">
					<div class="col-md-12"
						style="padding-left: 0px; padding-bottom: 10px">
						<div class="col-md-8" style="padding-left: 0px; padding-top: 50px">
							<label for="photo" cssClass="control-label">头像</label> <input
								id="photo" style="margin-top: 10px" type="file" name="photo"
								onchange="change(event)"></input>
						</div>
						
						<div class="col-md-4">
							<img src="<c:url value="${user.photoUrl}"/>" id="img"
								height="120px" width="120px">
						</div>
					</div>
					
					<spring:bind path="name">
						<div class="form-group">
							<form:label path="name" cssClass="control-label">姓名</form:label>
							<form:input path="name" cssClass="form-control"></form:input>
						</div>
					</spring:bind>
					
					<spring:bind path="gender">
						<div class="form-group">
							<form:label path="gender" cssClass="control-label">性别</form:label>
							<form:select path="gender" id="gender" cssClass="form-control">
								<form:option value="男">男</form:option>
								<form:option value="女">女</form:option>
							</form:select>
						</div>
					</spring:bind>
					
					<spring:bind path="mobile">
						<div class="form-group">
							<form:label path="mobile" cssClass="control-label">手机</form:label>
							<form:input path="mobile" cssClass="form-control"></form:input>
							<output itemid="status" style="color: red"></output>
						</div>
					</spring:bind>
					
					<spring:bind path="email">
						<div class="form-group">
							<form:label path="email" cssClass="control-label">邮箱</form:label>
							<form:input path="email" cssClass="form-control"></form:input>
							<output itemid="status" style="color: red" value=""></output>
						</div>
					</spring:bind>
					
					<div class="form-group">
						<button type="submit" class="btn btn-primary">确定</button>
						<a class="btn btn-success pull-right"
							onClick="javascript :history.back(-1);">返回</a>
					</div>
					
					<output style="color: red">${status}</output>
				</form:form>
			</div>

			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">修改密码</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding: 30px; margin-bottom: 15px">
				<div id="sec" class="col-md-12" style="padding: 15px;">
					<div class="form-group">
						<label for="oldPass">原密码</label> <input id="oldPass"
							class="form-control" type="password">
					</div>
					
					<div class="form-group">
						<label for="newPass1">新密码</label> <input id="newPass1"
							class="form-control" type="password">
					</div>
					
					<div class="form-group">
						<label for="newPass2">确认密码</label> <input id="newPass2"
							class="form-control" type="password">
						<output id="passError" style="color: red"></output>
					</div>
					
					<button onclick="submitPass()" class="btn btn-primary">确认修改</button>
				</div>
			</div>
		</div>
		<div id="re-bar" class="col-md-3"
			style="padding-left: 0px; padding-right: 0px;">
			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px; padding-left: 0px; padding-right: 0px;">
				<div id="review-bar" class="col-md-6 rev1-bar" align="center"
					onclick="reviewButton()">
					<B style="font-size: 16px; color: #c4c4c4">收到的评论</B>
				</div>
				
				<div id="reply-bar" class="col-md-6 rev2-bar" align="center"
					onclick="replyButton()">
					<B style="font-size: 16px; color: #c4c4c4">收到的回复</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-bottom: 15px">
				<div id="review-body" class="col-md-12 r3"
					style="display: none; overflow-y: auto; height: 595px; background-color: #ffffff; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 15px;">
					<c:choose>
						<c:when test="${reviews.size() == 0}">
							<div class="col-md-12" align="center"
								style="background-color: #ffffff;">
								<img src="<c:url value="/statics/image/logo/yihan.png"/>"
									width="95%" ; height="170px;">
								<p style="color: #c4c4c4; font-size: 16px">抱歉，暂无评论消息！</p>
							</div>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="review" items="${reviews}">
								<a
									href="/secondshop/user/review?goodId=${review.goodId}&reviewId=${review.id}">
									<div class="col-md-12 rev"
										style="padding-left: 0px; padding-right: 0px; margin-bottom: 5px;">
										<div class="col-md-11">
											<p></p>
											<p style="color: #c4c4c4;">${review.uploadDate}</p>
											<p>
												<B style="color: #2aabd2">${review.fromUser}</B>&nbsp;评论了你的物品
											</p>
										</div>
										
										<c:choose>
											<c:when test="${review.status == 0}">
												<div class="col-md-1" style="padding-right: 0px">
													<img src="<c:url value="/statics/image/logo/yihan.png"/>"
														height="30px" width="25px" align="right">
												</div>
											</c:when>
										</c:choose>
									</div>
								</a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div id="reply-body" class="col-md-12 r3"
					style="display: none; overflow-y: auto; height: 595px; background-color: #ffffff; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 15px;">
					<c:choose>
						<c:when test="${replies.size() == 0}">
							<div class="col-md-12" align="center"
								style="background-color: #ffffff;">
								<img src="<c:url value="/statics/image/logo/yihan.png"/>"
									width="95%" ; height="170px;">
								<p style="color: #c4c4c4; font-size: 16px">抱歉，暂无回复消息！</p>
							</div>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="reply" items="${replies}">
								<a
									href="/secondshop/user/reply?reviewId=${reply.reviewId}&replyId=${reply.id}">
									<div class="col-md-12 rev"
										style="padding-left: 0px; padding-right: 0px; margin-bottom: 5px;">
										<div class="col-md-11">
											<p></p>
											<p style="color: #c4c4c4;">${reply.uploadDate}</p>
											<p>
												<B style="color: #2aabd2">${reply.fromUser}</B>&nbsp;回复了你的消息
											</p>
										</div>
										
										<c:choose>
											<c:when test="${reply.status == 0}">
												<div class="col-md-1" style="padding-right: 0px">
													<img src="<c:url value="/statics/image/logo/yihan.png"/>"
														height="30px" width="25px" align="right">
												</div>
											</c:when>
										</c:choose>
									</div>
								</a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div id="adv-bar" class="col-md-12"
					style="margin-top: 5px; padding: 0px;">
					<div class="col-md-12" align="center">
						<B style="font-size: 20px; color: #c4c4c4">卖出的物品</B>
					</div>
					<div class="col-md-12"
						style="overflow-y: auto; height: 450px; padding: 5px; background-color: #ffffff;">
						<c:choose>
							<c:when test="${sellGoods.size() == 0}">
								<div class="col-md-12" align="center" style="margin-top: 150px">
									<img src="<c:url value="/statics/image/logo/yihan.png"/>"
										width="95%" ; height="170px;">
									<p style="color: #c4c4c4; font-size: 16px">抱歉，暂未卖出物品！</p>
								</div>
							</c:when>
							
							<c:otherwise>
								<c:forEach var="sellGood" items="${sellGoods}">
									<a href="/secondshop/user/sellerInfo?orderId=${sellGood.id}">
										<div class="col-md-12 rev"
											style="padding: 10px; margin-bottom: 5px;">
											<div class="col-md-11" style="padding: 0px;">
												<p></p>
												<p style="color: #c4c4c4;">${sellGood.submitDate}</p>
												<p>
													<B style="color: #2aabd2">${sellGood.customer}</B>&nbsp;购买了你的物品&nbsp;<B
														style="color: #2aabd2">${sellGood.goodName}</B>
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
		</div>
	</div>

	<jsp:include page="../home/footer.jsp" />

	<script>
		function submitPass() {
			var oldPassword = document.getElementById("oldPass").value;
			var password = document.getElementById("newPass1").value;
			var passwordConfirm = document.getElementById("newPass2").value;
			var pass = {
				"userId" : "${sessionScope.user.id}",
				"oldPassword" : oldPassword,
				"newPassword" : password
			};
			console.log(oldPassword);
			console.log(pass)
			if (password !== passwordConfirm) {
				document.getElementById("passError").innerHTML = "对不起，您2次输入的密码不一致";
			} else if (oldPassword === "" || password === "") {
				document.getElementById("passError").innerHTML = "对不起，不可以为空！";
			} else {
				document.getElementById("passError").innerHTML = "";
				$.ajax({
					type : "POST",
					url : "/secondshop/user/password/edit",
					contentType : "application/json; charset=UTF-8", //必须这样写
					dataType : "json",
					data : JSON.stringify(pass),//要提交是json字符串
					success : function(data) {
						if (data === true) {
							alert("密码修改成功！");
						} else {
							alert(data);
						}
					},
					error : function(xhr) {
						alert(xhr.responseText)
					}
				});
			}
		}
	</script>

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

		function change(ev) {
			var event = window.event || ev;
			var files = event.target.files[0];
			var myimg = document.getElementById("img");
			myimg.src = URL.createObjectURL(files);
		}
	</script>
	
	<script>
		function reviewButton() {
			if (document.getElementById("review-body").style.display === "none") {
				document.getElementById("review-bar").className = "col-md-12 rev-bar";
				$("#reply-bar").slideUp();
				$("#review-body").slideDown();
				$("#adv-bar").slideUp();
			} else {
				document.getElementById("review-bar").className = "col-md-6 rev1-bar";
				$("#reply-bar").slideDown();
				$("#review-body").slideUp();
				$("#adv-bar").slideDown();
			}
		}
		
		function replyButton() {
			if (document.getElementById("reply-body").style.display === "none") {
				document.getElementById("reply-bar").className = "col-md-12 rev-bar";
				document.getElementById("review-bar").style.display = "none";
				$("#reply-body").slideDown();
				$("#adv-bar").slideUp();
			} else {
				document.getElementById("reply-bar").className = "col-md-6 rev2-bar";
				$("#review-bar").slideDown();
				$("#reply-body").slideUp();
				$("#adv-bar").slideDown();
			}
		}
	</script>

	<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
	<script
		src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>