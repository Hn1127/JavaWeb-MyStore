package com.pers.MyStore.service;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.pers.MyStore.entity.Product;
import com.pers.MyStore.mapper.ProductMapper;

@Service
public class ProductService {
	@Autowired
	private ProductMapper productMapper;

	public List<Product> findAll() {
		return productMapper.findAll();
	}
	
	public List<Product> findAllLimit(int num) {
		return productMapper.findAllLimit(num);
	}
	
	public List<Product> findAllValid() {
		return productMapper.findAllValid();
	}
	
	public List<Product> findAllLimitValid(int num) {
		return productMapper.findAllLimitValid(num);
	}

	public int addProduct(Product product) {
		return productMapper.addProduct(product);
	}
	
	public int productCount() {
		return productMapper.productCount();
	}
	
	public int validProductCount() {
		return productMapper.validProductCount();
	}

	public Product findProductById(long product_id) {
		return productMapper.findProductById(product_id);
	}
	
	public int changeProductValid(long product_id) {
		return productMapper.changeProductValid(product_id);
	}
	
	@Transactional
	public int updateProduct(Product product) {
		// 更新成功则返回1
		return productMapper.updateProduct(product);
	}
	
	@Transactional
	public int buyProduct(long product_id,int quantity) {
		// 为product_id.inventory-quantity
		return productMapper.buyProduct(product_id,quantity);
	}

	public List<Product> findByMutiConditions(Long productId, String productName, Integer productType,
			BigDecimal productPriceLowerBound, BigDecimal productPriceUpperBound, Integer productInventoryLowerBound,
			Integer productInventoryUpperBound, Boolean productValid) {
		return productMapper.findByMutiConditions(productId, productName, productType, productPriceLowerBound,
				productPriceUpperBound, productInventoryLowerBound, productInventoryUpperBound, productValid);
	}
	
	public List<Product> findBySearch(String searchCondition){
		// "%"+searchCondition+"%"
		return productMapper.findBySearch(searchCondition);
	}
	
	public List<Product> findBySearchValid(String searchCondition){
		// "%"+searchCondition+"%"
		return productMapper.findBySearchValid(searchCondition);
	}

	public List<Product> findByType(int type){
		return productMapper.findByType(type);
	}
	
	public List<Product> findByTypeValid(int type){
		return productMapper.findByTypeValid(type);
	}

	public long getProductId() {
		// 时间戳+随机数生成uid
		// 定义日期格式
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddhhmm");
		// 当前日期
		Date currentDate = new Date();
		// 将日期转换成字符串
		String dateStr = dateFormat.format(currentDate);
		long longdate = Long.parseLong(dateStr);

		long uid = longdate * 100000 + (long) (Math.random() * 10000);
		return uid;
	}
}
