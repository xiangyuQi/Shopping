package com.qxy.entity;


import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.Date;




public class User {
    private int id;
    private String username;
    private String password;
    private String phone;
    private String addr;
    private Date rdate;
    
    
    public void initWithRs(ResultSet rs){
    	try {
			this.id = rs.getInt("id");
			this.username = rs.getString("username");
			this.password = rs.getString("password");
			this.addr = rs.getString("addr");
			this.phone = rs.getString("phone");
			this.rdate = rs.getTimestamp("rdate");
		} catch (SQLException e) {
			e.printStackTrace();
		}
    	
    }
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	
}
