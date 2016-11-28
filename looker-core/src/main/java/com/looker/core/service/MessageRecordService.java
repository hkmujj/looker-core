package com.looker.core.service;

import com.looker.core.model.ZMessageRecords;

/**
 * @description 发送消息记录
 */
public interface MessageRecordService {
	
	/**
	 * @Description 插入message record信息
	 * @param params
	 */
	Long insertMessageRecord(ZMessageRecords records);
	
	
}
