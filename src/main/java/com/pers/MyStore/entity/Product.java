package com.pers.MyStore.entity;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;

import org.springframework.web.multipart.MultipartFile;

public class Product {
	private long product_id;
	private String product_name;
	private String product_description;
	private BigDecimal product_price;
	private int product_type;
	private int product_inventory;
	private boolean product_valid;
	private String product_realtype;
	static String dircory="static/images/products/";
	static String filename="product.jpg";
	
	public Product(long product_id, String product_name, String product_description, BigDecimal product_price,
			int product_type, int product_inventory, boolean product_valid, String product_realtype) {
		super();
		this.product_id = product_id;
		this.product_name = product_name;
		this.product_description = product_description;
		this.product_price = product_price;
		this.product_type = product_type;
		this.product_inventory = product_inventory;
		this.product_valid = product_valid;
		this.product_realtype = product_realtype;
	}

	public Product(long product_id, String product_name, String product_description, BigDecimal product_price,
			int product_type, int product_inventory, boolean product_valid) {
		super();
		this.product_id = product_id;
		this.product_name = product_name;
		this.product_description = product_description;
		this.product_price = product_price;
		this.product_type = product_type;
		this.product_inventory = product_inventory;
		this.product_valid = product_valid;
	}

	public long getProduct_id() {
		return product_id;
	}

	public void setProduct_id(long product_id) {
		this.product_id = product_id;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_description() {
		return product_description;
	}

	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}

	public BigDecimal getProduct_price() {
		return product_price;
	}

	public void setProduct_price(BigDecimal product_price) {
		this.product_price = product_price;
	}

	public int getProduct_type() {
		return product_type;
	}

	public void setProduct_type(int product_type) {
		this.product_type = product_type;
	}

	public int getProduct_inventory() {
		return product_inventory;
	}

	public void setProduct_inventory(int product_inventory) {
		this.product_inventory = product_inventory;
	}

	public boolean isProduct_valid() {
		return product_valid;
	}

	public void setProduct_valid(boolean product_valid) {
		this.product_valid = product_valid;
	}

	public String getProduct_realtype() {
		return product_realtype;
	}

	public void setProduct_realtype(String product_realtype) {
		this.product_realtype = product_realtype;
	}
	
	public String getPhotoPath(){
		// 相对路径
		String dircory="/images/products/"+product_id;
		String filename="/product.jpg";

		return dircory+filename;
	}
	
	public String getPhotoAbsoluteDirectory(){
		// 项目文件中target对应目录
		return dircory+product_id;
	}
	
	public String getFilename(){
		// 项目文件中target对应目录
		return filename;
	}
	
	public void updatePhoto(MultipartFile photo) {
		if (photo != null) {
			if (!photo.isEmpty()) {
				// 获取存放该商品图片的路径
				String readDirectory = this.getPhotoAbsoluteDirectory();
				File directFile = new File(readDirectory);
				directFile.mkdir();
				// 获取图片被保存的名称
				String fileName = this.getFilename();
				File file = new File(directFile, fileName);
				System.out.println(file.getAbsolutePath());
				try {
					file.createNewFile();

					// 完成文件的上传
					photo.transferTo(file.getAbsoluteFile());
				} catch (IOException e) {
					System.out.println("图片上传失败");
				}
			}
		}
		else {
			System.out.println("图片为空!");
		}
	}

}
