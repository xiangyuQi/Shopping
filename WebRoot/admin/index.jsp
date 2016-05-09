<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="_sessionCheck.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>管理中心</title>
<meta http-equiv=Content-Type content=text/html;charset=UTF-8>
</head>
<frameset rows="64,*"  frameborder="NO" border="0" framespacing="0">
	<frame src="admin_top.html" noresize="noresize" frameborder="NO" name="topFrame" scrolling="no" marginwidth="0" marginheight="0" target="main" />

  <frameset cols="200,*"  rows="560,*" id="frame">
    <frame src="left.html" name="leftFrame" noresize="noresize" marginwidth="100" marginheight="0" frameborder="0" scrolling="no" target="main" />
	<frameset rows="*">
		<frame src="right.html" name="main" marginwidth="0" marginheight="0" frameborder="0" scrolling="YES" target="_self" />
	
	</frameset>
	<frame src="" name="detail" marginwidth="0" marginheight="auto" frameborder="0" scrolling="YES"  />
  </frameset>

 </frameset>
<noframes>
  <body></body>
    </noframes>
</html>
