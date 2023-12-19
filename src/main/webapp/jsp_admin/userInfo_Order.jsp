<%@page import="java.util.List"%>
<%@page import="com.pers.MyStore.entity.Order"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<br>
<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
共查询到[${orders==null?0:orders.size() }]条记录
<table style="margin: auto; width: 60%;" border=1px cellspacing="0"
	cellspacing="0">
	<tr style="background-color: #afd1f3;">
		<td width=15% height=25px>订单编号</td>
		<td width=15%>商品编号</td>
		<td width=10%>商品单价</td>
		<td width=10%>商品数量</td>
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
			href="/admin/productInfo?product_id=<%=order.getProduct_id()%>"><%=order.getProduct_id()%></a></td>
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