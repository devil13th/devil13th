package com.thd.core.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.thd.util.Page;
@Repository(value="jdbcDao")
public class JdbcDao {
	@Resource
	private JdbcTemplate jdbcTemplate;
	
	public Logger logger = Logger.getLogger(this.getClass());
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<Map<String,Object>> query(String sql,Object[] params,Integer currentPage ,Integer pageSize){
		if(currentPage !=null && pageSize != null && pageSize.compareTo(0)!=0 ){
			if(currentPage > 0){
				sql += " limit " + ((currentPage-1)*pageSize) + "," + pageSize ;
			}else{
				sql += " limit 0," + pageSize ;
			}
			
		}
		return this.jdbcTemplate.queryForList(sql, params);
	}
	
	public List<Map<String,Object>> query(String sql,Object[] params,Page p){
		logger.info("execute query SQL : " + sql);
		logger.info("execute query SQL PARAMS : " );
		if(params!=null){
			for(Object obj : params ){
				System.out.println(obj);
			}
		}
		if(p!= null && p.getCurrentPage() > 0 && p.getPageSize() > 0){
			p.setListSize(this.queryCount(sql, params));
			return this.query(sql, params,p.getCurrentPage(),p.getPageSize());
		}else{
			return this.query(sql, params,null,null);
		}
	}
	
	public int queryCount(String sql,Object[] params){
		String ctSql = "select count(*) from (" + sql + ") as result";
		
		logger.info("execute query SQL : " + ctSql);
		logger.info("execute query SQL PARAMS : " );
		if(params!=null){
			for(Object obj : params ){
				System.out.println(obj);
			}
		}
		
		
		return this.jdbcTemplate.queryForInt(ctSql,params);
	}
}
