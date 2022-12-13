package com.secondshop.models;

import java.text.SimpleDateFormat;

/**
 * 物品表
 * 
 * @author WEN
 *
 */
public class Good {
	private int id;
	private String name;
	private String photoUrl;
	private int firstTypeId;
	private int secondTypeId;
	private SecondType goodSecondType;
	private String describe;
	private String uploadDate;
	private float prise;
	private int statusId;
	private int userId;
	private User goodUser;
	private String update;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhotoUrl() {
		return photoUrl;
	}

	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}

	public int getFirstTypeId() {
		return firstTypeId;
	}

	public void setFirstTypeId(int firstTypeId) {
		this.firstTypeId = firstTypeId;
	}

	public int getSecondTypeId() {
		return secondTypeId;
	}

	public void setSecondTypeId(int secondTypeId) {
		this.secondTypeId = secondTypeId;
	}

	public SecondType getGoodSecondType() {
		return goodSecondType;
	}

	public void setGoodSecondType(SecondType goodSecondType) {
		this.goodSecondType = goodSecondType;
	}

	public String getDescribe() {
		return describe;
	}

	public void setDescribe(String describe) {
		this.describe = describe;
	}

	public String getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}

	public float getPrise() {
		return prise;
	}

	public void setPrise(float prise) {
		this.prise = prise;
	}

	public int getStatusId() {
		return statusId;
	}

	public void setStatusId(int statusId) {
		this.statusId = statusId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public User getGoodUser() {
		return goodUser;
	}

	public void setGoodUser(User goodUser) {
		this.goodUser = goodUser;
	}

	public String getUpdate() {
		return update;
	}

	public void setUpdate(java.sql.Timestamp update) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		this.update = sdf.format(update);
	}

}
