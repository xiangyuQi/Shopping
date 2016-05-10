package com.qxy.manager;

import java.util.Date;
import java.util.List;


import com.qxy.dao.ProductDao;
import com.qxy.dao.ProductMysqlDao;
import com.qxy.entity.Product;



public class ProductManager {

	private static ProductManager pm = null;
	static{
		if(pm==null){
			pm = new ProductManager();
			pm.setDao(new ProductMysqlDao());
		}
	}
	private ProductManager(){
		
	}
	
	public static ProductManager getInstance(){
		return pm;
	}
	
	private ProductDao dao = null;
	
	public Product loadById(int id){
		return dao.loadById(id);
	}
	
	public int getProducts( List<Product> products,int categoryid , int pageNo,int pageSize) {
		
		return dao.getProducts(products, categoryid, pageNo, pageSize);
	}
	
	/*public List<Product> getProducts(){
		
		return dao.getProducts();
	}*/
	
	public List<Product> getProducts(int pagNo,int pagSize){
		return dao.getProducts(pagNo, pagSize);
	}
	public int getProducts( List<Product> list,int pagNo,int pagSize){
		return dao.getProducts(list,pagNo, pagSize);
	}
	
	public List<Product> getLatestProduct(int num){
		return dao.getProducts(1, num);
	}
	
	public int  findProducts(
				List<Product> products,
				int []categoryId,
				String keyword,
				double lowNormalPrice,
				double highNormalPrice,
				double lowMemberPrice,
				double hightMemberPrice,
				Date startDate,
				Date endDate,
				int pageNo,
				int pageSize
			){
		
		return dao.findProducts(products,categoryId, keyword, lowNormalPrice, highNormalPrice, lowMemberPrice, hightMemberPrice, startDate, endDate, pageNo, pageSize);
	}
	
	
	
	public List<Product> finProducts(String name){
		
		return null;
	}
	
	public boolean deleteProductByCategoryId(int categoryid){
		return dao.deleteProductByCategoryId(categoryid);
	}
	
	public boolean deleteProductById(int[] idArray){
		return dao.deleteProductById(idArray);
	}
	
	public boolean updateProduct(Product p){
		return	dao.updateProduct(p);
	}
	
	public boolean addProduct(Product p){
		return dao.addProduct(p);
	}

	public ProductDao getDao() {
		return dao;
	}

	public void setDao(ProductDao dao) {
		this.dao = dao;
	}
}
