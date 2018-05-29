package com.thd.util;

import java.util.List;

public class ListUtil {
	/**
	 * 获取List中的第一个元素
	 * @param l List对象
	 * @return List中的第一个元素
	 */
	public static Object getOne(List<Object> l ){
		if( (l!=null) && !l.isEmpty()){
			if(l.get(0)!=null){
				return l.get(0);
			}else{
				return null;
			}			
		}else{
			return null;
		}
	}
	
	/**
	 * 判断List是否不空的
	 * @param l List对象
	 * @return 是：true 否：false
	 */
	public static boolean isNotEmpty(List l){
		return (l!=null && !l.isEmpty());
	}
}
