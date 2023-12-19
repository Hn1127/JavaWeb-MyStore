package com.pers.MyStore.controller;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pers.MyStore.entity.Order;
import com.pers.MyStore.entity.Product;
import com.pers.MyStore.entity.User;
import com.pers.MyStore.service.OrderService;
import com.pers.MyStore.service.ProductService;
import com.pers.MyStore.service.UserService;

import jakarta.servlet.http.HttpSession;

@RestController
public class TestRestController {
	@Autowired
	private UserService userService;
	@Autowired
	private ProductService productService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@RequestMapping("findAllUsers")
	public List<User> findUsers() {
		return userService.findAll();
	}

	@RequestMapping("/image/upload")
	public ModelAndView upload(MultipartFile photo) throws IOException {
		ModelAndView mv = new ModelAndView();
		// 判断用户是否上传了文件
		if (!photo.isEmpty()) {

			// 文件上传的地址
			String realPath = "D:\\Elipse-WorkSpace\\MyStore\\src\\main\\resources\\static\\images\\products";
			// 用于查看路径是否正确
			System.out.println(realPath);

			// 获取文件的名称
			final String fileName = photo.getOriginalFilename();

			// 限制文件上传的类型
			String contentType = photo.getContentType();
			if ("image/png".equals(contentType) || "image/jpg".equals(contentType)) {
				File file = new File(realPath, fileName);
				file.createNewFile();

				// 完成文件的上传
				photo.transferTo(file);
				System.out.println("图片上传成功!");
				String path01 = "../upload/" + fileName;
				mv.addObject("path", path01);
				mv.setViewName("lookphoto");
				return mv;
			} else {
				System.out.println("上传失败！");
				mv.setViewName("upload");
				return mv;
			}
		} else {
			System.out.println("上传失败！");
			mv.setViewName("upload");
			return mv;
		}
	}

	@RequestMapping("/dashboard")
	public String dashboard(HttpSession session) {
		// 获取用户 ID
		String userId = (String) session.getAttribute("userId");
		// 根据用户 ID 识别当前是哪一个用户
		return userId;
	}

	@RequestMapping("/dateTest")
	public Date dateTest() {
		long uid = userService.getUid();
		long createtime = uid / 100000;
		return new Date(createtime);

	}

	@RequestMapping("/userTest")
	public List<User> userTest() {
		return userService.findAll();

	}

	@RequestMapping("/productTest")
	public List<Product> productTest() {
		return productService.findAll();

	}

	@RequestMapping("/orderTest")
	public String orderTest() {
		List<Order> orders = orderService.findAll();
		Order order = orders.get(0);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(order.getOrder_date());
	}

	@RequestMapping("/addorderTest")
	public int addorderTest() {
		long pid = 170154149564602584L;
		BigDecimal tprice = new BigDecimal(0);
		BigDecimal pprice = new BigDecimal(0);
		Date date = new Date(1);
		//public Order(long order_id, long user_id, long product_id, BigDecimal product_price, int quantity,
		//		BigDecimal total_price, Date order_date)
		Order order = new Order(orderService.getOrderId(), 1L, pid,pprice, 1, tprice, date);
		return orderService.addOrder(order);
	}
	
	@RequestMapping("/mailTest")
	public SimpleMailMessage mailTest() {
		SimpleMailMessage message = new SimpleMailMessage();
        message.setSubject("古德猫宁");
        message.setText("发现邮件原来发起来这么容易");
        message.setTo("2909448453@qq.com");
        message.setFrom("2909448453@qq.com");
 
        mailSender.send(message);
        return message;
	}
}
