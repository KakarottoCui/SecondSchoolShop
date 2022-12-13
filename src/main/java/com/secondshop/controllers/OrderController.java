package com.secondshop.controllers;

import com.secondshop.models.Order;
import com.secondshop.models.User;
import com.secondshop.services.GoodService;
import com.secondshop.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class OrderController {
	private final GoodService goodService;
	private final OrderService orderService;

	@Autowired
	public OrderController(GoodService goodService, OrderService orderService) {
		this.goodService = goodService;
		this.orderService = orderService;
	}

	@RequestMapping(value = "/user/orderInfo", method = RequestMethod.GET)
	public String getOrderInfo(ModelMap model,
			@RequestParam(value = "orderId", required = false) Integer orderId,
			HttpSession session) {
		User sessionUser = (User) session.getAttribute("user");
		if (sessionUser == null) {
			return "redirect:/";
		}
		Order orderInfo = orderService.getOrderById(orderId);
		List<Order> orders = orderService.getOtherOrderByCustomerId(
				sessionUser.getId(), orderId);
		model.addAttribute("orderInfo", orderInfo);
		model.addAttribute("orders", orders);
		return "user/orderInfo";
	}

	@RequestMapping(value = "/user/sellerInfo", method = RequestMethod.GET)
	public String getSellerInfo(ModelMap model,
			@RequestParam(value = "orderId", required = false) Integer orderId,
			HttpSession session) {
		User sessionUser = (User) session.getAttribute("user");
		if (sessionUser == null) {
			return "redirect:/";
		}
		Order orderInfo = orderService.getOrderById(orderId);
		List<Order> orders = orderService.getOtherOrderBySellerId(
				sessionUser.getId(), orderId);
		model.addAttribute("orderInfo", orderInfo);
		model.addAttribute("orders", orders);
		System.out.println("sellerInfo.size:" + orders.size());
		return "user/sellerInfo";
	}

	@RequestMapping(value = "/user/order/delete/{orderId}", method = RequestMethod.GET)
	public ResponseEntity deleteOrderById(@PathVariable Integer orderId) {
		Boolean success;
		success = orderService.deleteOrderById(orderId) > 0;
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/user/sellerOrder/delete/{orderId}&{goodId}", method = RequestMethod.GET)
	public ResponseEntity deleteSellerOrderById(@PathVariable Integer orderId,
			@PathVariable Integer goodId) {
		Boolean success;
		success = goodService.updateGoodStatusId(1, goodId) > 0;
		if (success) {
			success = orderService.deleteOrderById(orderId) > 0;
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/user/order/update/status/{orderId}&{statusId}", method = RequestMethod.GET)
	public ResponseEntity updateOrderStatus(@PathVariable Integer orderId,
			@PathVariable Integer statusId) {
		Boolean success = orderService.updateStatus(statusId, orderId) > 0;
		if (success) {
			Order order = orderService.getOrderById(orderId);
			return ResponseEntity.ok(order);
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/user/order/create", method = RequestMethod.POST)
	public ResponseEntity createOrder(@RequestBody Order order) {
		Boolean success = orderService.insertOrder(order) > 0;
		if (success) {
			success = goodService.updateGoodStatusId(0, order.getGoodId()) > 0;
			if (success) {
				return ResponseEntity.ok(order.getId());
			} else {
				orderService.deleteOrderById(order.getId());
				return ResponseEntity.ok(success);
			}
		}
		return ResponseEntity.ok(success);
	}

	@RequestMapping(value = "/user/order/allOrder", method = RequestMethod.GET)
	public ResponseEntity getAllOrders() {
		List<Order> orderList = orderService.getOrderList();
		return ResponseEntity.ok(orderList);
	}
}
