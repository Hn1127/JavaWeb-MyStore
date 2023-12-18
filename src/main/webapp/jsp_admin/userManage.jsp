<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.pers.MyStore.service.UserService"%>
<%@page import="com.pers.MyStore.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/mainAdmin.css">
<title>用户详情</title>
<script>
var userID;
var username;
var email;
var nickname;
var registerDateLowerBound;
var registerDateUpperBound;

window.onload = function() {
	// 加载保存的查询条件
	userID = document.getElementById('userID');
	username = document.getElementById('username');
	email = document.getElementById('email');
	nickname = document
			.getElementById('nickname');
	registerDateLowerBound = document
			.getElementById('registerDateLowerBound');
	registerDateUpperBound = document
			.getElementById('registerDateUpperBound');
	loadValues();
}

function loadValues() {
	userID.value = localStorage.getItem('userID');
	username.value = localStorage.getItem('username');
	email.value = localStorage.getItem('email');
	nickname.value = localStorage
			.getItem('nickname');
	registerDateLowerBound.value = localStorage
			.getItem('registerDateLowerBound');
	registerDateUpperBound.value = localStorage
			.getItem('registerDateUpperBound');
}

function saveValues() {
	// 保存查询条件
	localStorage.setItem("userID", userID.value);
	localStorage.setItem("username", username.value);
	localStorage.setItem("email", email.value);
	localStorage.setItem("nickname",
			nickname.value);
	localStorage.setItem("registerDateLowerBound",
			registerDateLowerBound.value);
	localStorage.setItem("registerDateUpperBound",
			registerDateUpperBound.value);
}
</script>

</head>
<body>
	<div class="container">
		<div class="lefthalf" style="">
			<div class="leftcontainer">
				<div class="leftpart">
					<a href="/">返回首页</a>
				</div>
				<div class="leftpart">
					<a href="/admin/home">首页</a>
				</div>
				<div class="leftpart">
					<a href="/admin/productManage">商品管理</a>
				</div>
				<div class="leftpart">
					<a href="/admin/orderManage">订单查看</a>
				</div>
				<div class="leftpart" style="background-color: white">
					<a href="/admin/userManage">用户详情</a>
				</div>
			</div>
		</div>
		<div class="half">
			<div class="rightconatiner">
				<!-- 导航区 -->
				<div class='rightpartHead' style="">
					<table style="margin: auto; width: 100%">
						<tr>
							<td style="font-size: 190%;" align=left><a
								href="/admin/home">首页</a>/ <a href="/admin/userManage">用户详情</a></td>
							<td style="" align=right>返回前台</td>
						</tr>
					</table>
				</div>
				<!-- 功能区 -->
				<div class='rightpart' style="">
					<div style="dissplay: grid; width: 70%; margin: auto;">
						<!-- 查询栏 -->
						<br>
						<form style="width: 100%;" action="/admin/userManage" method="post">
							<div
								style="margin: auto; display: grid; width: 80%; grid-template-columns: 1fr 1fr; justify-content: center; gap: 5px;">
								<div>
									<label for="userID">用户ID</label> <input type="text"
										name="userID" id="userID">
								</div>
								<div>
									<label for="username">用户名&nbsp;</label> <input type="text"
										name="username" id="username">
								</div>
								<div>
									<label for="email">邮&nbsp;箱</label> <input type="text"
										name="email" id="email">
								</div>
								<div></div>
								<div><label for="nickname">昵&nbsp;称</label> <input type="text"
										name="nickname" id="nickname"></div>
								<div>
									<label>注册时间</label> <input type="date"
										name="registerDateLowerBound"
										id="registerDateLowerBound"> ~ <input type="date"
										name="registerDateUpperBound"
										id="registerDateUpperBound">
								</div>
								<div></div>
								<div style="text-align: right;">
									<input type="reset" value="重置" onclick="saveValues();">&nbsp;<input
										type="submit" value="查询" onclick="saveValues();">
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- 展示区 -->
				<div class='rightpart' style="text-align: center;">
					<!-- 用一个table+for循环表示，每一行为一个用户 -->
					<%
					List<User> users = (List<User>) request.getAttribute("users");
					%>
					<hr>
					共查询到[${users==null?0:users.size() }]条记录
					<table style="margin: auto; width: 70%;" border=1px cellspacing="0">
						<tr style="background-color: #afd1f3;">
							<td width=15%>ID</td>
							<td width=10%>用户名</td>
							<td width=10%>昵称</td>
							<td width=10%>邮箱</td>
							<td width=10%>注册时间</td>
							<td width=10%></td>
						</tr>
						<%
						if (users != null) {
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
							for (User user : users) {
						%>
						<tr>
							<td height=25px><a target="toPost"
								href="/admin/userInfo?user_id=<%=user.getUin()%>"><%=user.getUin()%></a></td>
							<td><a target="toPost"
								href="/admin/userInfo?user_id=<%=user.getUin()%>"><%=user.getUsername()%></a></td>
							<td><a target="toPost"
								href="/admin/userInfo?user_id=<%=user.getUin()%>"><%=user.getNickname()%></a></td>
							<td><%=user.getEmail()%></td>
							<td><%=user.getDate()%></td>
							<td><a target="toPost"
								href="/admin/userInfo?user_id=<%=user.getUin()%>">详情</a></td>
						</tr>
						<%
						}
						}
						%>
					</table>

				</div>
			</div>
		</div>
	</div>
</body>
</html>