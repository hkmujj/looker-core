package com.looker.core.common;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.niwodai.tech.base.dao.model.Page;


/**
* @ClassName: CoresProviderService 
* @Description: 征信核心系统对外提供接口
* @author zhengyangjun
* @date 2016�?�?6�?下午4:47:20 
*
 */
public interface CoresProviderService {

	/**
	 * 获取用户授权记录列表
	 * @param userId
	 * @param state
	 * @return
	 */
	public JSONObject selectAuthList(String userId,String state,Page<Object> page);
	
	/**
	 * 更新用户授权记录状�?
	 * @param recordId
	 * @param state
	 * @return
	 */
	public JSONObject updateAuthRecordState(long recordId, int state,byte[] fileByteArr,String fileName);
	
	
	/**
	 * 获取异议记录
	 * @param map 包含异议对象中的任何属�?参数，已通过这些条件获取异议记录数据
	 * @param page 分页对象
	 */
	public JSONObject findObjectionList(Map<String,Object> map, Page<Object> page);
	
	/**
	 * 插入异议记录数据
	 * @param userId 登录用户�?
	 * @param json 要插入的数据组成的JSONObject对象
	 */
	public JSONObject insertObjectionInfo(String userId,JSONObject json);
	
	/**
	 * 获取授权产品信息
	 * @param userId 当前登录用户
	 */
	public JSONObject findAuthProductList(String userId);
	
	/**
	 * 获取产品信息
	 * @param page
	 * @param params
	 * @return
	 */
	public JSONObject findProductList(Page<Object> page,Map<String, Object> params);
	
	/**
	 * �?��登录信息
	 * @param loginName
	 * @param password
	 * @return
	 */
	public JSONObject checkLogin(String loginName, String password);
	
	/**
	 * 查询登录用户机构信息
	 */
	public JSONObject findOrganizationList(Page<Object> page,Map<String, Object> params);
	
	/**
	 * @Description 商户用户密码修改
	 * @param params
	 * @return
	 */
	public JSONObject modifyPassword(Map<String, Object> params);
	
}
