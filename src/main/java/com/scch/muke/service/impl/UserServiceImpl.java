package com.scch.muke.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.scch.muke.dao.ExamDao;
import com.scch.muke.dao.SixiuDao;
import com.scch.muke.dao.UserDao;
import com.scch.muke.service.UserService;
import com.scch.muke.vo.Exam;
import com.scch.muke.vo.Sixiu;
import com.scch.muke.vo.User;

@Service
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserDao userDao;
	@Resource
	private SixiuDao sixiuDao;
	@Resource
	private ExamDao examDao;

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
	
	@Override
	public List<Exam> getExam(Integer chap, Integer type){
		return examDao.getExam(chap,type);
	}
	
	@Override
	public void updateUser(User user){
		userDao.updateUser(user);
	}
	
	@Override
	public void insertUser(User user){
		userDao.insertUser(user);
	}
}
