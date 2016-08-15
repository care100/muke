package com.scch.muke.service.impl;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scch.muke.dao.MeimeiDao;
import com.scch.muke.service.MeimeiService;

@Service
public class MeimeiServiceImpl implements MeimeiService {
	
	@Resource
	private MeimeiDao meimeiDao;
	
	@Override
	public String getName(){
		return meimeiDao.getName();
	}
}
