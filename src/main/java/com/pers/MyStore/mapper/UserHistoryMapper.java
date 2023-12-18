package com.pers.MyStore.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.pers.MyStore.entity.UserHistory;

@Mapper
public interface UserHistoryMapper {
	
	int addHistory(UserHistory history);
	
	List<UserHistory> findHistoryByUserId(long user_id);
	
}
