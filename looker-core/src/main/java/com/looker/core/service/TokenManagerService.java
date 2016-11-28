package com.looker.core.service;

import java.util.Map;

import com.looker.core.model.ZTokenRecords;
import com.niwodai.tech.base.dao.model.Page;

/**
 * @description token
 */
public interface TokenManagerService {
	
	/**
	 * @Description 查询token列表
	 * @param page
	 * @param params
	 * @return
	 */
	Page<Object> queryTokenList(Page<Object> page,Map<String, Object> params);
	
	/**
	 * @Description 插入token信息
	 * @param params
	 */
	void insertToken(ZTokenRecords token);
	
	
}
