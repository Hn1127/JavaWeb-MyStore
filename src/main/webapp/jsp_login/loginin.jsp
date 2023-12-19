<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录</title>
<!-- css -->
<link rel="stylesheet" type="text/css" href="/css/main.css">
<!-- js -->
<script type="text/javascript" src="/js/LoginFormCheck.js"></script>
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

	<!-- 3.登录 start -->
	<div class="login" style="margin: auto; width: 70%; min-height: 74.2%;padding-top:100px"
		align="center">
		<br> <span style="font-size: 110%;">用户登录</span>
		<%
		if (request.getAttribute("WrongMsg") == null || (((String)request.getAttribute("WrongMsg")).equals(""))) {
		%>
		<br>&nbsp;
		<%
		} else {
		%>
		<br>${WrongMsg }
		<%
		}
		%>

		<form action="loginSuccess" method="post"
			onsubmit="return checkFrom();">
			<table style="border-collapse: separate; border-spacing: 10px 10px;width:50%;" border="0">
				<tr>
					<td style="text-align: right; width: 20%; font-size: 120%;"><label
						for="username">用户名:</label></td>
					<td style="width: 15%;"><input type="text" name="username"
						style="width: 90%; height: 20px; font-size: 110%;" id="username"></td>
					<td style="width: 15%;"><span id="usernameMsg"></span></td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 120%;"><label
						for="password">密码:</label></td>
					<td><input type="password"
						style="width: 90%; height: 20px; font-size: 110%;" name="password"
						id="password"></td>
					<td><span id="passwordMsg"></span></td>
				</tr>
				<tr>
					<td style="text-align: right"><label for="remember">记住我</label></td>
					<td>
						<table width="100%">
							<tr>
								<td align="left"><input type="checkbox" id="remember"
									name="remember" /> <input type="hidden" name="remember"></td>
								<td align="right"><a href="#"></a></td>
							</tr>
						</table>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<table>
							<tr>
								<td><button type="submit" class="mybutton"
										style="color: black; border: 1px; padding: 7px 15px;">登录</button></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 3.登录 end -->

	<!-- 底部 start -->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 底部 end -->

</body>
</html>