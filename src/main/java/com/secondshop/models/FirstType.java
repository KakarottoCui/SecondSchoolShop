package com.secondshop.models;

import java.util.List;

/**
 * 一级分类表
 * 
 * @author WEN
 *
 */
public class FirstType {
	private int id;
	private String name;
	private List<SecondType> secondTypes;

	public List<SecondType> getSecondType() {
		return secondTypes;
	}

	public void setSecondType(List<SecondType> secondTypes) {
		this.secondTypes = secondTypes;
	}

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

}