package com.looker.core.service;

import java.util.List;

import com.looker.core.model.CodeItem;

public interface CodeItemService {
    /**
     * 加载配置表
     * @param type
     * @return
     */
    public List<CodeItem> getCodeItemByType(String type);
}
