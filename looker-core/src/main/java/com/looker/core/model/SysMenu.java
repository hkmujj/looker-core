package com.looker.core.model;

import java.io.Serializable;

/**
 * Entity：SysMenu
 */
public class SysMenu implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3902064845769925383L;

	/**
	 * 菜单ID
	 */
	private String menuId;

	/**
	 * 菜单名称
	 */
	private String menuName;

	/**
	 * 菜单类型
	 */
	private String menuType;

	/**
	 * 菜单URL
	 */
	private String menuUrl;

	/**
	 * 上级菜单id
	 */
	private String parentId;

	/**
	 * 模块索引
	 */
	private String menuIndex;

	/**
	 * 菜单排序
	 */
	private String menuSort;
	
	/**
	 * 菜单图标
	 */
	private String menuIcon;

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

	public SysMenu() {

	}

	public SysMenu(String menuId, String menuName, String menuType,
			String menuUrl, String parentId, String menuIndex, String menuSort,
			String whetherDelete, String createTime, String createUser,
			String updateTime, String updateUser) {
		this.menuId = menuId;
		this.menuName = menuName;
		this.menuType = menuType;
		this.menuUrl = menuUrl;
		this.parentId = parentId;
		this.menuIndex = menuIndex;
		this.menuSort = menuSort;
		this.whetherDelete = whetherDelete;
		this.createTime = createTime;
		this.createUser = createUser;
		this.updateTime = updateTime;
		this.updateUser = updateUser;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getMenuId() {
		return this.menuId;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuName() {
		return this.menuName;
	}

	public void setMenuType(String menuType) {
		this.menuType = menuType;
	}

	public String getMenuType() {
		return this.menuType;
	}

	public void setMenuUrl(String menuUrl) {
		this.menuUrl = menuUrl;
	}

	public String getMenuUrl() {
		return this.menuUrl;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getParentId() {
		return this.parentId;
	}

	public void setMenuIndex(String menuIndex) {
		this.menuIndex = menuIndex;
	}

	public String getMenuIndex() {
		return this.menuIndex;
	}
	
	public String getMenuIcon() {
		return menuIcon;
	}

	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}

	public void setMenuSort(String menuSort) {
		this.menuSort = menuSort;
	}

	public String getMenuSort() {
		return this.menuSort;
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