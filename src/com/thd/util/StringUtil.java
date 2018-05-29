package com.thd.util;

public class StringUtil {
	/**
	 * 判断字符串是否是null或空串
	 * @param str 字符串
	 * @return 是：true  否：false
	 */
	public static boolean isEmpty(String str){
		return (str == null || str.trim().equals(""));
	}
	
	
	/**
	 * 判断字符串是否不是null或空串
	 * @param str 字符串
	 * @return 是：true  否：false
	 */
	public static boolean isNotEmpty(String str){
		return !isEmpty(str);
	}
	
	public static String getStr(String str){
		return str == null ? "" : str;
	}
	
	
}
