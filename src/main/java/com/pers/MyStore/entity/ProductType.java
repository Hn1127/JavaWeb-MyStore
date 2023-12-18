package com.pers.MyStore.entity;

public class ProductType {
	private int product_type;
	private String real_type;

	public ProductType(int product_type, String real_type) {
		super();
		this.product_type = product_type;
		this.real_type = real_type;
	}

	public int getProduct_type() {
		return product_type;
	}

	public void setProduct_type(int product_type) {
		this.product_type = product_type;
	}

	public String getReal_type() {
		return real_type;
	}

	public void setReal_type(String real_type) {
		this.real_type = real_type;
	}

}
