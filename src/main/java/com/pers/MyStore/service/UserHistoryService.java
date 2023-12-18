package com.pers.MyStore.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pers.MyStore.entity.UserHistory;
import com.pers.MyStore.mapper.UserHistoryMapper;

@Service
public class UserHistoryService {
	@Autowired
	private UserHistoryMapper userHistoryMapper;
	
	public int addHistory(UserHistory history) {
		return userHistoryMapper.addHistory(history);
	}
	
	public List<UserHistory> findHistoryByUserId(long user_id){
		return userHistoryMapper.findHistoryByUserId(user_id);
	}
	
}
