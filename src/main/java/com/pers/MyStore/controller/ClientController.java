package com.pers.MyStore.controller;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pers.MyStore.service.CartService;
import com.pers.MyStore.service.OrderService;
import com.pers.MyStore.service.ProductService;
import com.pers.MyStore.service.ProductTypeService;
import com.pers.MyStore.service.UserHistoryService;
import com.pers.MyStore.service.UserService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pers.MyStore.entity.Cart;
import com.pers.MyStore.entity.Order;
import com.pers.MyStore.entity.Product;
import com.pers.MyStore.entity.ProductType;
import com.pers.MyStore.entity.User;
import com.pers.MyStore.entity.UserHistory;
import com.pers.MyStore.entity.Cart;

// 每一个username对应一个uid，每一个uid对应一个uin，由uin获取用户的信息：昵称，购物车，订单信息等
// cookie中储存sessionid，sessionid对应uin，由此获取用户信息
// 若要更新password则根据uid-uin的一对一关系查找，进行更新

@Controller
public class ClientController {
	@Autowired
	private UserService userService;
	@Autowired
	private ProductService productService;
	@Autowired
	private ProductTypeService productTypeService;
	@Autowired
	private CartService cartService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private UserHistoryService userHistoryService;
	@Autowired
	private JavaMailSenderImpl mailSender;

	@RequestMapping("/")
	public String returnIndex(Model m, HttpServletRequest request) {
		String realPath=request.getSession().getServletContext().getRealPath("/");
		
		return "forward:/show?welcomeMsg=1";
	}

	@RequestMapping("/index")
	public String getIndex(Model m, HttpServletRequest request) {
		return "redirect:/";
	}

	@RequestMapping("/search")
	public String getSearch(@RequestParam("searchCondition") String searchCondition, Model m,
			HttpServletRequest request) {
		// 模糊匹配数据库
		List<Product> products = productService.findBySearchValid(searchCondition);
		m.addAttribute("products", products);
		List<ProductType> productTypes = productTypeService.findAll();
		// 为request添加商品类型的对象
		m.addAttribute("productTypes", productTypes);
		m.addAttribute("title", searchCondition);
		m.addAttribute("welcomeMsg", "共查询到[" + products.size() + "]件商品");
		// 从数据库获取商品信息
		return "forward:/jsp_client/show.jsp";
	}

	@RequestMapping("/show")
	public String getProduct(@RequestParam(name = "welcomeMsg", required = false) String welcomeMsg,
			@RequestParam(name = "type", required = false) Integer producttype,
			@RequestParam(name = "showAll", defaultValue = "0") Boolean showAll, Model m, HttpServletRequest request) {
		// 获取商品列表
		List<Product> products;
		// 获取商品类型
		List<ProductType> productTypes = productTypeService.findAll();
		// 为request添加商品类型的对象
		m.addAttribute("productTypes", productTypes);
		if (producttype == null) {
			// 判断是否为分类页
			if (showAll == true) { // 判断是否为全部展示页
				products = productService.findAllValid();
				m.addAttribute("title", "全部");
				m.addAttribute("color", "all");
			}
			else {
				m.addAttribute("title", "首页");
				m.addAttribute("color", "index");
				products = productService.findAllLimitValid(12);
			}
		} else {
			// 分类页
			products = productService.findByTypeValid(producttype);
			m.addAttribute("title", productTypeService.getRealtype(producttype));
			m.addAttribute("color", producttype);
		}
		// 设置欢迎信息
		if (welcomeMsg != null) {
			welcomeMsg = "为您推荐";
		} else {
			welcomeMsg = "共查询到[" + products.size() + "]件商品";
		}
		m.addAttribute("products", products);
		m.addAttribute("welcomeMsg", welcomeMsg);
		return "forward:/jsp_client/show.jsp";
	}

	@RequestMapping("/productInfo")
	public String getIndex(Model m, HttpServletRequest request, @RequestParam(name = "product_id") long product_id) {
		Long uin = (Long) request.getSession().getAttribute("LogUserUin");
		Product product = productService.findProductById(product_id);
		// 商品不存在将返回首页
		if (product == null)
			return "redirect:/";
		if (uin != null) {
			// 只有登陆时记录浏览历史
			UserHistory history = new UserHistory(uin, product_id);
			userHistoryService.addHistory(history);
		}
		// 查找商品类型
		List<ProductType> productTypes = productTypeService.findAll();
		m.addAttribute("productTypes", productTypes);
		m.addAttribute("product", product);
		return "forward:/jsp_client/productInfo.jsp";
	}

	@RequestMapping("/orderlist")
	public String getOrderlist(Model m, HttpServletRequest request) {
		Long uin = (Long) request.getSession().getAttribute("LogUserUin");
		if (uin == null) {
			return "redirect:/login";
		}
		// 每次进入订单页面刷新session中的orders
		List<Order> orders = orderService.findOrderByUserWithPname(uin);
		request.getSession().setAttribute("orders", orders);
		// 从cart页面获取用户select的商品，以及修改过的carts
		return "forward:/jsp_client/orderlist.jsp";
	}

	@RequestMapping("/history")
	public String getUserHistory(Model m, HttpServletRequest request) {
		Long user_id = (Long) request.getSession().getAttribute("LogUserUin");
		if (user_id == null) {
			return "redirect:/login";
		}
		// 查找相关的浏览记录
		List<UserHistory> histories = userHistoryService.findHistoryByUserId(user_id);
		m.addAttribute("histories", histories);
		return "forward:/jsp_client/history.jsp";
	}

	@RequestMapping("/removeOrder")
	public String removeOrder(Model m, HttpServletRequest request,
			@RequestParam(name = "order_id", required = false) Long order_id) {
		// 只有与自己的uin相同的order才能删除
		Long uin = (Long) request.getSession().getAttribute("LogUserUin");
		if (uin == null) {
			return "redirect:/login";
		}
		if (order_id == null) {
			return "redirect:/orderlist";
		}
		orderService.removeOrder(uin, order_id);
		// 从cart页面获取用户select的商品，以及修改过的carts
		return "redirect:/orderlist";
	}

	@RequestMapping("/cart")
	public String getCart(Model m, HttpServletRequest request) {
		Long uin = (Long) request.getSession().getAttribute("LogUserUin");
		if (uin == null) {
			return "redirect:/login";
		}
		// 每次进入购物车页面刷新session中的carts项
		List<Cart> carts = cartService.findCartByUserID(uin);
		request.getSession().setAttribute("carts", carts);
		// 从cart页面获取用户select的商品，以及修改过的carts
		return "forward:/jsp_client/cart.jsp";
	}

	@RequestMapping("/addToCart")
	public String addToCart(@RequestParam("product_id") long product_id, @RequestParam("product_num") int product_num,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		Long user_id = (Long) request.getSession().getAttribute("LogUserUin");
		if(user_id==null)
			return "redirect:/login";
		Cart cart = new Cart(user_id, product_id, product_num);
		cartService.addCart(cart);
		redirectAttributes.addAttribute("product_id", product_id);
		return "redirect:/productInfo";
	}

	@RequestMapping("/buyDirect")
	public String buyDirect(@RequestParam("product_id") List<Long> product_id,
			@RequestParam("product_num") int product_num, HttpServletRequest request) {
		Long user_id = (Long) request.getSession().getAttribute("LogUserUin");
		if(user_id==null)
			return "redirect:/login";
		Cart cart = new Cart(user_id, product_id.get(0), product_num);
		cartService.addCart(cart);
		// 先加入购物车
		List<Cart> orderCarts = cartService.findCartByProductsID(user_id, product_id);

		request.getSession().setAttribute("orderCarts", orderCarts);
		return "forward:/jsp_cart/getOrderInfo.jsp";
	}

	@RequestMapping("/getOrderInfo")
	public String getOrderInfo(Model m, HttpServletRequest request,
			@RequestParam(name = "selectProduct", required = false) List<Long> selectProducts,
			@RequestParam(name = "product_id", required = false) List<Long> products_id,
			@RequestParam(name = "product_num", required = false) List<Integer> products_num) {
		long user_id = (long) request.getSession().getAttribute("LogUserUin");
		// 保证参数有效
		if (selectProducts == null)
			return "redirect:/cart";
		if (products_id == null)
			return "redirect:/cart";
		if (products_num == null)
			return "redirect:/cart";
		// 首先更新cart
		cartService.updateCarts(user_id, products_id, products_num);
		List<Cart> orderCarts = cartService.findCartByProductsID(user_id, selectProducts);
		m.addAttribute("selectProducts", selectProducts);
		request.getSession().setAttribute("orderCarts", orderCarts);
		// 从数据库再次查询到选中商品的信息
		return "forward:/jsp_cart/getOrderInfo.jsp";
	}

	@RequestMapping("/saveCart")
	public String saveCart(HttpServletRequest request,
			@RequestParam(name = "product_id", required = false) List<Long> products_id,
			@RequestParam(name = "product_num", required = false) List<Integer> products_num) {
		if (products_id == null)
			return "redirect:/cart";
		if (products_num == null)
			return "redirect:/cart";
		long user_id = (long) request.getSession().getAttribute("LogUserUin");
		cartService.updateCarts(user_id, products_id, products_num);
		return "forward:/cart";
	}

	@RequestMapping("/removeFromCart")
	public String removeFromCart(HttpServletRequest request, @RequestParam("product_id") long product_id) {
		Long user_id = (Long) request.getSession().getAttribute("LogUserUin");
		if (user_id == null) {
			return "redirect:/login";
		}
		cartService.removeCart(user_id, product_id);
		return "redirect:/cart";
	}

	@RequestMapping("/cashier")
	public String cashier(HttpServletRequest request) {
		// 生成订单放进session
		// 成功支付后再写入数据库
		long user_id = (long) request.getSession().getAttribute("LogUserUin");
		List<Order> orders = new ArrayList<Order>();
		// 获取将要购买的cart项
		List<Cart> carts = (List<Cart>) request.getSession().getAttribute("orderCarts");
		if (carts == null)
			return "redirect:/cart";
		// 记录总价
		BigDecimal total_price = new BigDecimal(0);
		for (Cart cart : carts) {
			// 根据cart项生成订单
			Order order = new Order(orderService.getOrderId(), user_id, cart.getProduct_id(), cart.getProduct_price(),
					cart.getQuantity(), cart.getTotalPrice());
			orders.add(order);
			total_price = total_price.add(cart.getTotalPrice());
		}
		// 将订单信息和总价均放在session中
		request.getSession().setAttribute("payOrders", orders);
		request.getSession().setAttribute("total_price", total_price);
		return "forward:/jsp_cart/cashier.jsp";
	}

	@RequestMapping("/pay")
	public String pay() {
		// 模拟支付
		return "forward:payOver";
	}

	@RequestMapping("/payOver")
	public String payOver(HttpServletRequest request) {
		// 将session.payOrders添加到数据库表order
		// 根据每个order的product_id和quantity更新数据库product
		long user_id = (long) request.getSession().getAttribute("LogUserUin");
		// 获取已支付的订单订单项
		List<Order> orders = (List<Order>) request.getSession().getAttribute("payOrders");
		// 获取订单项对应的购物车项
		List<Cart> carts = (List<Cart>) request.getSession().getAttribute("orderCarts");
		for (Order order : orders) {
			// 将订单加入数据库
			orderService.addOrder(order);
			// 减少商品库存
			productService.buyProduct(order.getProduct_id(), order.getQuantity());
			// 从用户购物车中移除支付了的商品
			cartService.removeCart(user_id, order.getProduct_id());
		}
		// 从数据库中读取用户信息，以获得用户邮箱
		User user = userService.findUserById(user_id);
		SimpleMailMessage message = new SimpleMailMessage();
		message.setSubject("收货通知");
		String msg = "您刚刚在我平台购买的";
		// 设置邮件内容
		for (Cart cart : carts) {
			msg += "【";
			msg += cart.getProduct_name();
			msg += "】x";
			msg += cart.getQuantity();
			msg += ",";
		}
		msg += "共花费";
		msg += request.getSession().getAttribute("total_price");
		msg += "元,请您查收!";
		// 设置邮件内容
		message.setText(msg);
		message.setTo(user.getEmail());
		message.setFrom("2909448453@qq.com");
		try {
			mailSender.send(message);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("邮件发送至" + user.getEmail() + "失败");
		}

		return "forward:/jsp_cart/payOver.jsp";
	}

	@RequestMapping("/userInfo")
	public String getUserInfo(HttpServletRequest request) {
		Long uin = (Long) request.getSession().getAttribute("LogUserUin");
		if (uin == null) {
			return "redirect:/login";
		}
		User user = userService.findUserById(uin);
		request.getSession().setAttribute("userInfo", user);
		return "forward:/jsp_client/userInfo.jsp";
	}

	@RequestMapping("/nicknameUpdate")
	public String nicknameUpdate(HttpServletRequest request, @RequestParam("nickname") String nickname) {
		long uin = (long) request.getSession().getAttribute("LogUserUin");
		userService.nicknameUpdate(uin, nickname);
		request.getSession().setAttribute("UserNickname", nickname);
		return "redirect:/userInfo";
	}

	@RequestMapping("/passwordUpdate")
	public String passwordUpdate(HttpServletRequest request) {
		return "forward:/jsp_client/passwordUpdate.jsp";
	}

	@RequestMapping("/passwordUpdateSuccess")
	public String passwordUpdateSuccess(RedirectAttributes redirectAttributes, HttpServletRequest request,
			@RequestParam("oldPassword") String oldPassword, @RequestParam("newPassword") String newPassword) {
		long uin = (long) request.getSession().getAttribute("LogUserUin");
		String relpassward = DigestUtils.md5DigestAsHex(((String) oldPassword).getBytes());
		if (userService.checkUser(uin, relpassward).equals("")) {
			// 密码正确
			relpassward = DigestUtils.md5DigestAsHex(((String) newPassword).getBytes());
			userService.passwordUpdate(uin, relpassward);
			return "forward:/LoginOut";
		}
		redirectAttributes.addFlashAttribute("wrongMsg", "旧密码错误");
		return "redirect:/passwordUpdate";
	}

	@RequestMapping("/emailUpdate")
	public String emailUpdate(HttpServletRequest request) {
		return "forward:/jsp_client/emailUpdate.jsp";
	}

	@RequestMapping("/emailUpdateSuccess")
	public String emailUpdateSuccess(RedirectAttributes redirectAttributes, HttpServletRequest request,
			@RequestParam("newEmail") String newEmail) {
		long uin = (long) request.getSession().getAttribute("LogUserUin");
		userService.emailUpdate(uin, newEmail);

		// redirectAttributes.addFlashAttribute("wrongMsg", "错误提示");
		return "redirect:/userInfo";
	}

}
