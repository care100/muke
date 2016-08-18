package com.scch.muke.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.scch.muke.vo.Exam;

public interface ExamDao extends BaseDao {
	public List<Exam> getExam(@Param("chap") Integer chap, @Param("type") Integer type);
}
