<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 首页搜索栏 -->
<div class="main" style="height: 15%; width:100%;margin:auto;">
	<br>
	<table border="0" align="center" style="width:60%">
		<tr>
			<!-- logo图片，点击将会转到首页 -->
			<td style="text-align: left;"><a href="index"> <img
					src="images/logo.png" width="117" height="117" border="0" />
			</a></td>
			<td style="text-align: right;">
				<form action="/search" method="get">
					<div
						style="display: flex; width: 100%; flex-direction: row-reverse;align-items:center;">
						<button type="submit" class=""
							style="padding: 0px 10px; background-color: red;height:35px;cursor: pointer;color: white;" >搜索</button>
						<input type="text" name="searchCondition"
							style="width: 250px; height: 30px;" placeholder="搜索...">
						<span style="font-size:120%;">search&nbsp;</span>
					</div>
				</form>
			</td>
		</tr>
	</table>
</div>