<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.qxy.manager.CategoryManager"%>
<%@page import="com.qxy.manager.ProductManager"%>
<%@ page import="com.qxy.entity.*"%>
<%@ include file="_sessionCheck.jsp"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
%>
<%
	//request.setCharacterEncoding("UTF-8");
	final int PAGE_SIZE = 5;
	int pageNo = 1;
	String pageNoStr = request.getParameter("pageno");
	if(pageNoStr!=null && !pageNoStr.trim().equals(""))
		pageNo = Integer.parseInt(pageNoStr);
	if(pageNo<1) pageNo = 1;
	List<Category> categorys = CategoryManager.getInstance().getCategories(0);
	List<Product> products = new ArrayList<Product>();
	String action = request.getParameter("action");
	String keyword = "";
	int categoryId =0;
	double lowNormalPrice = -1;
	double highNormalPrice = -1;
	double lowMemberPrice =-1;
	double highMemberPrice =-1;
	Date startDate = null;
	Date endDate = null;
	String endDateStr = "";
	String startDateStr = "";
	int pagCnt = 0;
	boolean isSerach = false;
%>
<%
	// 复杂搜索
	if (action != null && action.equals("complexserach")) {

		keyword = new String(request.getParameter("keyword").getBytes("ISO-8859-1"), "UTF-8");
		categoryId = Integer.parseInt(request
		.getParameter("categoryid"));
		int[] ids ;
		if (categoryId != 0){
	ids = new int[1];
	ids[0]=categoryId;
		}else {
	ids = null;
		}
	
		lowNormalPrice = Double.parseDouble(request
		.getParameter("lownormalprice"));
		highNormalPrice = Double.parseDouble(request
		.getParameter("highnormalprice"));
	    lowMemberPrice = Double.parseDouble(request
		.getParameter("lowmemberprice"));
	    highMemberPrice = Double.parseDouble(request
		.getParameter("highmemberprice"));
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if (request.getParameter("startdate") !=null && !request.getParameter("startdate").trim().equals("")){
	startDateStr=request.getParameter("startdate");
	startDate =  sf.parse(startDateStr);
		}
		if (request.getParameter("enddate") !=null && !request.getParameter("enddate").trim().equals("")){
	endDateStr = request.getParameter("enddate");
	endDate = sf.parse(endDateStr);
		} 
		pagCnt = ProductManager.getInstance().findProducts(products,
	ids, keyword,lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, 
	startDate, endDate, pageNo, PAGE_SIZE);
		if(pageNo>pagCnt) pageNo = pagCnt;
		isSerach = true;
  }
//System.out.println(products.size());
// 简单搜索
	if (action != null && action.equals("simpleserach")) {

	    keyword = new String(request.getParameter("keyword").getBytes("ISO-8859-1"), "UTF-8");
	   // out.println(keyword);
		categoryId = Integer.parseInt(request
		.getParameter("categoryid"));
		int[] ids ;
		if (categoryId != 0){
	ids = new int[1];
	ids[0]=categoryId;
		}else {
	ids = null;
		}
		pagCnt = ProductManager.getInstance().findProducts(products,
	ids, keyword,lowNormalPrice, highNormalPrice, lowMemberPrice, highMemberPrice, 
	startDate, endDate, pageNo, PAGE_SIZE);
		if(pageNo>pagCnt) pageNo = pagCnt;
		isSerach = true;
  }
//System.out.println(products.size());

//简单搜索2
%>
<%
	if(isSerach){
%>
<center>
	<h3>搜索结果</h3>
	<table border="1" align="center">
		<tr align="center">
			<td>ID</td>
			<td>Name</td>
			<td>Descr</td>
			<td>category</td>
			<td>normalPrice</td>
			<td>memberPrice</td>
			<td>manager</td>

		</tr>
		<%
			for (int i = 0; i < products.size(); i++) {
				Product p = products.get(i);
				Category c = CategoryManager.getInstance().loadById(p.getCategoryId());
		%>
		<tr>
			<td><%=p.getId()%></td>
			<td><%=p.getDescr()%></td>
			<td><%=p.getName()%></td>
			<td><%=c.getName()%></td>
			<td><%=p.getNormalPrice()%></td>
			<td><%=p.getMemberPrice()%></td>
			<td>
				<!--  <a href="admin/productAdd.jsp">add</a>--> <a
				href="productModify.jsp?id=<%=p.getId()%>">mod</a> <a
				href="productDel.jsp?id=<%=p.getId()%>">del</a>
			</td>
		</tr>
		<%
			}
		%>
	</table>
	<div>
		共<%=pagCnt%>页 &nbsp; 当前第<%=pageNo%>页
	</div>
	<a
		href="productSearch.jsp?action=<%=action%>&pageno=<%=pageNo-1%>&categoryid=<%=categoryId%>&keyword=<%=keyword%>
		&lownormalprice=<%=lowNormalPrice%>&highnormalprice=<%=highNormalPrice%>
		&lowmemberprice=<%=lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>
		&startdate=<%=startDateStr%>&enddate=<%=endDateStr%>">上一页</a>
	<a
		href="productSearch.jsp?action=<%=action%>&pageno=<%=pageNo+1%>&categoryid=<%=categoryId%>&keyword=<%=keyword%>
		&lownormalprice=<%=lowNormalPrice%>&highnormalprice=<%=highNormalPrice%>
		&lowmemberprice=<%=lowMemberPrice%>&highmemberprice=<%=highMemberPrice%>
		&startdate=<%=startDateStr%>&enddate=<%=endDateStr%>">下一页</a>
</center>
<%
	return ;}
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>添加产品</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
	function cheackdata() {
		with (document.forms["complex"]) {
			if (lownormalprice.value == null || lownormalprice.value == "") {
				lownormalprice.value = -1;
			}
			if (highnormalprice.value == null || highnormalprice.value == "") {
				highnormalprice.value = -1;
			}
			if (lowmemberprice.value == null || lowmemberprice.value == "") {
				lowmemberprice.value = -1;
			}
			if (highmemberprice.value == null || highmemberprice.value == "") {
				highmemberprice.value = -1;
			}
		}

	}
</script>

</head>

<body>
	<center>
		<h3>simpleSerach</h3>
		<form action="admin/productSearch.jsp" method="post"">
			<input type="hidden" name="action" value="simpleserach" />
			<table>
				<tr>
					<td>category:</td>
					<td><select name="categoryid">
							<option value="0" selected="selected">所有类别</option>
							<%
								for (Iterator<Category> it = categorys.iterator(); it.hasNext();) {
									Category c = it.next();
									String pre = "";
									for (int i = 1; i < c.getGrade(); i++)
										pre += "--";
							%>
							<option value="<%=c.getId()%>"><%=pre + c.getName()%></option>
							<%
								}
							%>
					</select></td>
				</tr>
				<tr>
					<td>keyword:</td>
					<td><input type="text" name="keyword" /></td>
			</table>
			<input type="submit" value="search" />
		</form>
		<br />
		<h3>complexSerach</h3>
		<form action="admin/productSearch.jsp" name="complex" method="post"
			onsubmit="cheackdata()">
			<input type="hidden" name="action" value="complexserach" />
			<table>
				<tr>
					<td>category:</td>
					<td><select name="categoryid">
							<option value="0" selected="selected">所有类别</option>
							<%
								for (Iterator<Category> it = categorys.iterator(); it.hasNext();) {
									Category c = it.next();
									String pre = "";
									for (int i = 1; i < c.getGrade(); i++)
										pre += "--";
							%>
							<option value="<%=c.getId()%>"><%=pre + c.getName()%></option>
							<%
								}
							%>
					</select></td>
				</tr>
				<tr>
					<td>keyword:</td>
					<td><input type="text" name="keyword" /></td>
				</tr>
				<tr>
					<td>normalPrice:</td>
					<td>from:<input type="text" size="5" name="lownormalprice" />
						to:<input type="text" size="5" name="highnormalprice" /></td>
				</tr>
				<tr>
					<td>memberPrice:</td>
					<td>from:<input type="text" size="5" name="lowmemberprice" />
						to:<input type="text" size="5" name="highmemberprice" /></td>
				</tr>
				<tr>
					<td>pdate:</td>
					<td>from:<input type="text" size="5" name="startdate" /> to:<input
						type="text" size="5" name="enddate" /></td>
				</tr>
			</table>
			<input type="submit" value="search" />
		</form>

	</center>

</body>
</html>
