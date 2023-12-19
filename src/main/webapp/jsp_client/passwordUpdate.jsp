<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改密码</title>
<link rel="stylesheet" type="text/css" href="/css/main.css">
<style type="text/css">
.mybutton {
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	cursor: pointer;
}

.userInfo td {
	font-size: 120%;
}

.userInfo td input {
	width: 180px;
	height: 20px;
	font-size: 110%;
}
</style>
<script>
	function checkInput(event) {
		var oldPassword = document.getElementById("oldPassword");
		var newPassword = document.getElementById("newPassword");
		if (oldPassword.value == "")
			event.preventDefault();
		if (newPassword.value == "")
			event.preventDefault();
	}
</script>

</head>
<body class="main" style="background-color:;">

	<!-- 1.网站顶部 start-->
	<%@include file="/jsp_compoment/tophead.jsp"%>
	<!-- 1.网站顶部 end-->

	<!-- 2.首页搜索栏 start -->
	<%@include file="/jsp_compoment/indexSearch.jsp"%>
	<!-- 2.首页搜索栏 end -->

	<!-- 3.信息展示 start -->
	<div style="width: 60%; margin: auto; min-height: 67.5%;">
		<form action="/passwordUpdateSuccess" method="post">
			<div>
				<table class="userInfo"
					style="margin: auto; border-collapse: separate; border-spacing: 10px 15px;" border="0">
					<tr>
						<td style="text-align: right;width:30%;">旧密码:</td>
						<td style="text-align: left;"><input type="password"
							id="oldPassword" name="oldPassword"></td>
						<td style="width:30%;"><span style="font-size: 100%; height: 20px; color: red;">${wrongMsg }</span></td>
					</tr>
					<tr>
						<td style="text-align: right">新密码:</td>
						<td style="text-align: left"><input type="password"
							id="newPassword" name="newPassword"></td>
					</tr>
				</table>

			</div>
			<div>
				<button class="mybutton" type="submit" onclick="checkInput(event)"
					style="color: black; border: 1px; padding: 7px 15px;">提交</button>
			</div>
		</form>
	</div>

	<!-- 4.底部 start -->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 4.底部 end -->
</body>
</html>