package com.pers.MyStore.entity;

import java.math.BigDecimal;

public class Cart {
	private long user_id;
	private long product_id;
	private int quantity;
	private boolean product_valid;
	private String product_name;
	private BigDecimal product_price;

	public Cart(long user_id, long product_id, int quantity, String product_name, BigDecimal product_price) {
		super();
		this.user_id = user_id;
		this.product_id = product_id;
		this.quantity = quantity;
		this.product_name = product_name;
		this.product_price = product_price;
	}

	public Cart(long user_id, long product_id, int quantity) {
		super();
		this.user_id = user_id;
		this.product_id = product_id;
		this.quantity = quantity;
	}

	public boolean isProduct_valid() {
		return product_valid;
	}

	public void setProduct_valid(boolean product_valid) {
		this.product_valid = product_valid;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public BigDecimal getProduct_price() {
		return product_price;
	}

	public void setProduct_price(BigDecimal product_price) {
		this.product_price = product_price;
	}

	public BigDecimal getTotalPrice() {

		return this.product_price.multiply(new BigDecimal(this.quantity));
	}

}
