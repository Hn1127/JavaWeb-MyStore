package com.pers.MyStore.mapper;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pers.MyStore.entity.Order;

@Mapper
public interface OrderMapper {
	int addOrder(Order order);
	
	int removeOrder(long user_id,long order_id);

	int orderCount();
	
	int orderCountToday();
	
	BigDecimal orderSum();
	
	BigDecimal orderSumToday();
	
	List<Order> findOrderByProduct(long product_id);
	
	List<Order> findOrderByUser(long user_id);
	
	List<Order> findOrderByUserWithPname(long product_id);
	
	List<Order> findAll();
	
	List<Order> findByMutiConditions(Long order_id,
			Long user_id,
			Long product_id,
			BigDecimal orderPriceLowerBound,
			BigDecimal orderPriceUpperBound,
			@Param("oderDateLowerBound")Date oderDateLowerBound,
			@Param("oderDateUpperBound")Date oderDateUpperBound);
}
