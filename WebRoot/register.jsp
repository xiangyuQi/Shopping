<%@page import="com.qxy.manager.UserManager"%>
<%@page import="com.qxy.entity.*"%>
<%@ page language="java" import="java.util.*,com.qxy.entity.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<%
	request.setCharacterEncoding("UTF-8");
	String action = request.getParameter("action");
	if (action != null && action.trim().equals("register")) {
		String username = request.getParameter("username");
		//后台应当也做验证
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String addr = request.getParameter("addr");
		User u = new User();
		u.setUsername(username);
		u.setPassword(password);
		u.setAddr(addr);
		u.setPhone(phone);
		u.setRdate(new Date());
		//UserDAO.save(u);
		UserManager.getInstance().add(u);
	%>
		<script	type="text/javascript">
			alert("恭喜您注册成功！");
		</script>
<%		
	response.sendRedirect("index.jsp");
	return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">

<title>MY网上商城</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="Fashionpress Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- Custom Theme files -->
<link href="css/style.css" rel='stylesheet' type='text/css' />
<!-- Custom Theme files -->
<!--webfont-->
<link
	href='http://fonts.useso.com/css?family=Lato:100,200,300,400,500,600,700,800,900'
	rel='stylesheet' type='text/css'>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<script  src="script/regcheckdata.js"></script>
</head>
<body>
	<div class="header">
		<div class="header_top">
			<div class="container">
				<div class="logo">
					<a href="index.jsp"><img src="images/logo.png" alt="" />
					</a>
				</div>
				<ul class="shopping_grid">
					<a href="register.jsp"><li>Join</li>
					</a>
					<a href="login.jsp"><li>Sign In</li>
					</a>
					<a href="#"><li><span class="m_1">Shopping Bag</span>&nbsp;&nbsp;(0)
							&nbsp;<img src="images/bag.png" alt="" />
					</li>
					</a>
					<div class="clearfix"></div>
				</ul>
				<div class="clearfix"></div>
			</div>
		</div>
		<div class="h_menu4">
			<!-- start h_menu4 -->
			<div class="container">
				<a class="toggleMenu" href="#">Menu</a>
				<ul class="nav">
					<li class="active"><a href="index.jsp" data-hover="Home">Home</a></li>
					<li><a  data-hover="About Us">About Us</a></li>
					<li><a  data-hover="Careers">Careers</a></li>
					<li><a  data-hover="Contact Us">Contact Us</a></li>
					<li><a  data-hover="Company Profile">Company Profile</a></li>
					<li><a  data-hover="Company Registration">Company Registration</a></li>
					<li><a  data-hover="Wish List">Wish List</a></li>
				 </ul>
				<script type="text/javascript" src="js/nav.js"></script>
			</div>
			<!-- end h_menu4 -->
		</div>
	</div>
	<div class="column_center">
		<div class="container">
			<div class="search">
				<div class="stay">Search Product</div>
				<div class="stay_right">
					<input type="text" value="" onfocus="this.value = '';"
						onblur="if (this.value == '') {this.value = '';}"> <input
						type="submit" value="">
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>

	<div class="about">
		<div class="container">
			<div class="register">
				<form name="form" id="from" action="register.jsp" method="post"
					onsubmit="return checkdata()">
					<input type="hidden" name="action" value="register">

					<div class="register-top-grid">
						<h3>PERSONAL INFORMATION</h3>
						<div>
							<span>User Name<label>*</label>
							</span> <input type="text" name="username">
						</div>

						<div>
							<span>Your Phone<label>*</label>
							</span> <input type="text" name="phone">
						</div>
						<div>
							<span>Your Address<label>*</label>
							</span> <input type="text" name="addr">
						</div>

						<div class="clearfix"></div>
						<a class="news-letter" href="#"> <label class="checkbox"><input
								type="checkbox" name="checkbox" checked=""><i> </i>Sign
								Up for Newsletter</label> </a>
					</div>
					<div class="register-bottom-grid">
						<h3>LOGIN INFORMATION</h3>
						<div>
							<span>Password<label>*</label>
							</span> <input type="password" name="password">
						</div>
						<div>
							<span>Confirm Password<label>*</label>
							</span> <input type="password" name="password2">
						</div>
						<div class="clearfix"></div>
					</div>
					<div class="clearfix"></div>
					<div class="register-but">
					
							<input type="submit" value="submit">
							<div class="clearfix"></div>
					
					</div>
				</form>
				
			</div>
		</div>

	</div>
	<div class="footer_bg"></div>
	<div class="footer">
		<div class="container">
			<div class="col-md-3 f_grid1">
				<h3>About</h3>
				<a href="#"><img src="images/logo.png" alt="" />
				</a>
				<p>Lorem Ipsum is simply dummy text of the printing and
					typesetting industry. Lorem Ipsum has been the industry's standard
					dummy text ever since the 1500s,</p>
			</div>
			<div class="col-md-3 f_grid1 f_grid2">
				<h3>Follow Us</h3>
				<ul class="social">
					<li><a href=""> <i class="fb"> </i>
						<p class="m_3">Facebook</p>
							<div class="clearfix"></div>
					</a>
					</li>
					<li><a href=""><i class="tw"> </i>
						<p class="m_3">Twittter</p>
							<div class="clearfix"></div>
					</a>
					</li>
					<li><a href=""><i class="google"> </i>
						<p class="m_3">Google</p>
							<div class="clearfix"></div>
					</a>
					</li>
					<li><a href=""><i class="instagram"> </i>
						<p class="m_3">Instagram</p>
							<div class="clearfix"></div>
					</a>
					</li>
				</ul>
			</div>
			<div class="col-md-6 f_grid3">
				<h3>Contact Info</h3>
				<ul class="list">
					<li><p>Phone : 1.800.254.5487</p>
					</li>
					<li><p>Fax : 1.800.254.2548</p>
					</li>
					<li><p>
							Email : <a href="mailto:info(at)fashionpress.com">
								info(at)fashionpress.com</a>
						</p>
					</li>
				</ul>
				<ul class="list1">
					<li><p>Aliquam augue a bibendum ipsum diam, semper
							porttitor libero elit egestas gravida, ut quam, nunc taciti</p>
					</li>
				</ul>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<div class="footer_bottom">
		<div class="container">
			<div class="cssmenu">
				<ul>
					<li class="active"><a href="login.html">Privacy Policy</a>
					</li> .
					<li><a href="checkout.html">Terms of Service</a>
					</li> .
					<li><a href="checkout.html">Creative Rights Policy</a>
					</li> .
					<li><a href="login.html">Contact Us</a>
					</li> .
					<li><a href="register.html">Support & FAQ</a>
					</li>
				</ul>
			</div>
			<div class="copy">
				<p>
					Copyright &copy; 2015.Company name All rights reserved.<a
						target="_blank" href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a>
				</p>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	<div style="display:none">
		<script src='http://v7.cnzz.com/stat.php?id=155540&web_id=155540'
			language='JavaScript' charset='gb2312'></script>
	</div>
</body>
</html>