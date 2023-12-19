package com.pers.MyStore.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.TimeZone;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pers.MyStore.entity.Order;
import com.pers.MyStore.entity.Product;
import com.pers.MyStore.entity.ProductType;
import com.pers.MyStore.entity.User;
import com.pers.MyStore.entity.UserHistory;
import com.pers.MyStore.service.OrderService;
import com.pers.MyStore.service.ProductService;
import com.pers.MyStore.service.ProductTypeService;
import com.pers.MyStore.service.UserHistoryService;
import com.pers.MyStore.service.UserService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	UserService userService;
	@Autowired
	ProductService productService;
	@Autowired
	ProductTypeService productTypeService;
	@Autowired
	UserHistoryService userHistoryService;
	@Autowired
	OrderService orderService;

	@RequestMapping("/home")
	public String adminLogin(Model m) {
		// 返回后台管理页面
		m.addAttribute("productCount", productService.productCount());
		m.addAttribute("validProductCount", productService.validProductCount());
		m.addAttribute("orderCount", orderService.orderCount());
		m.addAttribute("orderCountToday", orderService.orderCountToday());
		m.addAttribute("orderSum", orderService.orderSum());
		m.addAttribute("orderSumToday", orderService.orderSumToday());
		m.addAttribute("userCount", userService.userCountValid());

		return "forward:/jsp_admin/home.jsp";
	}

	@RequestMapping("/productManage")
	public String productManage(HttpServletRequest request, Model m,
			@RequestParam(name = "productId", required = false) Long productId,
			@RequestParam(name = "productName", required = false) String productName,
			@RequestParam(name = "productType", required = false) Integer productType,
			@RequestParam(name = "productValid", required = false) Boolean productValid,
			@RequestParam(name = "productPriceLowerBound", required = false) BigDecimal productPriceLowerBound,
			@RequestParam(name = "productPriceUpperBound", required = false) BigDecimal productPriceUpperBound,
			@RequestParam(name = "productInventoryLowerBound", required = false) Integer productInventoryLowerBound,
			@RequestParam(name = "productInventoryUpperBound", required = false) Integer productInventoryUpperBound) {
		// 按照条件获取查询到的记录

		List<Product> products = productService.findByMutiConditions(productId, productName, productType,
				productPriceLowerBound, productPriceUpperBound, productInventoryLowerBound, productInventoryUpperBound,
				productValid);
		// List<Product> products = productService.findAll();
		m.addAttribute("products", products);
		List<ProductType> productTypes = productTypeService.findAll();
		m.addAttribute("productTypes", productTypes);
		return "forward:/jsp_admin/productManage.jsp";
	}

	@RequestMapping("/addProduct")
	public String addProduct(HttpServletRequest request, @RequestParam("product_name") String product_name,
			@RequestParam("product_price") BigDecimal product_price, @RequestParam("product_type") int product_type,
			@RequestParam("product_inventory") int product_inventory,
			@RequestParam("product_description") String product_description,
			@RequestParam(name = "photo", required = false) MultipartFile photo) {
		long product_id = productService.getProductId();
		Product product = new Product(product_id, product_name, product_description, product_price, product_type,
				product_inventory, true);
		// 在数据库中添加商品
		productService.addProduct(product);
		// 上传照片
		product.updatePhoto(photo);
		return "redirect:/admin/productManage";
	}

	@RequestMapping("/productInfo")
	public String productInfo(@RequestParam("product_id") long product_id, Model m) {
		// 从数据库根据id查到商品的信息
		Product product = productService.findProductById(product_id);
		if (product == null) {
			return "redirect:/admin/productManage";
		}
		List<Order> orders = orderService.findOrderByProduct(product_id);
		List<ProductType> productTypes = productTypeService.findAll();
		m.addAttribute("productTypes", productTypes);
		m.addAttribute("product", product);
		m.addAttribute("orders", orders);
		return "forward:/jsp_admin/productInfo.jsp";
	}

	@RequestMapping("/changeProductValid")
	public String changeProductValid(@RequestParam("product_id") long product_id, Model m) {
		// 从数据库根据id查到商品的信息
		productService.changeProductValid(product_id);

		return "redirect:/admin/productManage";
	}

	@RequestMapping("updateProduct")
	public String updateProduct(@RequestParam("product_id") long product_id,
			@RequestParam("product_name") String product_name, @RequestParam("product_price") BigDecimal product_price,
			@RequestParam("product_type") int product_type, @RequestParam("product_inventory") int product_inventory,
			@RequestParam("product_description") String product_description, RedirectAttributes attributes,
			@RequestParam(value = "photo", required = false) MultipartFile photo) {
		Product product = new Product(product_id, product_name, product_description, product_price, product_type,
				product_inventory, true);
		// 更新数据库
		if (productService.updateProduct(product) != 1)
			attributes.addAttribute("wrongMsg", "更新失败");
		attributes.addAttribute("product_id", product_id);
		// 更新商品图片
		product.updatePhoto(photo);
		return "redirect:/admin/productInfo";
	}

	@RequestMapping("/orderManage")
	public String orderManage(Model m, @RequestParam(name = "orderId", required = false) Long orderId,
			@RequestParam(name = "userId", required = false) Long userId,
			@RequestParam(name = "productId", required = false) Long productId,
			@RequestParam(name = "orderPriceLowerBound", required = false) BigDecimal orderPriceLowerBound,
			@RequestParam(name = "orderPriceUpperBound", required = false) BigDecimal orderPriceUpperBound,
			@RequestParam(name = "oderDateLowerBound", required = false) String oderDateLowerBoundString,
			@RequestParam(name = "oderDateUpperBound", required = false) String oderDateUpperBoundString) {
		// 返回订单详情
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT+8:00"));
		Date oderDateLowerBound = null;
		Date oderDateUpperBound = null;
		try {
			// 获取前端输入的日期
			oderDateLowerBound = sdf.parse(oderDateLowerBoundString);
			oderDateUpperBound = sdf.parse(oderDateUpperBoundString);
		} catch (Exception e) {
			;
		}
		if (oderDateUpperBound != null) {
			Calendar calendar = new GregorianCalendar();
			calendar.setTime(oderDateUpperBound);
			// 把日期往后增加一天,整数 往后推,负数往前移动
			calendar.add(Calendar.DATE, 1);
			// 这个时间就是日期往后推一天的结果
			oderDateUpperBound = calendar.getTime();
		}
		List<Order> orders = orderService.findByMutiConditions(orderId, userId, productId, orderPriceLowerBound,
				orderPriceUpperBound, oderDateLowerBound, oderDateUpperBound);
		m.addAttribute("orders", orders);
		return "forward:/jsp_admin/orderManage.jsp";
	}

	@RequestMapping("/userManage")
	public String userManage(Model m, @RequestParam(name = "userID", required = false) Long userID,
			@RequestParam(name = "username", required = false) String username,
			@RequestParam(name = "email", required = false) String email,
			@RequestParam(name = "nickname", required = false) String nickname,
			@RequestParam(name = "registerDateLowerBound", required = false) String registerDateLowerBoundString,
			@RequestParam(name = "registerDateUpperBound", required = false) String registerDateUpperBoundString) {
		// 返回用户详情
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setTimeZone(TimeZone.getTimeZone("GMT+8:00"));
		Date registerDateLowerBound = null;
		Date registerDateUpperBound = null;
		try {
			// 获取前端输入的日期
			registerDateLowerBound = sdf.parse(registerDateLowerBoundString);
			registerDateUpperBound = sdf.parse(registerDateUpperBoundString);
		} catch (Exception e) {
			;
		}
		List<User> users = userService.findByMutiConditions(userID, username,
				email,nickname,registerDateLowerBound,registerDateUpperBound);
		m.addAttribute("users", users);

		// Date registerDate = new SimpleDateFormat("yyyy-MM-dd").parse(time);

		return "forward:/jsp_admin/userManage.jsp";
	}

	@RequestMapping("/userInfo")
	public String userInfo(Model m, @RequestParam(name = "user_id") long user_id,
			@RequestParam(name = "showType", defaultValue = "0") int type) {
		// 查询数据库得到用户的浏览历史和购物历史
		User user = userService.findUserById(user_id);
		type = type > 2 ? 0 : type;
		if (user == null) {
			return "forward:/admin/userManage";
		}
		switch (type) {
		case 0:
			break;
		case 1:
			List<Order> orders = orderService.findOrderByUser(user_id);
			m.addAttribute("orders", orders);
			break;
		case 2:
			List<UserHistory> histories = userHistoryService.findHistoryByUserId(user_id);
			m.addAttribute("histories", histories);
			break;
		}
		m.addAttribute("userAdmin", user);
		m.addAttribute("showType", type);
		return "forward:/jsp_admin/userInfo.jsp";
	}

}
