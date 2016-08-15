package com.scch.muke.vo;

public class User {
	private Integer       id;
	private Integer       type;
	private String        username;
	private String        password;
	private String        mobile;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
	    this.id = id;
	}

	public Integer getType() {
	    return type;
	}

	public void setType(Integer type) {
	    this.type = type;
	}

	public String getUsername() {
	    return username;
	}

	public void setUsername(String username) {
	    this.username = username;
	}

	public String getPassword() {
	    return password;
	}

	public void setPassword(String password) {
	    this.password = password;
	}

	public String getMobile() {
	    return mobile;
	}

	public void setMobile(String mobile) {
	    this.mobile = mobile;
	}
}
