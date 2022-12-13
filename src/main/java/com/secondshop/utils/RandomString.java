package com.secondshop.utils;

/**
 * 加密方法
 * 
 * @author WEN
 *
 */
public class RandomString {
	/**
	 * 加密用户密码
	 * 
	 * @param m
	 *            用户密码输入的长度
	 * @return
	 */
	public String getRandomString(int m) {
		String str = "";
		for (int i = 0; i < m; i++) {
			String STR = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
			int n = (int) (Math.random() * (STR.length() - 1));
			str += STR.charAt(n);
		}
		return str;
	}

}
