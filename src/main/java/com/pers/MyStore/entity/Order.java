package com.pers.MyStore.entity;

import java.math.BigDecimal;
import java.util.Date;

public class Order {
	private long order_id;
	private long user_id;
	private long product_id;
	private BigDecimal product_price;
	private int quantity;
	private BigDecimal total_price;
	private Date order_date; // 有默认值
	private String product_name;
	
	public Order(long order_id, long user_id, long product_id, BigDecimal product_price, int quantity,
			BigDecimal total_price, Date order_date, String product_name) {
		super();
		this.order_id = order_id;
		this.user_id = user_id;
		this.product_id = product_id;
		this.product_price = product_price;
		this.quantity = quantity;
		this.total_price = total_price;
		this.order_date = order_date;
		this.product_name = product_name;
	}

	public Order(long order_id, long user_id, long product_id, BigDecimal product_price, int quantity,
			BigDecimal total_price) {
		super();
		this.order_id = order_id;
		this.user_id = user_id;
		this.product_id = product_id;
		this.product_price = product_price;
		this.quantity = quantity;
		this.total_price = total_price;
	}

	public Order(long order_id, long user_id, long product_id, BigDecimal product_price, int quantity,
			BigDecimal total_price, Date order_date) {
		super();
		this.order_id = order_id;
		this.user_id = user_id;
		this.product_id = product_id;
		this.product_price = product_price;
		this.quantity = quantity;
		this.total_price = total_price;
		this.order_date = order_date;
	}

	public long getOrder_id() {
		return order_id;
	}

	public void setOrder_id(long order_id) {
		this.order_id = order_id;
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

	public BigDecimal getProduct_price() {
		return product_price;
	}

	public void setProduct_price(BigDecimal product_price) {
		this.product_price = product_price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public BigDecimal getTotal_price() {
		return total_price;
	}

	public void setTotal_price(BigDecimal total_price) {
		this.total_price = total_price;
	}

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	
	
}
