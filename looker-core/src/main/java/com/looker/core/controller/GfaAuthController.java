package com.looker.core.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.looker.core.util.DateUtils;
import com.niwodai.tech.base.util.StringUtil;

/**
 * 给数据平台提供的接口
 * 主要功能是:数据平台传递授权码和产品编码两个参数,在产品授权表中筛选出对应的产品是否授权，授权是否过期、授权次数这些结果
 *
 */
@Controller
public class GfaAuthController {

	private final Log logger = LogFactory.getLog(getClass());
	
	
	
	@ResponseBody
	@RequestMapping("/gfaAuth")
	public JSONObject gfaAuth(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		JSONObject retJson = new JSONObject();
		int resCode = 0;
		String resMsg = "success";
		
		//授权码
		String authCode = request.getParameter("authCode");
		//产品编码
		String productCode = request.getParameter("productCode");
		
		logger.info("authCode为["+authCode + "]-------------productCode为["+productCode+"],身份认证");
		
		try {
			
			if(StringUtil.isEmpty(authCode)){
				retJson.put("resCode", -1001);
				retJson.put("resMsg", "授权码为空！");
				return retJson;
			}
			

			//查询出产品授权表中所有对应的authCode的记录
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("authCode", authCode);
			params.put("notInStates", "2");//授权未停用的
			params.put("state", "9");//已开通的才可用
			//params.put("authTime", DateUtils.getDate(new Date()));//当前时间是不是在授权时间内
			List<Map<String, Object>> productList =  new ArrayList<Map<String,Object>>();
			
			//根据授权码未获取到授权记录
			if(productList == null || productList.size() <= 0){
				logger.info("----------对应authCode["+authCode + "]没有授权，或者授权了但是未开通----------");
				retJson.put("resCode", -1001);
				retJson.put("resMsg", "身份验证失败！");
				return retJson;
			}else{

				if(StringUtil.isEmpty(productCode)){
					retJson.put("resCode", -1001);
					retJson.put("resMsg", "产品编码为空！");
					return retJson;
				}
				
				//移除list中不包含当前参数中productCode的记录
				removeProuctList(productList,productCode);
				
				//获得新的List，只包含当前productCode的记录
				if(productList != null && productList.size() >0){
					
					//先判断有没有过期的
					if(isProductExpire(productList,productCode)){
						resCode = -1003;
						resMsg = "授权时间过期！";
					}else{
						Map<String, Object> data = new HashMap<String, Object>();
						
						//授权可能有多条，但是在当前时间内的一定只有一条，这个list中只有一条数据,如果出现多条选择最新的一条
						if(productList != null && productList.size() > 0){
							String authNum = (String)productList.get(0).get("AUTH_NUM");
							String channelCode = (String)productList.get(0).get("CHANNEL_CODE");
							String channelName = (String)productList.get(0).get("CHANNEL_NAME");
							//可调用次数
							Long totalCount = (Long)productList.get(0).get("TOTAL_COUNT");
							
							if(isProductAuthorize(authNum,channelCode,productCode,totalCount)){
								resCode =  -1004;
								resMsg = "授权次数不足！";
							}else{
								data.put("channelCode", channelCode);
								data.put("channelName", channelName);
								retJson.put("data", data);
							}
						//在正确的数据情况下以下的情况不会出现
						}else{
							resCode =  -2;
							resMsg = "授权异常！";
							logger.error("授权记录出错，请查看authCode为["+authCode + "]，productCode为["+productCode+"]的授权记录");
						}
						
						if(productList != null && productList.size() > 1){
							logger.error("授权记录出错，请查看authCode为["+authCode + "]，productCode为["+productCode+"]的授权记录，有效时间内授权了多次！");
						}
					}
					
				}else{
					logger.info("当前产品["+productCode+"]未授权");
					resCode =  -1002;
					resMsg = "权限不足！";
				}
			}
			
		} catch (Exception e) {
			resCode =  -2;
			resMsg = "系统异常！";
			logger.error(e);
		}
		
		
		retJson.put("resCode", resCode);
		retJson.put("resMsg", resMsg);
		return retJson;
		
	}
	
	
	
	/**
	 * 通过筛选把包含参数中的productCode的记录留下，其余的去除掉
	 */
	private void removeProuctList(List<Map<String, Object>> productList,String productCode){
		List<Map<String, Object>> removeList = new ArrayList<Map<String,Object>>();
		for(Map<String, Object> mangerInfo : productList){
			String pCode = (String)mangerInfo.get("PRODUCT_CODE");
			if(!pCode.equalsIgnoreCase(productCode)){
				removeList.add(mangerInfo);
			}
		}
		productList.removeAll(removeList);
	}
	
	
	/**
	 * 校验当前产品授权中对应的产品是否过期
	 * @param productList
	 * @param productCode
	 * @return
	 */
	private boolean isProductExpire(List<Map<String, Object>> productList,String productCode) throws Exception{
		
		boolean isExpire = true;
		//当前时间
		String date = DateUtils.getDate(new Date());
		
		List<Map<String, Object>> removeList = new ArrayList<Map<String,Object>>();
		
		for(Map<String, Object> mangerInfo : productList){
			//产品编码
			String pCode = (String)mangerInfo.get("PRODUCT_CODE");
			//授权开始时间
			String authBeginTime = (String)mangerInfo.get("AUTH_BEGIN_TIME");
			//授权结束时间
			String authEndTime = (String)mangerInfo.get("AUTH_END_TIME");
			//匹配产品编码
			if(pCode.equalsIgnoreCase(productCode)){
				//如果产品存在，判断有没有过期
				//比较当前授权的是否过期
				if(date.compareTo(authBeginTime) >= 0 
						&& date.compareTo(authEndTime) <= 0){
					isExpire = false;
				}else{
					removeList.add(mangerInfo);
				}
			}
		}
		productList.removeAll(removeList);//再次移除掉过期的记录
		return isExpire;
		
	}
	
	
	/**
	 * 判断当前授权次数还够不够
	 * @param authNum 授权次数
	 * @param channelCode
	 * @param productCode
	 * @param usedCount 可调用次数
	 * @return boolean isUsedUp 
	 */
	private boolean isProductAuthorize(String authNum,String channelCode,String productCode,Long totalCount){
		
		boolean isUsedUp = false;
		
		//-1是无限次
		if((Long.valueOf(authNum) == -1 || Long.valueOf(authNum) > 0) && totalCount > 0 ){
			//没有过期则比较接口调用次数有没有超过总次数
			Map<String, Object> statisParams = new HashMap<String, Object>();
			statisParams.put("channelCode", channelCode);
			statisParams.put("productCode", productCode);
			List<Map<String, Object>> queryStatistics = new ArrayList<Map<String, Object>>();
			
			if(queryStatistics != null && queryStatistics.size() > 0){
				//已调用次数
				BigDecimal usedCount = (BigDecimal) queryStatistics.get(0).get("totalCount");
				//次数没有用完可以继续
				if((Long.valueOf(authNum) == -1 || new BigDecimal(authNum).compareTo(usedCount) == 1)
						&& new BigDecimal(totalCount).compareTo(usedCount) == 1){
					isUsedUp = false;
					logger.info("----------授权次数上限["+authNum+"]，已购买次数["+totalCount+"]，已使用次数["+usedCount+"]");
				}else{
					logger.info("----------授权使用次数已达上限["+authNum+"]，或者已购买次数["+totalCount+"]已经用完,已用["+usedCount+"]次----------");
					isUsedUp = true;
				}
			}else{//如果没有数据说明一次也没调用过,并且也授权次数有，可以通过，数据平台在调用成功之后会insert记录到数据库里
				isUsedUp = false;
			}
		}else{
			isUsedUp = true;
		}
		
		return isUsedUp;
	}
	
}
