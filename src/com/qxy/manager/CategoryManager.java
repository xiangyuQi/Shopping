package com.qxy.manager;


import java.util.ArrayList;
import java.util.List;

import com.qxy.dao.CategoryDAO;
import com.qxy.entity.Category;

public class CategoryManager {

	private  CategoryDAO dao ;
	
	private static CategoryManager cmg = null;
	static{
		if(cmg==null){
			cmg = new CategoryManager();
			cmg.setDao(new CategoryDAO());
		}
	}
	
	public static CategoryManager getInstance(){
		return cmg;
	}
	
	private CategoryManager(){
		
	}
	
	public  void add(Category c){
		dao.save(c);
	}
	public void addTopCategory(String name,String descr){
		addChildCategory(0,name,descr);
	}
	public void addChildCategory(int pid ,String name,String descr){
		dao.addChildCategory(pid,name,descr);
		
	}
	
	
	public  List<Category> getCategories(int id){
		List<Category> list = new ArrayList<Category>();
		dao.getCategories(list, id);
		return list;
	}
	public  boolean delete(int id ,boolean leaf,int pid){
		boolean b = true;
		b = dao.delete(id,leaf);
		dao.cheack(pid);
		return b;
	}
	public  Category loadById(int id){
		Category c = dao.loadById(id);
		return c;
	}
	public  void update(Category c){
		dao.Update(c);
	}
	public CategoryDAO getDao() {
		return dao;
	}
	public void setDao(CategoryDAO dao) {
		this.dao = dao;
	}
}
