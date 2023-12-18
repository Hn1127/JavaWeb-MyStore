<%@page import="com.pers.MyStore.entity.UserHistory"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>浏览历史</title>
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
	List<UserHistory> histories = (List<UserHistory>) request.getAttribute("histories");
	%>
	<!-- 3.订单展示 start -->
	<br>
	<div
		style="display: grid; gap: 20px; grid-template-columns: 1fr; width: 50%; min-height: 66%; margin: auto;">
		<%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (histories != null) {
			for (UserHistory history : histories) {
		%>
		<div>
			<a
				style="display: flex; gap: 20px; flex-direction: row; width: 100%; border: 1px solid black;"
				href="/productInfo?product_id=<%=history.getProduct_id()%>">
				<div style="width: 20%">
					<img style="width: 100%"
						src="images/products/<%=history.getProduct_id()%>/product.jpg">
				</div>
				<div style="width: 20%; font-size: 120%;"><%=history.getProduct_name()%></div>
				<div style="vertical-align: bottom;"><%=sdf.format(history.getHistory_time())%></div>
			</a>
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