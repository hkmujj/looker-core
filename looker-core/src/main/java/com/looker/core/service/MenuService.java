package com.looker.core.service;

import java.util.List;
import java.util.Map;

import com.looker.core.model.SysUser;


public interface MenuService {
	/**
	 * @Description 查询所有菜单，超级管理员用
	 * @return
	 */
	List<Map<String,Object>> getAllMenus();
	/**
	 * @Description 查询菜单
	 * @param params
	 * @return
	 */
	List<Map<String,Object>> getMenus(Map<String,Object> params);
	/**
	 * @Description 查询特定用户有权限的菜单
	 * @param params
	 * @return
	 */
	List<Map<String,Object>> getUserMenus(Map<String,Object> params);
	
	/**
	 * @Description 拼接权限配置html片段
	 * @param list
	 * @return
	 */
	String getRightConfig_html(List<Map<String, Object>> menuList,List<Map<String,Object>> roleMenuList);
	
	/**
	 * 根据用户Id获取菜单并拼装菜单数据
	 * @param userId 用户Id
	 * @return List 拼装后的菜单数据
	 */
	List<Map<String, Object>> getMenuList(String userId);
}
