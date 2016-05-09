package com.qxy.test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.qxy.util.DButil;

public class DBtest {
   public static void main(String[] args) {
	   Connection conn = DButil.getConnection();
	
	   Statement stmt = DButil.createStmt(conn);
	   ResultSet rs = DButil.executQuery(stmt, "select * from user");
	   try {
		while(rs.next())
		   {
			   System.out.println(rs.getInt(1));
		   }
	} catch (SQLException e) {

		e.printStackTrace();
	}
	   DButil.close(stmt);
	   DButil.close(conn);
	   
   }
}
