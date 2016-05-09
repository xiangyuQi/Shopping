package com.qxy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.qxy.exception.PasswordNotCorrectException;
import com.qxy.exception.UserNotFoundException;
import com.qxy.entity.User;
import com.qxy.util.DButil;
import com.sun.org.apache.bcel.internal.generic.Select;


public class UserDAO {

	public  List<User> getUsers() {
		List<User> list = new ArrayList<User>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String sql = "select * from user order by id desc";
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt, sql);
			while (rs.next()) {
				User u = new User();
				u.initWithRs(rs);
				list.add(u);
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
	
	public  int getUsers(List<User> users,int pageNo ,int pageSize) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rsCnt = null;
		int pageCnt = 0;
		String sql = "select * from user order by id desc";
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rsCnt = DButil.executQuery(stmt, "select count(*) from user");
			rsCnt.next();
			pageCnt = (rsCnt.getInt(1)-1)/pageSize + 1;
			if(pageNo>pageCnt) pageNo = pageCnt;
			sql += " limit "+(pageNo-1)*pageSize+","+pageSize;
//System.out.println(sql);
			rs = DButil.executQuery(stmt, sql);
	
			while (rs.next()) {
				User u = new User();
				u.initWithRs(rs);
				users.add(u);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(rs);
			DButil.close(rsCnt);
			DButil.close(stmt);
			DButil.close(conn);

		}
		return pageCnt;
	}

	public  boolean delete(int id) {
		boolean b = false;
		Connection conn = DButil.getConnection();
		try {
			DButil.executUpdate(conn, "delete from user where id = " + id);
			b = true;
		} finally {
			DButil.close(conn);
		}

		return b;
	}

	public void save(User u) {
		Connection conn = DButil.getConnection();
		String sql = "insert into user values(null, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = DButil.getPreparedStmt(conn, sql);
		try {

			pstmt.setString(1, u.getUsername());
			pstmt.setString(2, u.getPassword());
			pstmt.setString(3, u.getPhone());
			pstmt.setString(4, u.getAddr());
			pstmt.setTimestamp(5, new Timestamp(u.getRdate().getTime()));
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(pstmt);
			DButil.close(conn);
		}
	}

	public  User validate(String username, String password)
			throws UserNotFoundException, PasswordNotCorrectException {
		User u = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select * from user where username = '" + username+"'";
		try {
			conn = DButil.getConnection();
			stmt = DButil.createStmt(conn);
			rs = DButil.executQuery(stmt, sql);
			if (!rs.next()) {
				throw new UserNotFoundException();
			} else if (!password.equals(rs.getString("password"))) {
				throw new PasswordNotCorrectException();
			}else{
				u = new User();
				u.initWithRs(rs);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(rs);
			DButil.close(stmt);
			DButil.close(conn);

		}
		return u;
	}
	
	public void update(User u){
		Connection conn = DButil.getConnection();
		String sql = "update user set password =?,phone=? ,addr=? where id = "+u.getId();
		PreparedStatement pstmt = DButil.getPreparedStmt(conn, sql);
		try {
			pstmt.setString(1, u.getPassword());
			pstmt.setString(2, u.getPhone());
			pstmt.setString(3, u.getAddr());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DButil.close(pstmt);
			DButil.close(conn);
		}
		
	}
	

}
