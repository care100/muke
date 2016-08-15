package com.scch.muke.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.scch.muke.dao.SixiuDao;
import com.scch.muke.dao.UserDao;
import com.scch.muke.service.UserService;
import com.scch.muke.vo.Sixiu;
import com.scch.muke.vo.User;

@Service
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserDao userDao;
	@Resource
	private SixiuDao sixiuDao;

	@Override
	public String getName() {
		return userDao.getName();
	}
	
	@Override
	public User getUser(User user) {
		return userDao.getUser(user);
	}
	
	@Override
	public User getUserByUsername(String username) {
		return userDao.getUserByUsername(username);
	}
	
	@Override
	public Sixiu getSixiuByUserId(Integer userId){
		return sixiuDao.getSixiuByUserId(userId);
	}
	
	@Override
	public void updateSixiu(Sixiu sixiu){
		sixiuDao.updateSixiu(sixiu);
	}
	
	@Override
	public void insertSixiu(Sixiu sixiu){
		sixiuDao.insertSixiu(sixiu);
	}

}
