package com.looker.core.util;

import java.util.Random;

import org.apache.commons.lang.StringUtils;

/**
 * 
 * @ClassName: GenerateRandomNumber
 * @Description: 随机生成数字和字母组合
 * @author zhengyangjun
 * @date 2016年6月12日 上午10:44:33
 */
public class GenerateRandomNumber {

	/**
	 * @Title: getStringRandom 
	 * @Description: 生成随机数字和字母 
	 * @param length 长度
	 * @param type 类型
	 * @return String    
	 * @throws
	 */
	public static String getStringRandom(String type,int length) {
		String val = "";
		Random random = new Random();
		// 参数length，表示生成几位随机数
		for (int i = 0; i < length; i++) {
			String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num";
			// 输出字母还是数字
			if ("char".equalsIgnoreCase(charOrNum)) {
				// 输出是大写字母还是小写字母
				int temp = random.nextInt(2) % 2 == 0 ? 65 : 97;
				val += (char) (random.nextInt(26) + temp);
			} else if ("num".equalsIgnoreCase(charOrNum)) {
				val += String.valueOf(random.nextInt(10));
			}
		}
		if(StringUtils.isNotEmpty(type)){
			val = type + val;
		}
		return val.toUpperCase();
	}

	public static void main(String[] args) {
		System.out.println(GenerateRandomNumber.getStringRandom(null,20));
		System.out.println(GenerateRandomNumber.getStringRandom("sq",8));
	}

}
