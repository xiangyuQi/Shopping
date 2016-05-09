<%@page import="java.sql.Timestamp"%>
<%@page import="com.qxy.manager.OrderManager"%>
<%@page import="com.qxy.entity.SalesOrder"%>
<%@page import="com.qxy.entity.User"%>
<%@page import="com.qxy.entity.CartItem"%>
<%@page import="com.qxy.entity.Cart"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String action =request.getParameter("action");
	User u = (User)session.getAttribute("user");
	if(u==null){
		u= new User();
		u.setId(-1);
	}

 %>

<%
	//request.setCharacterEncoding("UTF-8");
	String addr = new String(request.getParameter("addr").getBytes("ISO-8859-1"), "UTF-8");
	SalesOrder so = new SalesOrder();
	Cart cart= (Cart)session.getAttribute("cart");
	so.setUser(u);
	so.setCart(cart);
	so.setAddr(addr);
	so.setOdate(new Timestamp(System.currentTimeMillis()));
	so.setStatus(0);
	OrderManager.getInstance().save(so);
	session.removeAttribute("cart");
 %>
<!DOCTYPE HTML>
<html>
<head>
<title>Wishlist</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Fashionpress Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- Custom Theme files -->
<link href="css/style.css" rel='stylesheet' type='text/css' />
<!-- Custom Theme files -->
<!--webfont-->
<!--<link href='http://fonts.useso.com/css?family=Lato:100,200,300,400,500,600,700,800,900' rel='stylesheet' type='text/css'>-->
<script type="text/javascript" src="script/jquery-1.11.1.min.js"></script>

<!-- //for-mobile-apps -->
<link href="css/style1.css" rel="stylesheet" type="text/css" media="all" />
<!--<link href='//fonts.googleapis.com/css?family=Signika:400,300,600,700' rel='stylesheet' type='text/css'> -->

</head>
<body>
<div class="header">
	<div class="header_top">
		<div class="container">
			<div class="logo">
				<a href="index.html"><img src="images/logo.png" alt=""/></a>
			</div>
			<ul class="shopping_grid">
			      <a href="register.jsp"><li>Join</li></a>
			      <a href="login.jsp"><li>Sign In</li></a>
			      <a href="#"><li><span class="m_1">Shopping Bag</span>&nbsp;&nbsp;(0) &nbsp;<img src="images/bag.png" alt=""/></li></a>
			      <div class="clearfix"> </div>
			</ul>
		    <div class="clearfix"> </div>
		</div>
	</div>
	<div class="h_menu4"><!-- start h_menu4 -->
		<div class="container">
				<a class="toggleMenu" href="#">Menu</a>
				<ul class="nav">
					<li><a href="index.jsp" data-hover="Home">Home</a></li>
					<li><a href="about.html" data-hover="About Us">About Us</a></li>
					<li><a href="careers.html" data-hover="Careers">Careers</a></li>
					<li><a href="contact.html" data-hover="Contact Us">Contact Us</a></li>
					<li><a href="404.html" data-hover="Company Profile">Company Profile</a></li>
					<li><a href="register.jsp" data-hover="Company Registration">Company Registration</a></li>
					<li class="active"><a href="wishlist.html" data-hover="Wish List">Wish List</a></li>
				 </ul>
				 <script type="text/javascript" src="script/nav.js"></script>
	      </div><!-- end h_menu4 -->
     </div>
</div>
<div class="column_center">
  <div class="container">
	<div class="search">
	  <div class="stay">Search Product</div>
	  <div class="stay_right">
		  <input type="text" value="" onfocus="this.value = '';" onblur="if (this.value == '') {this.value = '';}">
		  <input type="submit" value="">
	  </div>
	  <div class="clearfix"> </div>
	</div>
    <div class="clearfix"> </div>
  </div>
</div>
<div class="about">
    <div class="container">
         <div class="register">
		  	  <div class="main">
				您已下单成功！<a href="index.jsp">点击连接回到首页继续购物</a>
			
			</div>
		  	  
		  	  
		 </div>
	</div>
</div>
<div class="footer_bg">
</div>
<div class="footer">
	<div class="container">
		<div class="col-md-3 f_grid1">
			<h3>About</h3>
			<a href="#"><img src="images/logo.png" alt=""/></a>
			<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,</p>
		</div>
		<div class="col-md-3 f_grid1 f_grid2">
			<h3>Follow Us</h3>
			<ul class="social">
				<li><a href=""> <i class="fb"> </i><p class="m_3">Facebook</p><div class="clearfix"> </div></a></li>
			    <li><a href=""><i class="tw"> </i><p class="m_3">Twittter</p><div class="clearfix"> </div></a></li>
				<li><a href=""><i class="google"> </i><p class="m_3">Google</p><div class="clearfix"> </div></a></li>
				<li><a href=""><i class="instagram"> </i><p class="m_3">Instagram</p><div class="clearfix"> </div></a></li>
			</ul>
		</div>
		<div class="col-md-6 f_grid3">
			<h3>Contact Info</h3>
			<ul class="list">
				<li><p>Phone : 1.800.254.5487</p></li>
				<li><p>Fax : 1.800.254.2548</p></li>
				<li><p>Email : <a href="mailto:info(at)fashionpress.com"> info(at)fashionpress.com</a></p></li>
			</ul>
			<ul class="list1">
				<li><p>Aliquam augue a bibendum ipsum diam, semper porttitor libero elit egestas gravida, ut quam, nunc taciti</p></li>
			</ul>
			<div class="clearfix"> </div>
		</div>
	</div>
</div>
<div class="footer_bottom">
       	<div class="container">
       		<div class="cssmenu">
				<ul>
					<li class="active"><a href="login.html">Privacy Policy</a></li> .
					<li><a href="checkout.html">Terms of Service</a></li> .
					<li><a href="checkout.html">Creative Rights Policy</a></li> .
					<li><a href="login.html">Contact Us</a></li> .
					<li><a href="register.html">Support & FAQ</a></li>
				</ul>
			</div>
			<div class="copy">
			    <p>Copyright &copy; 2015.Company name All rights reserved.<a target="_blank" href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a></p>
		    </div>
		    <div class="clearfix"> </div>
       	</div>
</div>
<div style="display:none"><script src='http://v7.cnzz.com/stat.php?id=155540&web_id=155540' language='JavaScript' charset='gb2312'></script></div>
</body>
</html>		