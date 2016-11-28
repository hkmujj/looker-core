package com.looker.core.util;

/**
 * Base64
 * @author zhengyangjun
 *
 */
@SuppressWarnings("restriction")
public class Base64 {

	public static String encode(byte[] bytes) {
		try {
			return (new sun.misc.BASE64Encoder()).encode(bytes);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static byte[] encodes(byte[] bytes) {
		try {
			return (new sun.misc.BASE64Encoder()).encode(bytes).getBytes("UTF-8");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static byte[] decode(String key) {
		try {
			return (new sun.misc.BASE64Decoder()).decodeBuffer(key);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public static byte[] decodes(byte[] key) {
		try {
			return (new sun.misc.BASE64Decoder()).decodeBuffer(new String(key, "UTF-8"));
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
