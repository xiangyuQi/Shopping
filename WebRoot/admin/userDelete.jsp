<%@page import="com.qxy.manager.UserManager"%>
<%@ include file="_sessionCheck.jsp" %>
<%@page import="com.qxy.entity.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	int id = Integer.parseInt(request.getParameter("id"));
  	//UserDAO.delete(id);
  	UserManager.getInstance().delete(id);
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

  </head>
  
  <body>
  <script language="javascript">

  		alert("删除成功!!");
  		parent.main.document.location.reload();
  </script>
 

  </body>
</html>
