package com.looker.core.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.looker.core.model.CodeItem;
import com.looker.core.service.CodeItemService;
import com.niwodai.tech.base.dao.IBaseDao;

@Service
public class CodeItemServiceImpl implements CodeItemService {

    @Resource
    IBaseDao iBaseDao;

    @Override
    public List<CodeItem> getCodeItemByType(String type) {
    	CodeItem item=new CodeItem();
    	item.setType(type);
        return iBaseDao.findByQuery("codeItem.findCodeItem", item);
    }
}
