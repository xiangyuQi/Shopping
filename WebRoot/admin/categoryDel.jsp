<%@page import="com.qxy.manager.CategoryManager"%>
<%@ include file="_sessionCheck.jsp" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	request.setCharacterEncoding("UTF-8");
	boolean t = false;
	int id = Integer.parseInt(request.getParameter("id"));
	int pid= Integer.parseInt(request.getParameter("pid"));
	boolean leaf = Boolean.parseBoolean(request.getParameter("leaf"));
	if(CategoryManager.getInstance().delete(id, leaf,pid)){
		t = true;
	}
		
%>

 	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   
    <title>delete</title>
    
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

  		alert("删除成功!!");
  		//parent.main.document.location.reload();
  		window.parent.frames["main"].location.href="admin/categoryList.jsp";
  	</script>
	<% } %>
  </head>
  
  <body>
  

  </body>
</html>
