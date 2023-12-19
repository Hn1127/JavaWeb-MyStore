<%@page import="com.pers.MyStore.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>


<div>
	<%
	User user = (User) request.getAttribute("userAdmin");
	%>
	<table class="userInfo"
		style="margin: auto; border-collapse: separate; border-spacing: 10px 15px;">
		<tr>
			<td style="text-align: right">用户名:</td>
			<td style="text-align: left"><span><%=user.getUsername()%></span>
			</td>
		</tr>
		<tr>
			<td style="text-align: right">昵称:</td>
			<td style="text-align: left"><span><%=user.getNickname()%></span>
		</tr>
		<tr>
			<td style="text-align: right">邮箱:</td>
			<td style="text-align: left"><span><%=user.getEmail()%></span></td>
		</tr>
		<tr>
			<td style="text-align: right">注册时间:</td>
			<td style="text-align: left"><span><%=user.getDate()%></span></td>
		</tr>
	</table>
</div>