package com.looker.core.quartz;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 定时任务 每天跑一次 扫描授权表里所有授权正常的记录，查看授权期限是否到期
 */
public class ProductAuthExpireTask {

	protected final Log logger = LogFactory.getLog(getClass());
	
	/**
	 * @throws Exception 
	 * @Description 产品授权是否过期或剩余时间是否为一天,由此发送邮件
	 */
	public void queryProductAuthExpire() throws Exception{
		logger.info("----------执行产品授权检查，并发送邮件------------");
	}
	
}
