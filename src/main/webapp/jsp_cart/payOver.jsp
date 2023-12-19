<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/css/main.css">
<script>
	// 新建interval，每隔一秒运行refresh方法
	var countDownInterval = setInterval("refresh()", 1000);

	// 倒计时开始的时间
	var count = 3;

	// refresh方法
	function refresh() {
		// 倒计时减少1s
		count--;
		// 页面中的倒计时更新
		document.getElementById("countDownNum").innerText = count;
		// 如果倒计时减少至0，清除interval并跳转至指定页面
		if (count == 0) {
			// 清除interval
			clearInterval(countDownInterval);
			// 跳转至指定页面
			location.href = "/index";
		}
	}
</script>
<title>购买完成</title>
</head>
<body class="main">
	<!-- 1.网站顶部 start-->
	<%@include file="/jsp_compoment/tophead.jsp"%>
	<!-- 1.网站顶部 end-->

	<!-- 2.提示 start -->
	<div class="main"
		style="height: 82.5%; display: flex;font-size:125%; align-items: center; justify-content: center; text-align: center; flex-direction: column;">
		<span>感谢您的购买，可点击<a href="/orderlist" style="color:blue;">此处</a>查看订单</span> 
		<span>将在<span id="countDownNum">3</span>秒后自动跳转至首页
		</span> <span><a href="/index"
			style="color: blue; text-decoration: underline">若未跳转请点击此处</a></span> <br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
	</div>
	<!-- 3.提示 end -->

	<!-- 5.底部 start -->
	<%@include file="/jsp_compoment/foot.jsp"%>
	<!-- 5.底部 end -->
</body>
</html>