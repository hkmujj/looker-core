package com.looker.core.model;

import java.lang.Long;
import java.util.Date;
import java.io.Serializable;

/**
 * Entity：ZMessageRecords
 */
public class ZMessageRecords implements Serializable {

	private static final long serialVersionUID = -1844375030945332782L;

	/**
	 * 消息记录Id
	 */
	private Long id;

	/**
	 * 消息模板Id
	 */
	private String templateId;

	/**
	 * 消息内容
	 */
	private String messageContent;

	/**
	 * 发送时间
	 */
	private Date sendDate;

	/**
	 * 收件人
	 */
	private String recipient;

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

	public ZMessageRecords() {

	}

	public ZMessageRecords(Long id, String templateId, String messageContent,
			Date sendDate, String recipient, Date createTime,
			String createUser, Date updateTime, String updateUser) {
		this.id = id;
		this.templateId = templateId;
		this.messageContent = messageContent;
		this.sendDate = sendDate;
		this.recipient = recipient;
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

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	public String getTemplateId() {
		return this.templateId;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public String getMessageContent() {
		return this.messageContent;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}

	public Date getSendDate() {
		return this.sendDate;
	}

	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}

	public String getRecipient() {
		return this.recipient;
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