package com.thd.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateFormart {
	/**
	 * Date对象转成yyyy-MM-dd格式的字符串 
	 * @param date 日期对象
	 * @return yyyy-MM-dd格式的字符串 
	 */
	public static String toString(Date date){
		String str ="";
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		try
		{
			str = sf.format(date);
		}catch(Exception ex)
		{
			str="";
		}
		return str;
	}
	
	/**
	 * Date类型转换成所需格式的字符串
	 * @param date 日期对象
	 * @param pattern 日期格式
	 * @return 所需格式的字符串
	 */
	public static String toString(Date date,String pattern){
		String str ="";
		SimpleDateFormat sf = new SimpleDateFormat(pattern);
		try
		{
			str = sf.format(date);
		}catch(Exception ex)
		{
			str="";
		}
		return str;
	}
	
	/**
	 * 日期类型转换成Date对象
	 * @param date yyyy-MM-dd格式的日期字符串
	 * @return 日期对象
	 */
	public static Date toDate(String date){
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date dt = null;
		try {
			dt = sf.parse(date);
		} catch (ParseException e) {
			dt = null;
		}
		return dt;
	}
	/**
	 * 日期类型转换成Date对象
	 * @param date yyyy-MM-dd HH:mm:ss格式的日期字符串
	 * @return 日期对象
	 */
	public static Date toDateTime(String dateTime){
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date dt = null;
		try {
			dt = sf.parse(dateTime);
		} catch (ParseException e) {
			dt = null;
		}
		return dt;
	}
}
