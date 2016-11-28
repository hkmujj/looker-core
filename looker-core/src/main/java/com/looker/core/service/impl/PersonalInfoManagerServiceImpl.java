package com.looker.core.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.looker.core.service.PersonalInfoManagerService;
import com.niwodai.tech.base.dao.IBaseDao;

@Service("personalInfoManagerService")
public class PersonalInfoManagerServiceImpl implements
		PersonalInfoManagerService {

	@Resource
	IBaseDao<Map<String,Object>> iBaseDao;
	@Override
	public void modifyPassword(Map<String, Object> params) {
		iBaseDao.update("SysUser.updateSysUser",params);
	}

}
