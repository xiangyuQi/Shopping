package com.qxy.entity;


public class SalesItem {

	private int id ;
	private Product p ;
	private double unitprice;
	private int pcount;
	private SalesOrder so;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Product getP() {
		return p;
	}
	public void setP(Product p) {
		this.p = p;
	}
	public double getUnitprice() {
		return unitprice;
	}
	public void setUnitprice(double unitprice) {
		this.unitprice = unitprice;
	}
	public int getPcount() {
		return pcount;
	}
	public void setPcount(int pcount) {
		this.pcount = pcount;
	}
	public SalesOrder getSo() {
		return so;
	}
	public void setSo(SalesOrder so) {
		this.so = so;
	}
	
}
