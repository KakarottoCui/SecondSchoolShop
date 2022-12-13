<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单信息</title>
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
</head>
<jsp:include page="../home/header.jsp" />

<div class="container"
	style="position: relative; transform: translate(0, 0)">
	<div class="col-md-9" style="float: left">
		<div class="col-md-12 r1"
			style="background-color: #e4e4e4; height: 40px">
			<div class="col-md-6" style="margin-top: 5px">
				<B style="color: #c4c4c4; font-size: 20px">订单</B>
			</div>
		</div>

		<div class="col-md-12 r2"
			style="background-color: #f9f9f9; padding-top: 5px; padding-bottom: 30px; padding-left: 120px; padding-right: 120px; margin-bottom: 20px">
			<div class="col-md-12" align="center" style="margin-bottom: 5px">
				<h3>订单信息明细</h3>
			</div>
			<div class="col-md-12" style="background-color: #ffffff">
				<div class="col-md-12"
					style="margin-bottom: 10px; margin-top: 20px;">
					<div class="col-md-12"
						style="padding: 30px; background-color: #f2f2f2">
						<div class="col-md-5"
							style="padding-left: 60px; padding-top: 20px">
							<p style="color: #666666; height: 30px">
								<B>订单号</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>物品名称</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>卖家</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>买家</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>订单状态</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>交易时间</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>结束时间</B>
							</p>
						</div>

						<div id="order" class="col-md-7"
							style="padding-left: 0px; padding-top: 20px">
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.id}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.goodName}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.seller}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.customer}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.statusId == 2 ? "交易中":"交易完成"}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.submitDate}</B>
							</p>
							<p style="color: #666666; height: 30px">
								<B>${orderInfo.endDate}</B>
							</p>
						</div>
					</div>

					<div class="col-md-12" style="margin-top: 20px">
						<button class="btn btn-success" onclick="deleteOrder()">删除</button>
						<button id="success" class="btn btn-primary pull-right"
							style="display: ${orderInfo.statusId == 2 ? "
							":"none"}" onclick="selectValue()">完成交易</button>
						<button id="noSuccess" class="btn btn-primary pull-right"
							style="display: ${orderInfo.statusId == 3 ? "
							":"none"}" disabled="true">交易已完成</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="re-bar" class="col-md-3 r"
		style="background-color: #f9f9f9; padding-bottom: 15px;">
		<div class="col-md-12 r"
			style="text-align: center; margin-top: 10px; background-color: #e4e4e4; padding: 5px">
			<B style="font-size: 20px; color: #a2a2a2">其他订单</B>
		</div>

		<div class="col-md-12 r"
			style="background-color: #ffffff; margin-top: 15px; overflow-y: auto; height: 500px; padding: 5px">
			<c:choose>
				<c:when test="${orders.size() == 0}">
					<div class="col-md-12" align="center"
						style="background-color: #ffffff; margin-top: 50px;">
						<img src="<c:url value="/statics/image/logo/yihan.png"/>"
							width="95%" ; height="170px;">
						<p style="color: #c4c4c4; font-size: 16px">抱歉，暂无其他订单！</p>
					</div>
				</c:when>
				
				<c:otherwise>
					<c:forEach var="order" items="${orders}">
						<a href="/secondshop/user/orderInfo?orderId=${order.id}">
							<div class="col-md-12 rev"
								style="padding: 10px; margin-bottom: 5px;">
								<p>${order.submitDate}</p>
								<p>${order.goodName}</p>
							</div>
						</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<jsp:include page="../home/footer.jsp" />

<script>
    $(function () {
        $(window).scroll(function () {
            if ($(document).scrollTop() >= 20) {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 50 + $(document).scrollTop() + "px",
                    "width": 285,
                    "right": 15
                });
            } else {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 70 + "px",
                    "width": 285,
                    "right": 15
                });
            }
        })
    });

    function deleteOrder() {
        $.getJSON("/secondshop/user/order/delete/" + ${orderInfo.id}, function (data) {
            if (data == true){
                alert("订单删除成功！");
                $(window).attr('location','/secondshop/user/userProfile');
            } else {
                alert("订单删除失败！");
            }
        })
    }

    function selectValue() {
        $.getJSON("/secondshop/user/order/update/status/" + ${orderInfo.id} + "&3", function (data) {
            if (data == false){
                alert("操作失败！");
            } else {
                document.getElementById("success").style.display = "none";
                document.getElementById("noSuccess").style.display = "";
                document.getElementById("order").innerHTML = "<p style=\"color: #666666; height: 30px\"><B>" + data.id + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.goodName + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.seller + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.customer + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>${data.statusId == 2 ? '交易中':'交易完成' }</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.submitDate + "</B></p>" +
                    "<p style=\"color: #666666; height: 30px\"><B>" + data.endDate + "</B></p>";
            }
        })
    }
</script>
<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
<script
	src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>