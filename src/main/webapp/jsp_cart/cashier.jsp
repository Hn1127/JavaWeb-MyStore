<%@page import="com.pers.MyStore.entity.Order"%>
<%@page import="com.pers.MyStore.entity.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>收银台</title>
<link rel="stylesheet" type="text/css" href="/css/main.css">
<style type="text/css">
.mybutton {
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 125%;
	cursor: pointer;
}
</style>
</head>
<body class="main">
	<!-- 1.网站顶部 start-->
	<%@include file="/jsp_compoment/tophead.jsp"%>
	<!-- 1.网站顶部 end-->

	<!-- 2.导航栏 start -->
	<div class="main" style="height: 15%;">
		<br>
		<table border="0" align="center" width=1200>
			<tr>
				<!-- logo图片，点击将会转到首页 -->
				<td style="text-align: left; display: center; align-items: center;"><a
					href="/cashier"> <img src="images/logo.png" width="117"
						height="117" border="0" />
				</a></td>
				<td style="text-align: right;">应付金额<span
					style="font-size: 150%; color: red;"><%=session.getAttribute("total_price")%></span>元
				</td>
			</tr>
		</table>
	</div>
	<!-- 2.导航栏 end -->

	<!-- 支付按钮 -->
	<div style="width: 60%; height: 10%; margin: auto; text-align: right;">
		<a href="/pay"><button class="mybutton" style="background-color: orange">支付</button></a>
	</div>

	<%
	List<Order> orders = (List<Order>) session.getAttribute("payOrders");
	List<Cart> carts = (List<Cart>) session.getAttribute("orderCarts");
	%>
	<!-- 3.订单展示 start -->
	<div
		style="display: grid; gap: 20px; grid-template-columns: 1fr; width: 70%;min-height:58%; margin: auto;">
		<%
		for (int i = 0; i < orders.size(); ++i) {
			Order order = orders.get(i);
			Cart cart = carts.get(i);
		%>
		<div>
			<table style="width: 100%;" border="0" cellspacing="0">
				<thead style="text-align: left; border: 0;">
					<tr>
						<th>订单号:<%=order.getOrder_id()%></th>
						<th></th>
						<th></th>
						<th></th>
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
								style="width: 100px; height: 100px;"><%=cart.getProduct_name()%></a>
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
		%>
	</div>
	<!-- 3.订单展示 end -->

	<!-- 4.网站底部 start -->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 4.网站底部 end -->

</body>
</html>