package com.secondshop.controllers;

import com.secondshop.models.*;
import com.secondshop.services.*;
import com.secondshop.utils.FileCheck;
import com.secondshop.utils.InfoCheck;
import com.secondshop.utils.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping(value = "user")
public class UserController {
	private final GoodService goodService;
	private final OrderService orderService;
	private final ReviewService reviewService;
	private final UserService userService;
	private final CollectService collectService;

	@Autowired
	public UserController(GoodService goodService, OrderService orderService,
			ReviewService reviewService, UserService userService,
			CollectService collectService) {
		this.goodService = goodService;
		this.orderService = orderService;
		this.reviewService = reviewService;
		this.userService = userService;
		this.collectService = collectService;
	}

	@RequestMapping(value = "userProfile", method = RequestMethod.GET)
	public String getMyProfile(ModelMap model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}
		List<Collect> collects = collectService
				.getCollectByUserId(user.getId());
		for (Collect collect : collects) {
			collect.setGood(goodService.getGoodById(collect.getGoodId()));
		}
		List<Good> goods = goodService.getGoodByUserId(user.getId());
		List<Order> orders = orderService.getOrderByCustomerId(user.getId());
		List<Review> reviews = reviewService.gerReviewByToUserId(user.getId());
		List<Reply> replies = reviewService.gerReplyByToUserId(user.getId());
		List<Order> sellGoods = orderService.getOrderBySellerId(user.getId());
		model.addAttribute("collects", collects);
		model.addAttribute("goods", goods);
		model.addAttribute("orders", orders);
		model.addAttribute("reviews", reviews);
		model.addAttribute("replies", replies);
		model.addAttribute("sellGoods", sellGoods);
		return "user/userProfile";
	}

	@RequestMapping(value = "/review", method = RequestMethod.GET)
	public String getReviewInfo(@RequestParam(required = false) Integer goodId,
			@RequestParam(required = false) Integer reviewId) {
		System.out.println("reviewId" + reviewId);
		if (reviewId != null) {
			System.out.println("reviewId" + reviewId);
			if (reviewService.updateReviewStatus(1, reviewId) == 1) {
				return "redirect:/goods/goodInfo?goodId=" + goodId;
			}
		}
		return "redirect:/user/userProfile";
	}

	@RequestMapping(value = "/reply", method = RequestMethod.GET)
	public String getReplyInfo(
			@RequestParam(required = false) Integer reviewId,
			@RequestParam(required = false) Integer replyId) {
		if (replyId != null) {
			if (reviewService.updateReplyStatus(1, replyId) == 1) {
				Integer goodId = reviewService.getGoodIdByReviewId(reviewId);
				return "redirect:/goods/goodInfo?goodId=" + goodId;
			}
		}
		return "redirect:/user/userProfile";
	}

	@RequestMapping(value = "/userEdit", method = RequestMethod.GET)
	public String getUserEdit(ModelMap model,
			@RequestParam(value = "userId", required = false) Integer userId,
			HttpSession session) {
		User sessionUser = (User) session.getAttribute("user");
		if (sessionUser == null) {
			return "redirect:/";
		}
		User user = userService.getUserById(userId);
		List<Order> sellGoods = orderService.getOrderBySellerId(user.getId());
		List<Review> reviews = reviewService.gerReviewByToUserId(user.getId());
		List<Reply> replies = reviewService.gerReplyByToUserId(user.getId());
		model.addAttribute("user", user);
		model.addAttribute("sellGoods", sellGoods);
		model.addAttribute("reviews", reviews);
		model.addAttribute("replies", replies);
		return "user/userEdit";
	}

	@RequestMapping(value = "/userEdit", method = RequestMethod.POST)
	public String postUserEdit(ModelMap model, @Valid User user,
			HttpSession session,
			@RequestParam(value = "photo", required = false) MultipartFile photo)
			throws IOException {
		String status;
		Boolean insertSuccess;
		User sessionUser = (User) session.getAttribute("user");
		user.setId(sessionUser.getId());
		InfoCheck infoCheck = new InfoCheck();
		if (!infoCheck.isMobile(user.getMobile())) {
			status = "请输入正确的手机号！";
		} else if (!infoCheck.isEmail(user.getEmail())) {
			status = "请输入正确的邮箱！";
		} else if (userService.getUserByMobile(user.getMobile()).getId() != user
				.getId()) {
			System.out.println(userService.getUserByMobile(user.getMobile())
					.getId() + " " + user.getId());
			status = "此手机号码已使用！";
		} else if (userService.getUserByEmail(user.getEmail()).getId() != user
				.getId()) {
			status = "此邮箱已使用！";
		} else {
			if (!photo.isEmpty()) {
				RandomString randomString = new RandomString();
				FileCheck fileCheck = new FileCheck();
				String filePath = "/statics/image/photos/" + user.getId();
				String pathRoot = fileCheck.checkGoodFolderExist(filePath);
				String fileName = user.getId()
						+ randomString.getRandomString(10);
				String contentType = photo.getContentType();
				String imageName = contentType.substring(contentType
						.indexOf("/") + 1);
				String name = fileName + "." + imageName;
				photo.transferTo(new File(pathRoot + name));
				String photoUrl = filePath + "/" + name;
				user.setPhotoUrl(photoUrl);
			} else {
				String photoUrl = userService.getUserById(user.getId())
						.getPhotoUrl();
				user.setPhotoUrl(photoUrl);
			}
			insertSuccess = userService.updateUser(user);
			if (insertSuccess) {
				session.removeAttribute("user");
				session.setAttribute("user", user);
				return "redirect:/user/userProfile";
			} else {
				status = "修改失败！";
				model.addAttribute("user", user);
				model.addAttribute("status", status);
				return "user/userEdit";
			}
		}
		System.out.println(user.getMobile());
		System.out.println(status);
		model.addAttribute("user", user);
		model.addAttribute("status", status);
		return "user/userEdit";
	}

	@RequestMapping(value = "/password/edit", method = RequestMethod.POST)
	public ResponseEntity editPassword(@RequestBody Password password) {
		User user = userService.getUserById(password.getUserId());
		String oldPass = DigestUtils
				.md5DigestAsHex((password.getOldPassword() + user.getCode())
						.getBytes());
		if (oldPass.equals(user.getPassword())) {
			RandomString randomString = new RandomString();
			String code = (randomString.getRandomString(5));
			String md5Pass = DigestUtils.md5DigestAsHex((password
					.getNewPassword() + code).getBytes());
			Boolean success = userService.updatePassword(md5Pass, code,
					password.getUserId());
			if (success) {
				return ResponseEntity.ok(true);
			} else {
				return ResponseEntity.ok("密码修改失败！");
			}
		} else {
			return ResponseEntity.ok("原密码输入不正确！");
		}
	}

}
