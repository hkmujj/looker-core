package com.looker.core.controller;

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
import com.looker.core.model.SysUser;
import com.looker.core.model.ZTokenRecords;
import com.looker.core.service.TokenManagerService;
import com.looker.core.util.GenerateRandomNumber;
import com.niwodai.tech.base.dao.model.Page;
import com.niwodai.tech.base.util.PageUtils;
import com.niwodai.tech.base.util.StringUtil;

/**
 * @description token controller 包含生成token和token列表两个方法
 */

@Controller
@RequestMapping("/cores/token")
public class GenerateTokenController {

	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	private TokenManagerService tokenManagerService;

	/**
	 * 生成token码
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("generate.qyzx")
	public JSONObject generate(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		SysUser user = (SysUser) request.getSession().getAttribute(
				"loginUserInfo");
		JSONObject resJson = new JSONObject();
		int resCode = 0;
		String resMsg = "success";

		String orgCode = request.getParameter("orgCode");

		String channelCode = request.getParameter("channelCode");

		logger.info("---------------生成orgCode为[" + orgCode + "],channelCode为["
				+ channelCode + "]授权码----------------");

		if (StringUtil.isEmpty(orgCode)) {
			resJson.put("resCode", -1);
			resJson.put("resMsg", "机构名称为空");
			return resJson;
		}

		if (StringUtil.isEmpty(channelCode)) {
			resJson.put("resCode", -1);
			resJson.put("resMsg", "渠道名称为空");
			return resJson;
		}

		// 生成token
		String token = GenerateRandomNumber.getStringRandom(null, 20);

		// 给生成的token每隔5位加上"-" 如 06FY2-7CL26-N9XU9-Q52NE
		//String newToken = addSymbolsForString(token, 5, "-");

		try {
			// 每次生成后插入到数据库
			ZTokenRecords tokenRecords = new ZTokenRecords();
			tokenRecords.setCreateTime(new Date());
			tokenRecords.setCreateUser(String.valueOf(user.getUserId()));
			tokenRecords.setTokenChannelcode(channelCode);
			tokenRecords.setTokenOrgcode(orgCode);
			tokenRecords.setTokenCreater(user.getUserAccount());
			tokenRecords.setTokenCode(token);
			tokenManagerService.insertToken(tokenRecords);
		} catch (Exception e) {
			resCode = -2;
			resMsg = "系统异常";
			logger.error(e);
		}

		Map<String, Object> data = new HashMap<String, Object>();
		data.put("token", token);
		resJson.put("resData", data);
		resJson.put("resCode", resCode);
		resJson.put("resMsg", resMsg);

		return resJson;

	}

	/**
	 * 获取token列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("tokenList.qyzx")
	public JSONObject queryTokenList(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		JSONObject resJson = new JSONObject();
		int resCode = 0;
		String resMsg = "success";

		Page<Object> page = PageUtils.getPage(request);
		try {

			// 列表查询参数
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("tokenOrgcode", request.getParameter("orgName"));
			params.put("tokenChannelcode", request.getParameter("channelName"));
			params.put("tokenCode", request.getParameter("token"));
			params.put("order", request.getParameter("order_by"));
			params.put("sort", request.getParameter("order"));

			//创建人
			params.put("tokenCreater", request.getParameter("userId"));
			
			tokenManagerService.queryTokenList(page, params);

			List<Object> tokenList = page.getResult();

			Map<String, Object> result = new HashMap<String, Object>();
			result.put("token", tokenList);

			resJson.put("resData", result);

		} catch (Exception e) {
			e.printStackTrace();
			resCode = -2;
			resMsg = "系统出现异常！";
		}

		resJson.put("totalCount", page.getTotalCount());
		resJson.put("pageNo", page.getPageNo());
		resJson.put("pageSize", page.getPageSize());
		resJson.put("resCode", resCode);
		resJson.put("resMsg", resMsg);
		return resJson;

	}

	/**
	 * 给字符串每隔几位加上字符
	 * 
	 * @param target
	 *            目标字符串
	 * @param length
	 *            隔几位加
	 * @param symbols
	 *            字符
	 * @return
	 */
	private String addSymbolsForString(String target, int length, String symbols) {
		String result = "";

		int size = ((target.length()) % length == 0) ? ((target.length()) / length)
				: ((target.length()) / length + 1);

		for (int i = 0; i < size; i++) {
			int endIndex = (i + 1) * length;
			if ((i + 1) == size) {
				endIndex = target.length();
			}
			if (i == 0) {
				result += target.substring(i, endIndex);
			} else {
				result += symbols + target.substring(i * length, endIndex);
			}
		}
		return result;
	}

}
