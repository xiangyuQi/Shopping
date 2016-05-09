<%@page import="com.qxy.manager.CategoryManager"%>
<%@page import="com.qxy.entity.Category"%>
<%@ include file="_sessionCheck.jsp" %>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	request.setCharacterEncoding("UTF-8");
   	List<Category> list = CategoryManager.getInstance().getCategories(0);
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
    <table border="1" align="center" >
    	<tr align="center">
    		<td>Id</td>
    		<td>Name</td>
    		<td>Pid</td>
    		<td>Grade</td>
    		<td>leaf</td>
    		<td>Manager</td>
    	
    	</tr>
    	<%
    		for(int i=0;i<list.size();i++){
    			Category c = list.get(i);
    			String preStr = "";
    			for(int j=1;j<c.getGrade();j++)
    					preStr+="----";
    	 %>
    	<tr>
    		<td><%=c.getId() %></td>
    		<td><%=preStr+c.getName() %></td>
    		<td><%=c.getPid() %></td>
    		<td><%=c.getGrade() %></td>
    		<td><%=c.isLeaf()==true?0:1 %></td>
    		<td>
    			<a href="admin/categoryAdd.jsp?pid=<%=c.getId()%>">add</a>
    			<a href="admin/categoryModify.jsp?id=<%=c.getId()%>">mod</a>
    			<a href="admin/categoryDel.jsp?pid=<%=c.getPid()%>&id=<%=c.getId()%>&leaf=<%=c.isLeaf()%>">del</a>
    			<%
    				if(c.isLeaf()){
    			%>
    			<a href="admin/productAdd.jsp?categoryid=<%=c.getId()%>">addProduct</a>
    			<%
    				}
    			%>
    		</td>
    	</tr>
    	 <%
    	 	}
    	 %>
    	
    </table>
  </body>
</html>
