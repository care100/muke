package com.scch.muke.dao;

import org.springframework.stereotype.Repository;
import com.scch.muke.dao.BaseDao;
import com.scch.muke.vo.User;

@Repository
public interface UserDao extends BaseDao {
	
	public String getName();
	
	public User getUser(User user);
	public User getUserByUsername(String username);
	
}
