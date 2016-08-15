package com.scch.muke.dao;

import org.springframework.stereotype.Repository;
import com.scch.muke.dao.BaseDao;

@Repository
public interface MeimeiDao extends BaseDao {
	
	public String getName();
	
}
