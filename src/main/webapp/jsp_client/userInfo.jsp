<%@page import="com.pers.MyStore.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的账户</title>
<link rel="stylesheet" type="text/css" href="/css/main.css">
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

.userInfo td {
	font-size: 120%;
}

.userInfo td input {
	width: 180px;
	height: 20px;
	font-size: 110%;
}
</style>

</head>
<body class="main" style="background-color:;">

	<!-- 1.网站顶部 start-->
	<%@include file="/jsp_compoment/tophead.jsp"%>
	<!-- 1.网站顶部 end-->

	<!-- 2.首页搜索栏 start -->
	<%@include file="/jsp_compoment/indexSearch.jsp"%>
	<!-- 2.首页搜索栏 end -->
	<%
	User user = (User) session.getAttribute("userInfo");
	%>
	<!-- 3.信息展示 start -->
	<div style="width: 60%; margin: auto; min-height: 67.5%;">
		<!-- 基本信息 -->
		<div>
			<form action="/nicknameUpdate" method="post">
				<table class="userInfo"
					style="margin: auto; border-collapse: separate; border-spacing: 10px 15px;">
					<tr>
						<td style="text-align: right">用户名:</td>
						<td style="text-align: left"><span><%=user.getUsername()%></span>
						</td>
					</tr>
					<tr>
						<td style="text-align: right">昵称:</td>
						<td style="text-align: left"><input type="text"
							name="nickname" value="<%=user.getNickname()%>"></td>
					</tr>
					<tr>
						<td style="text-align: right">邮箱:</td>
						<td style="text-align: left"><span><%=user.getEmail()%></span>
						</td>
					</tr>
					<tr>
						<td style="text-align: right">注册时间:</td>
						<td style="text-align: left"><span><%=user.getDate()%></span>
						</td>
					</tr>
					<tr>
						<td></td>
						<td style="text-align: right"><button type="submit">保存</button></td>
					</tr>
				</table>
			</form>
		</div>
		<br>
		
		<!-- 信息操作 -->
		<div style="display: grid; margin: auto;grid-template-columns:200px 1px 200px 1px 200px; justify-content: center;font-size:110%;">
			<div><a <%if(!session.getAttribute("LogUser").equals("admin")) {%>href="/deleteUser"<%} %>>注销用户</a></div>
			<div>|</div>
			<div><a href="/passwordUpdate">修改密码</a></div>
			<div>|</div>
			<div><a href="/emailUpdate">修改邮箱</a></div>
		</div>
	</div>
	<!-- 3.信息展示 end -->

	<!-- 4.底部 start -->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 4.底部 end -->

</body>
</html>