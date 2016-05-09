package com.qxy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.qxy.entity.Category;
import com.qxy.entity.Product;
import com.qxy.util.DButil;

public class ProductMysqlDao implements ProductDao {

	/*public List<Product> getProducts() {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Product p = null;
		Category c = null;
		String sql = "select p.id , p.name , p.descr, p.normalprice, p.memberprice,p.pdate,"
				+ " c.id cid, c.name cname , c.descr cdescr, c.normalprice ,"
				+ " c.memberprice , c.pid from product p join category c on(p.categoryid= c.id )";
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt, sql);
			while (rs.next()) {
				p = new Product();
				c = new Category();
				p.initWithRs(rs);
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setGrade(rs.getInt("grade"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				p.setC(c);
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(stmt);
			DButil.close(conn);
		}

		return list;
	}*/

	public List<Product> getProducts( int categoryid , int pageNo,int pageSize) {
		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rsCount  = null;
		Product p = null;
		Category c = null;
		String sql = "select p.id , p.name , p.descr, p.normalprice, p.memberprice,p.pdate,p.categoryid,"
				+ "c.id cid, c.name cname , c.descr cdescr, c.pid ,"
				+ " c.grade , c.isleaf from product p join category c on(p.categoryid= c.id ) where p.categoryid ="+categoryid;
		
		//System.out.println(sql);
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rsCount = DButil.executQuery(stmt, "select count(*) from product where categoryid ="+categoryid);
			rsCount.next();
			int max = rsCount.getInt(1);
			if(pageSize>max) pageSize = max;
			sql += " order by p.pdate desc limit "+pageNo+","+pageSize;
			rs = DButil.executQuery(stmt, sql);
			while (rs.next()) {
				p = new Product();
				c = new Category();
				p.initWithRs(rs);
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setGrade(rs.getInt("grade"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				p.setC(c);
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(rs);
			DButil.close(rsCount);
			DButil.close(stmt);
			DButil.close(conn);
		}

		return list;
	}
	
	public List<Product> getProducts(int pagNo, int pagSize) {

		List<Product> list = new ArrayList<Product>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Product p = null;
		Category c = null;
		String sql = "select p.id , p.name , p.descr, p.normalprice, p.memberprice,p.pdate, p.categoryid ,"
				+ " c.id cid, c.name cname , c.descr cdescr, c.pid ,"
				+ " c.grade , c.isleaf  from product p join category c on(p.categoryid= c.id )"
				+ " order by p.pdate desc  limit " + (pagNo - 1) * pagSize + "," + pagSize;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt, sql);
			while (rs.next()) {
				p = new Product();
				c = new Category();
				p.initWithRs(rs);
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setGrade(rs.getInt("grade"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				p.setC(c);
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(rs);
			DButil.close(stmt);
			DButil.close(conn);
		}

		return list;
	}

	public int getProducts(List<Product> list, int pagNo, int pagSize) {
		int pageNumber = 0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		Product p = null;
		Category c = null;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rsCount = DButil.executQuery(stmt, "select count(*) from product");
			rsCount.next();
			pageNumber = (rsCount.getInt(1) - 1) / pagSize + 1;
			if (pagNo < 1)
				pagNo = 1;
			if (pagNo > pageNumber)
				pagNo = pageNumber;
			String sql = "select p.id , p.name , p.descr, p.normalprice, p.memberprice,p.pdate,p.categoryid,"
					+ " c.id cid, c.name cname , c.descr cdescr, c.pid ,"
					+ " c.grade , c.isleaf from product p join category c on(p.categoryid= c.id )"
					+ "  limit " + (pagNo - 1) * pagSize + "," + pagSize;
			rs = DButil.executQuery(stmt, sql);
			// System.out.println(sql);
			while (rs.next()) {
				p = new Product();
				p.initWithRs(rs);
				c = new Category();
				// System.out.println(p.getPdate());
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setGrade(rs.getInt("grade"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				p.setC(c);
				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(rsCount);
			DButil.close(rs);
			DButil.close(stmt);
			DButil.close(conn);
		}

		return pageNumber;
	}

	public int findProducts(List<Product> products, int[] categoryId,
			String keyword, double lowNormalPrice, double highNormalPrice,
			double lowMemberPrice, double hightMemberPrice, Date startDate,
			Date endDate, int pageNo, int pageSize) {
		int pagCnt = 0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rsCnt = null;
		Product p = null;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			String sql = "select * from product where 1=1 ";
			if (categoryId != null && categoryId.length > 0) {
				String strId = "(";
				for (int i = 0; i < categoryId.length - 1; i++) {
					strId += categoryId[i] + ",";
				}
				strId += categoryId[categoryId.length - 1] + ")";
				sql += " and categoryid in " + strId;
			}
			if (keyword != null && !keyword.trim().equals("")) {
				sql += " and ( name like '%" + keyword + "%'"
						+ " or descr like '%" + keyword + "%' )";
			}
			if (lowNormalPrice >= 0) {
				sql += " and normalprice >= " + lowNormalPrice;
			}
			if (highNormalPrice > 0) {
				sql += " and normalprice <= " + highNormalPrice;
			}
			if (lowMemberPrice >= 0) {
				sql += " and normalprice >= " + lowMemberPrice;
			}
			if (hightMemberPrice > 0) {
				sql += " and normalprice <= " + hightMemberPrice;
			}
			if (startDate != null) {
				sql += " and pdate >= '"
						+ new SimpleDateFormat("yyyy-MM-dd").format(startDate)
						+ "'";
			}
			if (endDate != null) {
				sql += " and pdate <= '"
						+ new SimpleDateFormat("yyyy-MM-dd").format(endDate)
						+ "'";
			}

			String sqlCnt = sql.replace("select * ", "select count(*) ");
			rsCnt = DButil.executQuery(stmt, sqlCnt);
			rsCnt.next();

			pagCnt = (rsCnt.getInt(1) - 1) / pageSize + 1;
			// System.out.println(sqlCnt);
			// System.out.println(rsCnt.getInt(1));
			if (pageNo > pagCnt)
				pageNo = pagCnt;
			if (pageNo < 1)
				pageNo = 1;
			sql += " limit " + (pageNo - 1) * pageSize + "," + pageSize;
			System.out.println(sql);
			rs = DButil.executQuery(stmt, sql);
			while (rs.next()) {
				p = new Product();
				p.initWithRs(rs);
				products.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(rs);
			DButil.close(stmt);
			DButil.close(conn);
		}

		return pagCnt;

	}

	public boolean deleteProductByCategoryId(int categoryid) {

		boolean t = false;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rsCnt = null;
		int[] idArray;
		String sqlCnt = "select count(*) from product where categoryid = "
				+ categoryid;
		String sql = "select id from product where categoryid = " + categoryid;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rsCnt = DButil.executQuery(stmt, sqlCnt);
			rsCnt.next();
			idArray = new int[rsCnt.getInt(1)];
			rs = DButil.executQuery(stmt, sql);
			int i = 0;
			while (rs.next()) {
				int id = rs.getInt(1);
				idArray[i++] = id;
			}
			deleteProductById(idArray);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(rs);
			DButil.close(rsCnt);
			DButil.close(stmt);
			DButil.close(conn);
		}

		return t;
	}

	public boolean deleteProductById(int[] idArray) {
		boolean t = false;
		Connection conn = null;
		String sql = "";
		try {
			conn = DButil.getConnection();
			for (int i = 0; i < idArray.length; i++) {
				sql = "delete from product where id = " + idArray[i];
				DButil.executUpdate(conn, sql);
			}
			t = true;
		} finally {
			DButil.close(conn);
		}

		return t;
	}

	public boolean updateProduct(Product p) {

		boolean t = false;
		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "update product set name =? , descr = ? , categoryid = ?, "
				+ "normalprice = ? , memberprice = ? where id =" + p.getId();
		try {
			conn = DButil.getConnection();
			pstmt = DButil.getPreparedStmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setInt(3, p.getCategoryId());
			pstmt.setDouble(4, p.getNormalPrice());
			pstmt.setDouble(5, p.getMemberPrice());
			pstmt.executeUpdate();

			t = true;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(pstmt);
			DButil.close(conn);
		}

		return t;
	}

	public boolean addProduct(Product p) {
		boolean t = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = " insert into product values(null,?,?,?,?,?,?)";
		try {
			conn = DButil.getConnection();
			pstmt = DButil.getPreparedStmt(conn, sql);
			pstmt.setString(1, p.getName());
			pstmt.setString(2, p.getDescr());
			pstmt.setDouble(3, p.getNormalPrice());
			pstmt.setDouble(4, p.getMemberPrice());
			pstmt.setTimestamp(5, new Timestamp(p.getPdate().getTime()));
			pstmt.setInt(6, p.getCategoryId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return t;
	}

	public Product loadById(int id) {
		Product p = new Product();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Category c = null;
		String sql = "select p.id , p.name , p.descr, p.normalprice, p.memberprice,p.pdate,p.categoryid,"
				+ " c.id cid, c.name cname , c.descr cdescr, c.pid ,"
				+ " c.grade , c.isleaf from product p join category c on(p.categoryid= c.id ) where p.id ="
				+ id;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt, sql);
			while (rs.next()) {
				p = new Product();
				p.initWithRs(rs);
				c = new Category();
				c.setId(rs.getInt("cid"));
				c.setName(rs.getString("cname"));
				c.setGrade(rs.getInt("grade"));
				c.setDescr(rs.getString("cdescr"));
				c.setPid(rs.getInt("pid"));
				c.setLeaf(rs.getInt("isleaf") == 0 ? true : false);
				p.setC(c);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(rs);
			DButil.close(stmt);
			DButil.close(conn);
		}
		return p;
	}


	
}

