package com.looker.core.util;

import java.io.IOException;

public class Base64Util {
	public static final String ENCODE="UTF-8";
	public static void main(String[] args) {
			sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();    
			//System.out.println(encoder.encode("zhaobintraipse@live.cn".getBytes()));	
			
	}
	
	public static String encode(String tadata){ 
		sun.misc.BASE64Encoder encoder = new sun.misc.BASE64Encoder();    
		String ing = encoder.encode(tadata.getBytes());
		return ing.replace("=", "_");  //cookie中不允许存在类似于等号的特殊字符，而加密后的密文有时候会有等号存在
	}
	
	public static String decode(String data){
		sun.misc.BASE64Decoder decoder = new sun.misc.BASE64Decoder();	
		byte[] de = null;
		try {
			de = decoder.decodeBuffer(data.replace("_", "="));
			return new String(de);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
