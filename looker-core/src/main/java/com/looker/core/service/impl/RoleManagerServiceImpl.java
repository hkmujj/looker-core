package com.looker.core.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.looker.core.service.RoleManagerService;
import com.niwodai.tech.base.dao.IBaseDao;
import com.niwodai.tech.base.dao.model.Page;
@Service("roleManagerService")
public class RoleManagerServiceImpl implements RoleManagerService {

	@Resource
	IBaseDao<Map<String,Object>> iBaseDao;
	
	@Override
	public List<Map<String, Object>> queryAllRoleList() {
		return iBaseDao.findByQuery("SysRole.queryALLRoleList");
	}

	@Override
	public List<Map<String, Object>> queryUserRoleList(long userId) {
		return iBaseDao.findByQuery("SysRole.queryUserRoleList", userId);
	}

	@Override
	public Page<Object> queryRoleList(Page<Object> page,
			Map<String, Object> params) {
		return iBaseDao.findByQuery("SysRole.findSysRole", page, params);
	}

	@Override
	public Map<String,Object> queryRole(long roleId) {
		return iBaseDao.findObjectByQuery("SysRole.queryRole", roleId);
	}

	@Override
	public void updateRole(Map<String, Object> params) {
		iBaseDao.update("SysRole.updateSysRole", params);
	}

	@Override
	public void deleteRole(long roleId) {
		iBaseDao.delete("SysRole.deleteSysRole", roleId);
		
	}

	@Override
	public void addRole(Map<String, Object> params) {
		iBaseDao.create("SysRole.insertSysRole", params);
		
	}

	@Override
	public void deleteRoleMenu(Map<String, Object> params) {
		iBaseDao.delete("SysRole.deleteRoleMenu",params);
		
	}

	@Override
	public void addRoleMenu(Map<String, Object> params) {
		iBaseDao.create("SysRole.insertRoleMenu", params);
	}

	@Override
	public List<Map<String, Object>> getRoleMenus(Map<String, Object> params) {
		return iBaseDao.findByQuery("SysRole.selectRoleMenus", params);
	}

}
