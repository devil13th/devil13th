package com.thd.util.queryfilter;
/**
 * sql单个拼写器接口
 */
public interface SqlSpeller {
	/**
	 * 拼sql语句
	 * @return 完整的sql语句
	 * @throws Exception 
	 */
	public String spell()  throws Exception;
	/**
	 * 获取sql拼写器类型
	 * @return sql拼写器类型
	 */
	public SqlSpellerType getSpellType();
	/**
	 * 获取属性名称
	 * @return 属性名称
	 */
	public String getProperty();
}
