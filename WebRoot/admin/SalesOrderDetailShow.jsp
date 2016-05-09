<%@page import="com.qxy.entity.SalesItem"%>
<%@page import="com.qxy.manager.OrderManager"%>
<%@page import="com.qxy.entity.SalesOrder"%>
<%@ include file="_sessionCheck.jsp"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	SalesOrder so = OrderManager.getInstance().loadById(id);
	List<SalesItem> items = OrderManager.getInstance().getSalesItem(so);
	
%>
<html>
<head>
</head>
<body>
	<div align="center">下单人:<%=so.getUser().getUsername() %></div>
	<div align="center">
	<table border="1" >
		<tr >
			<td>商品ID</td>
			<td>商品名称</td>
			<td>商品单价</td>
			<td>购买数量</td>
		</tr>
		
			<%
				for(int i=0;i<items.size();i++){
					SalesItem item = items.get(i);
				
			%>
			<tr>
				<td><%=item.getP().getId() %></td>
				<td><%=item.getP().getName() %></td>
				<td><%=item.getUnitprice() %></td>
				<td><%=item.getPcount() %></td>
			</tr>
			<%
				}
			%>
	
	
	</table>
	</div>
</body>
</html>
