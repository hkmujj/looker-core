package com.looker.core.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.looker.core.model.Dictionary;
import com.looker.core.model.SysUser;
import com.looker.core.service.DictionaryService;
import com.looker.core.service.LoginService;
import com.looker.core.service.RoleManagerService;

/**
 * 提供一些公共接口
 *
 */

@Controller
@RequestMapping("/cores/common")
public class CommonController {

	private final Log logger = LogFactory.getLog(getClass());
	
	@Resource
	private DictionaryService dictionaryService;
	
	
	@Resource
	private LoginService loginService;
	
	@Resource
	private RoleManagerService roleManagerService;
	
	
	@ResponseBody
	@RequestMapping("/getDicCode.qyzx")
	public JSONObject getDicBydicType(HttpServletRequest request,HttpServletResponse response){
		logger.info("--------------获取字典项------------------------");
		JSONObject resJson = new JSONObject();
		int resCode = 0;
		String resMsg = "获取字典项成功";
		try {
			//传递过来的字典项type
			String types = request.getParameter("dicType");
			
			if(types != null && !"".equals(types)){
				Map<String, Object> listMap = new HashMap<String, Object>(); 
				
				String[] type = types.split(",");
				
				for(String s : type){
					List<Dictionary> dicList = dictionaryService.getDicByDicType(s);
					listMap.put(s, dicList);
				}
				
				resJson.put("resData", listMap);
				
			}else{
				resJson.put("resData", "");
				resJson.put("resCode", -1);
				resJson.put("resMsg", "参数错误！");
				return resJson;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resCode = -2;
			resMsg = "参数错误";
		}
		
		resJson.put("resCode", resCode);
		resJson.put("resMsg", resMsg);
		return resJson;
		
	}
	
	/**
	 * @Description 生成防重提交用的token并保存在session中
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getToken.qyzx")
	public JSONObject getToken(HttpServletRequest request,HttpServletResponse response){
		logger.info("--------------生成防重提交用token令牌----------------");
		JSONObject resJson = new JSONObject();
		int resCode = 0;
		String resMsg = "success";
		
		// 生成token令牌放在session中
		String token = UUID.randomUUID().toString();
		request.getSession().setAttribute("token", token);
		
		resJson.put("resData", token);
		resJson.put("resCode", resCode);
		resJson.put("resMsg", resMsg);
		return resJson;
		
	}
	
	/**
	 * @Description 查询所有可用机构
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryOrgList.qyzx")
	public JSONObject queryOrgList(HttpServletRequest request,HttpServletResponse response){
		JSONObject resJson = new JSONObject();
		int resCode = 0;
		String resMsg = "success";
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("orgStatus", 0);
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		
		// 组装返回数据
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("orgList", list);
		resJson.put("resData", map);
		resJson.put("resCode", resCode);
		resJson.put("resMsg", resMsg);
		return resJson;
		
	}
	
	/**
	 * @Description 查询所有可用渠道
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryChannelList.qyzx")
	public JSONObject queryChannelList(HttpServletRequest request,HttpServletResponse response){
		JSONObject resJson = new JSONObject();
		int resCode = 0;
		String resMsg = "success";
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("state", 0);
		params.put("orgCode", request.getParameter("orgCode"));
		// 时间有效期内
		params.put("effect", "effect");
		List<Map<String,Object>> list =  new ArrayList<Map<String,Object>>();
		
		// 组装返回数据
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("channelList", list);
		resJson.put("resData", map);
		resJson.put("resCode", resCode);
		resJson.put("resMsg", resMsg);
		return resJson;
		
	}
	
	/**
	 * @Description 查询所有可用产品
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/queryProductList.qyzx")
	public JSONObject queryProductList(HttpServletRequest request,HttpServletResponse response){
		JSONObject resJson = new JSONObject();
		int resCode = 0;
		String resMsg = "success";
		Map<String,Object> params = new HashMap<String, Object>();
		// 产品状态为启用
		params.put("productStatus", "0");
		// 复核状态为复核通过的
		params.put("recheckStatus", "1");
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>() ;
		
		// 组装返回数据
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("productList", list);
		resJson.put("resData", map);
		resJson.put("resCode", resCode);
		resJson.put("resMsg", resMsg);
		return resJson;
		
	}
	
	/**
	 * @Description 判断是否已登录
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkLogin.qyzx")
	public JSONObject checkLogin(HttpServletRequest request,HttpServletResponse response){
		SysUser user =  (SysUser) request.getSession(false).getAttribute("loginUserInfo");
		JSONObject resJson = new JSONObject();
		int resCode = 0;
		String resMsg = "success";
		if (user == null) {
			// 先校验是否带着cookie
			Cookie[] cookies = ((HttpServletRequest)request).getCookies();
			String userName = "";
			String password = "";
			if (null != cookies && cookies.length > 0) {
				for (Cookie cookie : cookies) {
					if ("userAccount".equals(cookie.getName())) {
						userName=cookie.getValue();
					}
					if ("password".equals(cookie.getName())) {
						password=cookie.getValue();
					}
				}
			}
			// 有cookie
			if (userName!=null&&userName.length() > 0 && password!=null&&password.length() > 0) {
				user = loginService.checkLogin(userName, password);
				if (user != null) {
					String userStatus = user.getUserStatus();
					if ("0".equals(userStatus)) {
						Map<String,Object> loginInfo = new HashMap<String, Object>();
						List<String> roleList = getRoleCodes(roleManagerService.queryUserRoleList(user.getUserId()));
						user.setRoleList(roleList);
						loginInfo.put("loginInfo", user);
						loginInfo.put("loginFlag", "Y");
						// 将登录成功的user信息存入到session中
						request.getSession().setAttribute("loginUserInfo", user);
						resJson.put("resData", loginInfo);
					}
				}
			} else {// 没有cookie
				Map<String,Object> loginInfo = new HashMap<String, Object>();
				loginInfo.put("loginFlag", "N");
				resJson.put("resData", loginInfo);
			}
			
		} else {
			Map<String,Object> loginInfo = new HashMap<String, Object>();
			List<String> roleList = getRoleCodes(roleManagerService.queryUserRoleList(user.getUserId()));
			user.setRoleList(roleList);
			loginInfo.put("loginInfo", user);
			loginInfo.put("loginFlag", "Y");
			resJson.put("resData", loginInfo);
		}
		
		resJson.put("resCode", resCode);
		resJson.put("resMsg", resMsg);
		return resJson;
		
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
