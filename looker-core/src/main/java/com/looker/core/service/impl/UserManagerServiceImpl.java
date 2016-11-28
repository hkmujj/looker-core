package com.looker.core.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.looker.core.common.GlobalConfig;
import com.looker.core.common.ItemDic.MailType;
import com.looker.core.service.MailService;
import com.looker.core.service.UserManagerService;
import com.looker.core.util.DateUtils;
import com.niwodai.tech.base.dao.IBaseDao;
import com.niwodai.tech.base.dao.model.Page;
@Service("userManagerService")
public class UserManagerServiceImpl implements UserManagerService{
	
	@Resource
	IBaseDao<Map<String,Object>> iBaseDao;
	
	@Resource
	private MailService mailSendService;
	
	@Resource
	private UserManagerService userManagerService;
	
	@Override
	public Page<Object> queryUserList(Page<Object> page,
			Map<String, Object> params) {
		return iBaseDao.findByQuery("SysUser.findSysUser", page, params);
	}

	@Override
	public void updateUser(Map<String, Object> params) throws Exception {
		
		//查询用户
		Map<String, Object> qUser = queryUser(Long.valueOf((String) params.get("userId")));
		
		// 更新用户表信息
		iBaseDao.update("SysUser.updateSysUser",params);
		String[] roleIds = (String[]) params.get("roleIds");
		if (roleIds != null && roleIds.length > 0) {
			// 更新用户角色表信息，先delete，后insert
			iBaseDao.delete("SysUser.deleteUserRole", params);
			// 用户角色表插入数据
			String userId = (String)params.get("userId");
			for (String roleId : roleIds) {
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("userId", userId);
				map.put("roleId", roleId);
				iBaseDao.create("SysUser.insertUserRole", map);
			}
		}
		
		
		//发送邮件
		if(!qUser.get("USER_STATUS").equals(params.get("userStatus"))){
			String subject = "";
			String type = "";
			if(GlobalConfig.ENABLE.equals(params.get("userStatus"))){//启用
				subject = MailType.YH01.subject;
				type = MailType.YH01.type;
			}else if(GlobalConfig.DISABLE.equals(params.get("userStatus"))){//停用
				subject = MailType.YH02.subject;
				type = MailType.YH02.type;
			}
			
			//获取管理员邮箱账号
			Map<String, Object> userMap = new HashMap<String, Object>();
			userMap.put("userAccount", GlobalConfig.ADMIN_ACCOUNT);
			Map<String, Object> userDetail = userManagerService.queryUserDetail(userMap);
			
			String email = (String) userDetail.get("EMAIL");
			
			String[] p = new String[]{(String) params.get("sysUser"),DateUtils.getDateTime(new Date()),(String) qUser.get("USER_NAME")};
			mailSendService.sendSimpleMail(subject, type, email, p,null);
			
		}
		
		
		
	}

	@Override
	public long addUser(Map<String, Object> params) {
		// 用户表新增用户
		long userId = iBaseDao.create("SysUser.insertSysUser", params);
		String[] roleIds = (String[]) params.get("roleIds");
		
		// 用户角色表插入数据
		for (String roleId : roleIds) {
			Map<String,Object> map = new HashMap<String, Object>();
			map.put("userId", userId);
			map.put("roleId", roleId);
			iBaseDao.create("SysUser.insertUserRole", map);
		}
		return userId;
	}

	@Override
	public boolean userIsExist(Map<String, Object> params) {
		int count = iBaseDao.findObjectByQuery("SysUser.findSysUser_COUNT", params);
		return count>0;
	}

	@Override
	public Map<String,Object> queryUser(long userId) {
		return iBaseDao.findObjectByQuery("SysUser.queryUserDetail", userId);
	}

	@Override
	public Map<String, Object> queryUserDetail(Map<String, Object> params) {
		return iBaseDao.findObjectByQuery("SysUser.queryUserDetailByParams", params);
	}

	@Override
	public String queryUserByUserRole(String userRole,boolean notAdmin) {
		String email = "";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("roleCode", userRole);
		//如果不需要超级管理员则把他移除
		if(notAdmin){
			params.put("userId", 1);
		}
		List<Map<String, Object>> userAccount = iBaseDao.findByQuery("SysUser.findSysUserByUserRole", params);
		
		for(int i = 0;i < userAccount.size();i++){
			if(userAccount.size() - 1 == i){
				email += (String) userAccount.get(i).get("EMAIL");
			}else{
				email += (String) userAccount.get(i).get("EMAIL") + ",";
			}
		}
		
		return email;
	}
	
}
