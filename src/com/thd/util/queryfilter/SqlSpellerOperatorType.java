package com.thd.util.queryfilter;
/**
 * 数据库 操作符类型
 */
public enum SqlSpellerOperatorType {
	/** 操作符:like '%...%' */
	LK,
	/** 操作符:= */
	EQ,
	/** 操作符:> */
	GT,
	/** 操作符:>= */
	GTE,
	/** 操作符:< */
	LT,
	/** 操作符:<= */
	LTE;
	
	/**
	 * 根据类型获取sql操作符类型对象
	 * @param type sql操作符字符串类型
	 * @return sql操作符类型对象
	 */
	public static SqlSpellerOperatorType getType(String type){
		if(type.toUpperCase().equals("LK")){
			return SqlSpellerOperatorType.LK;
		}else if(type.toUpperCase().equals("EQ")){
			return SqlSpellerOperatorType.EQ;
		}else if(type.toUpperCase().equals("GT")){
			return SqlSpellerOperatorType.GT;
		}else if(type.toUpperCase().equals("GTE")){
			return SqlSpellerOperatorType.GTE;
		}else if(type.toUpperCase().equals("LT")){
			return SqlSpellerOperatorType.LT;
		}else if(type.toUpperCase().equals("LTE")){
			return SqlSpellerOperatorType.LTE;
		}else{
			throw new RuntimeException("错误的数据类型");
		}
	}
	
	
}
