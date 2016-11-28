package com.looker.core.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.looker.core.model.ZTokenRecords;
import com.looker.core.service.TokenManagerService;
import com.niwodai.tech.base.dao.IBaseDao;
import com.niwodai.tech.base.dao.model.Page;


@Service("tokenManagerService")
public class TokenManagerServiceImpl implements TokenManagerService{
	
	@Resource
	IBaseDao<Map<String,Object>> iBaseDao;

	@Override
	public Page<Object> queryTokenList(Page<Object> page,
			Map<String, Object> params) {
		return iBaseDao.findByQuery("ZTokenRecords.findZTokenRecords", page, params);
	}

	@Override
	public void insertToken(ZTokenRecords token) {
		iBaseDao.create("ZTokenRecords.insertZTokenRecords", token);		
	}
	
	
}
