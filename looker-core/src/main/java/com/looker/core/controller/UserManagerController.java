package com.looker.core.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.looker.core.model.SysUser;
import com.looker.core.service.DictionaryService;
import com.looker.core.service.RoleManagerService;
import com.looker.core.service.UserManagerService;
import com.looker.core.token.Token;
import com.looker.core.util.Base64Util;
import com.looker.core.util.LoggerUtils;
import com.niwodai.tech.base.dao.model.Page;
import com.niwodai.tech.base.util.PageUtils;

/**
 * @description 用户管理controller
 */
@Controller
@RequestMapping("/cores/userManager")
public class UserManagerController {
	
	@Autowired
	private UserManagerService userManagerService;
	@Autowired
	private DictionaryService dictionaryService;
	@Autowired
	private RoleManagerService roleManagerService;

	/**
	 * @Description 用户列表查询
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/queryUserList.qyzx")
	public JSONObject queryUserList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		
		Page<Object> page = PageUtils.getPage(request);
		Map<String, Object> params = new HashMap<String, Object>();
		// 用户账号
		params.put("userAccount", request.getParameter("userAccount"));
		// 用户姓名
		params.put("userName", request.getParameter("userName"));
		// 用户状态
		params.put("userStatus", request.getParameter("userStatus"));
		// 用户角色
		params.put("roleId", request.getParameter("roleId"));
		// 手机号码
		params.put("phoneNo", request.getParameter("phoneNo"));
		// 所属部门
		params.put("depart", request.getParameter("depart"));
		
		// 排序方式：asc-升序，desc-降序
		params.put("order", request.getParameter("order"));
		// 排序字段
		params.put("order_by", request.getParameter("order_by"));
		
		// 查询用户列表
		userManagerService.queryUserList(page, params);
		for (Object temp : page.getResult()) {
			@SuppressWarnings("unchecked")
			Map<String,Object> map = (Map<String,Object>) temp;
			// 用户角色列表
			List<Map<String,Object>> userRoleList = roleManagerService.queryUserRoleList((long)map.get("USER_ID"));
			String roleNames = getRoleNames(userRoleList);
			map.put("ROLE_NAMES", roleNames);
		}
		
		// 组装返回数据
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("userList", page.getResult());
		resJson.put("resData", map);
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		resJson.put("totalCount", page.getTotalCount());
		resJson.put("pageNo", page.getPageNo());
		resJson.put("pageSize", page.getPageSize());
		return resJson;
	}
	
	/**
	 * @Description 用户详情查询
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/queryUserDetail.qyzx")
	public JSONObject queryUserDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		
		// 查询用户列表
		Map<String,Object> userInfo = userManagerService.queryUser(Long.parseLong(request.getParameter("userId")));
		
		// 组装返回数据
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("userInfo", userInfo);
		resJson.put("resData", map);
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		return resJson;
	}
	
	/**
	 * @Description 角色列表查询
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/queryRoleList.qyzx")
	public JSONObject queryRoleList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		
		String userId = request.getParameter("userId");
		List<Map<String, Object>> roleList = new ArrayList<Map<String,Object>>();
		if (userId == null || userId.trim().length() == 0) {
			// 查询所有角色
			roleList = roleManagerService.queryAllRoleList();
		} else {
			// 查询指定用户的角色
			roleList = roleManagerService.queryUserRoleList(Long.parseLong(userId));
		}
		
		// 组装返回数据
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("roleList", roleList);
		resJson.put("resData", map);
		return resJson;
	}
	
	/**
	 * @Description 新建用户
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/addUser.qyzx")
	@Token(checkToken=true)
	public JSONObject addUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		
		SysUser sysUser = (SysUser)request.getSession().getAttribute("loginUserInfo");
		String userAccount = request.getParameter("userAccount");
		String roleIds = request.getParameter("roleIds");
		String[] roleIdArr = {};
		if (roleIds != null && roleIds.length() > 0) {
			roleIdArr = roleIds.split(",");
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userAccount", userAccount);
		params.put("userName", request.getParameter("userName"));
		params.put("userStatus", request.getParameter("userStatus"));
		params.put("depart", request.getParameter("depart"));
		params.put("phoneNo", request.getParameter("phoneNo"));
		// 邮箱加上嘉银征信的邮箱后缀
		String email = (String) request.getParameter("email")+"@jiayincredit.com";
		params.put("email", email);
		if (checkEmail(email)) {
			resJson.put("resCode", -1);
			resJson.put("resMsg", "用户邮箱已注册！请更换邮箱!");
			return resJson;
		}
		// 初始默认password：123456
		params.put("password", Base64Util.encode("123456"));
		params.put("updateUser", sysUser.getUserAccount());
		params.put("roleIds", roleIdArr);
		try {
			long userId = userManagerService.addUser(params);
			resJson.put("resData", userId);
		} catch (Exception e) {
			LoggerUtils.error(this, "新增用户失败", e);
			resJson.put("resCode", -1);
			resJson.put("resMsg", "新增用户失败");
		}
		// 组装返回数据
		return resJson;
	}
	
	
	/**
	 * @Description 用户信息修改
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/updateUser.qyzx")
	public JSONObject updateUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		
		SysUser sysUser = (SysUser)request.getSession().getAttribute("loginUserInfo");
		String roleIds = request.getParameter("roleIds");
		String[] roleIdArr = {};
		if (roleIds != null && roleIds.length() > 0) {
			roleIdArr = roleIds.split(",");
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", request.getParameter("userId"));
		params.put("userName", request.getParameter("userName"));
		params.put("userStatus", request.getParameter("userStatus"));
		params.put("depart", request.getParameter("depart"));
		params.put("phoneNo", request.getParameter("phoneNo"));
		params.put("createUser", sysUser.getUserAccount());
		params.put("roleIds", roleIdArr);
		params.put("sysUser", sysUser.getUserName());
		try {
			userManagerService.updateUser(params);
		} catch (Exception e) {
			LoggerUtils.error(this, "更新用户失败", e);
			resJson.put("resCode", -1);
			resJson.put("resMsg", "更新用户失败");
		}
		// 组装返回数据
		return resJson;
	}
	
	/**
	 * 邮箱是否唯一
	 * @param req
	 * @param resp
	 * @param productName
	 * @return
	 */
	public boolean checkEmail(String email) {
		// 判断用户账号是否已经存在
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("email", email);
		return userManagerService.userIsExist(map);
	}
	
	/**
	 * @Description 密码重置
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/resetPassword.qyzx")
	public JSONObject resetPassword(HttpServletRequest request, HttpServletResponse response) throws Exception {
		JSONObject resJson = new JSONObject();
		resJson.put("resCode", 0);
		resJson.put("resMsg", "success");
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("userId", request.getParameter("userId"));
		String defaultPassword = "123456";
		params.put("password", Base64Util.encode(defaultPassword));
		try {
			userManagerService.updateUser(params);
		} catch(Exception e) {
			LoggerUtils.error(this, "重置密码失败!", e);
			resJson.put("resCode",-1);
			resJson.put("resMsg","重置密码失败!");
		}
		return resJson;
	}
	
	/**
	 * @Description 将用户角色列表拼接成字符串，以逗号分割
	 * @param list
	 * @return
	 */
	public String getRoleNames(List<Map<String, Object>> list) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < list.size(); i++) {
			sb.append(list.get(i).get("ROLE_NAME"));
			if (i < list.size() - 1) {
				sb.append(",");
			}
		}
		return sb.toString();
	}
}
