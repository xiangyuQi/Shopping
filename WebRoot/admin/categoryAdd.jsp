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
	String pidStr = request.getParameter("pid");
	int pid = 0;
	if(pidStr ==null || pidStr.trim().equals(""))
		pid = 0 ;
	else pid = Integer.parseInt(pidStr);
	String action = request.getParameter("action");
	if(action!=null &&action.equals("add")){
		
		String name = request.getParameter("name");
		String descr = request.getParameter("descr");
		//System.out.println(name+" "+descr);
		if (pid ==0 )
			CategoryManager.getInstance().addTopCategory(name, descr);
		else {
			CategoryManager.getInstance().addChildCategory(pid,name,descr);
		}
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
	<%
		if(t){
	 %>
	 
	 	<script language="javascript">

  		alert("添加成功!!");
  		//parent.main.document.location.reload();
  		window.parent.frames["main"].location.href="admin/categoryList.jsp";
  	</script>
	<%
		}
	 %>

 	
  </head>
  
  <body>
  	<center>
  		<a href="www.baidu.com" target="detail">跳转</a>
  		<h3>添加<%=pid==0?"根":"子" %>类别</h3>
		<form action="admin/categoryAdd.jsp" method="post" >
			<input type="hidden" name ="action" value="add"/>
			<input type="hidden" name ="pid" value="<%=pid%>"/>
		  	<table border="1">
			<tr>
				<td>类别名称:</td>
				<td><input type="text" name="name" /></td>
			
			</tr>
			<tr>
				<td>类别描述:</td>
				<td><textarea rows="10" cols="50" name="descr"></textarea></td>
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
