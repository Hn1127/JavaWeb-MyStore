<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="main" style="background-color: slategrey; height: 6.5%;">
	<br>
	<%
	String username = (String) session.getAttribute("LogUser");
	String UserNickname = (String) session.getAttribute("UserNickname");
	if (username != null && username.equals("admin")) {
	%>
	<div
		style="text-align: right; margin-right: 300px; color: red; font-size: 80%;">
		<a href="/admin/home">进入后台</a>
	</div>
	<%
	} else {
	%>
	<br>
	<%
	}
	%>
	<div style="width: 1200px; border: 1px; font-size: 120%;margin:auto;">
		<div
			style="display: grid; grid-template-columns: 200px 1px 200px 200px 150px 1px 150px 1px 150px 1px 150px; margin: auto; justify-content: center;">
			<div style="">
				<%
				if (username != null) {
					// 若已登录
				%>
				欢迎,
				<%=UserNickname%>
				<%
				} else {
				// 若未登录
				%>
				<a href="login"> 登录 </a>
				<%
				}
				%>
			</div>
			<div>|</div>
			<div style="">
				<%
				if (username != null) {
					// 若已登录
				%>
				<a href="LoginOut"> 退出登录 </a>
				<%
				} else {
				// 若未登录
				%>
				<a href="register"> 注册 </a>
				<%
				}
				%>
			</div>
			<div></div>
			<div style="">
				<a href="/userInfo"> 我的账户 </a>
			</div>
			<div>|</div>
			<div style="">
				<a href="/orderlist"> 我的订单 </a>
			</div>
			<div>|</div>
			<div style="">
				<a href="/cart"> 购物车 </a>
			</div>
			<div>|</div>
			<div style="">
				<a href="/history"> 浏览历史 </a>
			</div>
		</div>
	</div>

</div>