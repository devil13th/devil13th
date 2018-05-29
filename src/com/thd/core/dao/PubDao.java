package com.thd.core.dao;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;

import com.thd.util.Page;

public interface PubDao {
	/**
	 * @description 保存对象
	 * @param obj 保存的对象
	 */
	public void save(Object obj) ;
	
	/**
	 * @description 更新对象
	 * @param obj 更新的对象
	 */
	public void update(Object obj);
	
	/**
	 * @description 提交缓存
	 */
	public void flush() ;
	
	/**
	 * @description 根据参数对象更新数据库对象
	 * @param original 根据此对象不为空的属性更新数据库中的对象
	 * @param id 需要更新对象的id
	 * @param nullProperties 需要设置为空的属性
	 * @throws Exception
	 */
	public void update(Object original,Serializable id,Object[] nullProperties) throws Exception;
	
	/**
	 * 根据参数对象更新数据库对象
	 * @description 将original实例中的属性拷贝到dest实例中，不在nullableProps数组中的属性，如果为空不拷贝
	 * @param original	根据此对象的属性更新数据库中的对象
	 * @param id	需要更新对象的id
	 * @param nullableProps	前台页面可能传来null的属性
	 * @throws Exception
	 */
	public void updateEntity(Object original, Serializable id, Object[] nullableProps) throws Exception;
	
	/**
	 * @description 删除对象
	 * @param obj 删除的对象 对象要有主键
	 */
	public void delete(Object obj);
	
	/**
	 * @description 根据id删除对象
	 * @param c 删除的对象类型
	 * @param id 删除的对象的主键
	 */
	public void delete(Class c,Serializable id);
	
	/**
	 * @description 保存或更新对象
	 * @param obj 保存或更新的对象 有主键则是更新 没有主键则是保存
	 */
	public void saveOrUpdate(Object obj);
	
	/**
	 * @description 根据id查找对象
	 * @param c 对象的类
	 * @param id 对象的id
	 * @return 
	 */
	public Object findById(Class c,Serializable id);
	
	
	/**
	 * @description hql基础查询
	 * @param hql hql查询语句
	 * @param params 条件的值,对应hql中的"?"
	 * @param currPage 当前页
	 * @param pageSIze 每页显示条目数量
	 * @return 
	 */
	public List<Object> findByHql(final String hql,final Object[] params,final int currPage,final int pageSize);
	
	
	/**
	 * @description 无参数的hql全部记录查询
	 * @param hql hql语句
	 * @return 
	 */
	public List findByHql(String hql);
	
	/**
	 * @description 带有参数的hql全部记录查询
	 * @param hql hql语句
	 * @param params  条件的值,对应hql中的"?"
	 * @return
	 */
	public List<Object> findByHql(final String hql,final Object[] params);
	
	/**
	 * @description 不带参数的hql分页查询
	 * @param hql hql语句
	 * @param currPage 当前页
	 * @param pageSize 每页显示条目数量
	 * @return 
	 */
	public List<Object> findByHql(String hql,int currPage,int pageSize);
	
	
	/**
	 * @description sql基础查询
	 * @param sql sql语句
	 * @param params 条件的值,对应sql语句中的"?"
	 * @param currPage 当前页
	 * @param pageSize 每页显示条目数量
	 * @return List<Object[]>
	 */
	public List<Object> findBySql( final String sql,final Object[] params,final int currPage, final int pageSize);
	
	/**
	 * @description 不带参数的sql全部记录查询
	 * @param sql sql语句
	 * @return List<Object[]>
	 */
	public List<Object> findBySql(final String sql);
	
	
	/**
	 * @description 带参数的sql全部记录查询
	 * @param sql
	 * @param params
	 * @return List<Object[]>
	 */
	public List<Object> findBySql(final String sql,final Object[] params);
	
	/**
	 * 不带参数的sql分页查询
	 * @param sql sql语句
	 * @param currPage 当前页
	 * @param pageSize 每页显示条目数量
	 * @return  List<Object[]>
	 */
	public List<Object> findBySql(final String sql,int currPage,int pageSize);
	
	
	
	
	/**
	 * @description sql基础查询 
	 * @param sql sql语句
	 * @param params 条件的值,对应sql语句中的"?"
	 * @param currPage 当前页
	 * @param pageSize 每页显示条目数量
	 * @return List<Map>
	 */
	public List<Map> findBySqlToMap( final String sql,final Object[] params,final int currPage, final int pageSize);
	/**
	 * @description sql基础查询 
	 * @param sql sql语句
	 * @param params 条件的值,对应sql语句中的"?"
	 * @param page  分页信息
	 * @return List<Map>
	 */
	public List<Map> findBySqlToMap( final String sql,final Object[] params,Page page);
	
	
	/**
	 * @description 不带参数的sql全部记录查询
	 * @param sql sql语句
	 * @return List<Map>
	 */
	public List<Map> findBySqlToMap(final String sql);
	
	/**
	 * @description 带参数的sql全部记录查询
	 * @param sql
	 * @param params
	 * @return List<Map>
	 */
	public List<Map> findBySqlToMap(final String sql,final Object[] params);
	
	
	/**
	 * 不带参数的sql分页查询
	 * @param sql sql语句
	 * @param currPage 当前页
	 * @param pageSize 每页显示条目数量
	 * @return List<Map>
	 */
	public List<Map> findBySqlToMap(final String sql,int currPage,int pageSize);
	
	
	
	
	
	/**
	 * @description 执行sql语句
	 * @param sql
	 */
	public void executeSql(final String sql);
	
	
	/**
	 * @description 执行带"?"的sql语句
	 * @param sql sql语句
	 * @param params 条件的值,对应sql语句中的"?"
	 */
	public void executeSql(final String sql,final Object[] params);
	
	public Object getOne(List<Object> l );
	
	/**
	 * 查询sql 
	 * @param sql sql语句
	 * @param obj sql参数
	 * @param page 分页对象
	 * @return
	 */
	public List pageSQL(String sql,Object[] obj,Page page);
	
	/**
	 * 查询hql
	 * @param hql hql语句
	 * @param obj hql参数
	 * @param page 分页对象
	 * @return
	 */
	public List pageHQL(String hql,Object[] obj,Page page);
	/**
	 * 获取hibernate的Session对象
	 * @return
	 */
	public Session getMySession();
	
	
	/**
	 * 根据属性数组和排序条件获取单个对象实体
	 * @param c 对象类
	 * @param propName 属性数组名称
	 * @param propValue 属性数组值
	 * @param sortedCondition 排序条件
	 * @return 返回对象实体
	 */
	public Object getByProerties(Class c,String[] propName, Object[] propValue,Map<String, String> sortedCondition);
	/**
	 * 根据属性和排序条件获取单个对象实体
	 * @param c 对象类
	 * @param propName 属性名称
	 * @param propValue 属性值
	 * @param sortedCondition 排序条件
	 * @return 返回对象实体
	 */
	public Object getByProerties(Class c,String propName, Object propValue, Map<String, String> sortedCondition);
	/**
	 * 根据属性数组获取单个对象实体
	 * @param c 对象类 
	 * @param propName 属性数组名称
	 * @param propValue 属性数组值
	 * @return 返回对象实体
	 */
	public Object getByProerties(Class c,String[] propName, Object[] propValue);
	/**
	 * 根据属性获取单个对象实体
	 * @param c  对象类
	 * @param propName 属性名称
	 * @param propValue 属性值
	 * @return 返回对象实体
	 */
	public Object getByProerties(Class c,String propName, Object propValue) ;
	
	/**
	 * 根据属性、排序条件和要返回的记录数目获取对象实体列表
	 * @param c  对象类
	 * @param propName 属性数组名称
	 * @param propValue 属性数组值
	 * @param sortedCondition 排序条件
	 * @param top 要返回的记录数目
	 * @return 返回对象实体列表
	 */
	public List<Object> queryByProerties(Class c,String[] propName, Object[] propValue, Map<String, String> sortedCondition, Integer top);
	
	
	/**
	 * 根据属性和排序条件获取对象实体列表
	 * @param c 对象类 
	 * @param propName 属性数组名称
	 * @param propValue 属性数组值
	 * @param sortedCondition 排序条件
	 * @return 返回对象实体列表
	 */
	public List<Object> queryByProerties(Class c,String[] propName, Object[] propValue, Map<String, String> sortedCondition);

	/**
	 * 根据属性和要返回的记录数目获取对象实体列表
	 * @param c 对象类 
	 * @param propName 属性数组名称
	 * @param propValue 属性数组值
	 * @param top 要返回的记录数目
	 * @return 返回对象实体列表
	 */
	public List<Object> queryByProerties(Class c,String[] propName, Object[] propValue, Integer top);

	/**
	 * 根据属性获取对象实体列表
	 * @param c 对象类 
	 * @param propName 属性数组名称
	 * @param propValue 属性数组值
	 * @return
	 */
	public List<Object> queryByProerties(Class c,String[] propName, Object[] propValue);

	/**
	 * 根据属性、排序条件和要返回的记录数目获取对象实体列表
	 * @param c 对象类 
	 * @param propName 属性名称
	 * @param propValue 属性值
	 * @param sortedCondition 排序条件
	 * @param top 要返回的记录数目
	 * @return 返回对象实体列表
	 */
	public List<Object> queryByProerties(Class c,String propName, Object propValue, Map<String, String> sortedCondition, Integer top);

	/**
	 * 根据属性和排序条件获取对象实体列表
	 * @param c 对象类 
	 * @param propName 属性名称
	 * @param propValue 属性值
	 * @param sortedCondition 排序条件
	 * @return 返回对象实体列表
	 */
	public List<Object> queryByProerties(Class c,String propName, Object propValue, Map<String, String> sortedCondition);

	/**
	 * 根据属性和要返回的记录数目获取对象实体列表
	 * @param c 对象类 
	 * @param propName 属性名称
	 * @param propValue 属性值
	 * @param top 要返回的记录数目
	 * @return 返回对象实体列表
	 */
	public List<Object> queryByProerties(Class c,String propName, Object propValue, Integer top);

	/**
	 * 根据属性获取对象实体列表
	 * @param c 对象类 
	 * @param propName 属性名称
	 * @param propValue 属性值
	 * @return 返回对象实体列表
	 */
	public List<Object> queryByProerties(Class c,String propName, Object propValue);
}
