<%@page import="com.qxy.entity.User"%>
<%@page import="com.qxy.entity.CartItem"%>
<%@page import="com.qxy.entity.Cart"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String action =request.getParameter("action");
	User u = (User)session.getAttribute("user");
	if(u==null &&action==null){
%>
	<script type="text/javascript">
		alert("您未登陆 将以市场价购买,免费注册为会员将享受优惠");
	</script>
<%
	}

 %>

<%
	//request.setCharacterEncoding("UTF-8");
	Cart cart= (Cart)session.getAttribute("cart");
	List<CartItem> itmes = cart.getItems();
	if(action==null){
	if(u!=null){
		for(int i=0;i<itmes.size();i++){
			CartItem it = itmes.get(i);
			it.setPrice(it.getMemberprice());
		}
	}
	}
	if(action!=null && action.trim().equals("modify")){
		for(int i=0;i<itmes.size();i++){
			CartItem it = itmes.get(i);
			String str = "p"+it.getProductid();
			int count = Integer.parseInt(request.getParameter(str));
			it.setCount(count);
		}
		%>
		<script type="text/javascript">
			alert("修改成功");
			window.location.href="cart.jsp";
		</script>
<% 
	//response.sendRedirect("cart.jsp");
	}
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
<script>$(document).ready(function(c) {
	$('.alert-close').on('click', function(c){
		$('.message').fadeOut('slow', function(c){
	  		$('.message').remove();
		});
	});	  
});
</script>
<script>$(document).ready(function(c) {
	$('.alert-close1').on('click', function(c){
		$('.message1').fadeOut('slow', function(c){
	  		$('.message1').remove();
		});
	});	  
});
</script>
<script>$(document).ready(function(c) {
	$('.alert-close2').on('click', function(c){
		$('.message2').fadeOut('slow', function(c){
	  		$('.message2').remove();
		});
	});	  
});
</script>
<script type="text/javascript">


</script>
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
					<li class="active"><a href="index.jsp" data-hover="Home">Home</a></li>
					<li><a href="#" data-hover="About Us">About Us</a></li>
					<li><a href="#" data-hover="Careers">Careers</a></li>
					<li><a href="#" data-hover="Contact Us">Contact Us</a></li>
					<li><a href="#" data-hover="Company Profile">Company Profile</a></li>
					<li><a href="#" data-hover="Company Registration">Company Registration</a></li>
					<li><a href="#" data-hover="Wish List">Wish List</a></li>
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
			<h1>Shopping Cart Widget</h1>
			<div class="main-grid1">
				<ul>
					<li><a href="#" class="car">Add To Cart</a></li>
				</ul>
			</div>
			<div class="main-grid2">
				<h2>My Shopping Bag (<%=itmes.size() %>)</h2>
				<form action="cart.jsp">
				<input type="hidden" name="action" value="modify">
				<% 
					double total = 0;
					for(int i=0;i<itmes.size();i++){
						CartItem item = itmes.get(i);
						total += item.getTotalPrice();
				 %>
			
				<div class="cart_box">
					<div class="message">
						 <div class="alert-close"> </div> 
						<div class="list_img"><img src="images/product/<%=item.getProductid()%>.jpg" class="img-responsive" alt=""/></div>
						<div class="list_desc"><h4><a href="#"><%=item.getName() %></a></h4><span class="actual">
						 $<%=item.getPrice()%></span> &nbsp; &nbsp;
						 <small>count:<input name= "p<%=item.getProductid()%>" type="text" size="4" value="<%=item.getCount() %>"></small></div>
						  <div class="clear"></div>
					</div>
				</div>
					<%} %>
				<center><input type="submit" value="Modify" style="width: 70px;height: 30px;" ></center>
				</form>
				<form action="order.jsp" method="post">
				<div align="center" >
						<p>Address :</p>
						<textarea name= "addr" cols="40" rows="5" onchange="changeAddr()"><%=u==null?"":u.getAddr() %></textarea>
				</div>
				<div class="total">
					<div class="total-left">
						<p>Total :<span> $<%=total %></span></p>
					</div>
					
					
					<div class="total-right">
						<input type="submit" value="Confirm">
					</div>
					<div class="clear"> </div>
					<div class="clear"> </div>
				</div>
				</form>
			</div>
			
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