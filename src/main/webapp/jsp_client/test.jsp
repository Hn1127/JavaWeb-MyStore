<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head> 
<body>
<center>
		<h1>
			<a href="${pageContext.request.contextPath}/loadCartDataServlet.do">我的购物车</a>
			<a href="${pageContext.request.contextPath}/myOrderServlet.do">我的订单</a>
		</h1>
	</center>
 	 <c:if test="${empty listGoods}">
		<jsp:forward page="/myLoadDataServlet.do"></jsp:forward>
	</c:if> 
	<table border="4px" style="text-align: center;" height="600px" width="1000px" align="center" >
			<tr> 
				<td>商品序号</td>
				<td>商品名称</td>
				<td>商品单价</td>
				<td>操作</td>
			</tr>
			
			<c:forEach items="${listGoods }" var="g">
				<tr style="font-size:20px;">
					<td >${g.gId }</td>
					<td>${g.gName }</td>
					<td>${g.gPrice }</td>
					<td >
						<!-- 加入购物车 -->
						<a href="${pageContext.request.contextPath }/addCartServlet.do?gid=${g.gId}">
							<img src="${pageContext.request.contextPath}/static/images/1.ico" width="60px"/>
						</a>
						&nbsp;&nbsp;
						<!-- 立即购买：直接跳转到结账页面，不经过购物车 -->
						<a href="#">
							 <img src="${pageContext.request.contextPath}/static/images/8.ico" width="50px"/>
						</a>
					</td>
				</tr>	
			</c:forEach>
			
			
			
			
			</table>
</body>
</html>