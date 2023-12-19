package com.pers.MyStore.scheduled;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.pers.MyStore.entity.User;
import com.pers.MyStore.service.UserService;

@Component
public class ScheduledTaskTest {
	
	@Scheduled(fixedDelay = 1000000000) // 每10秒执行一次
	public void execute(){
        ;
    }
}