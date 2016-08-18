package com.scch.muke.service;

import java.util.List;

import com.scch.muke.vo.Sixiu;
import com.scch.muke.vo.User;
import com.scch.muke.vo.Exam;

public interface UserService {
	String getName();
	User getUser(User user);
	User getUserByUsername(String username);
	Sixiu getSixiuByUserId(Integer userId);
	void updateSixiu(Sixiu sixiu);
	void insertSixiu(Sixiu sixiu);
	
	List<Exam> getExam(Integer chap, Integer type);
	void updateUser(User user);
	void insertUser(User user);
}
