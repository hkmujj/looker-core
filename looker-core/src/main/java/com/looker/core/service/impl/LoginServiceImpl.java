package com.looker.core.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.looker.core.model.SysUser;
import com.looker.core.service.LoginService;
import com.niwodai.tech.base.dao.IBaseDao;

@Service("loginService")
public class LoginServiceImpl implements LoginService {
	
	@Resource
	IBaseDao<Map<String,Object>> iBaseDao;
	
	@Override
	public SysUser checkLogin(String userName, String password) {
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("userName", userName);
		params.put("password", password);
		return iBaseDao.findObjectByQuery("SysUser.checkLogin", params);
	}
}
