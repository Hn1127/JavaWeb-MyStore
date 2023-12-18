package com.pers.MyStore.Filter;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;

import com.pers.MyStore.service.UserService;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import com.pers.MyStore.entity.User;

@Order(1)
@WebFilter(filterName = "AutoLogFilter", urlPatterns = { "/*" })
public class AutoLogFilter implements Filter {
	@Autowired
	UserService userService;

	public void doFilter(ServletRequest servletRequest,
			ServletResponse servletResponse,
			FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		// 检查session中是否有LogUser项
		if (request.getSession().getAttribute("LogUser") == null) {
			Cookie[] cookies = request.getCookies();
			String autologin = null;
			// 遍历所有cookie查找AutoLogUser
			for (int i = 0; cookies != null && i < cookies.length; ++i) {
				if ("AutoLogUser".equals(cookies[i].getName())) {
					autologin = cookies[i].getValue();
					break;
				}
			}
			if (autologin != null) {
				// 有登陆的信息，做自动登录
				// 将user的信息放入session域
				String[] parts = autologin.split("-");
				if (parts.length < 2) {
					// 信息不完整
					request.removeAttribute("AutoLogUser");
				} else {
					String username = parts[0];
					String codePassword = parts[1];	// cookie中加密后的密码
					User user = userService.findUserByUsernameValid(username);
					if (user != null) {
						if (codePassword.equals(user.getPassword())) {
							// 信息符合,将username放入session区域
							System.out.println("User-" + username + "-AutoLogin");
							request.getSession().setAttribute("LogUser", username);
							request.getSession().setAttribute("LogUserUin", user.getUin());
							request.getSession().setAttribute("UserNickname", user.getNickname());
						} else {
							// 信息不符，删除原有cookie，要求重新登录
							request.removeAttribute("AutoLogUser");
						}
					}
				}
			}
		}

		filterChain.doFilter(servletRequest, servletResponse);
	}

}
