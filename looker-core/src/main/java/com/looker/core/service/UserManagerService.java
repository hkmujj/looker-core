package com.looker.core.service;

import java.util.Map;

import com.niwodai.tech.base.dao.model.Page;

/**
 * @description 用户管理service
 */
public interface UserManagerService {
	
	/**
	 * @Description 查询用户列表
	 * @param page
	 * @param params
	 * @return
	 */
	Page<Object> queryUserList(Page<Object> page,Map<String, Object> params);
	
	/**
	 * @Description 根据userId查询用户信息
	 * @param userId
	 * @return
	 */
	Map<String,Object> queryUser(long userId);
	
	/**
	 * @Description 根据用户参数查询用户信息
	 * @param params
	 * @return
	 */
	Map<String,Object> queryUserDetail(Map<String, Object> params);
	
	
	/**
	 * @Description 修改用户信息
	 * @param params
	 */
	void updateUser(Map<String,Object> params) throws Exception;
	
	/**
	 * @Description 新增用户
	 * @param params
	 */
	long addUser(Map<String,Object> params);
	
	/**
	 * @Description 判断用户是否已经存在（根据用户账号）
	 * @param params
	 * @return
	 */
	boolean userIsExist(Map<String,Object> params);
	
	/**
	 * @Description 根据用户角色获取用户信息
	 * @param userRole 用户角色
	 * @param notAdmin 返回值是否需要管理员email
	 * @return email 如果有多个则用,隔开
	 */
	String queryUserByUserRole(String userRole,boolean notAdmin);
	
}
