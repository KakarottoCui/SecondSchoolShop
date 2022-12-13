<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${goodInfo.name}</title>
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/css/swiper.min.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/css/simpleAlert.css"/>">
<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
<script src="<c:url value="/statics/js/simpleAlert.js"/>"></script>
<script src="<c:url value="/statics/js/swiper.min.js"/>"></script>
<script>
	$(function() {
		$(".swiper-slide img").mouseover(function() {
			var url = $(this).attr("src");
			$("#img-a").attr("src", url);
		})
	})
</script>
</head>
<body>
	<jsp:include page="../home/header.jsp" />

	<div class="container">
		<div class="col-md-9">
			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px">
				<div class="col-md-8" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">物品信息</B>
				</div>
				
				<div class="col-md-4"
					style="margin-top: 4px; display: ${collect == 0 ? 'none':''};">
					<B
						style="display: ${collect == 1 ? 'none':''}; color: #c4c4c4; font-size: 18px;margin-top: 3px; float: right">已收藏</B>
					<a onclick="collect()" class="btn"
						style="display: ${collect == 2 ? 'none':''}; float: right; margin-top: 0px; padding: 2px">
						<B style="color: #c4c4c4; font-size: 18px;">收藏</B>
					</a>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding: 0px; padding-bottom: 15px">
				<div class="col-md-12" style="margin-top: 40px;">
					<div class="col-md-7" align="center;">
						<div style="width: 100%" align="center">
							<img src="<c:url value="${goodInfo.photoUrl}"/>" width="100%" height="300px"
								id="img-a">
						</div>
						
						<div class="col-md-12"
							style="padding-left: 0px; padding-right: 0px; margin-top: 10px">
							<div class="swiper-container">
								<div class="swiper-wrapper">
									<div class="swiper-slide">
										<img src="<c:url value="${goodInfo.photoUrl}"/>" height="200px"
											width="85%">
									</div>
									
									<c:forEach var="image" items="${images}">
										<div class="swiper-slide">
											<img src="<c:url value="${image.url}"/>" height="100%"
												width="90%">
										</div>
									</c:forEach>
								</div>
								<div class="swiper-button-next"></div>
								<div class="swiper-button-prev"></div>
								<div class="swiper-pagination"></div>
							</div>
						</div>
					</div>
					
					<div class="col-md-5">
						<h3 style="margin-left: 15px">
							<B>${goodInfo.name}</B>
						</h3>
						<div style="height: 50px"></div>
						<div class="col-md-4" style="padding: 0px">
							<p style="color: #666666; height: 40px">
								<B>价格</B>
							</p>
							<p style="color: #666666; height: 40px">
								<B>卖家</B>
							</p>
							<p style="color: #666666; height: 40px">
								<B>物品类型</B>
							</p>
							<p style="color: #666666; height: 40px">
								<B>发布时间</B>
							</p>
						</div>
						
						<div class="col-md-8" style="padding: 0px">
							<p style="color: red; height: 40px; font-size: 20px">￥${goodInfo.prise}</p>
							<p style="color: #808080; height: 40px">${goodInfo.goodUser.name}</p>
							<p style="color: #808080; height: 40px">${goodInfo.goodSecondType.name}</p>
							<p style="color: #808080; height: 40px">${goodInfo.uploadDate}</p>
						</div>
						
						<div class="col-md-12" style="padding: 0px">
							<div onclick="connect()" class="col-md-5 r-c"
								style="display: ${sessionScope.user.id == goodInfo.goodUser.id ? 'none':''}">
								<B style="font-size: 20px; color: #e2e2e2">联系卖家</B>
							</div>
							
							<c:choose>
								<c:when test="${goodInfo.statusId == 1}">
									<div onclick="buyButton()" class="col-md-5 r-b pull-right"
										style="display: ${sessionScope.user.id == goodInfo.goodUser.id ? 'none':''}">
										<B style="font-size: 20px; color: #e2e2e2">购买</B>
									</div>
									<a
										style="display: ${sessionScope.user.id == goodInfo.goodUser.id ? '':'none'}"
										href="/secondshop/goods/userGoodEdit?goodId=${goodInfo.id}">
										<div class="col-md-5 r-b">
											<B style="font-size: 20px; color: #e2e2e2">编辑</B>
										</div>
									</a>
								</c:when>
								
								<c:otherwise>
									<div class="col-md-5 r-x pull-right">
										<B style="font-size: 20px; color: #bbbbbb">已下架</B>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						
						<div class="col-md-12" style="margin-top: 50px" align="right">
							<p>
								<a
									href="/secondshop/goods/userGoods?userId=${goodInfo.userId}">查看卖家其他物品</a>
							</p>
						</div>
					</div>
				</div>
			</div>

			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px; margin-top: 20px;">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">物品描述</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; height: 150px">
				<div class="col-md-12" style="margin-top: 20px">
					<p style="color: #b0b0b0;">&emsp;&emsp;${goodInfo.describe}</p>
				</div>
			</div>

			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px; margin-top: 20px;">
				<div class="col-md-6" style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px">物品留言</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="padding-top: 15px; background-color: #f9f9f9;">

				<c:choose>
					<c:when test="${reviews.size() == 0}">
						<div class="col-md-12 r"
							style="background-color: #ffffff; margin-top: 15px; margin-bottom: 15px">
							<p></p>
							<p style="color: #c4c4c4; font-size: 20px" align="center">留言板为空，赶快发表你的留言！</p>
						</div>
					</c:when>
					
					<c:otherwise>
						<c:forEach var="review" items="${reviews}">
							<div class="col-md-12 r"
								style="background-color: #ffffff; margin-bottom: 15px">
								<p></p>
								<P style="color: #c4c4c4">时间：${review.uploadDate}</P>
								<p onclick="replyFun(${review.id},'${review.fromUser}')">
									<B style="color: #2aabd2">${review.fromUser}</B>&nbsp;评论:&nbsp;${review.text}
								</p>
								
								<div class="col-md-10" style="margin-left: 50px">
									<c:forEach var="reply" items="${review.replys}">
										<P style="color: #c4c4c4">时间：${reply.uploadDate}</P>
										<p onclick="replyFun(${review.id},'${reply.fromUser}')">
											<B style="color: #2aabd2">${reply.fromUser}</B>&nbsp;回复&nbsp;<B
												style="color: #2aabd2">${reply.toUser}</B>:&nbsp;${reply.text}
										</p>
									</c:forEach>
								</div>
								
								<div id="${review.id}" class="col-md-12"
									style="margin-bottom: 15px; display: none">
									<form action="/secondshop/goods/goodInfo" method="post">
										<div class="col-sm-10">
											<input id="${review.id}goodId" name="goodId" type="text"
												value="${goodInfo.id}" style="display: none"> <input
												id="${review.id}reviewId" name="reviewId" type="text"
												value="${review.id}" style="display: none"> <input
												id="replyFromUser" name="fromUser" type="text"
												value="${sessionScope.user.name}" style="display: none">
											<input id="replyFromUserId" name="fromUserId" type="text"
												value="${sessionScope.user.id}" style="display: none">
											<input id="${review.id}replyToUser" name="toUser" type="text"
												value="" style="display: none"> <input
												id="${review.id}replyToUserId" name="toUserId" type="text"
												value="${review.fromUserId}" style="display: none">
											<input id="${review.id}replyText" name="replyText"
												type="text" class="form-control" placeholder="">
										</div>
										<button class="btn btn-success; col-sm-1" type="submit">回复</button>
										<p class="btn btn-success; col-sm-1"
											onclick="closeReplyDiv(${review.id})">X</p>
									</form>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				
				<c:choose>
					<c:when test="${sessionScope.user != null}">
						<form action="/secondshop/goods/goodInfo" method="post">
							<div class="col-md-12" style="margin-bottom: 15px">
								<div class="col-sm-11">
									<input id="goodId" name="goodId" type="text"
										value="${goodInfo.id}" style="display: none"> <input
										id="fromUser" name="fromUser" type="text"
										value="${sessionScope.user.name}" style="display: none">
									<input id="fromUserId" name="fromUserId" type="text"
										value="${sessionScope.user.id}" style="display: none">
									<input id="toUserId" name="toUserId" type="text"
										value="${goodInfo.userId}" style="display: none"> <input
										id="reviewText" name="reviewText" type="text"
										class="form-control" placeholder="留言">
								</div>
								
								<button class="btn btn-success; col-sm-1" type="submit">发表</button>
							</div>
						</form>
					</c:when>
					
					<c:otherwise>
						<div class="col-md-12" style="margin-bottom: 15px">
							<p></p>
							<p style="color: #595959; font-size: 20px" align="center">登陆后才能发表留言！</p>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<div class="col-md-3 r"
			style="background-color: #f9f9f9; padding-bottom: 15px;">
			<div class="col-md-12 r"
				style="text-align: center; margin-top: 10px; background-color: #e4e4e4; padding: 5px">
				<B style="font-size: 20px; color: #a2a2a2">相关推荐</B>
			</div>
			
			<div class="col-md-12"
				style="margin-top: 20px; padding-left: 0px; padding-right: 0px">
				<c:choose>
					<c:when test="${goods.size() == 0}">
						<div align="center">
							<h4>抱歉，暂无此类推荐！</h4>
						</div>
					</c:when>
				</c:choose>
				
				<c:forEach var="good" items="${goods}">
					<a  href="goodInfo?goodId=${good.id}">
						<div class="col-md-12 b"
							style="padding-left: 0px; padding-right: 0px">
							<div class="col-md-6"
								style="padding-top: 15px; padding-bottom: 15px">
								<img src="<c:url value="${good.photoUrl}"/>" height="100px"
									; width="100px">
							</div>
							
							<div class="col-md-6"
								style="padding-top: 15px; padding-bottom: 15px; height: 130px">
								<p style="height: 75px">${good.name}</p>
								<p align="right" style="color: red">￥${good.prise}</p>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
	</div>

	<jsp:include page="../home/footer.jsp" />

	<script>
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 3,
        spaceBetween: 30,
        slidesPerGroup: 3,
        loop: true,
        loopFillGroupWithBlank: true,
        pagination: {
            el: '.swiper-pagination',
            clickable: true
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev'
        }
    });
	</script>
	
	<script>
    function collect() {
        var collect = {
            "goodId":"${goodInfo.id}",
            "goodName":"${goodInfo.name}",
            "userId":"${sessionScope.user.id}"
        };
        $.ajax({
            type:"POST",
            url:"/secondshop/collect/insert",
            contentType: "application/json", //必须这样写
            dataType:"json",
            data:JSON.stringify(collect),//要提交是json字符串
            success:function (data) {
                if (data === false){
                    alert("由于未知原因，收藏失败！");
                } else {
                    alert("收藏成功！");
                    $(window).attr('location','/secondshop/goods/goodInfo?goodId=${goodInfo.id}');
                }
            }
        })
    }

    function replyFun(replyId, replyToUser) {
        if (${sessionScope.user != null}) {
            var replyDiv = document.getElementById(replyId);
            var toUser = "回复 " + replyToUser;
            var replyToUserId = "#" + replyId + "replyToUser";
            var replyText = "#" + replyId + "replyText";
            if (replyDiv.style.display === "none") {
                replyDiv.style.display = "";
            }
            $(replyToUserId).attr("value", replyToUser);
            $(replyText).attr("placeholder", toUser);
            console.log("value:" + $(replyToUserId).attr("value"));
            console.log("placeholder:" + $(replyText).attr("placeholder"));
        }
    }

    function closeReplyDiv(replyDiv) {
        document.getElementById(replyDiv).style.display = "none";
    }

    $(function () {
            var message = "${message}";
            if (message !== "" && message !== null) {
                alert(message);
            }
        }
    );

    function connect() {
        alert("卖家联系方式：\n手机号：${goodUser.mobile}\n邮箱：${goodUser.email}\n请选择自己方便的联系方式与卖家沟通！");
    }
	</script>
	
	<script>
    function buyButton() {
        var dblChoseAlert = simpleAlert({
            "content": "您即将购买该物品!",
            "buttons":{
                "确定":function () {
                    dblChoseAlert.close();
                    getBuy();
                },
                "取消":function () {
                    dblChoseAlert.close();
                }
            }
        })
    }
    
    function getBuy() {
        if (${sessionScope.user == null}) {
            alert("请先登录！");
            $(window).attr('location','/secondshop/login');
        } else {
            alert("我们正在为您创建订单！");
            var order = {
                "goodName": "${goodInfo.name}",
                "seller": "${goodInfo.goodUser.name}",
                "sellerId": ${goodInfo.goodUser.id},
                "customer": "${sessionScope.user.name}",
                "customerId": "${sessionScope.user.id}",
                "goodId": ${goodInfo.id},
                "money": ${goodInfo.prise}
            };
            console.log(order);
            $.ajax({
                type:"POST",
                url:"/secondshop/user/order/create",
                contentType: "application/json", //必须这样写
                dataType:"json",
                data:JSON.stringify(order),//要提交是json字符串
                success:function (data) {
                    if (data === false){
                        alert("由于未知原因，订单创建失败！");
                    } else {
                        alert("订单创建成功，请及时与卖家联系，线下验货交易！");
                        $(window).attr('location','/secondshop/user/orderInfo?orderId=' + data);
                    }
                }
            });
        }
    }
	</script>
	<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
	<script
		src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>