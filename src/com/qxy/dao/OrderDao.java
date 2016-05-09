package com.qxy.dao;

import java.util.List;

import com.qxy.entity.SalesItem;
import com.qxy.entity.SalesOrder;

public interface OrderDao {

	void sava(SalesOrder so);

	int  getSalesOrders(List<SalesOrder> orders, int pageNo, int pageSize);

	SalesOrder loadById(int id);

	List<SalesItem> getSalesItem(SalesOrder so);

}
