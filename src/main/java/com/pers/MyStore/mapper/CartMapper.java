package com.pers.MyStore.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pers.MyStore.entity.Cart;

@Mapper
public interface CartMapper {
	public int addCart(Cart art);
	
	public int addCartNum(Cart cart);
	
	public List<Cart> findCartByUserID(Long user_id);
	
	public Cart findCartByProductID(Long user_id, Long product_id);
	
	public int removeCart(Long user_id,Long product_id);
	
	public int updateCart(Long user_id,Long product_id,Integer quantity);
}
