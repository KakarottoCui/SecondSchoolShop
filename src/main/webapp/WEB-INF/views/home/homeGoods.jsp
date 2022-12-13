<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
<link rel="stylesheet"
	href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
<script>
	$(function() {
		var width = $("#type-bar").width();
		$(window).scroll(function() {
			if ($(document).scrollTop() >= $("#search-bar").height()) {
				$("#type-bar").css({
					"position" : "fixed",
					"top" : 150 - $("#search-bar").height() + "px",
					"width" : width
				});
			} else {
				$("#type-bar").css({
					"position" : "fixed",
					"top" : 150 - $(document).scrollTop() + "px",
					"width" : width
				});
			}
		})
	})
</script>
</head>
<body>
	<div>
		<jsp:include page="header.jsp" />
	</div>

	<div class="col-md-12" style="height: 80px;" id="search-bar">
		<div class="col-md-3"></div>
		<div class="col-md-6" style="padding-top: 10px">
			<form class="form-horizontal" action="/secondshop/" method="get">
				<div class="form-group col-md-12">
					<div class="col-md-10">
						<input id="searchText" name="searchText" type="text"
							class="form-control" value="${param.searchText}"
							placeholder="这里可以搜索哦~~">
					</div>

					<button class="btn btn-success; col-md-2">搜索</button>

					<div class="col-md-12">
						<c:if test="${param.searchText != '' && param.searchText != null}">
							<p></p>
							<p>为您搜索到“${param.searchText}”相关物品${goodsNum}条记录</p>
						</c:if>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-3"></div>
	</div>

	<div class="container">
		<div class="main-content">
			<div class="col-md-2" style="padding-left: 0px; padding-right: 0px;"
				id="type-bar">
				<div class="col-md-12" align="center"
					style="padding-left: 0px; padding-right: 0px;" id="type-button">
					<c:forEach var="firstType" items="${firstTypes}">
						<div
							style="height: 50px; width: 100%; background-color: #eaeaea; margin-top: 15px;"
							class="btn-type" align="center;" id="type${firstType.id}"
							onclick="typeButton(${firstType.id})">
							<p>
							<h4>${firstType.name}</h4>
							</p>
						</div>

						<div class="col-md-12 r" id="${firstType.id}"
							style="display: none; background-color: #f5f5f5; padding-left: 0px; padding-right: 0px;"
							align="center">
							<c:forEach var="secondType" items="${firstType.secondType}">
								<a class="col-md-12 r-type"
									href="?secondTypeId=${secondType.id}">
									<p></p>
									<p>${secondType.name}</p>
								</a>
							</c:forEach>
						</div>
					</c:forEach>
				</div>
			</div>

			<div class="col-md-10" style="margin-top: 10px; float: right;">
				<c:choose>
					<c:when test="${goods.size() == 0}">
						<div align="center">
							<img style="width: 500px; height: 350px"
								src="<c:url value="/statics/image/photos/default/shouqing.png"/>">
							<h2>抱歉，暂无此类物品！</h2>
						</div>
					</c:when>
				</c:choose>
				<c:forEach var="good" items="${goods}">
					<a  href="goods/goodInfo?goodId=${good.id}">
						<div class="c col-md-3">
							<div class="a col-md-12">
								<img src="<c:url value="${good.photoUrl}"/>" width="100%" height="200px">
								<p style="height: 25px; margin-top: 20px">${good.name}</p>
								<p style="color: red; text-align: right">
									<B>价格：${good.prise}￥</B>
								</p>
							</div>
						</div>
					</a>
				</c:forEach>

				<div class="col-md-12 column" align="right">
					<ul class="pagination">
						<c:choose>
							<c:when test="${offset >= limit}">
								<li><a
									href="?searchText=${param.searchText}&secondTypeId=${param.secondTypeId}&offset=${offset - limit}">上一页</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="disabled"><a href="#">上一页</a></li>
							</c:otherwise>
						</c:choose>

						<c:forEach var="page" begin="1" end="${pages}">
							<c:choose>
								<c:when test="${offset == limit * (page - 1)}">
									<li class="disabled"><a href="#">${page}</a></li>
								</c:when>
								<c:otherwise>
									<li><a
										href="?searchText=${param.searchText}&secondTypeId=${param.secondTypeId}&offset=${limit * (page - 1)}">${page}</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<c:choose>
							<c:when test="${goods.size() >= limit}">
								<li><a
									href="?searchText=${param.searchText}&secondTypeId=${param.secondTypeId}&offset=${offset + limit}">下一页</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="disabled"><a href="#">下一页</a></li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

	<script>
    function typeButton(firstTypeId) {
        var firstType ="#" + firstTypeId;
        var firstType1 = "#type" + firstTypeId;
        if (document.getElementById(firstTypeId).style.display === "none") {
            $(".btn-type").slideUp();
            $(firstType1).slideDown();
            $(firstType).slideDown();
        } else {
            $(".btn-type").slideDown();
            $(firstType).slideUp();
        }
    }
	</script>
	<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
	<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
	<script
		src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>