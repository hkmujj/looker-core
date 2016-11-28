package com.looker.core.util;

import com.looker.core.model.CodeItem;
import com.looker.core.service.CodeItemService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Yang Guang
 * Date: 2015/4/16 17:19
 * Description:加载配置
 */
@Service
public class SystemInit {
    /*private static final Logger logger = LoggerFactory.getLogger(SystemInit.class);

    @Autowired
    private CodeItemService codeItemService;

    public static final String SCHOOL = "School";
    public static final String ZHIMA = "ZhiMa";
    public static final String HBASECONF = "HBaseConf";
    public static final String SYSTEMCONF = "SystemConf";

    private static Map<String, List<CodeItem>> codeList = new HashMap<>();
    private static Map<String, Map<String, String>> codeMap = new HashMap<>();
    @PostConstruct
    public void initialize(){
        loadCodeitems();
    }

    private void loadCodeitems(){
        logger.info("Loading codeitems on starting!");
        codeList.clear();
        codeMap.clear();
        loadCodeitem(SCHOOL);
        loadCodeitem(HBASECONF);
        loadCodeitem(ZHIMA);
        loadCodeitem(SYSTEMCONF);
    }

    public static Map<String, String> getMapCodeItem(String type){
        return codeMap.get(type) != null ? codeMap.get(type) : new HashMap<String, String>();
    }

    private void loadCodeitem(String type){
        Map<String, String> map = new HashMap<>();
        List<CodeItem> codeItemByType = codeItemService.getCodeItemByType(type);
        for (CodeItem codeItem : codeItemByType) {
            map.put(codeItem.getCode(), codeItem.getValue());
        }
        codeMap.put(type, map);
    }*/
}
