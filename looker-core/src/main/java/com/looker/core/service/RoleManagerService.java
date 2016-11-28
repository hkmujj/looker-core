package com.looker.core.service;

import java.util.List;
import java.util.Map;

import com.niwodai.tech.base.dao.model.Page;

/**
 * @description 角色管理service
 */
public interface RoleManagerService {
	
	/**
	 * @Description 查询所有角色(不分页)
	 * @param page
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> queryAllRoleList();
	
	/**
	 * @Description 查询用户角色(不分页)
	 * @param page
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> queryUserRoleList(long userId);
	
	
	/**
	 * @Description 查询角色列表
	 * @param page
	 * @param params
	 * @return
	 */
	Page<Object> queryRoleList(Page<Object> page,Map<String, Object> params);
	
	/**
	 * @Description 查询角色
	 * @param page
	 * @param params
	 * @return
	 */
	Map<String,Object> queryRole(long roleId);
	
	/**
	 * @Description 新增角色
	 * @param page
	 * @param params
	 * @return
	 */
	void addRole(Map<String, Object> params);
	
	/**
	 * @Description 更新角色信息
	 * @param page
	 * @param params
	 * @return
	 */
	void updateRole(Map<String, Object> params);
	
	/**
	 * @Description 删除角色
	 * @param page
	 * @param params
	 * @return
	 */
	void deleteRole(long roleId);
	
	/**
	 * @Description 删除角色菜单关联关系
	 * @param page
	 * @param params
	 * @return
	 */
	void deleteRoleMenu(Map<String, Object> params);
	
	/**
	 * @Description 新增角色菜单关联关系
	 * @param page
	 * @param params
	 * @return
	 */
	void addRoleMenu(Map<String, Object> params);
	
	/**
	 * @Description 查询角色关联的菜单
	 * @param page
	 * @param params
	 * @return
	 */
	List<Map<String,Object>> getRoleMenus(Map<String, Object> params);
	
}
