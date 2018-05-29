package com.thd.util.queryfilter;
/**
 * sql拼写器类型
 */
public enum SqlSpellerType {
	
	/** 拼写条件 */
	CONDITION,//拼写条件
	/** 拼写排序 */
	ORDER;//拼写排序
	
	/**
	 * 获取sql拼写器类型
	 * @param type 类型
	 * @return 拼写器类型
	 */
	public static SqlSpellerType getType(String type){
		if(type.toUpperCase().equals("CONDITION")){
			return SqlSpellerType.CONDITION;
		}else if(type.toUpperCase().equals("ORDER")){
			return SqlSpellerType.ORDER;
		}else{
			throw new RuntimeException("错误的拼写器类型");
		}
	}
}
