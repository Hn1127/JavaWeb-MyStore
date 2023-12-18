<%@page import="com.pers.MyStore.entity.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/main.css">
<link rel="styleSheet" type="text/css" href="/css/ProductShow.css">
<title><%=request.getAttribute("title")%></title>
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
<script>
	window.onload = function(){
		var t = '<%=request.getAttribute("color")%>';
		console.log(t);
		var color = document.getElementById('<%=request.getAttribute("color")%>');
		console.log(color);
		color.style.backgroundColor = 'slategrey';
	}
</script>
</head>
<body class="main">

	<!-- 1.网站顶部 start-->
	<%@include file="/jsp_compoment/tophead.jsp"%>
	<!-- 1.网站顶部 end-->

	<!-- 2.首页搜索栏 start -->
	<%@include file="/jsp_compoment/indexSearch.jsp"%>
	<!-- 2.首页搜索栏 end -->

	<!-- 3.分类菜单 start -->
	<%@include file="/jsp_compoment/classify.jsp"%>
	<!-- 3.分类菜单 end -->

	<!-- 4.展示 start -->
	<%
	List<Product> products = (List<Product>) request.getAttribute("products");
	%>
	${welcomeMsg }
	<div
		style="width: 1300px; margin: auto; border: 1px solid grey; min-height: 63%; background-color: white">
		<div class="ProductShow">
			<%
			if (products != null) {
				for (Product product : products) {
			%>
			<a href="/productInfo?product_id=<%=product.getProduct_id()%>">
				<div class="product">
					<!-- 商品图片 -->
					<div class="product_img">
						<img src="<%=product.getPhotoPath()%>" width=250px height=180px>
					</div>
					<!-- 商品信息 -->
					<div class="product_info">
						<%=product.getProduct_name()%>
					</div>
					<!-- 商品价格 -->
					<div class="product_price">
						￥<%=product.getProduct_price()%>
					</div>
				</div>
			</a>
			<%
			}
			}
			%>
		</div>
	</div>
	<!-- 4.展示 end -->
	<br>
	<!-- 5.底部 start -->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 5.底部 end -->
</body>
</html>