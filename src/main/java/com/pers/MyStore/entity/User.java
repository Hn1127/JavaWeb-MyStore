package com.pers.MyStore.entity;

import java.sql.Date;

public class User {
	private long uin;
	private String username;
	private String nickname;
	private String password;
	private String email;
	private Date date;

	public User(long uin, String username, String nickname, String password, String email, Date date) {
		super();
		this.uin = uin;
		this.username = username;
		this.nickname = nickname;
		this.password = password;
		this.email = email;
		this.date = date;
	}

	public long getUin() {
		return uin;
	}

	public void setUin(long uin) {
		this.uin = uin;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}
