package com.secondshop.controllers;

import com.secondshop.models.*;
import com.secondshop.services.*;
import com.secondshop.utils.FileCheck;
import com.secondshop.utils.RandomString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller
public class GoodController {

	private final GoodService goodService;
	private final TypeService typeService;
	private final ReviewService reviewService;
	private final UserService userService;
	private final ImageService imageService;
	private final CollectService collectService;

	private static String message = "";

	@Autowired
	public GoodController(GoodService goodService, TypeService typeService,
			ReviewService reviewService, UserService userService,
			ImageService imageService, CollectService collectService) {
		this.goodService = goodService;
		this.typeService = typeService;
		this.reviewService = reviewService;
		this.userService = userService;
		this.imageService = imageService;
		this.collectService = collectService;
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String getHomeGoods(
			ModelMap model,
			@RequestParam(required = false, defaultValue = "") String searchText,
			@RequestParam(required = false) Integer secondTypeId,
			@RequestParam(required = false, defaultValue = "0") int offset,
			@RequestParam(required = false, defaultValue = "20") int limit) {
		List<Good> goods = goodService.getGoodsBySearchAndType(searchText,
				secondTypeId, offset, limit);
		double goodsNum = goodService.getGoodsBySearchAndTypeCount(searchText,
				secondTypeId);
		List<FirstType> firstTypes = typeService.getAllFirstType();
		for (FirstType firstType : firstTypes) {
			firstType.setSecondType(typeService
					.getSecondTypeByFirstTypeId(firstType.getId()));
		}
		model.addAttribute("firstTypes", firstTypes);
		model.addAttribute("goods", goods);
		model.addAttribute("pages", Math.ceil(goodsNum / limit));
		model.addAttribute("goodsNum", goodsNum);
		model.addAttribute("offset", offset);
		model.addAttribute("limit", limit);
		return "home/homeGoods";
	}

	@RequestMapping(value = "/goods/goodInfo", method = RequestMethod.GET)
	public String getGoodInfo(ModelMap model, HttpSession httpSession,
			@RequestParam(required = false) Integer goodId) {
		Good goodInfo = goodService.getGoodById(goodId);
		if (goodInfo == null) {
			return "goods/error";
		}
		Integer collect = 1;
		User user = (User) httpSession.getAttribute("user");
		if (user == null) {
			collect = 0;
		} else {
			if (collectService.getCollect(goodId, user.getId())) {
				collect = 2;
			}
		}
		List<Image> images = imageService.getImageByGoodId(goodId);
		User goodUser = userService.getUserById(goodInfo.getUserId());
		goodInfo.setGoodUser(userService.getUserById(goodInfo.getUserId()));
		goodInfo.setGoodSecondType(typeService.getSecondTypeById(goodInfo
				.getSecondTypeId()));
		List<Review> reviews = reviewService.gerReviewByGoodId(goodId);
		for (Review review : reviews) {
			review.setReplys(reviewService.gerReplyByReviewId(review.getId()));
		}
		List<Good> goods = goodService.getRECGoods(goodInfo.getSecondTypeId(),
				goodInfo.getId());
		model.addAttribute("message", message);
		model.addAttribute("reviews", reviews);
		model.addAttribute("goodInfo", goodInfo);
		model.addAttribute("images", images);
		model.addAttribute("goodUser", goodUser);
		model.addAttribute("goods", goods);
		model.addAttribute("collect", collect);
		message = "";
		return "goods/goodInfo";
	}

	@RequestMapping(value = "/goods/goodInfo", method = RequestMethod.POST)
	public String putReview(
			@RequestParam(value = "goodId", required = false) Integer goodId,
			@RequestParam(value = "reviewId", required = false) Integer reviewId,
			@RequestParam(value = "fromUserId", required = false) Integer fromUserId,
			@RequestParam(value = "toUserId", required = false) Integer toUserId,
			@RequestParam(value = "fromUser", required = false) String fromUser,
			@RequestParam(value = "toUser", required = false) String toUser,
			@RequestParam(value = "replyText", required = false, defaultValue = "") String replyText,
			@RequestParam(value = "reviewText", required = false, defaultValue = "") String reviewText) {
		if (reviewText.equals("")) {
			if (replyText.equals("")) {
				message = "内容不能为空！";
				return "redirect:/goods/goodInfo?goodId=" + goodId;
			} else {
				Reply reply = new Reply();
				reply.setReviewId(reviewId);
				reply.setFromUser(fromUser);
				reply.setFromUserId(fromUserId);
				reply.setToUser(toUser);
				reply.setToUserId(toUserId);
				reply.setText(replyText);
				if (reviewService.insertReply(reply) == 1) {
					message = "回复成功！";
					return "redirect:/goods/goodInfo?goodId=" + goodId;
				} else {
					message = "回复失败！";
					return "redirect:/goods/goodInfo?goodId=" + goodId;
				}
			}
		} else {
			Review review = new Review();
			review.setGoodId(goodId);
			review.setFromUser(fromUser);
			review.setFromUserId(fromUserId);
			review.setToUserId(toUserId);
			review.setText(reviewText);
			if (reviewService.insertReview(review) == 1) {
				message = "评论成功！";
				return "redirect:/goods/goodInfo?goodId=" + goodId;
			} else {
				message = "评论失败！";
				return "redirect:/goods/goodInfo?goodId=" + goodId;
			}
		}
	}

	@RequestMapping(value = "/goods/publishGood", method = RequestMethod.GET)
	public String getPublishGood(ModelMap model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}
		Good good = new Good();
		List<FirstType> firstTypes = typeService.getAllFirstType();
		List<Good> goods = goodService.getAllGoods(0, 5);
		model.addAttribute("goods", goods);
		model.addAttribute("good", good);
		model.addAttribute("firstTypes", firstTypes);
		return "goods/publishGood";
	}

	@RequestMapping(value = "/goods/publishGood", method = RequestMethod.POST)
	public String getGoodId(ModelMap model, HttpSession session,
			@Valid Good good) {
		List<FirstType> firstTypes = typeService.getAllFirstType();
		User user = (User) session.getAttribute("user");
		List<Good> goods = goodService.getAllGoods(0, 5);
		good.setUserId(user.getId());
		good.setPhotoUrl("/statics/image/goods/default/nophoto.png");
		if (goodService.insertGood(good) != 1) {
			System.out.println("插入物品失败！");
		}
		model.addAttribute("goods", goods);
		model.addAttribute("good", good);
		model.addAttribute("firstTypes", firstTypes);
		return "goods/publishGood";
	}

	@RequestMapping(value = "/goods/publishGood/uploadImage", method = RequestMethod.POST)
	public String uploadImage(
			HttpSession session,
			@RequestParam(value = "goodId", required = false) Integer goodId,
			@RequestParam(value = "mainFile", required = false) MultipartFile mainFile,
			@RequestParam(value = "file", required = false) MultipartFile[] file)
			throws IOException {
		User user = (User) session.getAttribute("user");
		FileCheck fileCheck = new FileCheck();
		RandomString randomString = new RandomString();
		String filePath = "/statics/image/goods/" + user.getId() + "/" + goodId;
		String pathRoot = fileCheck.checkGoodFolderExist(filePath);
		String name;
		if (!mainFile.isEmpty()) {
			String fileName = goodId + randomString.getRandomString(10);
			String contentType = mainFile.getContentType();
			String imageName = contentType
					.substring(contentType.indexOf("/") + 1);
			name = fileName + "." + imageName;
			mainFile.transferTo(new File(pathRoot + name));
			String photoUrl = filePath + "/" + name;
			goodService.updateGoodPhotoUrl(photoUrl, goodId);
		}
		for (MultipartFile mf : file) {
			if (!mf.isEmpty()) {
				// 生成uuid作为文件名称
				String fileName = goodId + randomString.getRandomString(10);
				// 获得文件类型（可以判断如果不是图片，禁止上传）
				String contentType = mf.getContentType();
				// 获得文件后缀名称
				String imageName = contentType.substring(contentType
						.indexOf("/") + 1);
				name = fileName + "." + imageName;
				System.out.println("name:" + name);
				mf.transferTo(new File(pathRoot + name));
				Image image = new Image();
				image.setGoodId(goodId);
				image.setName(name);
				image.setUrl(filePath + "/" + name);
				imageService.insertImage(image);
			} else {
				System.out.println("文件为空！");
			}
		}
		return "redirect:/goods/goodInfo?goodId=" + goodId;
	}

	@RequestMapping(value = "/goods/userGoods", method = RequestMethod.GET)
	public String getUserGoods(ModelMap model,
			@RequestParam(value = "userId", required = false) Integer userId) {
		User user = userService.getUserById(userId);
		List<Good> userGoods = goodService.getGoodStatusByUserId(userId);
		List<Good> goods = goodService.getAllGoods(0, 4);
		model.addAttribute("user", user);
		model.addAttribute("userGoods", userGoods);
		model.addAttribute("goods", goods);
		return "goods/userGood";
	}

	@RequestMapping(value = "/goods/userGoodEdit", method = RequestMethod.GET)
	public String getUserGoodEdit(ModelMap model,
			@RequestParam(value = "goodId", required = false) Integer goodId,
			HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}
		Good good = goodService.getGoodById(goodId);
		List<FirstType> firstTypes = typeService.getAllFirstType();
		List<Good> goods = goodService.getAllGoods(0, 5);
		List<Image> goodImages = imageService.getImageByGoodId(goodId);
		model.addAttribute("goods", goods);
		model.addAttribute("good", good);
		model.addAttribute("goodImages", goodImages);
		model.addAttribute("firstTypes", firstTypes);
		return "goods/userGoodEdit";
	}

	@RequestMapping(value = "/goods/userGoodEdit", method = RequestMethod.POST)
	public String postGoodEdit(ModelMap model, HttpSession session,
			@Valid Good good) {
		List<FirstType> firstTypes = typeService.getAllFirstType();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/";
		}
		List<Good> goods = goodService.getAllGoods(0, 5);
		if (!(goodService.updateGood(good) > 0)) {
			System.out.println("修改物品失败！");
		}
		List<Image> goodImages = imageService.getImageByGoodId(good.getId());
		model.addAttribute("goods", goods);
		model.addAttribute("good", good);
		model.addAttribute("goodImages", goodImages);
		model.addAttribute("firstTypes", firstTypes);
		return "goods/userGoodEdit";
	}

	@RequestMapping(value = "/goods/userGoodEdit/updateImage", method = RequestMethod.POST)
	public String updateImage(
			HttpSession session,
			@RequestParam(value = "goodId", required = false) Integer goodId,
			@RequestParam(value = "mainFile", required = false) MultipartFile mainFile,
			@RequestParam(value = "file", required = false) MultipartFile[] file)
			throws IOException {
		User user = (User) session.getAttribute("user");
		FileCheck fileCheck = new FileCheck();
		imageService.deleteImage(goodId);
		RandomString randomString = new RandomString();
		String filePath = "/statics/image/goods/" + user.getId() + "/" + goodId;
		String pathRoot = fileCheck.checkGoodFolderExist(filePath);
		String name;
		if (!mainFile.isEmpty()) {
			String contentType = mainFile.getContentType();
			String fileName = goodId + randomString.getRandomString(10);
			String imageName = contentType
					.substring(contentType.indexOf("/") + 1);
			name = fileName + "." + imageName;
			mainFile.transferTo(new File(pathRoot + name));
			String photoUrl = filePath + "/" + name;
			goodService.updateGoodPhotoUrl(photoUrl, goodId);
		}

		for (MultipartFile mf : file) {
			if (!mf.isEmpty()) {
				String contentType = mf.getContentType();
				String fileName = goodId + randomString.getRandomString(10);
				String imageName = contentType.substring(contentType
						.indexOf("/") + 1);
				name = fileName + "." + imageName;
				System.out.println("name:" + name);
				mf.transferTo(new File(pathRoot + name));
				Image image = new Image();
				image.setGoodId(goodId);
				image.setName(name);
				image.setUrl(filePath + "/" + name);
				imageService.insertImage(image);
			}
		}
		return "redirect:/goods/goodInfo?goodId=" + goodId;
	}

	@RequestMapping(value = "/goods/userGoodEdit/delete/{goodId}", method = RequestMethod.GET)
	public ResponseEntity deleteGood(@PathVariable Integer goodId) {
		Boolean success;
		success = goodService.deleteGood(goodId) > 0;
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/goods/userGoodEdit/updateGoodStatus/{goodId}", method = RequestMethod.GET)
	public ResponseEntity updateGoodStatus(@PathVariable Integer goodId) {
		Boolean success;
		success = goodService.updateGoodStatusId(0, goodId) > 0;
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/admin/goods/allGoods", method = RequestMethod.GET)
	public ResponseEntity adminGetAllGoods() {
		List<Good> goodList = goodService.getAllGoodList();
		for (Good good : goodList) {
			good.setGoodUser(userService.getUserById(good.getUserId()));
			good.setGoodSecondType(typeService.getSecondTypeById(good
					.getSecondTypeId()));
		}
		return ResponseEntity.ok(goodList);
	}
}
