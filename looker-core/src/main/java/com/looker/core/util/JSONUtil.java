package com.looker.core.util;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * json工具类
 *
 * @author qianjc
 * @date May 28, 2015 8:53:12 AM
 */
public class JSONUtil {
    private static Logger logger = LoggerFactory.getLogger(JSONUtil.class);
    private static ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 对象转为JSON字符串
     */
    public static String toJson(Object object) {
        String str = null;
        try {
            str = objectMapper.writeValueAsString(object);
        } catch (IOException e) {
            logger.info("对象转为JSON字符串失败" + e.getMessage(), e);
        }
        return str;
    }

    /**
     * JSON字符串转为对象
     *
     * @param valueType 目标对象的类型
     * @param json      JSON字符串
     * @return object 目标对象(转换失败返回 null)
     */
    public static <T> T toObject(String json, Class<T> valueType) {
        T object = null;
        try {
            object = objectMapper.reader(valueType).readValue(json);
        } catch (IOException e) {
            logger.info("JSON字符串转为对象" + e.getMessage());
        }
        return object;
    }
}