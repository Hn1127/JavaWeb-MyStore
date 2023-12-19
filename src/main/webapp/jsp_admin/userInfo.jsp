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
<title>用户详情-<%=((User)request.getAttribute("userAdmin")).getUin() %></title>
</head>
<body>
	<%
	int showType = (int) request.getAttribute("showType");
	%>
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
							
						</tr>
					</table>
				</div>
				<!-- 展示区 -->
				<div class='rightpart' style="height: 90px;">
					<br>
					<div style="display: grid; width: 70%; margin: auto;">
						<a href="/admin/userInfo?user_id=${userAdmin.getUin() }">
							<h3>用户ID:${userAdmin.getUin() }</h3>
						</a>
					</div>
					<hr>
				</div>
				<div class='rightpart' style="margin: auto; text-align: center;">
					<div>
						<table
							style="margin: auto; width: 20%; background-color: #afd1f3;"
							border=1>
							<tr>
								<td <%if(showType==0){ %> style="background-color: white;"
									<%} %>><a href="/admin/userInfo?user_id=${userAdmin.getUin() }">用户信息</a></td>
								<td <%if(showType==1){ %> style="background-color: white;"
									<%} %>><a href="/admin/userInfo?user_id=${userAdmin.getUin() }&showType=1">订单记录</a></td>
								<td <%if(showType==2){ %> style="background-color: white;"
									<%} %>><a href="/admin/userInfo?user_id=${userAdmin.getUin() }&showType=2">浏览历史</a></td>
							</tr>
						</table>
					</div>
					<%
					switch (showType) {
					case 0:
					%>
					<%@include file="/jsp_admin/userInfo_Info.jsp"%>
					<%
					break;
					case 1:
					%>
					<%@include file="/jsp_admin/userInfo_Order.jsp"%>
					<%
					break;
					case 2:
					%>
					<%@include file="/jsp_admin/userInfo_History.jsp"%>
					<%
					break;
					}
					%>
				</div>
			</div>
		</div>
	</div>
</body>
</html>