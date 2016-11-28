package com.looker.core.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * LoggerUtil.debug(this, "debug message");       //调试信息
 * LoggerUtil.info(this, "info message");         //日志信息
 * LoggerUtil.warn(this, "warn message");         //无异常警告信息
 * LoggerUtil.warn(this, "warn message", e);      //有异常警告信息
 * LoggerUtil.error(this, "error message");       //无异常错误信息
 * LoggerUtil.error(this, "error message", e);    //有异常错误信息
 * 
 * @ClassName: LoggerUtils 
 * @Description: 日志工具类
 * @author zhengyangjun 
 * @date 2016年7月28日 下午12:45:03 
 *
 */
public class LoggerUtils {

	/**LoggerUtils.info(LoggerUtils.class, String.format("error message demo: %s, process bean: %s", 1, 2));*/
    
	public static void error(Object obj, String message) {
        error(obj.getClass(), message, null);
    }

    public static void error(@SuppressWarnings("rawtypes") Class clz, String message) {
        error(clz, message, null);
    }

    public static void error(Object obj, String message, Throwable t) {
        error(obj.getClass(), message, t);
    }

    public static void error(@SuppressWarnings("rawtypes") Class clazz, String message, Throwable t) {
        Log logger = LogFactory.getLog(clazz);
        logger.error(message, t);
    }

    public static void warn(Object obj, String message) {
        warn(obj.getClass(), message, null);
    }

    public static void warn(@SuppressWarnings("rawtypes") Class clazz, String message) {
        warn(clazz, message);
    }

    public static void warn(Object obj, String message, Throwable t) {
        warn(obj.getClass(), message, t);
    }

    public static void warn(@SuppressWarnings("rawtypes") Class clazz, String message, Throwable t) {
    	Log logger = LogFactory.getLog(clazz);
        logger.warn(message, t);
    }

    public static void info(Object obj, String message) {
        info(obj.getClass(), message);
    }

    public static void info(@SuppressWarnings("rawtypes") Class clazz, String message) {
    	Log logger = LogFactory.getLog(clazz);
        logger.info(message);
    }

    public static void debug(Object obj, String message) {
        debug(obj.getClass(), message);
    }

    public static void debug(@SuppressWarnings("rawtypes") Class clazz, String message) {
    	Log logger = LogFactory.getLog(clazz);
        logger.debug(message);
    }
    
    public static void main(String[] args) {
	}
}
