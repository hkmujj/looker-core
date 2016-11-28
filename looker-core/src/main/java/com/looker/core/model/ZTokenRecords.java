package com.looker.core.model;

import java.lang.Long;
import java.util.Date;
import java.io.Serializable;

/**
 * Entity：ZTokenRecords
 */
public class ZTokenRecords implements Serializable {

	private static final long serialVersionUID = 4002766917976921816L;

	/**
	 * token记录Id
	 */
	private Long id;

	/**
	 * 生成token的机构
	 */
	private String tokenOrgcode;

	/**
	 * 生成token的渠道
	 */
	private String tokenChannelcode;

	/**
	 * token授权码
	 */
	private String tokenCode;

	/**
	 * 操作人
	 */
	private String tokenCreater;

	/**
	 * 创建日期
	 */
	private Date createTime;

	/**
	 * 创建用户
	 */
	private String createUser;

	/**
	 * 修改日期
	 */
	private Date updateTime;

	/**
	 * 更新用户
	 */
	private String updateUser;

	public ZTokenRecords() {

	}

	public ZTokenRecords(Long id, String tokenOrgcode, String tokenChannelcode,
			String tokenCode, String tokenCreater, Date createTime,
			String createUser, Date updateTime, String updateUser) {
		this.id = id;
		this.tokenOrgcode = tokenOrgcode;
		this.tokenChannelcode = tokenChannelcode;
		this.tokenCode = tokenCode;
		this.tokenCreater = tokenCreater;
		this.createTime = createTime;
		this.createUser = createUser;
		this.updateTime = updateTime;
		this.updateUser = updateUser;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return this.id;
	}

	public void setTokenOrgcode(String tokenOrgcode) {
		this.tokenOrgcode = tokenOrgcode;
	}

	public String getTokenOrgcode() {
		return this.tokenOrgcode;
	}

	public void setTokenChannelcode(String tokenChannelcode) {
		this.tokenChannelcode = tokenChannelcode;
	}

	public String getTokenChannelcode() {
		return this.tokenChannelcode;
	}

	public void setTokenCode(String tokenCode) {
		this.tokenCode = tokenCode;
	}

	public String getTokenCode() {
		return this.tokenCode;
	}

	public void setTokenCreater(String tokenCreater) {
		this.tokenCreater = tokenCreater;
	}

	public String getTokenCreater() {
		return this.tokenCreater;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getCreateUser() {
		return this.createUser;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getUpdateUser() {
		return this.updateUser;
	}

}