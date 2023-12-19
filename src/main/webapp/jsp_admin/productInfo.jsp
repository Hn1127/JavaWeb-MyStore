<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.pers.MyStore.entity.Order"%>
<%@page import="com.pers.MyStore.entity.ProductType"%>
<%@page import="java.util.List"%>
<%@page import="com.pers.MyStore.entity.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/mainAdmin.css">
<link rel="stylesheet" type="text/css" href="/css/HiddenForm.css">

<script type="text/javascript" src="/js/ShowHiddenForm.js"></script>
<script type="text/javascript">
	function unLockEdit() {
		document.getElementById("product_name").disabled = "";
		document.getElementById("product_price").disabled = "";
		document.getElementById("product_description").disabled = "";
		document.getElementById("product_type").disabled = "";
		document.getElementById("product_inventory").disabled = "";
		document.getElementById("saveKey").disabled = "";
		document.getElementById("addButton").disabled = "";
		document.getElementById("subButton").disabled = "";
		document.getElementById("withdrawKey").disabled = "";

	}

	function LockEdit() {
		document.getElementById("product_name").disabled = "true";
		document.getElementById("product_price").disabled = "true";
		document.getElementById("product_description").disabled = "true";
		document.getElementById("product_type").disabled = "true";
		document.getElementById("product_inventory").disabled = "true";
		document.getElementById("addButton").disabled = "true";
		document.getElementById("subButton").disabled = "true";
	}

	function subInventory() {
		var curinventory = document.getElementById("product_inventory").value;
		curinventory--;
		document.getElementById("product_inventory").value = curinventory;
	}

	function addInventory() {
		var curinventory = document.getElementById("product_inventory").value;
		curinventory++;
		document.getElementById("product_inventory").value = curinventory;
	}
	
	function checkForm(){
		var product_price = document.getElementById("product_price").value;	
		
	
		
		return true;
	}
</script>


<script>
	var getUserPhoto;
	window.onload = function(){
		getUserPhoto = document.getElementById("photo");
		
		getUserPhoto.onchange = function () 
	    {
	        var file = this.files;
	        console.log(file);
	        var reader = new FileReader();
	        reader.readAsDataURL(file[0]);
	        reader.onload = function () 
	        {
	            var image = document.getElementById("show_img");
	            image.src = reader.result;
	        };
	     };
	}
   
    
</script>

<title>商品详情-${product.getProduct_name() }</title>
</head>
<body>
	<%
	Product curProduct = (Product) request.getAttribute("product");
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
				<div class="leftpart" style="background-color: white">
					<a href="/admin/productManage">商品管理</a>
				</div>
				<div class="leftpart">
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
								href="/admin/home">首页</a>/ <a href="/admin/productManage">商品管理</a>/
								商品详情</td>
						</tr>
					</table>
				</div>
				<!-- 展示区 -->
				<div class='rightpart' style="height: 90px;">
					<br>
					<div style="display: grid; width: 70%; margin: auto;">
						<a
							href="/admin/productInfo?product_id=${product.getProduct_id() }"><h3>商品编号:${product.getProduct_id() }</h3></a>
					</div>
					<hr>
				</div>
				<!-- 展示区 -->
				<div class='rightpart'>
					<div style="width: 70%; margin: auto;padding:20px">
						<form action="/admin/updateProduct" method="post" enctype="multipart/form-data"
							style="display: flex;padding-left: 20%;">
							<div>
								<input type="text" id="product_id" name="product_id"
									style="display: none;" value="${product.getProduct_id()}">
								<div
									style="display: grid; grid-template-columns: 300px 300px; justify-content: center; gap: 10px;">
									<div style="border: 1px;">
										<label for="product_name">品名:</label> <input type="text"
											id="product_name" name="product_name"
											value="${product.getProduct_name()}" disabled="true">
									</div>
									<div style="border: 1px;">
										<label for="product_price">&nbsp;&nbsp;单价:</label> <input
											type="text" id="product_price" name="product_price"
											value="${product.getProduct_price()}" disabled="true">
									</div>
									<div>
										<label for="product_type">分类:</label> <select
											id="product_type" name="product_type" disabled="true">
											<option value="">--商品分类--</option>
											<%
											// 循环打印商品分类项
											List<ProductType> productTypes = (List<ProductType>) request.getAttribute("productTypes");
											if (productTypes != null) {
												for (int i = 1; i < productTypes.size(); ++i) {
													ProductType productType = productTypes.get(i);
											%>
											<option value="<%=productType.getProduct_type()%>"
												<%if (curProduct.getProduct_type() == productType.getProduct_type()) {%>
												selected <%}%>><%=productType.getReal_type()%></option>
											<%
											}
											}
											%>
											<option value="0"
												<%if (curProduct.getProduct_type() == 0) {%> selected <%}%>>其他</option>
										</select>
									</div>
									<div>
										<label for="product_inventory">&nbsp;&nbsp;库存:</label>
										<button type="button" onclick="subInventory()" id="addButton"
											disabled="true">-</button>
										<input type="text" id="product_inventory"
											name="product_inventory" style="width: 40%;"
											value="${product.getProduct_inventory()}" disabled="true">
										<button type="button" onclick="addInventory()" id="subButton"
											disabled="true">+</button>
									</div>
								</div>

								<br>
								<div
									style="display: grid; grid-template-columns: 600px; justify-content: center;">
									<div>
										<label for="product_description">商品描述</label> <br> <input
											type="text" id="product_description"
											name="product_description"
											style="width: 550px; height: 100px;"
											value="${product.getProduct_description()}" disabled="true">
									</div>
								</div>
								<br>
								<div
									style="display: grid; grid-template-columns: 180px 80px 80px 80px; gap: 20px; direction: rtl;">
									<div></div>
									<div></div>
									<button type="button" onclick="unLockEdit()">编辑</button>
									<button type="button" id="ConfirmKey" onclick="LockEdit()"
										style="display: none;">确认</button>
								</div>
								<button type="submit" id="saveKey" disabled="true">保存修改</button>
								<a
									href="/admin/productInfo?product_id=<%=curProduct.getProduct_id()%>"><button
										type="button" id="withdrawKey" disabled="true">撤回修改</button></a>
							</div>
							<div>
								商品图片: <input type="file" name="photo" id="photo" value="更换图片" accept=".png, .jpg, .jpeg" onclick="unLockEdit()">
								<br>
								<img id="show_img" src="<%=curProduct.getPhotoPath() %>" width="240px">
							</div>
						</form>
					</div>
					<!-- 相关订单 -->
					<div class='rightpart' style="text-align: center;">
						<!-- 用一个table+for循环表示，每一行为一个订单 -->
						<%
						List<Order> orders = (List<Order>) request.getAttribute("orders");
						%>
						<hr>
						共查询到[${orders==null?0:orders.size() }]条记录
						<table style="margin: auto; width: 60%;" border=1px
							cellspacing="0" cellspacing="0">
							<tr style="background-color: #afd1f3;">
								<td width=15% height=25px>订单编号</td>
								<td width=15%>用户id</td>
								<td width=10%>单价</td>
								<td width=10%>订单数量</td>
								<td width=10%>订单总价</td>
								<td width=15%>订单时间</td>
							</tr>
							<%
							SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							if (orders != null) {
								for (Order order : orders) {
							%>
							<tr style="background-color: white;">
								<td height=25px><%=order.getOrder_id()%></td>
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
	</div>
</body>
</html>