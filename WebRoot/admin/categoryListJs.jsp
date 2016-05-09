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
	<script type="text/javascript" src="admin/js/TV20.js"></script>
	<script type="text/javascript">
		function f(key,parentkey){
			
			document.forms["form"].pid.value = key;
		}
		function modify(key,parentkey){
			window.parent.frames["main"].location.href="categoryModify.jsp?id="+key;
		}
	
	</script>
  </head>
  
  <body>
    	
    	<center>
    	<form action="admin/categoryAdd.jsp" name="form">
    		<input type="hidden" name="action" value="add">
    		<table align="center" border="1">
    			<tr >
    				<td id="show" colspan="2" ></td>
    			</tr>
    			<tr>
    				<td>Pid</td>
    				<td><input type="text"  name="pid" readonly="readonly" value=""/></td>
    				
    			</tr>
    			<tr>
    				<td>类别名称</td>
    				<td><input type="text" name="name"></td>
    			</tr>
    			
    			<tr>
    				<td>类别描述</td>
    				<td><textarea cols="50" rows="10" name="descr"></textarea></td>
    			</tr>
    			<tr>
    				
    				<td align="center" colspan="2"><input type="submit" value="提交"/></td>
    			</tr>
    		</table>
    	
    	
    	</form>	
    	
    	
    	</center>
    	
   	<script type="text/javascript">
   		addNode(-1,0,"所有类别","admin/images/top.gif");
   		<%
   			for(Iterator<Category> it = list.iterator();it.hasNext();){
   				Category c = it.next();
   			
   				
   		%>
   		
   		addNode(<%=c.getPid() %>,<%=c.getId()%>,"<%=c.getName()%>","admin/images/top.gif");
   		<%
   			}
   		%>
   		showTV();
   		addListener("click","f");
   		addListener("dblclick","modify");
   	</script>
  </body>
</html>
