<%@page import="com.qxy.manager.CategoryManager"%>
<%@page import="com.qxy.entity.Category"%>
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
	Category c = CategoryManager.getInstance().loadById(id);
	String action = request.getParameter("action");
	if(action !=null && action.equals("modify")){
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		c.setName(name);
		c.setDescr(descr);
		CategoryManager.getInstance().update(c);
		t = true;
	}
%>

 	
 	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   
    <title>My JSP 'userDelete.jsp' starting page</title>
    
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

  		alert("修改成功!!");
  		//parent.main.document.location.reload();
  		window.parent.frames["main"].location.href="admin/categoryList.jsp";
  	</script>
  	<%  }%>
  </head>
  
  <body>
  	<center>
  		<h3>修改类别</h3>
		<form action="admin/categoryModify.jsp" method="post" >
			<input type="hidden" name ="action" value="modify"/>
			<input type="hidden" name ="id" value="<%=id%>"/>
		  	<table border="1">
			<tr>
				<td>类别名称:</td>
				<td><input type="text" name="name" value="<%=c.getName() %>"></td>
			
			</tr>
			<tr>
				<td>类别描述:</td>
				<td><textarea rows="10" cols="50" name="descr" ><%=c.getDescr()%></textarea></td>
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
