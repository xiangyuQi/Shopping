package com.qxy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mysql.fabric.xmlrpc.base.Array;
import com.qxy.entity.Cart;
import com.qxy.entity.CartItem;
import com.qxy.entity.Category;
import com.qxy.entity.Product;
import com.qxy.entity.SalesItem;
import com.qxy.entity.SalesOrder;
import com.qxy.entity.User;
import com.qxy.util.DButil;
import com.sun.org.apache.regexp.internal.recompile;

public class OrderMysqlDao implements OrderDao {


	public void sava(SalesOrder so) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rsKey = null;
		String sql = "insert into salesorder values(null,?,?,?,?)";
		try{
			conn = DButil.getConnection();
			conn.setAutoCommit(false);
			pstmt = DButil.getPreparedStmt(conn, sql,true);
			pstmt.setInt(1, so.getUser().getId());
			pstmt.setString(2, so.getAddr());
			pstmt.setTimestamp(3, so.getOdate());
			pstmt.setInt(4, so.getStatus());
			pstmt.executeUpdate();
			rsKey = pstmt.getGeneratedKeys();
			rsKey.next();
			int key = rsKey.getInt(1);
			String sqlItem="insert into salesitem values(null,?,?,?,?)";
			pstmt = DButil.getPreparedStmt(conn, sqlItem);
			Cart c = so.getCart();
			List<CartItem> itmes = c.getItems();
			for(int i=0;i<itmes.size();i++){
				CartItem item = itmes.get(i);
				pstmt.setInt(1, item.getProductid());
				pstmt.setDouble(2, item.getPrice());
				pstmt.setInt(3, item.getCount());
				pstmt.setInt(4, key);
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			
			conn.commit();
			conn.setAutoCommit(true);
			
		}catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.setAutoCommit(true);
				conn.rollback();
			} catch (SQLException e1) {
				
				e1.printStackTrace();
			}
		
		}finally{
			DButil.close(rsKey);
			DButil.close(pstmt);
			DButil.close(conn);
		}
	}


	public int getSalesOrders(List<SalesOrder> orders, int pageNo, int pageSize) {
		int pageNumber = 0;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rsCount = null;
		SalesOrder so= null;
		User u = null;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rsCount = DButil.executQuery(stmt, "select count(*) from salesorder");
			rsCount.next();
			pageNumber = (rsCount.getInt(1) - 1) / pageSize + 1;
			if (pageNo < 1)
				pageNo = 1;
			if (pageNo > pageNumber)
				pageNo = pageNumber;
			String sql = "select so.id ,so.userid ,so.addr ,so.odate ,so.status, " +
					"u.id uid, u.username  , u.password, u.addr uaddr,u.phone,u.rdate " +
					"from salesorder so left join user u on (so.userid = u.id) "
					+ "  limit " + (pageNo - 1) * pageSize + "," + pageSize;
			rs = DButil.executQuery(stmt, sql);
			// System.out.println(sql);
			while (rs.next()) {
				so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setOdate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				
				u = new User();
				u.setId(rs.getInt("uid"));
				u.setAddr(rs.getString("uaddr"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setRdate(rs.getTimestamp("rdate"));
				so.setUser(u);
				orders.add(so);
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



	public SalesOrder loadById(int id) {
		SalesOrder so = null;
		User u = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		Category c = null;
		String sql = "select so.id ,so.userid ,so.addr ,so.odate ,so.status, " +
				"u.id uid, u.username  , u.password, u.addr uaddr,u.phone,u.rdate " +
				"from salesorder so left join user u on (so.userid = u.id) where so.id = "+id;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt, sql);
			while (rs.next()) {
				so = new SalesOrder();
				so.setId(rs.getInt("id"));
				so.setAddr(rs.getString("addr"));
				so.setOdate(rs.getTimestamp("odate"));
				so.setStatus(rs.getInt("status"));
				
				u = new User();
				u.setId(rs.getInt("uid"));
				u.setAddr(rs.getString("uaddr"));
				u.setUsername(rs.getString("username"));
				u.setPassword(rs.getString("password"));
				u.setPhone(rs.getString("phone"));
				u.setRdate(rs.getTimestamp("rdate"));
				so.setUser(u);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(rs);
			DButil.close(stmt);
			DButil.close(conn);
		}
		return so;
	}



	public List<SalesItem> getSalesItem(SalesOrder so) {
		List<SalesItem> items = new ArrayList<SalesItem>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		SalesItem si = null;
		Product p = null;
		String sql = "select si.id, si.productid, si.unitprice ,si.pcount, si.orderid ," +
				" p.id pid , p.name , p.descr , p.normalprice ,p.memberprice ,p.pdate, p.categoryid " +
				" from salesitem si join product p on (p.id = si.productid ) where si.orderid = "+so.getId();
//System.out.println(sql);
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt, sql);
			while(rs.next()){
				si = new SalesItem();
				p = new Product();
				
				p.setCategoryId(rs.getInt("categoryid"));
				p.setId(rs.getInt("pid"));
				p.setName(rs.getString("name"));
				p.setDescr(rs.getString("descr"));
				p.setMemberPrice(rs.getDouble("memberprice"));
				p.setNormalPrice(rs.getDouble("normalprice"));
				p.setPdate(rs.getTimestamp("pdate"));
				
				si.setId(rs.getInt("id"));
				si.setPcount(rs.getInt("pcount"));
				si.setUnitprice(rs.getDouble("unitprice"));
				si.setSo(so);
				si.setP(p);
				
				items.add(si);
			}
//System.out.println(items.size());
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
	
			DButil.close(stmt);
			DButil.close(conn);
		}
		return items;
	}
		

}
