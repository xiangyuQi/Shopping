package com.qxy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import com.qxy.entity.*;
import com.qxy.manager.ProductManager;
import com.qxy.util.DButil;

public class CategoryDAO {

	public  void save(Category c) {
		Connection conn = null;
		String sql = "insert into category values(null, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = null;
		try {
			conn = DButil.getConnection();
			pstmt = DButil.getPreparedStmt(conn, sql);
			pstmt.setString(1, c.getName());
			pstmt.setString(2, c.getDescr());
			pstmt.setInt(3, c.getPid());
			pstmt.setInt(4, c.isLeaf() ? 0 : 1);
			pstmt.setInt(5, c.getGrade());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(pstmt);
			DButil.close(conn);
		}
	}

	public void getCategories(List<Category> list, int id) {
		Connection conn = null;
		conn = DButil.getConnection();
		getCategories(conn, list, id);

	}

	private void getCategories(Connection conn, List<Category> list, int id) {
		String sql = "select * from category where pid= " + id;
		Statement stmt = null;
		ResultSet rs = null;
		Category c = null;
		try {
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt, sql);
			while (rs.next()) {
				c = new Category();
				c.initWithRs(rs);
				list.add(c);
				if (!c.isLeaf()) {
					getCategories(conn,list, c.getId());
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(stmt);
		}

	}

	public  void addChildCategory(int pid, String name, String descr) {

		Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		try {

			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			boolean autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);
			int grade = 1;
			if (pid != 0) {
				Category c = loadById(pid);
				c.setLeaf(false);
				Update(c);
				grade = c.getGrade() + 1;
			}
			String sql = "insert into category values(null, ?, ?, ?, ?, ?)";
			pstmt = DButil.getPreparedStmt(conn, sql);
			pstmt.setString(1, name);
			pstmt.setString(2, descr);
			pstmt.setInt(3, pid);
			pstmt.setInt(4, 0);
			pstmt.setInt(5, grade);
			pstmt.executeUpdate();

			conn.commit();
			conn.setAutoCommit(autoCommit);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(pstmt);
			DButil.close(stmt);
			DButil.close(conn);
		}
	}

	public  void Update(Category c) {

		Connection conn = null;
		String sql = "update category set name =? , descr = ? , isleaf = ? where id ="
				+ c.getId();
		PreparedStatement pstmt = null;
		try {
			conn = DButil.getConnection();
			pstmt = DButil.getPreparedStmt(conn, sql);
			pstmt.setString(1, c.getName());
			pstmt.setString(2, c.getDescr());
			pstmt.setInt(3, c.isLeaf() ? 0 : 1);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(pstmt);
			DButil.close(conn);
		}

	}

	public Category loadById(int id) {
		Category c = new Category();
		Connection conn = null;
		Statement stmt = null;
		String sql = "select * from category where id = " + id;
		ResultSet rs = null;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt, sql);
			if (rs.next()) {
				c.initWithRs(rs);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			DButil.close(conn);
		}

		return c;

	}

	public  boolean delete(int id, boolean leaf) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		boolean b= true;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			if (!leaf) {
				rs = DButil.executQuery(stmt,
						"select * from category where pid =" + id);
				while (rs.next()) {
					delete(rs.getInt("id"), rs.getInt("isleaf") == 0);
				}
			}else{
				ProductManager.getInstance().deleteProductByCategoryId(id);
			}
			DButil.executUpdate(conn, "delete from category where id = " + id);

		} catch (SQLException e) {
			e.printStackTrace();
			b = false;
		} finally {
			DButil.close(stmt);
			DButil.close(conn);
		}
		return b;
	}

	public  void cheack(int pid) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt,
					"select count(*) from category where pid =" + pid);
			rs.next();
			if (rs.getInt(1) <= 0) {
				
				DButil.executUpdate(conn, "update category set isleaf = 0 where id ="+pid);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(stmt);
			DButil.close(conn);
		}

	}

}
