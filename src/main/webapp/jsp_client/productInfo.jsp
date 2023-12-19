
<%@page import="com.pers.MyStore.entity.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
Product curProduct = (Product) request.getAttribute("product");
%>
<title>【<%=curProduct.getProduct_name()%>】
</title>
<link rel="stylesheet" type="text/css" href="/css/main.css">

<style type="text/css">
.mybutton {
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	cursor: pointer;
}
</style>
<script>
	function showAlert(msg) {
		alert(msg);
	}

	function subProductnum() {
		var curinventory = document.getElementById("product_num").value;
		if (curinventory > 1) {
			curinventory--;
			document.getElementById("product_num").value = curinventory;
		}
	}

	function addProductnum() {
		var curinventory = document.getElementById("product_num").value;
		curinventory++;
		document.getElementById("product_num").value = curinventory;
	}
</script>
</head>
<body class="main" style="gap: 20px;">
	<!-- 1.网站顶部 start -->
	<%@include file="/jsp_compoment/tophead.jsp"%>
	<!-- 1.网站顶部 end -->

	<!-- 2.首页搜索栏 start -->
	<%@include file="/jsp_compoment/indexSearch.jsp"%>
	<!-- 2.首页搜索栏 end -->

	<!-- 3.分类菜单 start -->
	<%@include file="/jsp_compoment/classify.jsp"%>
	<!-- 3.分类菜单 end -->

	<!-- 4.商品展示 start -->
	<div
		style="display: flex; width: 60%; min-height: 59.15%; margin: auto; border: 1px solid grey; align-items: flex-start; justify-content: center; padding: 20px; gap: 20px;">
		<div
			style="width: 30%; height: 300px; display: flex; align-items: center; justify-content: center;">
			<img src="/images/products/${product.getProduct_id() }/product.jpg"
				style="max-height: 280px;max-width:100%;">
		</div>
		<div style="width: 60%; text-align: left;">
			<!-- 品名 -->
			<div style="font-size: 150%; font-weight: 1000">${product.getProduct_name() }</div>
			<br>
			<!-- 价格 -->
			<div style="font-size: 120%; color: orange;">
				￥${product.getProduct_price() }</div>
			<br>
			<!-- 商品描述 -->
			<div style="font-size: 120%; font-weight: 100; min-height: 100px;">
				&nbsp;&nbsp;${product.getProduct_description() }</div>
			<br>
			<!-- 商品分类 -->
			<div>分类:${product.getProduct_realtype() }</div>
			<!-- 购买 -->
			<div style="display: flex; align-items: center;">
				<form action="#" method="get">
					<input type="hidden" id="product_id" name="product_id"
						value="${product.getProduct_id() }">
					<button type="button" onclick="subProductnum()" id="addButton"
						style="width: 30px; height: 30px">-</button>
					<input type="text" name="product_num" id="product_num" value="1"
						min="1" oninput="if (value < 1) value = 1;"
						style="width: 25px; height: 25px; text-align: center;">
					<button type="button" onclick="addProductnum()" id="subButton"
						style="width: 30px; height: 30px">+</button>
					&nbsp;
					<button class="mybutton" style="background-color: orange"
						type="submit" formaction="/addToCart" onclick="showAlert('加入购物车')">加入购物车</button>
					&nbsp;
					<button class="mybutton" style="background-color: red"
						type="submit" formaction="/buyDirect">直接购买</button>
				</form>
			</div>
		</div>
	</div>
	<!-- 5.商品展示 end  -->
	<br>
	<!-- 6.网站底部 start-->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 6.网站底部 end-->
</body>
</html>