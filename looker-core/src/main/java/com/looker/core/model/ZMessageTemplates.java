package com.looker.core.model;

import java.lang.Long;
import java.util.Date;
import java.io.Serializable;

/**
 * Entity：ZMessageTemplates
 */
public class ZMessageTemplates implements Serializable {

	private static final long serialVersionUID = 7425611557084877972L;

	/**
	 * 模板ID
	 */
	private Long id;

	/**
	 * 0-短信发送, 1-邮件发送
	 */
	private String sendType;

	/**
	 * 模板对应的模块主题
	 */
	private String messageSubject;

	/**
	 * 消息主题对应的序号
	 */
	private String messageType;

	/**
	 * 模板内容
	 */
	private String templateContent;

	/**
	 * 模板内容备注
	 */
	private String messageRemarks;

	/**
	 * 发送开关:0-开，1-关
	 */
	private String sendSwitch;

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

	public ZMessageTemplates() {

	}

	public ZMessageTemplates(Long id, String sendType, String messageSubject,
			String messageType, String templateContent, String messageRemarks,
			String sendSwitch, Date createTime, String createUser,
			Date updateTime, String updateUser) {
		this.id = id;
		this.sendType = sendType;
		this.messageSubject = messageSubject;
		this.messageType = messageType;
		this.templateContent = templateContent;
		this.messageRemarks = messageRemarks;
		this.sendSwitch = sendSwitch;
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

	public void setSendType(String sendType) {
		this.sendType = sendType;
	}

	public String getSendType() {
		return this.sendType;
	}

	public void setMessageSubject(String messageSubject) {
		this.messageSubject = messageSubject;
	}

	public String getMessageSubject() {
		return this.messageSubject;
	}

	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}

	public String getMessageType() {
		return this.messageType;
	}

	public void setTemplateContent(String templateContent) {
		this.templateContent = templateContent;
	}

	public String getTemplateContent() {
		return this.templateContent;
	}

	public void setMessageRemarks(String messageRemarks) {
		this.messageRemarks = messageRemarks;
	}

	public String getMessageRemarks() {
		return this.messageRemarks;
	}

	public void setSendSwitch(String sendSwitch) {
		this.sendSwitch = sendSwitch;
	}

	public String getSendSwitch() {
		return this.sendSwitch;
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