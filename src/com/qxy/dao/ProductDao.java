package com.qxy.dao;

import java.util.Date;
import java.util.List;

import com.qxy.entity.Product;

public interface ProductDao {
	/*public List<Product> getProducts();*/
	
	public List<Product> getProducts(int pagNo,int pagSize);
	
	public List<Product> getProducts( int categoryid , int pageNo,int pageSize) ;
	
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
			);
	
	

	public boolean deleteProductByCategoryId(int categoryid);
	
	public boolean deleteProductById(int[] idArray);
	
	public boolean updateProduct(Product p);
	
	public boolean addProduct(Product p);

	public Product loadById(int id);

	public int getProducts(List<Product> list, int pagNo, int pagSize);


}
