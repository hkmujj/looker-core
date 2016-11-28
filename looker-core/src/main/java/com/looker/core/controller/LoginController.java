package com.looker.core.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.looker.core.model.SysUser;
import com.looker.core.service.LoginService;
import com.looker.core.service.MenuService;
import com.looker.core.service.RoleManagerService;
import com.looker.core.util.Base64Util;
import com.niwodai.tech.base.util.StringUtil;

/**
 * @description 核心系统登录
 */
@Controller
@RequestMapping("/cores")
public class LoginController {
	
	@Autowired
	MenuService menuService;
	
	@Autowired
	LoginService loginService;
	@Resource
	RoleManagerService roleManagerService;
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * 登录验证
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/login.qyzx")
	public JSONObject getPubMsg(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		JSONObject retJson = new JSONObject();
		int resCode = 0;
		String resMsg = "success";
		
		String path = request.getContextPath();
		String username = "";
		String password = "";
		
		// 内容及用户输入的验证码
		username = request.getParameter("username");
		password = request.getParameter("password");
		
		if(StringUtil.isEmpty(username)){
			retJson.put("resCode", -1001);
			retJson.put("resMsg", "用户名为空");
			return retJson;
		}
		
		if(StringUtil.isEmpty(password)){
			retJson.put("resCode", -1001);
			retJson.put("resMsg", "密码为空");
			return retJson;
		}
		
		SysUser user = null;
		
		user = (SysUser) request.getSession().getAttribute("loginUserInfo");
		if(user == null){
			user = loginService.checkLogin(username, Base64Util.encode(password));
		}	
		if (user != null) {
			String userStatus = user.getUserStatus();
			if("0".equals(userStatus)){
				
				Map<String,Object> loginInfo = new HashMap<String, Object>();
				
				List<String> roleList = getRoleCodes(roleManagerService.queryUserRoleList(user.getUserId()));
				user.setRoleList(roleList);
				loginInfo.put("loginInfo", user);
				retJson.put("resData", loginInfo);
				// 登录时不记住任何信息
				// 是否勾选了 记住我 复选框
				String rememberFlag = request.getParameter("rememberFlag");
				if ("Y".equals(rememberFlag)) {
					Cookie userAccCookie = new Cookie("userAccount", user.getUserAccount());
					userAccCookie.setHttpOnly(false);
					// cookie有效期暂定为一个星期
					userAccCookie.setMaxAge(60*60*24*7);
					response.addCookie(userAccCookie);
					Cookie userNameCookie = new Cookie("userName", URLEncoder.encode(user.getUserName(),"UTF-8"));
					userNameCookie.setPath(path);
					userNameCookie.setHttpOnly(false);
					// cookie有效期暂定为一个星期
					userNameCookie.setMaxAge(60*60*24*7);
					response.addCookie(userNameCookie);
					Cookie passwordCookie = new Cookie("password", user.getPassword());
					passwordCookie.setPath(path);
					passwordCookie.setHttpOnly(false);
					// cookie有效期暂定为一个星期
					passwordCookie.setMaxAge(60*60*24*7);
					response.addCookie(passwordCookie);
				}
				request.getSession().setAttribute("loginUserInfo", user);
			} else {
				resCode = -1002;
				resMsg = "用户已停用!";
			}
		} else {
			resCode = -1003;
			resMsg = "用户名或密码错误，请重新填写!";
		}
		
		response.setContentType("text/plain;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		
		retJson.put("resCode", resCode);
		retJson.put("resMsg", resMsg);
		return retJson;
	}
	
	@RequestMapping("/logout.qyzx")
	@ResponseBody
	public JSONObject logout(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		JSONObject retJson = new JSONObject();
		HttpSession session = request.getSession();
		session.removeAttribute("loginUserInfo");
		
		Cookie[] cookies = request.getCookies();
		if (null != cookies && cookies.length > 0) {
			// 删除cookie
			for (Cookie cookie : cookies) {
				if ("userAccount".equals(cookie.getName())||"userName".equals(cookie.getName())||"password".equals(cookie.getName())) {
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
			}
		}
		session.invalidate();
		retJson.put("resCode", 0);
		retJson.put("resMsg", "success");
		return retJson;
	}
	
	
	/**
	 * 根据用户Id获取当前登录用户的菜单
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/menu/menu.qyzx")
	@ResponseBody
	public JSONObject menu(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		JSONObject retJson = new JSONObject();
		int resCode = 0;
		String resMsg = "succss";
		
		
		String userId = request.getParameter("userId");
		
		if(StringUtil.isEmpty(userId)){
			retJson.put("resCode", -1);
			retJson.put("resMsg", "userId为空");
			return retJson;
		}
		
		try {
			Map<String, Object> menu = new HashMap<String, Object>();
			//获取菜单权限列表数据
			List<Map<String, Object>> userMenus = menuService.getMenuList(userId);
			menu.put("menu", userMenus);
			retJson.put("resData",menu);
			
		} catch (Exception e) {
			e.printStackTrace();
			resCode = -2;
			resMsg = "系统异常";
		}
		
		retJson.put("resCode", resCode);
		retJson.put("resMsg", resMsg);
		return retJson;
	}
	
	/**
	 * @Description 将用户角色Code列表拼接成List
	 * @param list
	 * @return
	 */
	private List<String> getRoleCodes(List<Map<String, Object>> list) {
		List<String> resultList = new ArrayList<String>();
		for (Map<String, Object> temp : list) {
			resultList.add((String) temp.get("ROLE_CODE"));
		}
		return resultList;
	}
	
}
