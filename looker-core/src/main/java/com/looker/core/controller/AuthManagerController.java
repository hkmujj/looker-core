package com.looker.core.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.looker.core.service.AuthManagerService;
import com.niwodai.tech.base.dao.model.Page;
import com.niwodai.tech.base.util.DateUtil;
import com.niwodai.tech.base.util.PageUtils;
import com.niwodai.tech.base.util.StringUtil;

/**
 * 
* @ClassName: AuthManagerController 
* @Description: 用户授权管理
*
*/

@Controller
@RequestMapping("/cores/userAuth")
public class AuthManagerController {
	
	@Autowired
	private AuthManagerService myAuthManagerService;
	
	
	/**
	 * 用户授权列表查询
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("userAuthList.qyzx")
	public JSONObject queryUserAuthRecord(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		JSONObject respJson = new JSONObject();
		
		int resCode = 0;
		String resMsg = "获取用户授权列表成功";
		
		Page<Object> page = PageUtils.getPage(request);
		try{
			
			//String orgCode = request.getParameter("orgCode");
			String orgName = request.getParameter("orgName");
			//String channelId = request.getParameter("channelId");
			String channeName = request.getParameter("channelName");
			//String productId = request.getParameter("productId");
			String productName = request.getParameter("productName");
			String certNo = request.getParameter("certNo");
			String userName = request.getParameter("userName");
			String authStartTime = request.getParameter("authStartTime");
			String authStopTime = request.getParameter("authStopTime");
			String queryState = request.getParameter("state");
			String sort = request.getParameter("order");
			String order = request.getParameter("order_by");
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("orgName", orgName);
			params.put("channelName", channeName);
			params.put("productName", productName);
			params.put("certNo", certNo);
			params.put("userName", userName);
			params.put("authStartTime", authStartTime);
			params.put("authStopTime", authStopTime);
			params.put("order", order);
			params.put("sort", sort);
			
			//由于超时的没有定时任务，所以表中不会存在状态为超时的数据，超时的数据需要根据状态为3的数据在库里筛选
			//筛选条件为当前时间-6小时和申请授权时间比较
			Calendar calendar = Calendar.getInstance();
			if("4".equals(queryState)){
				params.put("state", "3");
				params.put("stateFlag", "4");
				calendar.set(Calendar.HOUR_OF_DAY, calendar.get(Calendar.HOUR_OF_DAY) - 6);
				String applyTime = DateUtil.formatDateTime("yyyy-MM-dd HH:mm:ss", calendar.getTime());
				params.put("applyTime", applyTime);
			}
			else{
				params.put("state", queryState);
				params.put("stateFlag", queryState);
				calendar.set(Calendar.HOUR_OF_DAY, calendar.get(Calendar.HOUR_OF_DAY) - 6);
				String applyTime = DateUtil.formatDateTime("yyyy-MM-dd HH:mm:ss", calendar.getTime());
				params.put("applyTime", applyTime);
			}
			
			
			myAuthManagerService.queryAuthInfoList(page, params);
			List<Object> orgList = page.getResult();
			
			Map<String, Object> result = new HashMap<String, Object>();
			result.put("userAuth", orgList);
			respJson.put("resData", result);
			respJson.put("totalCount", page.getTotalCount());
			respJson.put("pageNo", page.getPageNo());
			respJson.put("pageSize", page.getPageSize());
			
		} catch (Exception e) {
			e.printStackTrace();
			resCode = -2;
			resMsg = "系统出现异常！";
		}
		
		respJson.put("resCode", resCode);
		respJson.put("resMsg", resMsg);
		return respJson;
		
		
	}
	
	
	/**
	 * 用户授权授权操作
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("applyUserAuth.qyzx")
	public JSONObject userAuthApply(HttpServletRequest request, HttpServletResponse response) throws Exception {

		SysUser sysUser = (SysUser)request.getSession().getAttribute("loginUserInfo");
		
		JSONObject respJson = new JSONObject();
		
		int resCode = 0;
		String resMsg = "";
		int applyCount = 0;
		
		//用户授权Id
		String authId = request.getParameter("authId");
		
		Map<String, Object> updateparams = new HashMap<String, Object>();
		//更新后的状态
		updateparams.put("destState", "3");
		//需要更新的状态
		updateparams.put("state", "1");
		//申请授权时间
		updateparams.put("applyTime", DateUtil.formatDateTime("yyyy-MM-dd HH:mm:ss", new Date()));
		
		updateparams.put("userEmail", sysUser.getEmail());
		
		try {
			//一键全部申请
			if(StringUtil.isEmpty(authId)){
				
				applyCount = myAuthManagerService.updateApplyAuthInfo(updateparams,null);
			}else{
				
				List<String> applyRecords = new ArrayList<String>();
				applyRecords.add(authId);
				updateparams.put("recordIds", applyRecords);
				applyCount = myAuthManagerService.updateApplyAuthInfo(updateparams,authId);
			}
			
			resCode = 0;
			resMsg = "success";
			Map<String, Object> resData = new JSONObject();
			resData.put("updateCount", applyCount);
			respJson.put("resData", resData);
		} catch (Exception e) {
			e.printStackTrace();
			resCode = -2;
			resMsg = "申请授权失败";
		}
		
		respJson.put("resCode", resCode);
		respJson.put("resMsg", resMsg);
		return respJson;
		
	}
	
	
	
	@ResponseBody
	@RequestMapping("queryAuthInfo.qyzx")
	public JSONObject queryAuthInfo(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		JSONObject respJson = new JSONObject();
		
		int resCode = 0;
		String resMsg = "";
		
		try {
			String authId = request.getParameter("authId");
			
			if(StringUtil.isEmpty(authId)){
				respJson.put("resCode", -1);
				respJson.put("resMsg", "授权编号为空");
				return respJson;
			}
			
			Map<String, Object> params = new HashMap<String, Object>();
			List<String> recordIds = new ArrayList<String>();
			recordIds.add(authId);
			params.put("recordIds", recordIds);
			List<Map<String, Object>> authList = myAuthManagerService.queryAuthListById(params);
			if(authList != null && authList.size() > 0){
				resCode = 0;
				resMsg = "用户授权查询成功!";
				respJson.put("resData", authList.get(0));
			}
			else{
				resCode = -1;
				resMsg = "查询失败,未找到相关记录!";
			}
		} catch (Exception e) {
			e.printStackTrace();
			resCode = -2;
			resMsg = "查询出现异常";
		}
		
		respJson.put("resCode", resCode);
		respJson.put("resMsg", resMsg);
		return respJson;
		
	}
	

	
	
	
	/**
	 * @Description 授权文件展示
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/showAuthFile.qyzx")
	public JSONObject showAuthFile(HttpServletRequest request,HttpServletResponse response) throws Exception {
		JSONObject respJson = new JSONObject();
		
		String filePath = request.getParameter("filePath");

		// response.setContentType("image/*;charset=UTF-8");
		response.setContentType("image/*");
		FileInputStream fis = null;
		OutputStream os = null;
		try {
			fis = new FileInputStream(filePath);
			os = response.getOutputStream();
			int count = 0;
			byte[] buffer = new byte[2048];
			while ((count = fis.read(buffer)) != -1) {
				os.write(buffer, 0, count);
				os.flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (fis != null) {
					fis.close();
				}
				if (os != null) {
					os.flush();
					os.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		respJson.put("resCode", 0);
		respJson.put("resMsg", "success");
		return respJson;
	}
}
