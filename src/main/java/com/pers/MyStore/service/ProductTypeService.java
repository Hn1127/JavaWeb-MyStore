package com.pers.MyStore.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pers.MyStore.entity.ProductType;
import com.pers.MyStore.mapper.ProductTypeMapper;

@Service
public class ProductTypeService {
	@Autowired
	private ProductTypeMapper productTypeMapper;
	
	public List<ProductType> findAll(){
		return productTypeMapper.findAll();
	}
	
	public String getRealtype(Integer type) {
		return productTypeMapper.getRealtype(type);
	}
	
}
