package com.pers.MyStore.service;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pers.MyStore.entity.Order;
import com.pers.MyStore.mapper.OrderMapper;

@Service
public class OrderService {
	@Autowired
	private OrderMapper orderMapper;

	public int addOrder(Order order) {
		return orderMapper.addOrder(order);
	}
	
	public int removeOrder(long user_id,long order_id) {
		return orderMapper.removeOrder(user_id, order_id);
	}
	
	public int orderCount() {
		return orderMapper.orderCount();
	}
	
	public int orderCountToday() {
		return orderMapper.orderCountToday();
	}
	
	public BigDecimal orderSum() {
		return orderMapper.orderSum();
	}
	
	public BigDecimal orderSumToday() {
		return orderMapper.orderSumToday();
	}

	public List<Order> findOrderByProduct(long product_id) {
		return orderMapper.findOrderByProduct(product_id);
	}

	public List<Order> findOrderByUser(long user_id) {
		return orderMapper.findOrderByUser(user_id);
	}
	
	public List<Order> findOrderByUserWithPname(long user_id) {
		return orderMapper.findOrderByUserWithPname(user_id);
	}

	public List<Order> findAll() {
		return orderMapper.findAll();
	}

	public List<Order> findByMutiConditions(Long orderId,
			Long userId,
			Long productId,
			BigDecimal orderPriceLowerBound,
			BigDecimal orderPriceUpperBound,
			Date oderDateLowerBound,
			Date oderDateUpperBound) {
		return orderMapper.findByMutiConditions(orderId,
				userId,
				productId,
				orderPriceLowerBound,
				orderPriceUpperBound,
				oderDateLowerBound,
				oderDateUpperBound);
	}
	
	public long getOrderId() {
		// 时间戳+随机数生成uid
		// 定义日期格式
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddhhmmss");
		// 当前日期
		Date currentDate = new Date();
		// 将日期转换成字符串
		String dateStr = dateFormat.format(currentDate);
		long longdate = Long.parseLong(dateStr);

		long uid = longdate * 100000 + (long) (Math.random() * 10000);
		return uid;
	}

}
