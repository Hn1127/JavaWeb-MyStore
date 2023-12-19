<%@page import="java.math.BigDecimal"%>
<%@page import="com.pers.MyStore.entity.Cart"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>购物车</title>
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
<script>
	function showAlert(msg) {
		alert(msg);
	}

	function subProductnum(product_id) {
		var tid = product_id + '_num';
		var curinventory = document.getElementById(tid).value;
		if (curinventory > 1) {
			curinventory--;
			document.getElementById(tid).value = curinventory;
		}
		changePrice(product_id);
	}

	function addProductnum(product_id) {
		var tid = product_id + '_num';
		var curinventory = document.getElementById(tid).value;
		curinventory++;
		document.getElementById(tid).value = curinventory;
		changePrice(product_id);
	}

	function changePrice(product_id) {
		var price = document.getElementById(product_id + '_price').innerHTML;
		var curnum = document.getElementById(product_id + '_num').value;
		document.getElementById(product_id + '_total').innerHTML = (price * curnum)
				.toFixed(2);
		;
	}
</script>

<script>
	window.onload = function() {
		// 1、获取我们所需的标签对象
		// 获取表示全选的input标签
		var inputAll = document.getElementById("selectProductAll");
		//获取其他所有的input标签，存储在一个伪数组中
		var inputOther = document.getElementsByName("selectProduct");
		// 2、给表示全选的input标签添加点击事件
		inputAll.addEventListener('click', function() {
			// 循环遍历伪数组中存储的其他的所有input标签对象
			inputOther.forEach(function(item) {
				// item中存储的是伪数组中的每一个 name="other" 的input标签
				// 将全选input标签的checked属性值赋值给其他的input标签
				item.checked = inputAll.checked;
			});
		});
		// 3、循环遍历伪数组, 给所有其他的input标签添加点击事件
		inputOther.forEach(function(item) {
			item.addEventListener('click', function() {
				// 定义一个变量存储原始值
				var res = true;
				// 循环遍历每一个其他input标签对象, 判断checked属性值 
				for (var i = 0; i < inputOther.length; i++) {
					// 如果其他的input标签里面有checked属性值是false的
					if (inputOther[i].checked === false) {
						// 给变量赋值false
						res = false;
						// 只要有一个其他input没有选中,全选input就不会选中 
						// 伪数组中之后的其他input也就不用循环判断了，使用break跳出当前整个循环
						break;
					}
				}
				// 循环结束,  res存储的true或者false, 就是全选input标签checked属性的属性值
				// 将res作为属性值赋值给全选input标签的checked属性
				inputAll.checked = res;
			})
		})
	}

	function checkCart(event) {
		var inputOther = document.getElementsByName("selectProduct");
		var count = 0;
		for (var i = 0; i < inputOther.length; ++i) {
			if (inputOther[i].checked == true) {
				// 选中该商品
				return true;
			}

		}
		alert("至少选择一件商品");
		event.preventDefault();
	}
</script>

</head>
<body class="main">
	<!-- 1.网站顶部 start-->
	<%@include file="/jsp_compoment/tophead.jsp"%>
	<!-- 1.网站顶部 end-->

	<!-- 2.搜索栏 start -->
	<%@include file="/jsp_compoment/indexSearch.jsp"%>
	<!-- 2.搜索栏 end -->

	<!-- 3.购物车展示 start -->
	<%
	List<Cart> carts = (List<Cart>) session.getAttribute("carts");
	%>
	<div
		style="width: 60%; min-height: 68%; margin: auto; display: grid; gird-template-columns: 1fr;">
		<form action="getOrderInfo" method="post">
			<span style="font-size: 120%; font-weight: 1000;">全部商品[<%=carts == null ? 0 : carts.size()%>]件
			</span>
			<table
				style="width: 100%; line-height: 1.5; border-collapse: separate; border-spacing: 0px 15px;"
				border="0" cellspacing="0">
				<thead style="background-color: #f5f5f5;">
					<tr>
						<th width="55%" height="42px">商品</th>
						<th width="10%" height="42px">单价</th>
						<th width="15%" height="42px">数量</th>
						<th width="10%" height="42px">小计</th>
						<th width="10%" height="42px">操作</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (carts != null) {
						for (Cart cart : carts) {
					%>
					<tr>
						<!-- 商品 -->
						<td style="display: flex; font-size: 120%"><label
							for="<%=cart.getProduct_id()%>"><input type="checkbox"
								name="selectProduct" id="<%=cart.getProduct_id()%>"
								value="<%=cart.getProduct_id()%>"> <img
								src="/images/products/<%=cart.getProduct_id()%>/product.jpg"
								style="width: 100px; height: 100px;"></label>
								<a href="productInfo?product_id=<%=cart.getProduct_id()%>" target="toPost"><%=cart.getProduct_name()%></a>
						</td>
						<!-- 单价 -->
						<td style="text-align: center"><span
							id="<%=cart.getProduct_id()%>_price"><%=cart.getProduct_price()%></span></td>
						<!-- 数量 -->
						<td style="text-align: center"><input type="hidden"
							name="product_id" value="<%=cart.getProduct_id()%>"> <!-- 减按钮 -->
							<button type="button"
								onclick="subProductnum('<%=cart.getProduct_id()%>')"
								id="addButton" style="width: 30px; height: 30px">-</button> <!-- 数量 -->
							<input type="text" name="product_num"
							id="<%=cart.getProduct_id()%>_num"
							value="<%=cart.getQuantity()%>" min="1"
							oninput="if (value < 1) value = 1;"
							onchange="changePrice('<%=cart.getProduct_id()%>')"
							style="width: 25px; height: 25px; text-align: center;"> <!-- 加按钮 -->
							<button type="button"
								onclick="addProductnum('<%=cart.getProduct_id()%>')"
								id="subButton" style="width: 30px; height: 30px">+</button></td>
						<!-- 总价 -->
						<td style="text-align: center"><span
							id="<%=cart.getProduct_id()%>_total"><%=cart.getTotalPrice()%></span></td>
						<td style="text-align: center; font-weight: 1000"><a
							href="/removeFromCart?product_id=<%=cart.getProduct_id()%>">删除</a></td>
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
			<table style="width: 100%; background-color: #f5f5f5;" border="0"
				cellspacing="0">
				<tr>
					<td style="text-align: left"><input type="checkbox"
						id="selectProductAll"><label for="selectProductAll">全选</label>
						<button type="submit" formaction="/saveCart"
							style="background-color: transparent; border: 0; cursor: pointer;">保存修改</button>
					</td>
					<td style="text-align: right">
						<button type="submit" class="mybutton"
							style="background-color: orange" onclick="checkCart(event)">去结算</button>
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