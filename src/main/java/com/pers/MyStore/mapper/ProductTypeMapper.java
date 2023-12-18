package com.pers.MyStore.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pers.MyStore.entity.ProductType;

@Mapper
public interface ProductTypeMapper {
	List<ProductType> findAll();
	
	String getRealtype(Integer type);
}
