package com.secondshop.utils;

import java.util.regex.Pattern;

/**
 * 信息检查
 * 
 * @author WEN
 *
 */
public class InfoCheck {

	/**
	 * 用户邮箱格式检查
	 */
	public static String CHECK_EMAIL = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";

	public boolean isEmail(String email) {
		return Pattern.matches(CHECK_EMAIL, email);
	}

	/**
	 * 用户电话格式检查
	 */
	public static String CHECK_MOBILE = "^1[3|4|5|6|7|8|9][0-9]\\d{4,8}$";

	public boolean isMobile(String mobile) {
		return Pattern.matches(CHECK_MOBILE, mobile);
	}

}
