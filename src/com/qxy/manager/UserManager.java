package com.qxy.manager;

import java.util.List;


import com.qxy.dao.UserDAO;
import com.qxy.exception.PasswordNotCorrectException;
import com.qxy.exception.UserNotFoundException;
import com.qxy.entity.User;


public class UserManager {
    
	private static UserManager umg = null;
	private UserDAO dao = null;
	static{
		if(umg ==null){
			umg = new UserManager();
			umg.setDao(new UserDAO());
		}
	}
	
	public static UserManager getInstance(){
		return umg;
	}
	
	private UserManager(){
		
	}
	
	public List<User> getUsers(){
		return dao.getUsers();
	}
	public  int getUsers(List<User> users,int pageNo ,int pageSize) {
		return dao.getUsers(users, pageNo, pageSize);
	}
	public boolean delete(int id){
		return dao.delete(id);
	}
	public  void add(User u){
		
		dao.save(u);
	}
	
	public User validate(String username, String password) throws UserNotFoundException, PasswordNotCorrectException{
		return dao.validate(username, password);
	}
	
	public  void update(User u){
		dao.update(u);
	}

	public UserDAO getDao() {
		return dao;
	}

	public void setDao(UserDAO dao) {
		this.dao = dao;
	}
}
