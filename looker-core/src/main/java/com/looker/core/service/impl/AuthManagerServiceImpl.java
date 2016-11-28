package com.looker.core.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.looker.core.common.GlobalConfig;
import com.looker.core.common.ItemDic.MailType;
import com.looker.core.model.ZUserAuthInfo;
import com.looker.core.service.AuthManagerService;
import com.looker.core.service.MailService;
import com.looker.core.util.DateUtils;
import com.niwodai.tech.base.dao.IBaseDao;
import com.niwodai.tech.base.dao.model.Page;
import com.niwodai.tech.base.util.StringUtil;

@Service("myAuthManagerService")
public class AuthManagerServiceImpl implements AuthManagerService {

	@Resource
	IBaseDao<Map<String, Object>> iBaseDao;
	
	@Autowired
	private MailService mailSendService;
	
	@Override
	public void updateAuthRecordStateById(Map<String, Object> params) {
		iBaseDao.update("ZUserAuthInfo.updateZUserAuthStateById", params);
	}

	@Override
	public void updateAuthRecordStateByState(Map<String, Object> params) {
		iBaseDao.update("ZUserAuthInfo.updateZUserAuthStateByState", params);
	}
	
	@Override
	public Page<Object> queryAuthInfoList(Page<Object> page,
			Map<String, Object> params) {
		return iBaseDao.findByQuery("ZUserAuthInfo.findZUserAuthInfo", page, params);
	}

	@Override
	public List<Map<String, Object>> queryAuthListById(Map<String, Object> params) {
		return iBaseDao.findByQuery("ZUserAuthInfo.selectZUserAuthById", params);
	}

	@Override
	public int insertAuthInfo(ZUserAuthInfo authInfo) {
		return (int) iBaseDao.create("ZUserAuthInfo.insertZUserAuthInfo", authInfo);
	}

	@Override
	public int updateApplyAuthInfo(Map<String, Object> params,String authId) throws Exception {
		
		
		Map<String, Object> authParams = new HashMap<String, Object>();
		List<Object[]> param = new ArrayList<Object[]>();
		
		if(StringUtil.isEmpty(authId)){
			//找出对应的用户授权信息,这边是找出全部未授权的
			authParams.put("state", "1");
		}else{
			authParams.put("id", authId);
		}
		
		//拼装邮件内容
		List<Map<String, Object>> authInfoList = queryAuthInfoList(authParams);
		for(Map<String, Object> auth : authInfoList){
			String userName = (String)auth.get("userName");
			String idNum = (String)auth.get("certNo");
			String idNumLast = ((String)auth.get("certNo")).substring(idNum.length() - 4, idNum.length());
			Object[] o = new Object[]{userName,idNumLast,DateUtils.getDateTime(new Date())};
			param.add(o);
		}
		
		//更新状态
		int count = iBaseDao.update("ZUserAuthInfo.updateZUserAuthApplyInfo", params);
		
		//发送邮件
		String userEmail = (String) params.get("userEmail");
		mailSendService.sendSimpleMail(MailType.YHSQ01.subject, MailType.YHSQ01.type, userEmail, null,param);
		
		return count;
	}

	@Override
	public List<Map<String, Object>> queryAuthInfoList(Map<String, Object> params) {
		return iBaseDao.findByQuery("ZUserAuthInfo.findZUserAuthInfo", params);
	}

	@Override
	public void updateAuthInfoById(ZUserAuthInfo authInfo) {
		iBaseDao.update("ZUserAuthInfo.updateZUserAuthInfo", authInfo);
	}
	
	
}
