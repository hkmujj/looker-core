package com.looker.core.model;

import java.io.Serializable;
import java.util.Date;

/**
 * Entity：ZUserAuthInfo
 */
public class ZUserAuthInfo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4047289076208181259L;

	/**
	 * 主键ID
	 */
	private Long id;

	/**
	 * 授权代码
	 */
	private String authCode;

	/**
	 * 用户名称
	 */
	private String userName;

	/**
	 * 状态
	 */
	private String state;

	/**
	 * 证件类型
	 */
	private String certType;

	/**
	 * 证件号码
	 */
	private String certNo;

	/**
	 * 所属产品
	 */
	private Long productId;

	/**
	 * 所属用户
	 */
	private String belongUser;

	/**
	 * 所属渠道
	 */
	private Long channelId;

	/**
	 * 所属机构
	 */
	private String orgCode;

	/**
	 * 授权日期
	 */
	private String authTime;

	/**
	 * 创建日期
	 */
	private Date createTime = new Date();

	/**
	 * 创建用户
	 */
	private String createUser;

	/**
	 * 修改日期
	 */
	private Date updateTime = new Date();

	/**
	 * 更新用户
	 */
	private String updateUser;
	
	/**
	 * 获取授权时间
	 */
	private String obtainTime;
	
	/**
	 * 申请获取授权时间
	 */
	private String applyTime;

	/**
	 * 授权文件存放地址
	 */
	private String authUrl;
	
	public ZUserAuthInfo() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

	public String getAuthCode() {
		return this.authCode;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getState() {
		return this.state;
	}

	public void setCertType(String certType) {
		this.certType = certType;
	}

	public String getCertType() {
		return this.certType;
	}

	public void setCertNo(String certNo) {
		this.certNo = certNo;
	}

	public String getCertNo() {
		return this.certNo;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Long getProductId() {
		return this.productId;
	}

	public void setBelongUser(String belongUser) {
		this.belongUser = belongUser;
	}

	public String getBelongUser() {
		return this.belongUser;
	}

	public void setChannelId(Long channelId) {
		this.channelId = channelId;
	}

	public Long getChannelId() {
		return this.channelId;
	}

	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}

	public String getOrgCode() {
		return this.orgCode;
	}

	public void setAuthTime(String authTime) {
		this.authTime = authTime;
	}

	public String getAuthTime() {
		return this.authTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
	public Date getUpdateTime() {
		return updateTime;
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

	public String getObtainTime() {
		return obtainTime;
	}

	public void setObtainTime(String obtainTime) {
		this.obtainTime = obtainTime;
	}

	public String getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(String applyTime) {
		this.applyTime = applyTime;
	}

	public String getAuthUrl() {
		return authUrl;
	}

	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
	}

}