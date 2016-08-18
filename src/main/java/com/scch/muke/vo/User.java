package com.scch.muke.vo;

public class User {
	private Integer       id;
	private String        username;
	private String        name;
	private String        password;
	private String        studentId;
	private String        major;
	private String        classs;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
	    this.id = id;
	}

	public String getUsername() {
	    return username;
	}

	public void setUsername(String username) {
	    this.username = username;
	}
	
	public String getName() {
	    return name;
	}

	public void setName(String name) {
	    this.name = name;
	}

	public String getPassword() {
	    return password;
	}

	public void setPassword(String password) {
	    this.password = password;
	}

	public String getStudentId() {
	    return studentId;
	}

	public void setStudentId(String studentId) {
	    this.studentId = studentId;
	}
	
	public String getMajor() {
	    return major;
	}

	public void setMajor(String major) {
	    this.major = major;
	}
	
	public String getClasss() {
	    return classs;
	}

	public void setClasss(String classs) {
	    this.classs = classs;
	}
}
