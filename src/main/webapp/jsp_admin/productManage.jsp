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
<script>
	var productId;
	var productName;
	var productType;
	var productPriceLowerBound;
	var productPriceUpperBound;
	var productInventoryLowerBound;
	var productInventoryUpperBound;
	var getUserPhoto;

	window.onload = function() {
		// 加载保存的查询条件
		productId = document.getElementById('productId');
		productName = document.getElementById('productName');
		productType = document.getElementById('productType');
		productPriceLowerBound = document
				.getElementById('productPriceLowerBound');
		productPriceUpperBound = document
				.getElementById('productPriceUpperBound');
		productInventoryLowerBound = document
				.getElementById('productInventoryLowerBound');
		productInventoryUpperBound = document
				.getElementById('productInventoryUpperBound');
		loadValues()
		getUserPhoto = document.getElementById("photo");

		getUserPhoto.onchange = function() {
			var file = this.files;
			console.log(file);
			var reader = new FileReader();
			reader.readAsDataURL(file[0]);
			reader.onload = function() {
				var image = document.getElementById("show_img");
				image.src = reader.result;
			};
		};
	}

	function loadValues() {
		productId.value = localStorage.getItem('productId');
		productName.value = localStorage.getItem('productName');
		productType.value = localStorage.getItem('productType');
		productPriceLowerBound.value = localStorage
				.getItem('productPriceLowerBound');
		productPriceUpperBound.value = localStorage
				.getItem('productPriceUpperBound');
		productInventoryLowerBound.value = localStorage
				.getItem('productInventoryLowerBound');
		productInventoryUpperBound.value = localStorage
				.getItem('productInventoryUpperBound');
	}

	function saveValues() {
		// 保存查询条件
		localStorage.setItem("productId", productId.value);
		localStorage.setItem("productName", productName.value);
		localStorage.setItem("productType", productType.value);
		localStorage.setItem("productPriceLowerBound",
				productPriceLowerBound.value);
		localStorage.setItem("productPriceUpperBound",
				productPriceUpperBound.value);
		localStorage.setItem("productInventoryLowerBound",
				productInventoryLowerBound.value);
		localStorage.setItem("productInventoryUpperBound",
				productInventoryUpperBound.value);
	}

	function checkForm(event) {
		var wrongMsg = document.getElementById("wrongMsg");
		var product_name = document.getElementById("product_name");
		var product_price = document.getElementById("product_price");
		var product_price_check = /^[0-9]*$/;
		var product_type = document.getElementById("product_type");
		console.log(product_name.value);
		console.log(product_name);
		console.log(product_price);
		console.log(product_type);
		console.log(wrongMsg);
		if (product_name.value == "") {
			wrongMsg.innerHTML = "商品名不能为空";
			return false;
		}

		if (product_price.value == "") {
			wrongMsg.innerHTML = "商品单价不能为空";
			return false;
		}
		
		if (!product_price_check.test(product_price.value)) {
			wrongMsg.innerHTML = "商品单价不能有特殊符号";
			return false;
		}

		if (product_type.value == "") {
			wrongMsg.innerHTML = "请选择商品类型";
			return false;
		}
		var product_price = document.getElementById("product_price").value;	
		
		return true;
	}
</script>
<title>商品管理</title>
</head>
<body>
	<div class="container">
		<!-- 左侧 -->
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
		<!-- 右侧 -->
		<div class="half">
			<div class="rightconatiner">
				<!-- 导航区 -->
				<div class='rightpartHead' style="">
					<table style="margin: auto; width: 100%">
						<tr>
							<td style="font-size: 190%" align=left><a
								href="/admin/home">首页</a>/ <a href="/admin/productManage">商品管理</a></td>
						</tr>
					</table>
				</div>
				<!-- 功能区 -->
				<div class='rightpart' style="height: 150px;">
					<div style="dissplay: grid; width: 70%; margin: auto;">
						<!-- 查询栏 -->
						<br>
						<form style="width: 100%;" action="/admin/productManage"
							method="post">
							<div
								style="margin: auto; display: grid; width: 80%; grid-template-columns: 1fr 1fr; justify-content: center; gap: 5px;">
								<div>
									<label for="productId">商品编号</label> <input type="text"
										name="productId" id="productId">
								</div>
								<%
								List<ProductType> productTypes = (List<ProductType>) request.getAttribute("productTypes");
								%>
								<div>
									<label for="productType">类型</label> <select id="productType"
										name="productType">
										<option value="">--商品分类--</option>
										<%
										// 循环打印商品分类项

										if (productTypes != null) {
											for (int i = 1; i < productTypes.size(); ++i) {
												ProductType productType = productTypes.get(i);
										%>
										<option value="<%=productType.getProduct_type()%>"><%=productType.getReal_type()%></option>
										<%
										}
										}
										%>
										<option value="0">其他</option>
									</select>
								</div>
								<div>
									<label for="productValid">商品状态</label> <select
										name="productValid" id="productValid">
										<option value="" selected>--商品状态--</option>
										<option value="1">售卖中</option>
										<option value="0">下架</option>
									</select>
								</div>
								<div>
									<label for="productName">名称</label> <input type="text"
										name="productName" id="productName">
								</div>
								<div>
									<label>价格</label> <input type="text"
										name="productPriceLowerBound" id="productPriceLowerBound">
									- <input type="text" name="productPriceUpperBound"
										id="productPriceUpperBound">
								</div>
								<div>
									<label>库存</label> <input type="text"
										name="productInventoryLowerBound"
										id="productInventoryLowerBound"> - <input type="text"
										name="productInventoryUpperBound"
										id="productInventoryUpperBound">
								</div>
								<div></div>
								<div style="text-align: right;">
									<button type="reset" onclick="saveValues()">重置</button>
									&nbsp;
									<button type="submit" onclick="saveValues()">查询</button>
								</div>
							</div>
						</form>
						<button onclick="openForm()">添加商品</button>
						<a href="/admin/productManage"><button>刷新</button></a>
						<!-- 添加商品 -->
						<div id="Hidden">
							<form action="/admin/addProduct" method="post"
								enctype="multipart/form-data" onsubmit="return checkForm(event)"
								style="width: 700px;">
								<div style="margin: auto;">
									<!-- 错误提示 -->
									<span id="wrongMsg" style="color: red"></span> <br>
									<!-- 商品表单 -->
									<div
										style="display: grid; grid-template-columns: 300px 300px; justify-content: center; gap: 10px;">
										<div width=50% style="border: 1px;">
											<label for="product_name">品名:</label> <input type="text"
												id="product_name" name="product_name">
										</div>
										<div width=50% style="border: 1px;">
											<label for="product_price">单&nbsp;&nbsp;价:</label> <input
												type="text" id="product_price" name="product_price">
										</div>
										<div width=70%>
											<label for="product_type">分类:</label> <select
												id="product_type" name="product_type">
												<option value="">--商品分类--</option>
												<%
												// 循环打印商品分类项

												if (productTypes != null) {
													for (int i = 1; i < productTypes.size(); ++i) {
														ProductType productType = productTypes.get(i);
												%>
												<option value="<%=productType.getProduct_type()%>"><%=productType.getReal_type()%></option>
												<%
												}
												}
												%>
												<option value="0">其他</option>
											</select>
										</div>
										<div width=30%>
											<label for="product_inventory">初始库存:</label> <input
												type="text" id="product_inventory" name="product_inventory"
												value="0">
										</div>
									</div>
									<br>
									<!-- 商品图片 -->
									<div
										style="display: grid; grid-template-columns: 600px; justify-content: center; min-height: 200px; margin: auto;">
										<input type="file" name="photo" id="photo" value="商品图片"><br>
										<img src="" id="show_img" height="190px" style="margin: auto;">
									</div>
									<br>
									<div
										style="display: grid; grid-template-columns: 600px; justify-content: center;">
										<div>
											<label for="product_description">商品描述</label> <br> <input
												type="text" id="product_description"
												name="product_description"
												style="width: 550px; height: 100px;">
										</div>
										<br> <br>
									</div>
									<div
										style="display: grid; grid-template-columns: 80px 20px 80px; justify-content: center;">
										<input type="submit" value="提交"> &nbsp;
										<button type="button" onclick="closeForm()">取消</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
				<!-- 展示区 -->
				<div class='rightpart'>
					<!-- 用一个table+for循环表示，每一行为一个商品 -->
					<%
					List<Product> products = (List<Product>) request.getAttribute("products");
					%>
					<hr>
					<div style="width: 70%; margin: auto; text-align: center;">
						共查询到[${products==null?0:products.size() }]条记录
						<table style="width: 100%;" border=1px cellspacing="0">
							<tr style="background-color: #afd1f3;">
								<td width=15% height=25px>商品编号</td>
								<td width=10%>商品名称</td>
								<td width=10%>单价</td>
								<td width=10%>库存</td>
								<td width=10%>商品分类</td>
								<td width=10%>状态</td>
								<td width=10%></td>
							</tr>
							<%
							if (products != null) {
								for (Product product : products) {
							%>
							<tr style="background-color: white;">
								<td height=25px><%=product.getProduct_id()%></td>
								<td><a
									href="/admin/productInfo?product_id=<%=product.getProduct_id()%>"><%=product.getProduct_name()%></a></td>
								<td><%=product.getProduct_price()%></td>
								<td><%=product.getProduct_inventory()%></td>
								<td><%=productTypes.get(product.getProduct_type()).getReal_type()%></td>
								<td><%=product.isProduct_valid() == false ? "下架" : "售卖中"%></td>
								<td style="font-weight: bold;">
								<a href="/admin/productInfo?product_id=<%=product.getProduct_id()%>" target="toPost">
								详情
								</a>&nbsp; 
								<a href="/admin/changeProductValid?product_id=<%=product.getProduct_id()%>">
								<%=product.isProduct_valid() == false ? "上架" : "下架"%>
								</a>
								</td>

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