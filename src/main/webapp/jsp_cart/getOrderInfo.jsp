<%@page import="java.math.BigDecimal"%>
<%@page import="com.pers.MyStore.entity.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>订单结算页</title>
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
				<td style="text-align: left;"><a href="index"> <img
						src="images/logo.png" width="117" height="117" border="0" />
				</a></td>
				<td style="text-align: right;">核对订单信息</td>
			</tr>
		</table>
	</div>
	<!-- 2.导航栏 end -->

	<!-- 3.订单展示 start -->
	<%
	List<Cart> carts = (List<Cart>) session.getAttribute("orderCarts");
	BigDecimal total_price = new BigDecimal(0);
	%>
	<div
		style="width: 60%; min-height: 68%; margin: auto; display: grid; gird-template-columns: 1fr;">
		<form action="cashier" method="post">
			<span style="font-size: 120%; font-weight: 1000;">全部商品[<%=carts == null ? 0 : carts.size()%>]件
			</span>
			<table style="width: 100%;border-collapse: separate; border-spacing: 0px 15px;" border="0" cellspacing="0">
				<thead style="background-color: #f5f5f5;">
					<tr>
						<th width="55%" height="42px">商品</th>
						<th width="10%" height="42px">单价</th>
						<th width="15%" height="42px">数量</th>
						<th width="10%" height="42px">小计</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (carts != null) {
						for (Cart cart : carts) {
							total_price=total_price.add(cart.getTotalPrice());
					%>
					<tr>
						<!-- 商品 -->
						<td><a
							href="/productInfo?product_id=<%=cart.getProduct_id()%>"
							target="toPost" style="display: flex; font-size: 120%"><img
								src="/images/products/<%=cart.getProduct_id()%>/product.jpg"
								style="width: 100px; height: 100px;"><%=cart.getProduct_name()%></a>
						</td>
						<!-- 单价 -->
						<td style="text-align: center"><span
							id="<%=cart.getProduct_id()%>_price"><%=cart.getProduct_price()%></span></td>
						<!-- 数量 -->
						<td style="text-align: center"><span><%=cart.getQuantity()%></span>
						</td>
						<!-- 总价 -->
						<td style="text-align: center"><span
							id="<%=cart.getProduct_id()%>_total"><%=cart.getTotalPrice()%></span></td>
					</tr>
					<%
					}
					}
					%>

				</tbody>
			</table>
			<br>
			<div style="width: 100%; margin: auto;">
				<div style="width:"></div>
				<div style="width:"></div>
			</div>
			<table style="width: 100%;" border="0" cellspacing="0">
				<tr>
					<td style="text-align: right">
					
					<span style="">应付总额:<span style="color:red;">￥<%=total_price %></span></span><br><br>
						<button type="submit" class="mybutton"
							style="background-color: orange" onclick="">提交订单</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 3.购物车展示 end -->
	
	<!-- 4.网站底部 start -->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 4.网站底部 end -->

</body>
</html>