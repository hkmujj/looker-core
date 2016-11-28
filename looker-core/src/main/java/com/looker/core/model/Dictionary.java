package com.looker.core.model;

import java.io.Serializable;

/**
 * Entity：Dictionary
 */
public class Dictionary implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -603727588845008507L;

	/**
	 * 字典ID
	 */
	private String dicId;

	/**
	 * 字典类型代码
	 */
	private String dicType;

	/**
	 * 字典类型描述
	 */
	private String dicTypeDesc;

	/**
	 * 业务代码
	 */
	private String dicCode;

	/**
	 * 业务描述
	 */
	private String dicDesc;

	/**
	 * 排序字段
	 */
	private String dicSort;

	/**
	 * 创建时间
	 */
	private String createTime;

	/**
	 * 修改时间
	 */
	private String updateTime;

	/**
	 * 创建人
	 */
	private String createUser;

	/**
	 * 修改人
	 */
	private String updateUser;

	public Dictionary() {

	}

	public Dictionary(String dicId, String dicType, String dicTypeDesc,
			String dicCode, String dicDesc, String dicSort, String createTime,
			String updateTime, String createUser, String updateUser) {
		this.dicId = dicId;
		this.dicType = dicType;
		this.dicTypeDesc = dicTypeDesc;
		this.dicCode = dicCode;
		this.dicDesc = dicDesc;
		this.dicSort = dicSort;
		this.createTime = createTime;
		this.updateTime = updateTime;
		this.createUser = createUser;
		this.updateUser = updateUser;
	}

	public void setDicId(String dicId) {
		this.dicId = dicId;
	}

	public String getDicId() {
		return this.dicId;
	}

	public void setDicType(String dicType) {
		this.dicType = dicType;
	}

	public String getDicType() {
		return this.dicType;
	}

	public void setDicTypeDesc(String dicTypeDesc) {
		this.dicTypeDesc = dicTypeDesc;
	}

	public String getDicTypeDesc() {
		return this.dicTypeDesc;
	}

	public void setDicCode(String dicCode) {
		this.dicCode = dicCode;
	}

	public String getDicCode() {
		return this.dicCode;
	}

	public void setDicDesc(String dicDesc) {
		this.dicDesc = dicDesc;
	}

	public String getDicDesc() {
		return this.dicDesc;
	}

	public void setDicSort(String dicSort) {
		this.dicSort = dicSort;
	}

	public String getDicSort() {
		return this.dicSort;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getCreateTime() {
		return this.createTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getUpdateTime() {
		return this.updateTime;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getCreateUser() {
		return this.createUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getUpdateUser() {
		return this.updateUser;
	}

}