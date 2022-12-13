<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
<link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
<title>error</title>
</head>
<body>
	<div class="container">
		<div class="col-xs-12" align="center">
			<p></p>
			<h1>SORRY, FOUND A ERROR</h1>
			<img src="<c:url value="/statics/image/logo/yihan.png"/>"
				width="350px" height="300px">
			<h1>系统错误</h1>
			<p>系统遇到错误，错误信息已记录，请联系系统管理人员。</p>
		</div>
	</div>

	<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
	<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
</body>
</html>