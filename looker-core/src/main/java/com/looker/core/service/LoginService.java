package com.looker.core.service;

import com.looker.core.model.SysUser;



public interface LoginService {
	/**
	 * @Description 登录验证
	 * @return
	 */
	SysUser checkLogin(String userName,String password);
}
