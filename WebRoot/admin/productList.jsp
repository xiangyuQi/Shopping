<%@page import="com.qxy.manager.CategoryManager"%>
<%@page import="com.qxy.entity.Category"%>
<%@page import="com.qxy.manager.ProductManager"%>
<%@page import="com.qxy.entity.Product"%>
<%@ include file="_sessionCheck.jsp"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	final int PAGE_SIZE = 5;
%>
<%
	request.setCharacterEncoding("UTF-8");
	int pageNo = 1;
	try {
		pageNo = Integer.parseInt(request.getParameter("pageno"));
	} catch (NumberFormatException e) {
		pageNo = 1;
	}
	List<Product> list = new ArrayList<Product>();
	int maxNumberOfPage = ProductManager.getInstance().getProducts(list, pageNo, PAGE_SIZE);
	if (pageNo < 1)
			pageNo = 1;
	if (pageNo > maxNumberOfPage)
		pageNo = maxNumberOfPage;
	//System.out.println(list.size());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>用户列表</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->


</head>

<body>
	<center>
	<table border="1" >
		<tr align="center">
			<td>ID</td>
			<td>Name</td>
			<td>Descr</td>
			<td>categoryId</td>
			<td>normalPrice</td>
			<td>memberPrice</td>
			<td>pdate</td>
			<td>manager</td>

		</tr>
		<%
			//Category c = null;
			for (int i = 0; i < list.size(); i++) {
				Product p = list.get(i);
				//c =  CategoryManager.getInstance().loadById(p.getCategoryId());
			
		%>
		<tr>
			<td><%=p.getId()%></td>
			<td><%=p.getName()%></td>
			<td><%=p.getDescr()%></td>
			<td><%=p.getC().getName()%></td>
			<td><%=p.getNormalPrice()%></td>
			<td><%=p.getMemberPrice()%></td>
			<td><%=p.getPdate()%></td>
			<td>
				<!--  <a href="admin/productAdd.jsp">add</a>--> <a
				href="admin/productModify.jsp?id=<%=p.getId()%>">mod</a> <a
				href="admin/productDel.jsp?id=<%=p.getId()%>">del</a>
				<a href="admin/productUpload.jsp?id=<%=p.getId()%>">uploadImg</a></td>
		</tr>
		<%
			}
		%>

	</table>
	<form name="form2" >
		当前第
		<select name="pageno" onchange="document.form2.submit()" >
			<%
				for(int i=1;i<=maxNumberOfPage;i++){
			%>
					<option value="<%=i%>" <%=pageNo==i?"selected":""%>><%=i%></option>
			<%
				}
			%>
		</select>
		页 &nbsp;共<%=maxNumberOfPage %>页
	</form>
	<div >
		<a href="admin/productList.jsp?pageno=1>">首页</a>
		<a href="admin/productList.jsp?pageno=<%=pageNo - 1%>">上一页</a> 
		<a href="admin/productList.jsp?pageno=<%=pageNo + 1%>">下一页</a> 
		<a href="admin/productList.jsp?pageno=<%=maxNumberOfPage%>">尾页</a>
	</div>

</center>
</body>
</html>
