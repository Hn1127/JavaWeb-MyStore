<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.pers.MyStore.entity.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/mainAdmin.css">
<title>后台管理</title>
<script>
	var orderId;
	var userId;
	var productID;
	var orderPriceLowerBound;
	var orderPriceUpperBound;
	var oderDateLowerBound;
	var oderDateUpperBound;

	window.onload = function() {
		// 加载保存的查询条件
		orderId = document.getElementById('orderId');
		userId = document.getElementById('userId');
		productID = document.getElementById('productID');
		orderPriceLowerBound = document
				.getElementById('orderPriceLowerBound');
		orderPriceUpperBound = document
				.getElementById('orderPriceUpperBound');
		oderDateLowerBound = document
				.getElementById('oderDateLowerBound');
		oderDateUpperBound = document
				.getElementById('oderDateUpperBound');
		loadValues();
	}

	function loadValues() {
		orderId.value = localStorage.getItem('orderId');
		userId.value = localStorage.getItem('userId');
		productID.value = localStorage.getItem('productID');
		orderPriceLowerBound.value = localStorage
				.getItem('orderPriceLowerBound');
		orderPriceUpperBound.value = localStorage
				.getItem('orderPriceUpperBound');
		oderDateLowerBound.value = localStorage
				.getItem('oderDateLowerBound');
		oderDateUpperBound.value = localStorage
				.getItem('oderDateUpperBound');
	}

	function saveValues() {
		// 保存查询条件
		localStorage.setItem("orderId", orderId.value);
		localStorage.setItem("userId", userId.value);
		localStorage.setItem("productID", productID.value);
		localStorage.setItem("orderPriceLowerBound",
				orderPriceLowerBound.value);
		localStorage.setItem("orderPriceUpperBound",
				orderPriceUpperBound.value);
		localStorage.setItem("oderDateLowerBound",
				oderDateLowerBound.value);
		localStorage.setItem("oderDateUpperBound",
				oderDateUpperBound.value);
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
				<div class="leftpart" style="background-color: white">
					<a href="/admin/orderManage">订单查看</a>
				</div>
				<div class="leftpart">
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
								href="/admin/home">首页</a>/ <a href="/admin/orderManage">订单查看</a></td>
							<td style="" align=right>返回前台</td>
						</tr>
					</table>
				</div>
				<!-- 功能区 -->
				<div class='rightpart' style="">
					<div style="dissplay: grid; width: 70%; margin: auto;">
						<!-- 查询栏 -->
						<br>
						<form style="width: 100%;" action="/admin/orderManage"
							method="post ">
							<div
								style="margin: auto; display: grid; width: 80%; grid-template-columns: 1fr 1fr; justify-content: center; gap: 5px;">
								<div>
									<label for="orderId">订单编号</label> <input type="text"
										name="orderId" id="orderId">
								</div>
								<div>
									<label for="userId">用户ID&nbsp;</label> <input type="text"
										name="userId" id="userId">
								</div>
								<div>
									<label for="productID">商品编号</label> <input type="text"
										name="productID" id="productID">
								</div>
								<div></div>
								<div>
									<label>订单总价</label> <input type="text"
										name="orderPriceLowerBound" id="orderPriceLowerBound">
									- <input type="text" name="orderPriceUpperBound"
										id="orderPriceUpperBound">
								</div>
								<div>
									<label>订单时间</label> <input type="date"
										name="oderDateLowerBound" id="oderDateLowerBound"> - <input
										type="date" name="oderDateUpperBound" id="oderDateUpperBound">
								</div>
								<div></div>
								<div style="text-align: right;">
									<button type="reset" onclick="saveValues()">重置</button>
									&nbsp;
									<button type="submit" onclick="saveValues()">查询</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- 展示区 -->
				<div class='rightpart' style="text-align: center;">
					<!-- 用一个table+for循环表示，每一行为一个订单 -->
					<%
					List<Order> orders = (List<Order>) request.getAttribute("orders");
					%>
					<hr>
					共查询到[${orders==null?0:orders.size() }]条记录
					<table style="margin: auto; width: 60%;" border=1px cellspacing="0"
						cellspacing="0">
						<tr style="background-color: #afd1f3;">
							<td width=15% height=25px>订单编号</td>
							<td width=15%>商品编号</td>
							<td width=15%>用户ID</td>
							<td width=10%>商品单价</td>
							<td width=10%>商品数量</td>
							<td width=10%>订单总价</td>
							<td width=15%>订单时间</td>
						</tr>
						<%
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						if (orders != null) {
							for (Order order : orders) {
						%>
						<tr>
							<td height=25px><%=order.getOrder_id()%></td>
							<td><a target="toPost"
								href="/admin/productInfo?product_id=<%=order.getProduct_id()%>"><%=order.getProduct_id()%></a></td>
							<td><a target="toPost"
								href="/admin/userInfo?user_id=<%=order.getUser_id()%>"><%=order.getUser_id()%></a></td>
							<td><%=order.getProduct_price()%></td>
							<td><%=order.getQuantity()%></td>
							<td><%=order.getTotal_price()%></td>
							<td><%=sdf.format(order.getOrder_date())%></td>
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