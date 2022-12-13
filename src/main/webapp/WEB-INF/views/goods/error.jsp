<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>error</title>
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
</head>
<body>
	<jsp:include page="../home/header.jsp" />

	<div class="container">
		<div class="col-md-12" align="center"
			style="height: 560px; padding-top: 60px">
			<h1>物品不存在</h1>
			<p>
				<img src="<c:url value="/statics/image/logo/yihan.png"/>"
					height="300px" width="300px">
			</p>
			<p>物品好像已被下架，信息已记录，请联系系统管理人员。</p>
		</div>
	</div>

	<jsp:include page="../home/footer.jsp" />

	<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
	<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
</body>
</html>