<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.pers.MyStore.entity.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的订单</title>
<link rel="stylesheet" type="text/css" href="/css/main.css">


</head>
<body class="main" style="background-color:;">
	<!-- 1.网站顶部 start-->
	<%@include file="/jsp_compoment/tophead.jsp"%>
	<!-- 1.网站顶部 end-->

	<!-- 2.搜索栏 start -->
	<%@include file="/jsp_compoment/indexSearch.jsp"%>
	<!-- 2.搜索栏 end -->

	<%
	List<Order> orders = (List<Order>) session.getAttribute("orders");
	%>
	<!-- 3.订单展示 start -->
	<br>
	<div
		style="display: grid; gap: 20px; grid-template-columns: 1fr; width: 70%; min-height: 66%; margin: auto;">
		<span style="font-size: 120%; font-weight: 1000;">共有[<%=orders == null ? 0 : orders.size()%>]个订单
			</span>
		<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (orders != null) {
			for (Order order : orders) {
		%>
		<div>
			<table style="width: 100%;" border="0" cellspacing="0">
				<thead style="text-align: left; border: 0;">
					<tr>
						<th style="display: flex"><span
							style="display: block; width: 300px;"><%=sdf.format(order.getOrder_date())%></span>订单号:<%=order.getOrder_id()%></th>
						<th></th>
						<th></th>
						<th style="text-align: right"><a
							href="/removeOrder?order_id=<%=order.getOrder_id()%>">删除订单</a></th>
					</tr>
				</thead>
				<thead style="background-color: #f5f5f5;">
					<tr>
						<th width="55%" height="42px">商品</th>
						<th width="10%" height="42px">单价</th>
						<th width="15%" height="42px">数量</th>
						<th width="10%" height="42px">小计</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<!-- 商品 -->
						<td><a
							href="/productInfo?product_id=<%=order.getProduct_id()%>"
							target="toPost" style="display: flex; font-size: 120%"><img
								src="/images/products/<%=order.getProduct_id()%>/product.jpg"
								style="width: 100px; height: 100px;"><%=order.getProduct_name()%></a>
						</td>
						<!-- 单价 -->
						<td style="text-align: center"><span
							id="<%=order.getProduct_id()%>_price"><%=order.getProduct_price()%></span></td>
						<!-- 数量 -->
						<td style="text-align: center"><span><%=order.getQuantity()%></span>
						</td>
						<!-- 总价 -->
						<td style="text-align: center"><span
							id="<%=order.getProduct_id()%>_total"><%=order.getTotal_price()%></span></td>
					</tr>
				</tbody>
			</table>
		</div>
		<%
		}
		}
		%>
		<br>
	</div>
	<!-- 3.订单展示 end -->

	<!-- 4.网站底部 start -->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 4.网站底部 end -->

</body>
</html>