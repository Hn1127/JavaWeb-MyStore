<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/mainAdmin.css">
<title>后台管理</title>
</head>
<body>
	<div class="container" style="">
		<div class="lefthalf" style="">
			<div class="leftcontainer">
				<div class="leftpart">
					<a href="/">返回首页</a>
				</div>
				<div class="leftpart" style="background-color: white">
					<a href="/admin/home">首页</a>
				</div>
				<div class="leftpart">
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
				<div class='rightpartHead' style="background-color: #6699CC">
					<table style="margin: auto; width: 100%">
						<tr>
							<td style="font-size: 190%;" align=left><a
								href="/admin/home">首页</a></td>
							<td style="" align=right>返回前台</td>
						</tr>
					</table>
				</div>
				<!-- 功能区 -->
				<div class='rightpart' style="height: 80px;"></div>
				<!-- 展示区 -->
				<div class='rightpart'
					style="display: grid; grid-template-columns: 1fr 1fr 1fr; width: 80%; margin: auto; font-size: 150%; gap: 50px; min-height: 700px; align-items: center; justify-items: center;">
					<div
						style="border: 1px solid; background-color: white; width: 100%; height: 400px;">
						<div style="width: 100%;" align="center">
							<a href="/admin/productManage">商品</a>
						</div>
						<div style="font-size: 90%; padding: 20px">
							当前共有[${productCount }]件商品<br>[${validProductCount }]件正在售卖中
						</div>
					</div>

					<div
						style="border: 1px solid; background-color: white; width: 100%; height: 400px;">
						<div style="width: 100%;" align="center">
							<a href="/admin/orderManage">订单</a>
						</div>
						<div style="font-size: 90%; padding: 20px">
							当前共有[${orderCount }]个订单<br>历史交易总金额为${orderSum }元<br><br>今日订单数[${orderCountToday }]<br>今日交易总金额为${orderSumToday }元
						</div>
					</div>

					<div
						style="border: 1px solid; background-color: white; width: 100%; height: 400px;">
						<div style="width: 100%;" align="center">
							<a href="/admin/userManage">用户</a>
						</div>
						<div style="font-size: 90%; padding: 20px">当前共有[${userCount }]位有效用户</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>