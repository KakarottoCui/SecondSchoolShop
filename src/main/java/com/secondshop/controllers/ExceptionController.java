package com.secondshop.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExceptionController {
	@RequestMapping(value = "/error")
	public void toError() {
		int b = 10 / 0;
		System.out.println(b);
	}
}
