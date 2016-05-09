package com.qxy.manager;


import java.util.List;

import com.qxy.dao.OrderDao;
import com.qxy.dao.OrderMysqlDao;
import com.qxy.entity.SalesItem;
import com.qxy.entity.SalesOrder;

public class OrderManager {

	private static OrderManager om = null;
	private OrderDao dao =null;
	static {
		if(om==null){
			om = new OrderManager();
			om.setDao(new OrderMysqlDao());
		}
		
	}
	private OrderManager(){
		
	}
	
	public static OrderManager getInstance(){
		return om;
	}
	public OrderDao getDao() {
		return dao;
	}
	public void setDao(OrderDao dao) {
		this.dao = dao;
	}
	
	public void save(SalesOrder so){
		dao.sava(so);
	}
	public int getSalesOrders(List<SalesOrder>orders, int pageNo, int pageSize){
		return dao.getSalesOrders(orders,pageNo,pageSize);
	}
	public SalesOrder loadById(int id){
		return dao.loadById(id);
	}
	
	public List<SalesItem> getSalesItem(SalesOrder so){
		return dao.getSalesItem(so);
	}
}
