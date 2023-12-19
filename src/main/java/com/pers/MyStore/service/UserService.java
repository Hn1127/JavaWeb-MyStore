package com.pers.MyStore.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pers.MyStore.entity.User;
import com.pers.MyStore.mapper.UserMapper;

@Service
public class UserService {

	@Autowired
	private UserMapper userMapper;

	public List<User> findAll() {
		return userMapper.findAll();
	}
	
	public List<User> findByMutiConditions(Long userID,String username,
			String email,String nickname,Date registerDateLowerBound,Date registerDateUpperBound) {
		return userMapper.findByMutiConditions(userID, username,
				email,nickname,registerDateLowerBound,registerDateUpperBound);
	}

	public User findUserByUsername(String username) {
		return userMapper.findByUsername(username);
	}
	
	public User findUserByUsernameValid(String username) {
		return userMapper.findUserByUsernameValid(username);
	}

	public User findUserById(long user_id) {
		return userMapper.findUserById(user_id);
	}

	public int nicknameUpdate(long user_id, String nickname) {
		return userMapper.nicknameUpdate(user_id,nickname);
	}

	public int passwordUpdate(long user_id, String password) {
		return userMapper.passwordUpdate(user_id,password);
	}
	
	public int emailUpdate(long user_id, String email) {
		return userMapper.emailUpdate(user_id,email);
	}
	
	public int userCountValid() {
		return userMapper.userCountValid();
	}
	
	public int addUser(User user) {
		return userMapper.addUser(user);
	}

	public String checkUser(String username, String password) {
		User user = this.findUserByUsernameValid(username);
		if (user == null)
			return "用户名不存在";
		if (!user.getPassword().equals(password))
			return "密码错误";
		return "";
	}
	
	public String checkUser(long uin, String password) {
		User user = this.findUserById(uin);
		if (user == null)
			return "用户名不存在";
		if (!user.getPassword().equals(password))
			return "密码错误";
		return "";
	}

	public long getUid() {
		// 时间戳+随机数生成uid
		// 定义日期格式
		DateFormat dateFormat = new SimpleDateFormat("yyyyMMddhhmm");
		// 当前日期
		Date currentDate = new Date();
		// 将日期转换成字符串
		String dateStr = dateFormat.format(currentDate);
		long longdate = Long.parseLong(dateStr);

		long uid = longdate * 1000000 + (long) (Math.random() * 100000);
		return uid;
	}
}
