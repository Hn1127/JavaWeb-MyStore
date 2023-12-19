<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<head>
	<style type="text/css">
.mybutton {
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 100%;
	cursor: pointer;
}
</style>

</head>	

<!-- 搜索栏 start -->
<div class="main" style="height: 3%;">
	<form action="#" id="searchform">
		<table width=1200 align="center">
			<tr>
				<td style="text-align: right;"><div
						style="display: flex; width: 100%; flex-direction: row-reverse;align-items:center;">
						<button type="submit" class="mybutton"
							style="padding: 0px 10px; background-color: red;height:35px;">搜索</button>
						<input type="text" name="searchCondition"
							style="width: 250px; height: 30px;" placeholder="搜索...">
						<span style="font-size:120%;">search&nbsp;</span>
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>
<!-- 搜索栏 end -->