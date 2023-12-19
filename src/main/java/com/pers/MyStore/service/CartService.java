package com.pers.MyStore.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pers.MyStore.entity.Cart;
import com.pers.MyStore.mapper.CartMapper;

@Service
public class CartService {
	@Autowired
	private CartMapper cartMapper;

	public int addCart(Cart cart) {
		return cartMapper.addCart(cart);
	}

	public List<Cart> findCartByUserID(Long user_id) {
		return cartMapper.findCartByUserID(user_id);
	}
	
	public List<Cart> findCartByProductsID(long user_id, List<Long> products_id){
		System.out.println("CartService.findCartByProductsID()");
		List<Cart> carts=new ArrayList<>();
		for (Long product_id:products_id) {
			carts.add(cartMapper.findCartByProductID(user_id,product_id));
		}
		return carts;
	}
	
	public Cart findCartByProductID(long user_id, long product_id){
		System.out.println("CartService.findCartByProductID()");
		return cartMapper.findCartByProductID(user_id,product_id);
	}

	public int removeCart(long user_id, long product_id) {
		return cartMapper.removeCart(user_id, product_id);
	}
	
	public int updateCarts(long user_id, List<Long> products_id, List<Integer> quantitys) {
		int count=0;
		for (int i = 0; i < products_id.size(); ++i) {
			long product_id = products_id.get(i);
			int quantity = quantitys.get(i);
			count+=cartMapper.updateCart(user_id, product_id, quantity);
		}
		return count;
	}
	
	public int updateCart(long user_id, long product_id, int quantity) {
		return cartMapper.updateCart(user_id, product_id, quantity);
	}

}
