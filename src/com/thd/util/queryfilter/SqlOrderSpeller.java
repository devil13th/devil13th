package com.thd.util.queryfilter;
/**
 * sql单个排序语句拼写器
 */
public class SqlOrderSpeller implements SqlSpeller{
	
	/** 属性名 */
	private String property;
	/** 排序方式 */
	private String order = "desc";
	/** 拼写类型 */
	private SqlSpellerType spellType = SqlSpellerType.ORDER;
	public SqlOrderSpeller(){
		
	}
	/**
	 * 构造方法
	 * @param property 属性名(排序字段)
	 * @param order 排序方式 asc,desc
	 */
	public SqlOrderSpeller(String property,String order){
		this.property = property;
		this.order = order;
	}
	/**
	 * 拼写order by语句
	 * @return order by 语句
	 */
	public String spell(){
		return " " + property + " " + order + " " ;
	}
	
	/**
	 * 获取sql拼写器类型
	 * @return sql拼写器类型
	 */
	public SqlSpellerType getSpellType() {
		return spellType;
	}
	/**
	 * 获取属性名
	 * 例如: select * from user order userName desc 中的userName
	 * @return 属性名
	 */
	public String getProperty() {
		return property;
	}
	/**
	 * 设置属性名
	 * 例如: select * from user order userName desc 中的userName
	 * @param property 属性名
	 */
	public void setProperty(String property) {
		this.property = property;
	}
	/**
	 * 获取排序规则
	 * 例如: select * from user order userName desc 中的desc
	 * @return 排序规则(desc,asc)
	 */
	public String getOrder() {
		return order;
	}
	/**
	 * 设置排序规则
	 * 例如: select * from user order userName desc 中的desc
	 * @param order
	 */
	public void setOrder(String order) {
		this.order = order;
	}
	
	
	
	
}
