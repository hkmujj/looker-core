package com.looker.core.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.looker.core.model.ZMessageRecords;
import com.looker.core.service.MessageRecordService;
import com.niwodai.tech.base.dao.IBaseDao;


@Service("messageRecordService")
public class MessageRecordServiceImpl implements MessageRecordService {
	
	@Resource
	IBaseDao<Map<String,Object>> iBaseDao;

	@Override
	public Long insertMessageRecord(ZMessageRecords records) {
		return iBaseDao.create("ZMessageRecords.insertZMessageRecords", records);
	}

	
	
}
