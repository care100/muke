package com.scch.muke.vo;

public class Exam {

	private Integer       id;
	private Integer       chap;
	private Integer       type;
	private String        question;
	private String        option;
	private String        answer;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
	    this.id = id;
	}
	
	public Integer getChap() {
	    return chap;
	}

	public void setChap(Integer chap) {
	    this.chap = chap;
	}

	public Integer getType() {
	    return type;
	}

	public void setType(Integer type) {
	    this.type = type;
	}

	public String getQuestion() {
	    return question;
	}

	public void setQuestion(String question) {
	    this.question = question;
	}

	public String getOption() {
	    return option;
	}

	public void setOption(String option) {
	    this.option = option;
	}

	public String getAnswer() {
	    return answer;
	}

	public void setAnswer(String answer) {
	    this.answer = answer;
	}
}
