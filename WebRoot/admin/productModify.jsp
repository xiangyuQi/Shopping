<%@page import="com.qxy.manager.CategoryManager"%>
<%@page import="com.qxy.entity.Category"%>
<%@page import="com.qxy.manager.ProductManager"%>
<%@page import="com.qxy.entity.Product"%>
<%@ include file="_sessionCheck.jsp" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	boolean t = false;
	request.setCharacterEncoding("UTF-8");
	String idStr = request.getParameter("id");
	int id  = Integer.parseInt(idStr);
	Product p = ProductManager.getInstance().loadById(id);
	String action = request.getParameter("action");
	if(action !=null && action.equals("modify")){
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		int categoryId = Integer.parseInt(request.getParameter("categoryid"));
		Category c = CategoryManager.getInstance().loadById(categoryId);
		if(!c.isLeaf()){
%>
		<script type="text/javascript">
			alert("非叶子节点不能添加商品");
			window.parent.frames["main"].location.href="productModify.jsp?id=<%=id%>";
		</script>
		
<%		
		//response.sendRedirect("productModify.jsp?id="+id);
		return ;
		}
%>
<% 
		double normalPrice= Double.parseDouble(request.getParameter("normalprice"));
		double memberPrice= Double.parseDouble(request.getParameter("memberprice"));
		p.setName(name);
		p.setDescr(descr);
		p.setCategoryId(categoryId);
		p.setNormalPrice(normalPrice);
		p.setMemberPrice(memberPrice);
		t = ProductManager.getInstance().updateProduct(p);
	}
%>

 	
 	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   
    <title>productModify</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<% if(t) {%>
	<script language="javascript">

  		alert("修改成功!!<%=id%>");
  		//parent.main.document.location.reload();
  		window.parent.frames["main"].location.href="admin/productList.jsp";
  	</script>
  	<%  }%>
  </head>
  
  <body>
  	<center>
  		<h3>修改产品</h3>
		<form action="admin/productModify.jsp" method="post" >
			<input type="hidden" name ="action" value="modify"/>
			<input type="hidden" name ="id" value="<%=id%>"/>
		  	<table border="1">
			<tr>
				<td>产品名称:</td>
				<td><input type="text" name="name" value="<%=p.getName()%>"/></td>
			
			</tr>
			<tr>
				<td>产品描述:</td>
				<td><textarea rows="10" cols="50" name="descr"><%=p.getDescr() %></textarea></td>
			</tr>
			<tr>
				<td>categoryId:</td>
				<td>
					<select name="categoryid">
			<%
					String pre;
					List<Category> categories = CategoryManager.getInstance().getCategories(0);
					for(int i=0;i<categories.size();i++){
						Category c = categories.get(i);
						pre = "";
						for(int j = 1;j<c.getGrade();j++)
							pre += "--";
			 %>
			 		<option value="<%=c.getId()%>" 
			 			<%=p.getC().getId()==c.getId()?"selected":"" %>><%=pre+c.getName()%></option>
			<%
					}
			 %>		
					</select>
				
				</td>
			
			</tr>	
			<tr>
				<td>normalPrice:</td>
				<td><input type="text" name="normalprice" value="<%=p.getNormalPrice()%>"/></td>
			
			</tr>
			<tr>
				<td>memberPrice:</td>
				<td><input type="text" name="memberprice" value="<%=p.getMemberPrice()%>"/></td>
			
			</tr>		
			<tr >
				<td colspan="2" align="center">
					<input type="submit" value="提交"/>
				</td>
			</tr>
			</table>
			

		</form>
 </center>

  </body>
</html>
