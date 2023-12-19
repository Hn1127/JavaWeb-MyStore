package com.pers.MyStore.entity;

import java.util.Date;

public class UserHistory {
	private long user_id;
	private long product_id;
	private Date history_time;
	private String product_name;

	public UserHistory(long user_id, long product_id) {
		super();
		this.user_id = user_id;
		this.product_id = product_id;
	}

	public UserHistory(long user_id, long product_id, Date history_time, String product_name) {
		super();
		this.user_id = user_id;
		this.product_id = product_id;
		this.history_time = history_time;
		this.product_name = product_name;
	}

	public long getUser_id() {
		return user_id;
	}

	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}

	public long getProduct_id() {
		return product_id;
	}

	public void setProduct_id(long product_id) {
		this.product_id = product_id;
	}

	public Date getHistory_time() {
		return history_time;
	}

	public void setHistory_time(Date history_time) {
		this.history_time = history_time;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

}
