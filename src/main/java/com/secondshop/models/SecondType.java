package com.secondshop.models;

/**
 * 二级分类表
 * 
 * @author WEN
 *
 */
public class SecondType {
	private int id;
	private int firstTypeId;
	private String name;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getFirstTypeId() {
		return firstTypeId;
	}

	public void setFirstTypeId(int firstTypeId) {
		this.firstTypeId = firstTypeId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
