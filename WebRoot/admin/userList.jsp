<%@page import="com.qxy.manager.UserManager"%>
<%@ include file="_sessionCheck.jsp" %>
<%@page import="com.qxy.entity.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	request.setCharacterEncoding("UTF-8");
   	//List<User> list = UserDAO.getUsers();
   	final int PAGE_SIZE = 5;
   	int pageNo = 1;
   	try{
   		pageNo = Integer.parseInt(request.getParameter("pageno"));
   	}catch(NumberFormatException e){
   		pageNo = 1;
   	}
   	if(pageNo<1){
   		pageNo = 1;
   	}
	List<User> list = new ArrayList<User>();
   	int pageCnt =  UserManager.getInstance().getUsers(list, pageNo, PAGE_SIZE);
   	if(pageNo>pageCnt) pageNo = pageCnt;
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
    		<td>用户ID</td>
    		<td>用户名</td>
    		<td>电话</td>
    		<td>送货地址</td>
    		<td>注册时间</td>
    		<td>管理</td>
    	</tr>
    	<%
    		for(int i=0;i<list.size();i++){
    			User u = list.get(i);
    	 %>
    	<tr>
    		<td><%=u.getId() %></td>
    		<td><%=u.getUsername() %></td>
    		<td><%=u.getPhone() %></td>
    		<td><%=u.getAddr() %></td>
    		<td><%=u.getRdate() %></td>
    		<td>
    
    			<a href="admin/userDelete.jsp?id=<%=u.getId()%>" target="detail" >删除 </a>
    		</td>
    	</tr>
    	 <%
    	 	}
    	 %>
    </table>
    <center >
    		<form name="form2">
    			共<%=pageCnt %>页 当前第
    			<select name="pageno" onchange="document.form2.submit()">
    				<%
    					for(int i=1;i<=pageCnt;i++){
    				%>
    					<option value="<%=i%>" <%=pageNo==i?"selected":"" %>><%=i %></option>
    				<%
    					}
    				%>
    			</select>
    			页
    		</form>
    	<div>
    		<a href = "admin/userList.jsp?pageno=<%=pageNo-1%>">上一页</a>
    		<a href = "admin/userList.jsp?pageno=<%=pageNo+1%>">下一页</a>
    	</div>
    	
    </center>
  </body>
</html>
