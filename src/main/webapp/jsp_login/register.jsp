<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>用户注册</title>
<!-- 链接相关的css和js脚本 -->
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/main.css">
<!-- js -->
<script type="text/javascript" src="/js/RegisterFormCheck.js"></script>

<style type="text/css">
.mybutton {
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 100%;
	cursor: pointer;
}
</style>

</head>
<body class="main">
	<!-- 1.网站顶部 start-->
	<%@include file="/jsp_compoment/head.jsp"%>
	<!-- 1.网站顶部 end-->

	<!-- 3.注册 start -->
	<div class="form" style="margin: auto; width: 70%; min-height: 74.2%;padding-top:100px"
		align="center">
		<br> <span style="font-size: 125%;">用户注册</span>
		<%
		if (request.getAttribute("WrongMsg") == null || (((String) request.getAttribute("WrongMsg")).equals(""))) {
		%>
		<br>&nbsp;
		<%
		} else {
		%>
		<br>${WrongMsg }
		<%
		}
		%>
		<form action="registerSuccess" method="post"
			onsubmit="return checkFrom();">
			<table
				style="width: 50%; border-collapse: separate; border-spacing: 5px 10px;"
				border="0">
				<tr>
					<td style="text-align: right; width: 30%; font-size: 125%;"><label
						for="username">用户名:</label></td>
					<td style="width: 20%;"><input type="text" name="username"
						id="username" onkeyup="checkUsername()"></td>
					<td style="width: 20%;"><span id="usernameMsg"></span></td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 125%"><label
						for="password">密码:</label></td>
					<td><input type="password" name="password" id="password"
						onkeyup="checkPassword()"></td>
					<td><span id="passwordMsg"></span></td>
				</tr>

				<tr>
					<td style="text-align: right; font-size: 125%"><label
						for="email">邮箱:</label></td>
					<td><input type="text" name="email" id="email"
						onkeyup="checkEmail()"></td>
					<td><span id="emailMsg"></span></td>
				</tr>
			</table>
			<button type="reset" class="mybutton"
				style="color: black; border: 1px; padding: 7px 15px;">重置</button>
			<button type="submit" class="mybutton"
				style="color: black; border: 1px; padding: 7px 15px;">注册</button>

		</form>
	</div>
	<!-- 3.注册 end -->

	<!-- 底部 start -->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 底部 end -->

</body>
</html>