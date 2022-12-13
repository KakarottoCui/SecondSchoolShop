<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人信息</title>
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
		<div class="col-md-9" style="float: left">
			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">我的信息</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px">
				<div class="col-md-2" style="padding-left: 0px; padding-right: 0px;">
					<img src="<c:url value="${sessionScope.user.getPhotoUrl()}"/>"
						width="128px" height="128px">
				</div>
				
				<div class="col-md-10">
					<div class="col-md-12" style="height: 60px;">
						<h3>
							<B>${sessionScope.user.getName()}</B>
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
						<p style="color: #666666; height: 20px">${sessionScope.user.getName()}</p>
						<p style="color: #666666; height: 20px">${sessionScope.user.getGender()}</p>
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
						<p style="color: #666666; height: 20px">${sessionScope.user.getMobile()}</p>
						<p style="color: #666666; height: 20px">${sessionScope.user.getEmail()}</p>
					</div>
					
					<div class="col-md-3">
						<a
							href="/secondshop/user/userEdit?userId=${sessionScope.user.getId()}">修改个人资料</a>
					</div>
				</div>
			</div>

			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">我收藏的物品</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px;">
				<div class="col-md-12 r" style="background-color: #ffffff;">
					<p></p>
					<p style="color: #c4c4c4; font-size: 20px; margin-bottom: 0px;"
						align="center">
						<B>我收藏的物品</B>
					</p>
					
					<c:choose>
						<c:when test="${collects.size() == 0}">
							<div class="col-md-12" style="margin-top: 50px;" align="center">
								<p></p>
								<img src="<c:url value="/statics/image/logo/yihan.png"/>"
									width="40%" ; height="222px;">
								<p style="color: #c4c4c4; font-size: 20px">你还没有收藏物品哦！</p>
							</div>
						</c:when>
						
						<c:otherwise>
							<div class="col-md-12 column" style="padding-left: 15px;">
								<table class="table" style="margin-bottom: 0px">
									<thead>
										<tr style="color: #666666">
											<th style="width: 102px">编号</th>
											<th style="width: 200px">标题</th>
											<th style="width: 200px">发布时间</th>
											<th style="width: 100px">状态</th>
											<th>操作</th>
										</tr>
									</thead>
								</table>
							</div>
							
							<div class="col-md-12 column"
								style="overflow-y: auto; height: 280px;">
								<table class="table table-hover">
									<tbody id="collectTable">
										<c:forEach var="collect" items="${collects}">
											<tr style="color: #666666">
												<td style="width: 102px"><a
													href="/secondshop/goods/goodInfo?goodId=${collect.good.id}">${collect.good.id}</a></td>
												<td style="width: 200px">${collect.good.name}</td>
												<td style="width: 200px">${collect.good.uploadDate}</td>
												<td style="width: 100px">${collect.good.statusId == 0 ? "已下架":"在售"}</td>
												<td><a onclick="deleteCollect(${collect.id})">删除</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">我的物品</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px;">
				<div class="col-md-12 r" style="background-color: #ffffff;">
					<p></p>
					<p style="color: #c4c4c4; font-size: 20px; margin-bottom: 0px;"
						align="center">
						<B>我发布的物品</B>
					</p>
					
					<c:choose>
						<c:when test="${goods.size() == 0}">
							<div class="col-md-12" style="margin-top: 50px;" align="center">
								<p></p>
								<img src="<c:url value="/statics/image/logo/yihan.png"/>"
									width="40%" ; height="222px;">
								<p style="color: #c4c4c4; font-size: 20px">你还没有发布物品哦！</p>
							</div>
						</c:when>
						
						<c:otherwise>
							<div class="col-md-12 column" style="padding-left: 15px;">
								<table class="table" style="margin-bottom: 0px">
									<thead>
										<tr style="color: #666666">
											<th style="width: 102px">编号</th>
											<th style="width: 227px">标题</th>
											<th style="width: 260px">发布时间</th>
											<th>状态</th>
										</tr>
									</thead>
								</table>
							</div>
							
							<div class="col-md-12 column"
								style="overflow-y: auto; height: 280px;">
								<table class="table table-hover">
									<tbody>
										<c:forEach var="good" items="${goods}">
											<tr style="color: #666666">
												<td style="width: 102px"><a
													href="/secondshop/goods/goodInfo?goodId=${good.id}">${good.id}</a></td>
												<td style="width: 227px">${good.name}</td>
												<td style="width: 260px">${good.uploadDate}</td>
												<td>${good.statusId == 0 ? "已下架":"在售"}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">我的订单</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px;">
				<div class="col-md-12 r" style="background-color: #ffffff;">
					<p></p>
					<p style="color: #c4c4c4; font-size: 20px; margin-bottom: 0px;"
						align="center">
						<B>我所有的订单</B>
					</p>
					
					<c:choose>
						<c:when test="${orders.size() == 0}">
							<div class="col-md-12" style="margin-top: 50px;" align="center">
								<p></p>
								<img src="<c:url value="/statics/image/logo/yihan.png"/>"
									width="40%" ; height="200px;">
								<p style="color: #c4c4c4; font-size: 20px">你还没有订单哦！</p>
							</div>
						</c:when>
						
						<c:otherwise>
							<div class="col-md-12 column" style="padding-left: 15px;">
								<table class="table" style="margin-bottom: 0px">
									<thead>
										<tr style="color: #666666">
											<th style="width: 90px">订单编号</th>
											<th style="width: 100px">卖家</th>
											<th style="width: 140px">物品名称</th>
											<th style="width: 70px">金额</th>
											<th style="width: 200px">提交时间</th>
											<th>订单状态</th>
										</tr>
									</thead>
								</table>
							</div>
							
							<div class="col-md-12 column"
								style="overflow-y: auto; height: 280px;">
								<table class="table table-hover">
									<tbody>
										<c:forEach var="order" items="${orders}">
											<tr style="color: #666666">
												<td style="width: 90px"><a
													href="/secondshop/user/orderInfo?orderId=${order.id}">${order.id}</a></td>
												<td style="width: 100px">${order.seller}</td>
												<td style="width: 140px">${order.goodName}</td>
												<td style="width: 70px">${order.money}</td>
												<td style="width: 200px">${order.submitDate}</td>
												<td>${order.statusId == 2 ? "交易中":"交易完成"}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</c:otherwise>
					</c:choose>
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
					style="display: none; overflow-y: auto; height: 585px; background-color: #ffffff; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 15px;">
					<c:choose>
						<c:when test="${reviews.size() == 0}">
							<div class="col-md-12" align="center"
								style="background-color: #ffffff; margin-top: 150px">
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
													<img
														src="<c:url value="/statics/image/logo/new_message.png"/>"
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
					style="display: none; overflow-y: auto; height: 585px; background-color: #ffffff; padding-left: 5px; padding-right: 5px; padding-top: 5px; padding-bottom: 15px;">
					<c:choose>
						<c:when test="${replies.size() == 0}">
							<div class="col-md-12" align="center"
								style="background-color: #ffffff; margin-top: 150px">
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
													<img
														src="<c:url value="/statics/image/logo/new_message.png"/>"
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
						<B style="font-size: 16px; color: #c4c4c4">卖出的物品</B>
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
									<a
										href="/secondshop/user/sellerInfo?orderId=${sellGood.id}">
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
    function deleteCollect(collectId) {
        $.get("/secondshop/collect/delete/"+collectId+"&"+${sessionScope.user.id}, function (data) {
            if (data === false){
                alert("未知原因，删除失败！");
            } else {
                document.getElementById("collectTable").innerHTML = "";
                $.each(data, function (i, type) {
                    var collectId = type.id;
                    var collectGoodId = type.good.id;
                    var collectGoodName = type.good.name;
                    var collectGoodUploadDate = type.good.uploadDate;
                    var collectGoodStatus = type.good.statusId === 0 ? "已下架":"在售";
                    var collect = "<tr style=\"color: #666666\">"+
                        "<td style=\"width: 102px\"><a target='_blank' href='/secondshop/goods/goodInfo?goodId="+collectGoodId+"'>"+collectGoodId+"</a></td>"+
                    "<td style=\"width: 200px\">"+collectGoodName+"</td>"+
                    "<td style=\"width: 200px\">"+collectGoodUploadDate+"</td>"+
                    "<td style=\"width: 100px\">"+collectGoodStatus+"</td>"+
                    "<td><a onclick='deleteCollect("+collectId+")'>删除</a></td>"+
                    "</tr>";
                    $("#collectTable").append(collect);
                });
                alert("删除成功！");
            }
        })
    }
    
    function reviewButton() {
        if (document.getElementById("review-body").style.display === "none"){
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
        if (document.getElementById("reply-body").style.display === "none"){
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
	
	<script>
    var bar_width = document.getElementById("re-bar").scrollWidth;
    $(function () {
        $(window).scroll(function () {
            if ($(document).scrollTop() >= 20) {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 50 + $(document).scrollTop() + "px",
                    "width": bar_width,
                    "right": 15
                });
            } else {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 70 + "px",
                    "width": bar_width,
                    "right": 15
                });
            }
        })
    })
	</script>

	<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
	<script
		src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>