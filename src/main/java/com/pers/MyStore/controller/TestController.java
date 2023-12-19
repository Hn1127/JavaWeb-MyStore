package com.pers.MyStore.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pers.MyStore.entity.User;
import com.pers.MyStore.service.UserService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class TestController {
	@Autowired
	private UserService userService;
	
	@RequestMapping("/TestRedirect")
	public String redirect(RedirectAttributes attributes) {
	    attributes.addFlashAttribute("WrongMsg", "Hello, World!");
	    return "redirect:/login";
	}
	
	@RequestMapping("/LoginTest")
    public String login(HttpServletRequest request,HttpServletResponse response) {
        
        return "forward:WEB-INF/jsp/client/test.jsp";
    }
}
