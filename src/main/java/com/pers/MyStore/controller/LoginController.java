package com.pers.MyStore.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pers.MyStore.service.ProductService;
import com.pers.MyStore.service.UserService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pers.MyStore.entity.Product;
import com.pers.MyStore.entity.User;

// 每一个username对应一个uid，每一个uid对应一个uin，由uin获取用户的信息：昵称，购物车，订单信息等
// cookie中储存sessionid，sessionid对应uin，由此获取用户信息
// 若要更新password则根据uid-uin的一对一关系查找，进行更新

@Controller
public class LoginController {
	@Autowired
	private UserService userService;
	@Autowired
	private ProductService productService;

	@RequestMapping("/register")
	public String clientRegister(Model m, @RequestParam(name = "WrongMsg", required = false) String WrongMsg) {
		// 处理register请求,返回register页面
		m.addAttribute("WrongMsg", WrongMsg);
		return "forward:/jsp_login/register.jsp";
	}

	@RequestMapping("/registerSuccess")
	public String registerSuccess(Model m, @RequestParam("username") Object username,
			@RequestParam("password") Object password, @RequestParam("email") Object email,
			RedirectAttributes attributes, HttpServletRequest request, HttpServletResponse response) {
		// 此时已经check注册信息
		// 将用户信息填入数据库，为浏览器添加识别cookie/将sessionid追加到url中

		// 若该username已存在，将Msg返回给register
		if (userService.findUserByUsernameValid((String) username) != null) {
			attributes.addAttribute("WrongMsg", "用户名已存在");
			return "redirect:/register";
		}

		// 密码加密
		String relpassward = DigestUtils.md5DigestAsHex(((String) password).getBytes());
		// cookie中存放username和password, username-password
		String cookieval = (String) username + "-" + relpassward;
		Cookie cookie = new Cookie("AutoLogUser", cookieval);
		// cookie.setDomain(""); // 设置域名
		cookie.setPath("/");
		cookie.setMaxAge(60 * 60); // 默认有效期为60min
		long uid = userService.getUid();
		String nickname = (String) username;
		User user = new User(uid, (String) username, nickname, (String) relpassward, (String) email,
				new Date(System.currentTimeMillis()));
		// 调用service方法将其加入数据库
		userService.addUser(user);
		response.addCookie(cookie);
		request.getSession().setAttribute("LogUser", username);
		request.getSession().setAttribute("LogUserUin", user.getUin());
		request.getSession().setAttribute("UserNickname", nickname);
		// 为request添加cookie，cookie key为autologin，val由username和加密后的password构成
		// 设置sessionid的值为username的uid
		return "forward:/jsp_login/registerSuccess.jsp";
	}

	@RequestMapping("/login")
	public String clientLogin(Model m, @RequestParam(name = "WrongMsg", required = false) String WrongMsg) {
		// 处理login请求,返回login页面
		m.addAttribute("WrongMsg", WrongMsg);
		return "forward:/jsp_login/loginin.jsp";
	}

	@RequestMapping("/loginSuccess")
	public String registerSuccess(Model m, RedirectAttributes attributes,
			@RequestParam("username") Object username,
			@RequestParam("password") Object password,
			@RequestParam("remember") Object remember,
			HttpServletResponse response) {
		// 检查表单提交的信息是否与数据库中一致
		String Msg;
		String relpassward = DigestUtils.md5DigestAsHex(((String) password).getBytes());
		Msg = userService.checkUser((String) username, (String) relpassward);
		if (Msg.equals("")) {
			// 信息正确，设置cookie  username——password的形式
			// 根据remember的值判断是否记住用户
			// 若记住用户则将cookie的有效期设为30天
			// 确保只有一个username，要将原有可能存在的username清空
			// 使用cookie中的username记录当前是哪一个用户
			// 每次登录时将cookie中的user记录在session中
			String cookieval = (String) username + "-" + relpassward;
			Cookie cookie = new Cookie("AutoLogUser", cookieval);
			// cookie.setDomain(""); // 设置域名
			cookie.setPath("/");
			cookie.setMaxAge(60 * 60); // 默认有效期为60min
			if (remember != null) {
				// 记住用户
				// 将cookie有效期设为30x24x60x60
				cookie.setMaxAge(30 * 24 * 60 * 60); // 有效期设为30天,登录时检查这个时间，若大于60min则更新时间
			}
			response.addCookie(cookie);
			if (username.equals("admin")) // 管理员账户进入后台网站
				return "redirect:/admin/home";
			return "redirect:/";
		}
		attributes.addAttribute("WrongMsg", Msg);
		return "redirect:login";
	}

	@RequestMapping("/LoginOut")
	public String clientLogOut(HttpServletRequest request, HttpServletResponse response) {
		// 删除Session域中对象
		request.getSession().removeAttribute("LogUser");
		request.getSession().removeAttribute("LogUserUin");
		request.getSession().removeAttribute("UserNickname");
		// 删除cookie中用户信息
		// 为response添加一个同名但存活0的cookie
		// 路径和域名要一致
		Cookie cookie = new Cookie("AutoLogUser", null);
		cookie.setMaxAge(0);
		cookie.setPath("/");
		cookie.setDomain(null);
		response.addCookie(cookie);
		return "redirect:/";
	}

	@RequestMapping("/deleteUser")
	public String deleteUser(HttpServletRequest request, HttpServletResponse response) {
		Long uin = (Long) request.getSession().getAttribute("LogUserUin");
		if (uin != null) {
			userService.passwordUpdate(uin, "0");
			return "forward:/LoginOut";
		}
		return "redirect:/";
	}
}
