package com.scch.muke.dao;

import java.util.List;
import java.util.Map;

import com.scch.muke.vo.Sixiu;

public interface SixiuDao extends BaseDao {
	
	public Sixiu getSixiuByUserId(Integer userId);
	
	public void updateSixiu(Sixiu sixiu);
	
	public void insertSixiu(Sixiu sixiu);

	public List<Map<String, Object>> getGrade();

	public List<Map<String, Object>> searchGrade(String searchKey);
}
