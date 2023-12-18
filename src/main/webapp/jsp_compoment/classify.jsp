<%@page import="com.pers.MyStore.entity.ProductType"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!-- 分类栏 -->
<div class="main"
	style="height: 2.5%; width: 1200px; margin: auto; border-bottom: solid;font-size:120%;">
	<table align=center width="100%" border=0>
		<tr style="height:25px">
			<td id="index"><a href="/">首页</a></td>
			<td id="all"><a href="/show?showAll=1">全部</a></td>
			<%
			// 循环打印商品分类项
			List<ProductType> productTypes = (List<ProductType>) request.getAttribute("productTypes");
			if (productTypes != null) {
				for (int i = 1; i < productTypes.size(); ++i) {
					ProductType productType = productTypes.get(i);
			%>
			<td id="<%=productType.getProduct_type() %>"><a href="/show?type=<%=productType.getProduct_type() %>"><%=productType.getReal_type() %></a></td>
			<%
			}
			}
			%>
		</tr>
	</table>
</div>
<br>

