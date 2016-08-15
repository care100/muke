package com.scch.muke.dao;

import com.scch.muke.vo.Sixiu;

public interface SixiuDao extends BaseDao {
	
	public Sixiu getSixiuByUserId(Integer userId);
	
	public void updateSixiu(Sixiu sixiu);
	
	public void insertSixiu(Sixiu sixiu);
}
