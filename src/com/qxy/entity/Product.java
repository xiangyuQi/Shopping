package com.qxy.entity;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Product {
	
	private int id ;
	private String name;
	private String descr;
	private double normalPrice ;
	private double memberPrice;
	private Date pdate;
	private int categoryId;
	private Category c;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public double getNormalPrice() {
		return normalPrice;
	}
	public void setNormalPrice(double normalPrice) {
		this.normalPrice = normalPrice;
	}
	public double getMemberPrice() {
		return memberPrice;
	}
	public void setMemberPrice(double memberPrice) {
		this.memberPrice = memberPrice;
	}
	public Date getPdate() {
		return pdate;
	}
	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public void initWithRs(ResultSet rs) {
		try {
			this.id = rs.getInt("id");
			this.categoryId = rs.getInt("categoryid");
			this.name = rs.getString("name");
			this.descr = rs.getString("descr");
			this.normalPrice = rs.getDouble("normalprice");
			this.memberPrice = rs.getDouble("memberPrice");
			this.pdate = rs.getTimestamp("pdate");
			
		} catch (SQLException e) {

			e.printStackTrace();
		}
		
	}
	public Category getC() {
		return c;
	}
	public void setC(Category c) {
		this.c = c;
	}
	
	

}
