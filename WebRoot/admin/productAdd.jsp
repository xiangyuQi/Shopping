<%@page import="com.qxy.manager.CategoryManager"%>
<%@page import="com.qxy.manager.ProductManager"%>
<%@ page import="com.qxy.entity.*" %>
<%@ include file="_sessionCheck.jsp" %>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<%
	boolean t = false ;
	request.setCharacterEncoding("UTF-8");
	int categoryId ;
	try {
		categoryId =  Integer.parseInt(request.getParameter("categoryid"));
	}catch(NumberFormatException e){
		categoryId  = 0;
	}
	List<Category> categorys = CategoryManager.getInstance().getCategories(0);
	String action = request.getParameter("action");
	if(action!=null &&action.equals("add")){
		
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		double normalPrice = Double.parseDouble(request.getParameter("normalprice"));
		double memberPrice = Double.parseDouble(request.getParameter("memberprice"));
		
		Product p = new Product();
		p.setName(name);
		p.setDescr(descr);
		p.setMemberPrice(memberPrice);
		p.setNormalPrice(normalPrice);
		p.setCategoryId(categoryId);
		p.setPdate(new Date());
		
		ProductManager.getInstance().addProduct(p);
		t = true;
	}
	%>
	
 	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   
    <title>添加产品</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<%
		if(t){
		
	 %>
	 <script language="javascript">

  		alert("添加成功!!");
  		//parent.main.document.location.reload();
  		window.parent.frames["main"].location.href="admin/productList.jsp";
  	</script>
	
	<%
	
		}	
	 %>
<script type="text/javascript">
	var arrLeaf = new Array();
	function checkdate(){
		if(arrLeaf[document.form.categoryid.selectedIndex] != "leaf"){
			alert("不能选择非叶子节点");
			document.form.categoryid.focus();
			return false;
		}
		return true;
	}

</script>	 
  </head>
  
  <body>
  	<center>
  		<h3>添加产品</h3>
		<form action="admin/productAdd.jsp" method="post" name="form" onsubmit=" return checkdate()">
			<input type="hidden" name ="action" value="add"/>

		  	<table border="1">
			<tr>
				<td>产品名称:</td>
				<td><input type="text" name="name" /></td>
			
			</tr>
			<tr>
				<td>产品描述:</td>
				<td><textarea rows="10" cols="50" name="descr"></textarea></td>
			</tr>
			<tr>
				<td>categoryId:</td>
				<td><select name="categoryid">
				<%
					Category c = null;
					int index = 0;
					for(Iterator<Category> it = categorys.iterator();it.hasNext();){
						c = it.next();
						String pre = "";
					for(int i=1;i<c.getGrade();i++)
						pre+="----";
				 %>
				 	<script type="text/javascript">
				 		arrLeaf[<%=index%>] = '<%=c.isLeaf() ? "leaf":"nolearf" %>';
				 	</script>
				 	<option value="<%=c.getId()%>" <%=c.getId()==categoryId?"selected":"" %> ><%=pre+c.getName() %></option>
				 <%
					index++;}
				 %>
				</select></td>
	
			</tr>	
			<tr>
				<td>normalPrice:</td>
				<td><input type="text" name="normalprice" /></td>
			
			</tr>
			<tr>
				<td>memberPrice:</td>
				<td><input type="text" name="memberprice" /></td>
			
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
