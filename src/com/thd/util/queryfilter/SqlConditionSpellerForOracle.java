package com.thd.util.queryfilter;

/**
 * oracle sql单个条件语句拼写器
 */
public class SqlConditionSpellerForOracle extends SqlConditionSpeller {
	
	
	
	/**
	 * 构造方法
	 * @param property 属性名
	 * @param operator 操作符
	 * @param value 值
	 * @param valueType 值类型
	 */
	public SqlConditionSpellerForOracle(String property, SqlSpellerOperatorType operator, Object value,
			SqlSpellerDataType valueType) {
		super(property, operator, value, valueType, SqlSpellerDbType.ORACLE);
	}
	
	/**
	 * 构造方法
	 * @param queryRuleStr 查询规则字符串
	 * 例如
	 *   Q|t.user_name|S|LK  ==> t.user_name like ?
	 *   Q|t.user_bir|D|EQ  ==> t.user_bir = ?
	 * @param value 值
	 * @param dbType 数据库类型
	 */
	public SqlConditionSpellerForOracle(String queryRuleStr,Object value, SqlSpellerDbType dbType){
		super(queryRuleStr,value,SqlSpellerDbType.ORACLE);
	}
	
	/**
	 * 构造方法
	 * @param property 属性名
	 * @param operator 操作符
	 * @param value 值
	 * @param valueType 值类型
	 */
	public SqlConditionSpellerForOracle(String property, String operator, Object value,
			String valueType) {
		super(property, SqlSpellerOperatorType.getType(operator), value, SqlSpellerDataType.getType(valueType), SqlSpellerDbType.ORACLE);
	}
	
	public SqlConditionSpellerForOracle(){
		
	}
	
	/*
	 * @see com.thd.util.queryfilter.SqlConditionSpeller#spell()
	 */
	public String spell(){
		StringBuffer sb = new StringBuffer();
		sb.append(" " + this.getProperty() + " ");
		
		String finalValue = " ? ";
		if(this.getValueType().equals(SqlSpellerDataType.D)){
			finalValue = " to_date( ? , 'yyyy-MM-dd') ";
		}
		if(this.getOperator().equals(SqlSpellerOperatorType.LK)){
			sb.append(" like  " + finalValue);
		}else if(this.getOperator().equals(SqlSpellerOperatorType.EQ)){
			sb.append(" = " + finalValue);
		}else if(this.getOperator().equals(SqlSpellerOperatorType.GT)){
			sb.append(" > " + finalValue);
		}else if(this.getOperator().equals(SqlSpellerOperatorType.GTE)){
			sb.append(" >= " + finalValue);
		}else if(this.getOperator().equals(SqlSpellerOperatorType.LT)){
			sb.append(" < " + finalValue);
		}else if(this.getOperator().equals(SqlSpellerOperatorType.LTE)){
			sb.append(" <= " + finalValue);
		}else{
			throw new RuntimeException("操作类型错误!");
		}
		return sb.toString();
	}
	
	/*
	 * @see com.thd.util.queryfilter.SqlConditionSpeller#valueToString(com.thd.util.queryfilter.SqlSpellerDataType, java.lang.Object)
	 */
	public String valueToString(SqlSpellerDataType type,Object value) throws Exception{
		if(type.equals(SqlSpellerDataType.S)){
			return value.toString();
		}else if(type.equals(SqlSpellerDataType.N)){
			return value.toString();
		}else if(type.equals(SqlSpellerDataType.BD)){
			return value.toString();
		}else if(type.equals(SqlSpellerDataType.FT)){
			return value.toString();
		}else if(type.equals(SqlSpellerDataType.D)){
			return " to_date(?,'yyyy-mm-dd') ";
		}else{
			throw new RuntimeException("错误的类型!");
		}
	}

}
