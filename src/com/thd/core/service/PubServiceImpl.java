package com.thd.core.service;

import java.io.Serializable;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.thd.core.dao.PubDaoImpl;
import com.thd.util.ListUtil;
import com.thd.util.Page;
import com.thd.util.queryfilter.SqlQueryFilter;

@Service("pubServiceImpl")
public class PubServiceImpl implements PubService{
	@Resource
	private PubDaoImpl pubDaoImpl;
	
	public PubDaoImpl getPubDaoImpl() {
		return pubDaoImpl;
	}

	public void setPubDaoImpl(PubDaoImpl pubDaoImpl) {
		this.pubDaoImpl = pubDaoImpl;
	}


	//日志
	private Logger log = Logger.getLogger(this.getClass());
	
	/*
	 * @see com.thd.service.PubService#getLog()
	 */
	public Logger getLog() {
		return log;
	}
	
	/*
	 * @see com.ccse.core.service.PubService#delete(java.lang.Object)
	 */
	public void delete(Object obj) {
		this.pubDaoImpl.delete(obj);
	}
	
	/*
	 * @see com.thd.service.PubService#deleteById(java.lang.Class, java.io.Serializable)
	 */
	public void deleteById(Class c,Serializable id){
		this.pubDaoImpl.delete(c, id);
	};
	
	/*
	 * @see com.ccse.core.service.PubService#save(java.lang.Object)
	 */
	public void save(Object obj) {
		this.pubDaoImpl.save(obj);
		
	}
	/*
	 * @see com.ccse.core.service.PubService#update(java.lang.Object)
	 */
	public void update(Object obj) {
		this.pubDaoImpl.update(obj);
		
	}
	
	
	public void saveOrUpdate(Object obj){
		this.pubDaoImpl.saveOrUpdate(obj);
	};
	
	/*
	 * @see com.ccse.core.service.PubService#query(java.lang.String)
	 */
	public List query(String sql){
		return this.pubDaoImpl.findBySql(sql);
	};
	
	/*
	 * @see com.ccse.core.service.PubService#query(java.lang.String, com.ccse.core.web.paging.Page)
	 */
	public List query(String sql,Page page){
		/*List l = this.pubDaoImpl.findBySql(sql);
		if(ListUtil.isNotEmpty(l)){
			page.setListSize(l.size());
			int m = l.size() % page.getPageSize();
			if( m == 0){
				page.setMaxPage(l.size() / page.getPageSize());
			}else{
				page.setMaxPage(l.size() / page.getPageSize() + 1);
			}
		}else{
			page.setListSize(0);
		}
		return this.pubDaoImpl.findBySql(sql, page.getCurrentPage(), page.getPageSize());
		*/
		
		String countSql = "select count(*) from ( " + sql + ")  countTab";
		this.getLog().info(countSql);
		List countSqlList = this.pubDaoImpl.findBySql(countSql);
		int listCt = 0;
		try{
			listCt = Integer.parseInt(countSqlList.get(0).toString());
		}catch(Exception e){
			e.printStackTrace();
		}
		
		if(listCt>0){
			//int listCt = l.size();
			page.setListSize(listCt);
			int m = listCt % page.getPageSize();
			if( m == 0){
				page.setMaxPage(listCt / page.getPageSize());
			}else{
				page.setMaxPage(listCt / page.getPageSize() + 1);
			}
		}else{
			page.setListSize(0);
		}
		return this.pubDaoImpl.findBySql(sql, page.getCurrentPage(), page.getPageSize());
	};
	/*
	 * @see com.ccse.core.service.PubService#query(java.lang.String, java.lang.Object[], com.ccse.core.web.paging.Page)
	 */
	public List query(String sql,Object[] params,Page page){
		/*
		List l = this.pubDaoImpl.findBySql(sql, params);
		if(ListUtil.isNotEmpty(l)){
			page.setListSize(l.size());
			int m = l.size() % page.getPageSize();
			if( m == 0){
				page.setMaxPage(l.size() / page.getPageSize());
			}else{
				page.setMaxPage(l.size() / page.getPageSize() + 1);
			}
		}else{
			page.setListSize(0);
		}
		return this.pubDaoImpl.findBySql(sql, params, page.getCurrentPage(), page.getPageSize());
		*/
		String countSql = "select count(*) from ( " + sql + ")  countTab";
		this.getLog().info(countSql);
		List countSqlList = this.pubDaoImpl.findBySql(countSql);
		int listCt = 0;
		try{
			listCt = Integer.parseInt(countSqlList.get(0).toString());
		}catch(Exception e){
			e.printStackTrace();
		}
		if(listCt>0){
			page.setListSize(listCt);
			int m = listCt % page.getPageSize();
			if( m == 0){
				page.setMaxPage(listCt/ page.getPageSize());
			}else{
				page.setMaxPage(listCt / page.getPageSize() + 1);
			}
		}else{
			page.setListSize(0);
		}
		return this.pubDaoImpl.findBySql(sql, params, page.getCurrentPage(), page.getPageSize());
	};
	
	/*
	 * @see com.ccse.core.service.PubService#query(com.ccse.core.command.sql.SqlQueryFilter)
	 */
	public List query(SqlQueryFilter filter){
		String sql = filter.toSql();
		List l = this.pubDaoImpl.findBySql(sql);
		if(ListUtil.isNotEmpty(l)){
			filter.setTotal(l.size());
		}
		return this.pubDaoImpl.findBySql(sql, filter.getPage(),filter.getRows());
	};
	
	
	public List queryByHql(String hql){
		return this.pubDaoImpl.findByHql(hql);
	};
	
	
	public Object findById(Class c,Serializable id){
		return this.pubDaoImpl.findById(c, id);
	};
	
	
	

}
