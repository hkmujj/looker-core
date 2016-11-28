package com.looker.core.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.looker.core.model.Dictionary;
import com.looker.core.service.DictionaryService;
import com.niwodai.tech.base.dao.IBaseDao;

@Service("dictionaryService")
public class DictionaryServiceImpl implements DictionaryService{

	private final Log logger = LogFactory.getLog(getClass());
	
	@Resource
	IBaseDao iBaseDao;
	
	@Override
	public List<Dictionary> getDicByDicType(String dicType) {
		return iBaseDao.findByQuery("Dictionary.findDictionaryByDicType",dicType);
	}

}
