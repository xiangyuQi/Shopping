package com.qxy.entity;

import java.util.ArrayList;
import java.util.List;

public class Cart {

	private List<CartItem> items = new ArrayList<CartItem>();

	public List<CartItem> getItems() {
		return items;
	}

	public void setItems(List<CartItem> items) {
		this.items = items;
	}
	public void add(CartItem item){
		for(int i=0;i<items.size();i++){
			CartItem it = items.get(i);
			if(it.getProductid()==item.getProductid()){
				it.setCount(it.getCount()+item.getCount());
				return;
			}

		}
			
		items.add(item);
	}
}
