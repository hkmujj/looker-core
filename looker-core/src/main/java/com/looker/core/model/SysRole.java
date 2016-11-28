package com.looker.core.model;

import java.io.Serializable;

/**
 * Entity：SysRole
 */
public class SysRole implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2345593510468650405L;

	/**
	 * 角色ID
	 */
	private String roleId;

	/**
	 * 角色code
	 */
	private String roleCode;

	/**
	 * 角色名称
	 */
	private String roleName;

	/**
	 * 角色描述
	 */
	private String roleDesc;

	/**
	 * 是否删除0是1否
	 */
	private String whetherDelete;

	/**
	 * 创建日期
	 */
	private String createTime;

	/**
	 * 创建用户
	 */
	private String createUser;

	/**
	 * 修改日期
	 */
	private String updateTime;

	/**
	 * 更新用户
	 */
	private String updateUser;

	public SysRole() {

	}

	public SysRole(String roleId, String roleCode, String roleName,
			String roleDesc, String whetherDelete, String createTime,
			String createUser, String updateTime, String updateUser) {
		this.roleId = roleId;
		this.roleCode = roleCode;
		this.roleName = roleName;
		this.roleDesc = roleDesc;
		this.whetherDelete = whetherDelete;
		this.createTime = createTime;
		this.createUser = createUser;
		this.updateTime = updateTime;
		this.updateUser = updateUser;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getRoleId() {
		return this.roleId;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getRoleCode() {
		return this.roleCode;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}

	public String getRoleDesc() {
		return this.roleDesc;
	}

	public void setWhetherDelete(String whetherDelete) {
		this.whetherDelete = whetherDelete;
	}

	public String getWhetherDelete() {
		return this.whetherDelete;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	public String getCreateUser() {
		return this.createUser;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public String getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getUpdateUser() {
		return this.updateUser;
	}

}