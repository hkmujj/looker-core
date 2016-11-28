package com.looker.core.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;

import com.alibaba.fastjson.JSONObject;
import com.looker.core.common.CoresProviderService;
import com.looker.core.model.ZUserAuthInfo;
import com.looker.core.service.AuthManagerService;
import com.niwodai.tech.base.dao.model.Page;
import com.niwodai.tech.base.util.DateUtil;
import com.niwodai.tech.base.util.JSonUtil;

public class CoresProviderServiceImpl implements CoresProviderService {

	private static final Logger logger = Logger.getLogger(CoresProviderServiceImpl.class);
	
	@Value("${cores.auth.filePath}")
	private String authFilePath;
	
	@Autowired
	private AuthManagerService myAuthManagerService;
	
	
	/**
	 * 查询授权列表
	 */
	@Override
	public JSONObject selectAuthList(String userId,String state,Page<Object> page) {
		logger.info("---------获取用户"+userId+"状态为"+state+"的授权记录列表------------");
		JSONObject respJson = new JSONObject();
		int retCode = 0;
		String retMsg = "交易成功";
		try{
			if(StringUtils.isEmpty(userId)){
				retCode = -1;
				retMsg = "客户号不能为空";
			}
			else{
				Map<String,Object> params = new HashMap<String,Object>();
				params.put("state", state);
				params.put("belongUser", userId);
				myAuthManagerService.queryAuthInfoList(page,params);
				String pageJson = JSonUtil.toJSonString(page);
				JSONObject authJson = JSONObject.parseObject(pageJson);
				respJson.put("data", authJson);
			}
		}
		catch(Exception e){
			e.printStackTrace();
			retCode = -1;
			retMsg = "交易失败";
		}
		respJson.put("retCode", retCode);
		respJson.put("retMsg", retMsg);
		return respJson;
	}

	/**
	 * 更新授权记录状态
	 */
	@Override
	public JSONObject updateAuthRecordState(long recordId, int state,byte[] fileByteArr,String fileName) {
		logger.info("---------更新用户授权记录"+recordId+"状态为"+state+"的授权记录列表------------");
		int retCode = 0;
		String retMsg = "交易成功";
		JSONObject respJson = new JSONObject();
		// 保存用户授权书到本地
		File f = new File(authFilePath+fileName);
		if (!f.getParentFile().exists()) {// 文件夹不存在就新建文件夹
			if (!f.getParentFile().mkdirs()) {  
                logger.error("创建授权书文件夹失败"); 
                retCode = -1;
                retMsg = "创建授权书文件夹失败";
            } 
		}
		int length = fileByteArr.length;
		FileOutputStream fos;
		try {
			fos = new FileOutputStream(f);
			for (int i = 0; i < length; i = i + 2048) {
				if (i + 2048 < length) {
					fos.write(fileByteArr, i, 2048);

				} else {
					fos.write(fileByteArr, i, length - i);
				}
			}
			if (fos != null) {
				fos.close();
			}
		} catch (FileNotFoundException e1) {
			logger.error(e1);
		} catch (IOException e) {
			logger.error(e);
		}
		
		
		
		try{
				Map<String,Object> params = new HashMap<String,Object>();
				params.put("id", recordId);
				if("5".equals(state)){
					params.put("applyTime", DateUtil.formatDateTime("yyyy-MM-dd HH:mm:ss", new Date()));
				}
				params.put("state", state);
				ZUserAuthInfo authInfo = new ZUserAuthInfo();
				authInfo.setId(recordId);
				authInfo.setState(String.valueOf(state));
				authInfo.setAuthUrl(authFilePath+fileName);
				authInfo.setObtainTime(DateUtil.formatDateTime("yyyy-MM-dd HH:mm:ss", new Date()));
				JSONObject authJson = new JSONObject();
				myAuthManagerService.updateAuthInfoById(authInfo);
				respJson.put("data", authJson);
		}
		catch(Exception e){
			e.printStackTrace();
			retCode = -1;
			retMsg = "交易失败";
		}
		respJson.put("retCode", retCode);
		respJson.put("retMsg", retMsg);
		return respJson;
	}

	/**
	 * 查询所有的异议记录
	 */
	@Override
	public JSONObject findObjectionList(Map<String,Object> map,Page<Object> page) {
		logger.info("---------获取异议列表------------");
		JSONObject respJson = new JSONObject();
		int retCode = 0;
		String retMsg = "交易成功";
		respJson.put("retCode", retCode);
		respJson.put("retMsg", retMsg);
		return respJson;
	}

	@Override
	public JSONObject insertObjectionInfo(String userId,JSONObject json) {
		logger.info("-------插入异议数据-----------");
		JSONObject respJson = new JSONObject();
		int retCode = 0;
		String retMsg = "交易成功";
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -1;
			retMsg = "交易失败";
		}
		respJson.put("retCode", retCode);
		respJson.put("retMsg", retMsg);
		return respJson;
	}

	@Override
	public JSONObject findAuthProductList(String userId) {
		logger.info("---------获取授权用户产品列表------------");
		JSONObject respJson = new JSONObject();
		int retCode = 0;
		String retMsg = "交易成功";
		respJson.put("retCode", retCode);
		respJson.put("retMsg", retMsg);
		return respJson;
	}
	
	@Override
	public JSONObject checkLogin(String loginName, String password) {
		logger.info("---------商户系统登录------------");
		JSONObject respJson = new JSONObject();
		int retCode = 0;
		String retMsg = "交易成功";
		respJson.put("retCode", retCode);
		respJson.put("retMsg", retMsg);
		return respJson;
	}

	@Override
	public JSONObject findOrganizationList(Page<Object> page,
			Map<String, Object> params) {
		logger.info("---------商户系统获取用户机构信息------------");
		JSONObject respJson = new JSONObject();
		int retCode = 0;
		String retMsg = "交易成功";
			respJson.put("retCode", retCode);
			respJson.put("retMsg", retMsg);
			return respJson;
		}

	@Override
	public JSONObject findProductList(Page<Object> page,
			Map<String, Object> params) {
		logger.info("---------获取产品列表------------");
		JSONObject respJson = new JSONObject();
		int retCode = 0;
		String retMsg = "交易成功";
		try {
			 Page<Object> productManagerList = null;
			respJson.put("data", productManagerList);
		} catch (Exception e) {
			e.printStackTrace();
			retCode = -1;
			retMsg = "交易失败";
		}
		respJson.put("retCode", retCode);
		respJson.put("retMsg", retMsg);
		return respJson;
	}

	@Override
	public JSONObject modifyPassword(Map<String, Object> params) {
		logger.info("---------商户系统密码修改------------");
		JSONObject respJson = new JSONObject();
		int retCode = 0;
		String retMsg = "交易成功";
		respJson.put("retCode", retCode);
		respJson.put("retMsg", retMsg);
		return respJson;
	}
}
