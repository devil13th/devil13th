package com.thd.util.queryfilter;

/**
 *	数据库 数据类型
 */
public enum SqlSpellerDataType {
	/** 数据类型:字符串*/
	S,
	/** 数据类型:日期*/
	D,
	/** 数据类型:整形 */
	N,
	/** 数据类型:浮点 */
	FT,
	/** 数据类型:BigDecimal */
	BD;
	/**
	 * 根据类型获取数据类型对象
	 * @param type 数据类型
	 * @return 数据类型对象
	 */
	public static SqlSpellerDataType getType(String type){
		if(type.toUpperCase().equals("S")){
			return SqlSpellerDataType.S;
		}else if(type.toUpperCase().equals("D")){
			return SqlSpellerDataType.D;
		}else if(type.toUpperCase().equals("N")){
			return SqlSpellerDataType.N;
		}else if(type.toUpperCase().equals("FT")){
			return SqlSpellerDataType.FT;
		}else if(type.toUpperCase().equals("BD")){
			return SqlSpellerDataType.BD;
		}else{
			throw new RuntimeException("错误的数据类型");
		}
	}
	
}
