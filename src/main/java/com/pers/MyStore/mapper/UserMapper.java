package com.pers.MyStore.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.pers.MyStore.entity.User;

@Mapper
public interface UserMapper {
	
	List<User> findAll();
	List<User> findByMutiConditions(Long uin,String username,
			String email,String nickname,Date registerDateLowerBound,Date registerDateUpperBound);
	
	User findByUsername(@Param("username") String username);
	
	public User findUserByUsernameValid(String username);
	
	User findUserById(@Param("uin") long uin);
	
	int nicknameUpdate(long user_id, String nickname);

	int passwordUpdate(long user_id, String password);
	
	int emailUpdate(long user_id, String email);
	
	int userCountValid();
	
	int addUser(User user);
	
	User checkUser(@Param("username") String username,@Param("password") String password);
}
