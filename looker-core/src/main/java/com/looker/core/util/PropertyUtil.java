package com.looker.core.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;


/**
 * 从属性文件中获取属性值的工具
 * 
 * @author 郑阳军
 * 
 */
public class PropertyUtil {
	
	private static final Logger logger = Logger.getLogger(PropertyUtil.class);
	
	private static final ResourceBundle area;
	
	private static final ResourceBundle spider;
	
	static {
		area = ResourceBundle.getBundle("areaCode");
		spider = ResourceBundle.getBundle("spider");
	}
	
	public static ResourceBundle getBundle(String filePath){
		InputStream in = null;
		try {
			in = new BufferedInputStream(new FileInputStream(filePath));
			return new PropertyResourceBundle(in);
		} catch (Exception e) {
			logger.error("读取应用配置文件失败："+e.getMessage());
			return null;
		}finally{
			try {
				if (null != in)
					in.close();
			} catch (IOException e) {
				logger.error("读取应用配置文件失败："+e.getMessage());
				return null;
			}
		}
	}

	/**
	 * 获取属性值
	 * 
	 * @param key
	 * @return value
	 */
	public static String getProperty(String key) {
		String value = null;
		try {
			value = area.getString(key);
		} catch (Exception e) {
			value = "";
		}
		return value;
	}
	
	/**
	 * 获取spider属性值
	 * 
	 * @param key
	 * @return value
	 */
	public static String getSpiderProperty(String key) {
		String value = null;
		try {
			value = spider.getString(key);
		} catch (Exception e) {
			value = "";
		}
		return value;
	}
	
	public static void main(String[] args) {
		System.out.println(PropertyUtil.getProperty("1000"));
		System.out.println(PropertyUtil.getSpiderProperty("spider.url"));
	}
}
