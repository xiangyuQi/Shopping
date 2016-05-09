package com.qxy.entity;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Category {

	private int id ;
	private String name;
	private String descr;
	private int pid;
	private boolean leaf;
	private int grade;
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
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public boolean isLeaf() {
		return leaf;
	}
	public void setLeaf(boolean leaf) {
		this.leaf = leaf;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	public void initWithRs(ResultSet rs){
		try {
			name = rs.getString("name");
			id = rs.getInt("id");
			descr = rs.getString("descr");
			grade = rs.getInt("grade");
			leaf = rs.getInt("isleaf")==1?false:true;
			pid = rs.getInt("pid");
		} catch (SQLException e) {
		
			e.printStackTrace();
		}
	}
}
