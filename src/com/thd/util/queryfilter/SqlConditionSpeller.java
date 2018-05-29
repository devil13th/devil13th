package com.thd.util.queryfilter;

/**
 * sql单个条件拼写器
 */
public abstract class SqlConditionSpeller implements SqlSpeller{
	/** 属性名 */
	private String property;
	/** 操作符 */
	private SqlSpellerOperatorType operator;
	/** 值 */
	private Object value;
	/** 值类型 */
	private SqlSpellerDataType valueType;
	/** 数据库类型 */
	private SqlSpellerDbType dbType;
	/** 拼写类型 */
	private SqlSpellerType spellType = SqlSpellerType.CONDITION;
	
	
	

	public SqlConditionSpeller(){}
	
	/**
	 * 查询规则字符串
	 *
	 * @param queryRuleStr 查询规则字符串
	 * 例如
	 *   Q|t.user_name|S|LK  ==> t.user_name like ?
	 *   Q|t.user_bir|D|EQ  ==> t.user_bir = ?
	 * @param value 值
	 */
	public SqlConditionSpeller(String queryRuleStr,Object value, SqlSpellerDbType dbType){
		String[] vs = queryRuleStr.split("[" + SqlQueryFilter.SPLIT + "]");
		this.property = vs[1];
		this.operator = SqlSpellerOperatorType.getType(vs[3]);
		this.value = value;
		this.valueType = SqlSpellerDataType.getType(vs[2]);
		this.dbType = dbType;
	}
		
	
	/**
	 * 构造方法
	 * @param property 属性名
	 * @param operator 操作符
	 * @param value 值
	 * @param valueType 值类型
	 * @param dbType 数据库类型
	 */
	public SqlConditionSpeller(String property, SqlSpellerOperatorType operator, Object value,SqlSpellerDataType valueType, SqlSpellerDbType dbType) {
		this.property = property;
		this.operator = operator;
		this.value = value;
		this.valueType = valueType;
		this.dbType = dbType;
	}
	
	/**
	 * 拼写sql条件语句 
	 */
	abstract public String spell() ;		
	/**
	 * 把值转换成sql语句
	 * @param type 值类型
	 * @param value 值
	 * @return 
	 * @throws Exception
	 */
	abstract public String valueToString(SqlSpellerDataType type,Object value) throws Exception;
	
	/**
	 * 获取属性名 
	 * 例:select * from user where userName like '%a%' 中的userName
	 */
	public String getProperty() {
		return property;
	}
	
	/**
	 * 设置属性名 
	 * 例:select * from user where userName like '%a%' 中的userName
	 * @param property 属性名
	 */
	public void setProperty(String property) {
		this.property = property;
	}
	
	/**
	 * 获取操作符类型  
	 * 例:select * from user where userName like '%a%' 中的like
	 * @return 操作符类型
	 */
	public SqlSpellerOperatorType getOperator() {
		return operator;
	}
	/**
	 * 设置操作符类型
	 * 例:select * from user where userName like '%a%' 中的like
	 * @param operator 操作符类型
	 */
	public void setOperator(SqlSpellerOperatorType operator) {
		this.operator = operator;
	}
	/**
	 * 获取值
	 * 例:select * from user where userName like '%a%' 中的a
	 * @return 值
	 */
	public Object getValue() {
		return value;
	}
	/**
	 * 设置值
	 * 例:select * from user where userName like '%a%' 中的a
	 * @param value
	 */
	public void setValue(Object value) {
		this.value = value;
	}
	/**
	 * 获取值的类型
	 * 例:select * from user where userName like '%a%' 中a的数据类型
	 * @return 值的类型
	 */
	public SqlSpellerDataType getValueType() {
		return valueType;
	}
	/**
	 * 设置值的类型
	 * 例:select * from user where userName like '%a%' 中a的数据类型
	 * @param valueType 值的类型
	 */
	public void setValueType(SqlSpellerDataType valueType) {
		this.valueType = valueType;
	}
	/**
	 * 获取数据库类型
	 * @return 数据库类型
	 */
	public SqlSpellerDbType getDbType() {
		return dbType;
	}
	/**
	 * 设置数据库类型
	 * @param dbType 数据库类型
	 */
	public void setDbType(SqlSpellerDbType dbType) {
		this.dbType = dbType;
	}
	/**
	 * 获取拼写器类型
	 * @return 拼写器类型
	 */
	public SqlSpellerType getSpellType() {
		return spellType;
	}
	
	
		
		
	
	
	

}
