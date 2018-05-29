package com.thd.core.service;

import java.io.Serializable;
import java.util.List;

import org.apache.log4j.Logger;

import com.thd.core.dao.PubDaoImpl;
import com.thd.util.Page;
import com.thd.util.queryfilter.SqlQueryFilter;

public interface PubService {
	/**
	 * 获取日志对象
	 * @return 日志对象
	 */
	public Logger getLog();
	/**
	 * 保存对象
	 * @param obj POJO类
	 */
	public void save(Object obj);
	/**
	 * 更新对象
	 * @param obj POJO类
	 */
	public void update(Object obj);
	
	/**
	 * 保存/更新对象  id不为null且不为空字符串时是修改 反之新增
	 * @param obj
	 */
	public void saveOrUpdate(Object obj);
	/**
	 * 删除对象
	 * @param obj POJO类
	 */
	public void delete(Object obj);
	
	/**
	 * 根据主键删除对象
	 * @param c 实体类的类型
	 * @param id 主键
	 */
	public void deleteById(Class c,Serializable id);
	/**
	 * 查询
	 * @param sql sql语句
	 * @return 
	 */
	public List query(String sql);
	/**
	 * 查询
	 * @param filter sql过滤器
	 * @return
	 */
	public List query(SqlQueryFilter filter);
	/**
	 * 根据id和class加载POJO对象
	 * @param c 类
	 * @param id 主键
	 * @return
	 */
	public Object findById(Class c,Serializable id);
	
	/**
	 * 根据sql分页,分页信息查询
	 * @param sql sql语句
	 * @param page 分页信息
	 * @return
	 */
	public List query(String sql,Page page);
	/**
	 * 根据sql(带有"?"的sql),分页信息查询
	 * @param sql sql语句
	 * @param params 参数 对应sql中的"?"
	 * @param page 分页信息
	 * @return
	 */
	public List query(String sql,Object[] params,Page page);
	
	/**
	 * 根据hql查询
	 * @param hql hql语句
	 * @return List
	 */
	public List queryByHql(String hql);
	
	/**
	 * 获取公共dao
	 * @return
	 */
	public PubDaoImpl getPubDaoImpl();
	
	
}
