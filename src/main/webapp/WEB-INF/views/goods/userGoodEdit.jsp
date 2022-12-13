<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>物品编辑</title>
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

	<div class="container">
		<div class="col-md-9">
			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px;">
				<div style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px;">修改物品信息</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
				<div class="col-md-12">
					<form:form method="post" commandName="good" items="${good}"
						id="register">
						<spring:bind path="id">
							<div class="form-group" style="display: none">
								<form:input path="id" cssClass="form-control"></form:input>
							</div>
						</spring:bind>
						
						<spring:bind path="photoUrl">
							<div class="form-group" style="display: none">
								<form:input path="photoUrl" cssClass="form-control"></form:input>
							</div>
						</spring:bind>
						
						<spring:bind path="name">
							<div class="form-group">
								<form:label path="name" cssClass="control-label">物品标题</form:label>
								<form:input path="name" cssClass="form-control"></form:input>
							</div>
						</spring:bind>
						
						<spring:bind path="firstTypeId">
							<div class="form-group">
								<form:label path="firstTypeId" cssClass="control-label">一级分类</form:label>
								<form:select id="goodType" onchange="selectValue()"
									cssClass="form-control" path="firstTypeId"
									items="${firstTypes}" itemLabel="name" itemValue="id"></form:select>
							</div>
						</spring:bind>
						
						<spring:bind path="secondTypeId">
							<div class="form-group">
								<form:label path="secondTypeId" cssClass="control-label">二级分类</form:label>
								<form:select id="secondType" cssClass="form-control"
									path="secondTypeId"></form:select>
							</div>
						</spring:bind>
						
						<spring:bind path="prise">
							<div class="form-group">
								<form:label path="prise" cssClass="control-label">物品价格</form:label>
								<form:input id="prise" path="prise" cssClass="form-control"
									onblur="checkNum(this)"></form:input>
								<output id="priseError" style="color: red"></output>
							</div>
						</spring:bind>
						
						<spring:bind path="describe">
							<div class="form-group">
								<form:label path="describe" cssClass="control-label">物品描述</form:label>
								<form:textarea path="describe" cssClass="form-control"
									cssStyle="height: 160px"></form:textarea>
							</div>
						</spring:bind>
						
						<div class="form-group">
							<a onclick="deleteGood()" class="btn"
								style="background-color: #e5e5e5">删除物品</a>
							<button type="submit" class="btn pull-right"
								style="background-color: #e5e5e5">提交信息</button>
						</div>
					</form:form>
				</div>
			</div>
			
			<div class="col-md-12 r1"
				style="background-color: #e4e4e4; height: 40px; margin-top: 20px;">
				<div style="margin-top: 5px">
					<B style="color: #c4c4c4; font-size: 20px;">修改物品图片</B>
				</div>
			</div>
			
			<div class="col-md-12 r2"
				style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
				<div class="col-md-12 r"
					style="margin-top: 15px; background-color: #ffffff; padding: 0px">
					<div id="goodImg" class="col-md-12" style="padding: 0px;">
						<div class="col-md-4" style="padding: 15px" align="center">
							<div style="width: 100%; height: 230px;">
								<img src="<c:url value="${good.photoUrl}"/>" height="100%"
									width="100%">
							</div>
						</div>
						
						<c:forEach var="goodImage" items="${goodImages}">
							<div class="col-md-4" style="padding: 15px" align="center">
								<div style="width: 100%; height: 230px;">
									<img src="<c:url value="${goodImage.url}"/>" height="100%"
										width="100%">
								</div>
							</div>
						</c:forEach>
					</div>
					
					<form action="/secondshop/goods/userGoodEdit/updateImage"
						method="post" enctype="multipart/form-data">
						<input name="goodId" value="${good.id}" style="display: none">
						<div id="addImg" class="col-md-12"
							style="padding: 0px; display: none;">
							<div class="col-md-4" style="padding: 15px" align="center">
								<div style="width: 100%; height: 230px;">
									<img src="" id="img1" height="100%" width="100%">
								</div>
								<input style="width: 100%" type="file" name="mainFile"
									onchange="change(event)" onclick="changeImgId('img1')">
							</div>
							
							<div class="col-md-4" style="padding: 15px" align="center">
								<div style="width: 100%; height: 230px;">
									<img src="" id="img2" height="100%" width="100%">
								</div>
								<input style="width: 100%" type="file" name="file"
									onchange="change(event)" onclick="changeImgId('img2')">
							</div>
							
							<div class="col-md-4" style="padding: 15px" align="center">
								<div style="width: 100%; height: 230px;">
									<img src="" id="img3" height="100%" width="100%">
								</div>
								<input style="width: 100%" type="file" name="file"
									onchange="change(event)" onclick="changeImgId('img3')">
							</div>
							
							<div class="col-md-4" style="padding: 15px" align="center">
								<div style="width: 100%; height: 230px;">
									<img src="" id="img4" height="100%" width="100%">
								</div>
								<input style="width: 100%" type="file" name="file"
									onchange="change(event)" onclick="changeImgId('img4')">
							</div>
							
							<div class="col-md-4" style="padding: 15px" align="center">
								<div style="width: 100%; height: 230px;">
									<img src="" id="img5" height="100%" width="100%">
								</div>
								<input style="width: 100%" type="file" name="file"
									onchange="change(event)" onclick="changeImgId('img5')">
							</div>
							
							<div class="col-md-4" style="padding: 15px" align="center">
								<div style="width: 100%; height: 230px;">
									<img src="" id="img6" height="100%" width="100%">
								</div>
								<input style="width: 100%" type="file" name="file"
									onchange="change(event)" onclick="changeImgId('img6')">
							</div>
						</div>
						
						<div class="col-md-12" style="padding: 15px">
							<div class="col-md-6" style="padding: 0px">
								<p id="addBtn" class="btn" style="background-color: #e5e5e5"
									onclick="addImg()">重新上传图片</p>
							</div>
							<div class="col-md-6" align="right" style="padding: 0px">
								<button type="submit" class="btn"
									style="background-color: #e5e5e5">提交</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		<div class="col-md-3 r"
			style="background-color: #f9f9f9; padding-bottom: 15px;">
			<div class="col-md-12 r"
				style="text-align: center; margin-top: 10px; background-color: #e4e4e4; padding: 5px">
				<B style="font-size: 20px; color: #a2a2a2">最新发布的物品</B>
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
				
				<c:forEach var="Good" items="${goods}">
					<a  href="goodInfo?goodId=${Good.id}">
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
    $(function () {
        var goodType = $("#goodType option:selected").attr("value");
        $.getJSON("/secondshop/type/secondType/" + goodType, function (data) {
            console.log(data);
            $.each(data, function (i, type) {
                var id = type.id;
                var name = type.name;
                console.log(id);
                console.log(name);
                var option = '<option value= \"'+ id +'\"> '+ name +'</option>';
                $("#secondType").append(option);
            })
        });
    });
    
    function selectValue() {
        var goodType = $("#goodType option:selected").attr("value");
        $.getJSON("/secondshop/type/secondType/" + goodType, function (data) {
            console.log(data);
            document.getElementById("secondType").innerHTML = "";
            $.each(data, function (i, type) {
                var id = type.id;
                var name = type.name;
                console.log(id);
                console.log(name);
                var option = '<option value= \"'+ id +'\"> '+ name +'</option>';
                $("#secondType").append(option);
            })
        });
    }
    
    function checkNum() {
        var prise = document.getElementById("prise").value;
        var reg = /^[-+]?[0-9]*\.?[0-9]+$/;
        if (! reg.test(prise)){
            document.getElementById("priseError").innerHTML="对不起，请输入数字！";
        }else {
            document.getElementById("priseError").innerHTML="";
        }
    }

    function deleteGood() {
        $.get("/secondshop/goods/userGoodEdit/delete/" + ${good.id}, function (data) {
            if (data == true){
                alert("物品删除成功！");
                $(window).attr('location','/secondshop/user/userProfile');
            } else {
                alert("物品删除失败！");
            }
        })
    }
	</script>
	
	<script>
    var imgId = "img1";
    function changeImgId(img) {
        imgId = img;
    }
    
    function change(ev){
        var event = window.event || ev;
        var files = event.target.files[0];
        var myimg = document.getElementById(imgId);
        myimg.src = URL.createObjectURL(files);
    }
    
    function addImg() {
        if (document.getElementById("addImg").style.display === "none"){
            $("#goodImg").slideUp();
            $("#addImg").slideDown();
            document.getElementById("addBtn").innerHTML = "取消重新上传图片";
        } else {
            $("#goodImg").slideDown();
            $("#addImg").slideUp();
            document.getElementById("addBtn").innerHTML = "重新上传图片";
        }
    }
	</script>

	<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
	<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
	<script
		src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>