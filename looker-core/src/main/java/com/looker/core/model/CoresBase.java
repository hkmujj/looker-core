package com.looker.core.model;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * @Description: 核心系统参数配置
 */
@Component
public class CoresBase {

	// 报表管理--报表下载模板文件存放位置
	@Value("${cores.statement.excelFilePath}")
	private String excelFilePath;

	// 未登录时候重定向url
	@Value("${cores.login.loginUrl}")
	private String loginUrl;

	public String getExcelFilePath() {
		return excelFilePath;
	}

	public String getLoginUrl() {
		return loginUrl;
	}

}
