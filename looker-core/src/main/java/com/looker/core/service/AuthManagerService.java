package com.looker.core.service;

import java.util.List;
import java.util.Map;

import com.looker.core.model.ZUserAuthInfo;
import com.niwodai.tech.base.dao.model.Page;

public interface AuthManagerService {
	
	public void updateAuthRecordStateById(Map<String, Object> params);

	public void updateAuthRecordStateByState(Map<String, Object> params);

	public int updateApplyAuthInfo(Map<String, Object> params,String authId) throws Exception;

	public Page<Object> queryAuthInfoList(Page<Object> page,
			Map<String, Object> params);

	public List<Map<String, Object>> queryAuthInfoList(
			Map<String, Object> params);

	public List<Map<String, Object>> queryAuthListById(
			Map<String, Object> params);

	public int insertAuthInfo(ZUserAuthInfo authInfo);

	public void updateAuthInfoById(ZUserAuthInfo authInfo);
}
