package com.thd.util.queryfilter;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.thd.util.StringUtil;
/**
 *	sql过滤器,负责生成sql语句
 */
public class SqlQueryFilter {
	
	/** 总条目数量(不分页的总条目数) */
	private int total= 0;
	/** 当前页 */
	private int page = 1;
	/** 每页显示条目数量 */
	private int rows = 10;
	/** 数据库类型 */
	private SqlSpellerDbType dbType;
	/** 基础sql语句 */
	private String baseSql;
	/** 分隔符 */
	public static final String SPLIT = "|";
	/** 查询条件 */
	private Map<String,SqlConditionSpeller> conditionMap = new HashMap<String,SqlConditionSpeller>();
	/** 排序字段 */
	private Map<String,SqlOrderSpeller> orderMap = new HashMap<String,SqlOrderSpeller>();
	/** request对象 */
	HttpServletRequest request;
	/** 查询参数 **/
	List<Object> params;
	
	public SqlQueryFilter(SqlSpellerDbType dbType) {
		this.dbType = dbType;
	}
	public SqlQueryFilter(HttpServletRequest request,SqlSpellerDbType dbType) {
		this.dbType = dbType;
		
		this.request=request;
		Enumeration paramEnu= request.getParameterNames();
		//条件
		while(paramEnu.hasMoreElements()){
			String paramName = (String)paramEnu.nextElement();
			if(paramName.startsWith("Q|")){
    			String paramValue = request.getParameter(paramName);
    			
    			
    			
    			if(StringUtil.isNotEmpty(paramValue)){
    				
    				// Q|user_name|S|LK  =>  user_name like '%...%';
    				// Q|create_date|D|LT  =>  create_date < 'todate('...','yyyy-mm-dd')';
    				
	    			String[] vs = paramName.split("[" + SqlQueryFilter.SPLIT + "]");
	    			SqlConditionSpeller speller = null;
	    			if(dbType.equals(SqlSpellerDbType.SQLSERVER)){
	    				speller = new SqlConditionSpellerForSqlServer(vs[1],vs[3],paramValue,vs[2]);
	    			}else if(dbType.equals(SqlSpellerDbType.ORACLE)){
	    				speller = new SqlConditionSpellerForOracle(vs[1],vs[3],paramValue,vs[2]);
	    			}else if(dbType.equals(SqlSpellerDbType.MYSQL)){
	    				speller = new SqlConditionSpellerForSqlServer(vs[1],vs[3],paramValue,vs[2]);
	    			}
	    			conditionMap.put(vs[1],speller);
    			}
    		}
		}
		String sort = request.getParameter("sort");
		if(StringUtil.isNotEmpty(sort)){
			String order = request.getParameter("order");
			orderMap.put(order,new SqlOrderSpeller(sort,order));
		}
		
		String pageStr = request.getParameter("page") != null ? request.getParameter("page") : "0";
		String rowsStr = request.getParameter("rows") != null ? request.getParameter("rows") : "0";
		page = Integer.parseInt(pageStr);
		rows = Integer.parseInt(rowsStr);
	}
	
	
	/**
	 * 拼where条件语句
	 * @return where 条件语句
	 */
	public String toCondition(){
		StringBuffer str = new StringBuffer("");
		Iterator<String> iter = conditionMap.keySet().iterator();
		while(iter.hasNext()){
			try{
				SqlConditionSpeller speller = conditionMap.get(iter.next());
				str.append(" and ");
				str.append(speller.spell());
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return str.toString();
	}
	
	/**
	 * 拼order by 语句
	 * @return order by 语句
	 */
	public String toOrderBy(){
		StringBuffer str = new StringBuffer("");
		Iterator<String> iter = orderMap.keySet().iterator();
		while(iter.hasNext()){
			try{
				SqlOrderSpeller speller = orderMap.get(iter.next());
				str.append(speller.spell());
				str.append(",");
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		if(StringUtil.isNotEmpty(str.toString())){
			return str.toString().substring(0,str.toString().length() - 1);
		}else{
			return str.toString();
		}
	}
	
	/**
	 * 拼完整的sql语句
	 * @return sql语句
	 */
	public String toSql(){
		StringBuffer str = new StringBuffer(this.baseSql);
		Iterator<String> orderIter = orderMap.keySet().iterator();
		Iterator<String> conditionIter = conditionMap.keySet().iterator();
		String condition = this.toCondition();
		String order = this.toOrderBy();
		if(!condition.trim().equals("")){
			str.append(condition);
		}
		if(!order.trim().equals("")){
			str.append(" order by " + order);
		}
		//System.out.println("===========" + str.toString());
		return str.toString();
	}
	
	public List<Object> getParams(){
		Iterator<String> iter = conditionMap.keySet().iterator();
		List<Object> params_tmp = new ArrayList<Object>();
		while(iter.hasNext()){
			SqlConditionSpeller conditionSpeller = conditionMap.get(iter.next());
			params_tmp.add(conditionSpeller.getValue());
		}
		return params_tmp;
	}
	
	
	
	/**
	 * 添加条件拼写项
	 * @param spell
	 * @throws Exception
	 */
	public void addCondition(SqlConditionSpeller spell) throws Exception{
		this.getConditionMap().put(spell.getProperty(), spell);
	}
	/**
	 * 填写排序拼写项
	 * @param spell
	 * @throws Exception
	 */
	public void addOrder(SqlOrderSpeller spell) throws Exception{
		this.getOrderMap().put(spell.getProperty(), spell);
	}
	/**
	 * 获取基础sql语句  
	 * 例如：select * from user where 1=1 and userName like '%a%' 中 and之前的sql语句
	 * @return 基础sql语句  
	 */
	public String getBaseSql() {
		return baseSql;
	}
	/**
	 * 设置基础sql语句
	 * 例如：select * from user where 1=1 and userName like '%a%' 中 and之前的sql语句
	 * @param baseSql 基础sql语句
	 */
	public void setBaseSql(String baseSql) {
		this.baseSql = baseSql;
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
	 * 获取sql条件拼写器集合
	 * 一般用于手动设置sql条件的情况
	 * @return sql条件拼写器集合
	 */
	public Map<String, SqlConditionSpeller> getConditionMap() {
		return conditionMap;
	}
	/**
	 * 设置sql条件拼写器集合
	 * @param conditionMap
	 */
	public void setConditionMap(Map<String, SqlConditionSpeller> conditionMap) {
		this.conditionMap = conditionMap;
	}
	/**
	 * 获取sql排序拼写器集合
	 * 一般用于手动设置sql排序的情况
	 * @return sql排序拼写器集合
	 */
	public Map<String, SqlOrderSpeller> getOrderMap() {
		return orderMap;
	}
	/**
	 * 设置sql排序拼写器集合
	 * @param orderMap
	 */
	public void setOrderMap(Map<String, SqlOrderSpeller> orderMap) {
		this.orderMap = orderMap;
	}
	/**
	 * 获取HttpServletRequest对象
	 * @return HttpServletRequest对象
	 */
	public HttpServletRequest getRequest() {
		return request;
	}
	/**
	 * 设置HttpServletRequest对象
	 * @param request HttpServletRequest对象
	 */
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	/**
	 * 获取sql语句查询结果的集合数量
	 * @return sql语句查询结果的集合数量
	 */
	public int getTotal() {
		return total;
	}
	/**
	 * 设置sql语句查询结果的集合数量
	 */
	public void setTotal(int total) {
		this.total = total;
	}
	/**
	 * 获取当前页页码
	 * @return 当前页页码
	 */
	public int getPage() {
		return page;
	}
	/**
	 * 设置当前页页码
	 * @param page 当前页页码
	 */
	public void setPage(int page) {
		this.page = page;
	}
	/**
	 * 获取每页显示条目数量
	 * @return 每页显示条目数量
	 */
	public int getRows() {
		return rows;
	}
	/**
	 * 设置每页显示条目数量
	 * @param rows
	 */
	public void setRows(int rows) {
		this.rows = rows;
	}
	
	
	public static void main(String[] args) throws Exception{
		SqlQueryFilter sqf = new SqlQueryFilter(SqlSpellerDbType.ORACLE);
		sqf.setBaseSql("select t.username,t.userid,t.age,t.bir,g.name,g.type from user_info t left join group g on t.gid = g.gid where 1=1 ");
		SqlConditionSpellerForOracle condition1 = new SqlConditionSpellerForOracle("Q|t.username|S|LK","张三",SqlSpellerDbType.ORACLE);
		sqf.addCondition(condition1);
		
		SqlConditionSpellerForOracle condition2 = new SqlConditionSpellerForOracle("Q|t.age|N|LT",5,SqlSpellerDbType.ORACLE);
		sqf.addCondition(condition2);
		
		SqlConditionSpellerForOracle condition3 = new SqlConditionSpellerForOracle("Q|t.bir|D|EQ","2014-01-01",SqlSpellerDbType.ORACLE);
		sqf.addCondition(condition3);
		
		SqlConditionSpellerForOracle condition4 = new SqlConditionSpellerForOracle("Q|g.name|S|EQ","2013界",SqlSpellerDbType.ORACLE);
		sqf.addCondition(condition4);
		
		SqlOrderSpeller sop = new SqlOrderSpeller("t.username","desc");
		
		sqf.addOrder(sop);
		
		System.out.println(sqf.toSql());
		System.out.println(sqf.getParams());
	}
}
