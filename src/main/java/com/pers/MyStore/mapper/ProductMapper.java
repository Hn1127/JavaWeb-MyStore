package com.pers.MyStore.mapper;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pers.MyStore.entity.Product;

@Mapper
public interface ProductMapper {
	List<Product> findAll();
	
	List<Product> findAllValid();
	
	List<Product> findAllLimit(int num);
	
	List<Product> findAllLimitValid(int num);
	
	List<Product> findByMutiConditions(Long productId,
			String productName,
			Integer productType,
			BigDecimal productPriceLowerBound,
			BigDecimal productPriceUpperBound,
			Integer productInventoryLowerBound,
			Integer productInventoryUpperBound,
			Boolean productValid);
	
	List<Product> findBySearch(String searchCondition);
	
	List<Product> findBySearchValid(String searchCondition);
	
	List<Product> findByType(int type);
	
	List<Product> findByTypeValid(int type);
	
	Product findProductById(long product_id);
	
	int changeProductValid(long product_id);
	
	int updateProduct(Product product);
	
	int buyProduct(long product_id,int quantity);
	
	int addProduct(Product product);
	
	int productCount();
	
	int validProductCount();
}
