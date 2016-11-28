package com.looker.core.service;

import java.util.List;

import com.looker.core.model.Dictionary;

/**
 * @Description:字典表数据接口
 */
public interface DictionaryService {

	/**
	 * 根据字典类型获取字典表数据
	 * @param dicType
	 * @return
	 */
	public List<Dictionary> getDicByDicType(String dicType);
	
}
