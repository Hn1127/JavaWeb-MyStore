<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.pers.MyStore.entity.UserHistory"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>


<br>
<%
List<UserHistory> histories = (List<UserHistory>) request.getAttribute("histories");
%>
共查询到[${histories==null?0:histories.size() }]条记录
<table style="margin: auto; width: 60%;" border=1px cellspacing="0"
	cellspacing="0">
	<tr style="background-color: #afd1f3;">
		<td width=15% height=25px>商品编号</td>
		<td width=10%>品名</td>
		<td width=15%>浏览时间</td>
	</tr>
	<%
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	if (histories != null) {
		for (UserHistory history : histories) {
	%>
	<tr  style="background-color: white;">
		<td height=25px><a target="toPost"
			href="/admin/productInfo?product_id=<%=history.getProduct_id()%>"><%=history.getProduct_id()%></a></td>
		<td><%=history.getProduct_name() %></td>
		<td><%=sdf1.format(history.getHistory_time())%></td>
	</tr>
	<%
	}
	}
	%>
</table>