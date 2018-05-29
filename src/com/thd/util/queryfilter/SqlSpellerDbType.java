package com.thd.util.queryfilter;
/**
 *	数据库类型
 */
public enum SqlSpellerDbType {
	/** oracle */
	ORACLE,
	/** mysql */
	MYSQL,
	/** sql server */
	SQLSERVER;
	/**
	 * 根据类型获取数据库类型对象
	 * @param type 数据库类型
	 * @return 数据库类型对象
	 */
	public static SqlSpellerDbType getType(String type){
		if(type.toUpperCase().equals("ORACLE")){
			return SqlSpellerDbType.ORACLE;
		}else if(type.toUpperCase().equals("MYSQL")){
			return SqlSpellerDbType.MYSQL;
		}else if(type.toUpperCase().equals("SQLSERVER")){
			return SqlSpellerDbType.SQLSERVER;
		}else{
			throw new RuntimeException("错误的数据库类型");
		}
	}
}
