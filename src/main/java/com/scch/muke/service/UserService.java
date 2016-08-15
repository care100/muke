package com.scch.muke.service;

import com.scch.muke.vo.Sixiu;
import com.scch.muke.vo.User;

public interface UserService {
	String getName();
	User getUser(User user);
	User getUserByUsername(String username);
	Sixiu getSixiuByUserId(Integer userId);
	void updateSixiu(Sixiu sixiu);
	void insertSixiu(Sixiu sixiu);
}
