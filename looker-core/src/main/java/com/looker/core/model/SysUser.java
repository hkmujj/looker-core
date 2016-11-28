package com.looker.core.model;

import java.io.Serializable;
import java.util.List;

/**
 * Entity：SysUser
 */
public class SysUser implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -659137772456558193L;

	/**
	 * 用户ID
	 */
	private Long userId;

	/**
	 * 用户账号
	 */
	private String userAccount;

	/**
	 * 登录密码
	 */
	private String password;

	/**
	 * 用户姓名
	 */
	private String userName;

	/**
	 * 状态0启用1停用
	 */
	private String userStatus;

	/**
	 * 工号
	 */
	private String empNo;

	/**
	 * 所属部门
	 */
	private String belongDepart;
	
	/**
	 * 电话号码
	 */
	private String phoneNo;
	
	/**
	 * 邮箱
	 */
	private String email;

	/**
	 * 是否删除：0是1否
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
	
	/**
	 * 角色CodeList
	 */
	private List<String> roleList;

	public SysUser() {

	}

	public SysUser(long userId, String userAccount, String password,
			String userName, String userStatus, String empNo,String phoneNo,String email,
			String belongDepart, String whetherDelete, String createTime,
			String createUser, String updateTime, String updateUser) {
		this.userId = userId;
		this.userAccount = userAccount;
		this.password = password;
		this.userName = userName;
		this.userStatus = userStatus;
		this.empNo = empNo;
		this.belongDepart = belongDepart;
		this.phoneNo = phoneNo;
		this.email = email;
		this.whetherDelete = whetherDelete;
		this.createTime = createTime;
		this.createUser = createUser;
		this.updateTime = updateTime;
		this.updateUser = updateUser;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}

	public String getUserAccount() {
		return this.userAccount;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return this.password;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getUserStatus() {
		return this.userStatus;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getEmpNo() {
		return this.empNo;
	}

	public void setBelongDepart(String belongDepart) {
		this.belongDepart = belongDepart;
	}

	public String getBelongDepart() {
		return this.belongDepart;
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

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getWhetherDelete() {
		return whetherDelete;
	}

	public void setWhetherDelete(String whetherDelete) {
		this.whetherDelete = whetherDelete;
	}

	public List<String> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<String> roleList) {
		this.roleList = roleList;
	}

}