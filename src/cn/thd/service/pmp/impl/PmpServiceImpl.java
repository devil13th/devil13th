/** 
 * Class Description:########
 * Date : 2018年2月6日 上午9:38:40
 * Auth : ccse 
*/  

package cn.thd.service.pmp.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.thd.bean.StaticVar;
import cn.thd.service.common.impl.CommonServiceImpl;
import cn.thd.service.pmp.PmpService;

import com.thd.core.dao.JdbcDao;
import com.thd.util.MyStringUtils;
import com.thd.util.Page;
import com.thd.util.StringUtil;
@Service("pmpService")
public class PmpServiceImpl extends CommonServiceImpl implements PmpService {
	@Resource
	private JdbcDao jdbcDao;
	@Override
	public List queryProcessGroup() {
		String sql = "select "
				+ " process_group_id as id,"
				+ " process_group_name as name,"
				+ " process_group_name_en as nameEn,"
				+ " process_group_remark as remark,"
				+ " process_group_order as sort,"
				+ " 'ProcessGroup' as classify "
				+ " from pmp_dic_process_group order by process_group_order";
		return this.jdbcDao.query(sql,null, null);
	}

	@Override
	public List queryKnowledgeArea() {
		String sql = "select"
				+ " knowledge_area_id as id,"
				+ " knowledge_area_name as name,"
				+ " knowledge_area_name_en as nameEn,"
				+ " knowledge_area_remark as remark,"
				+ " knowledge_area_order as sort,"
				+ " 'KnowledgeArea' as classify "
				+ " from pmp_dic_knowledge_area order by knowledge_area_order ";
		return this.jdbcDao.query(sql,null, null);
	}

	@Override
	public List queryProcess() {
		String sql = "select"
				+ " process_id as id,"
				+ " process_name as name,"
				+ " process_name_en as nameEn,"
				+ " process_remark as remark,"
				+ " process_order as sort,"
				+ " knowledge_area_id as knowledgeAreaId,"
				+ " process_group_id as processGroupId,"
				+ " 'Process' as classify "
				+ " from pmp_process order by process_order";
		System.out.println(sql);
		return this.jdbcDao.query(sql,null, null);
	}

	@Override
	public List queryItto() {
		String sql = "select"
				+ " itto_id as id,"
				+ " itto_name as name,"
				+ " itto_name_en as nameEn,"
				+ " itto_remark as remark,"
				+ " itto_type as type,"
				+ "'Itto' as classify"
				+ " from pmp_process_itto ";
		System.out.println(sql);
		return this.jdbcDao.query(sql,null, null);
	}
	
	
	@Override
	public List queryProcessIttoRela() {
		String sql = "select"
				+ " id as id,"
				+ " process_id as processId,"
				+ " itto_id as ittoId,"
				+ " rela_type as relaType,"
				+ " rela_order as sort"
				+ " from pmp_rela_procesS_itto order by process_id,rela_order";
		System.out.println(sql);
		return this.jdbcDao.query(sql,null, null);
	}
	
	
	public List queryProcessData(Map<String,String> m , Page p){
		List<String> param = new ArrayList<String>();
		
		String sql = "select "
				+ " pg.process_group_name as processGroupName,"
				+ " pg.process_group_name_en as processGroupNameEn,"
				+ " ka.knowledge_area_name as knowledgeAreaName,"
				+ " ka.knowledge_area_name_en as knowledgeAreaNameEn,"
				+ " p.process_name as processName,"
				+ " p.process_name_en as processNameEn,"
				+ " p.process_id as processId "
				+ " from pmp_process p "
				+ " left join pmp_dic_process_group pg on pg.process_group_id = p.process_group_id "
				+ " left join pmp_dic_knowledge_area ka on ka.knowledge_area_id = p.knowledge_area_id where 1=1 ";
				
		
		if(m!=null){
			if(StringUtil.isNotEmpty(m.get("processGroupId"))){
				sql += " and p.process_group_id = ? ";
				param.add( m.get("processGroupId").toString().trim() );
			}
			if(StringUtil.isNotEmpty(m.get("knowledgeAreaId"))){
				sql += " and p.knowledge_area_id= ? ";
				param.add(m.get("knowledgeAreaId").toString().trim());
			}
			if(StringUtil.isNotEmpty(m.get("key"))){
				sql += " and ( p.process_name like ? or p.process_name_en like ?  or upper(p.process_id) like upper(?)) ";
				param.add("%" + m.get("key").toString().trim() + "%");
				param.add("%" + m.get("key").toString().trim() + "%");
				param.add("%" + m.get("key").toString().trim() + "%");
			}
		}
		
		sql += " order by pg.process_group_order,ka.knowledge_area_order,p.process_order";
		
		System.out.println(sql);
		List l=  this.jdbcDao.query(sql,param.toArray(), p);
		return l;

	};
	
	public List queryProcessIttoRela(String processId,String classify,String ittoName){
		List<String> param = new ArrayList<String>();
		//System.out.println(processId + "|" + classify + "|" + ittoName + "==============");
		String sql = 
				" select "+
				" r.id as id, "+
				" p.process_name as processName, "+
				" p.process_name_en as processNameEn, "+
				" p.process_id as processId, "+
				" itto.itto_name as ittoName, "+
				" itto.itto_name_en as ittoNameEn, "+
				" itto.itto_id as ittoId, "+
				" ka.knowledge_area_name as knowledgeAreaName, " + 
				" ka.knowledge_area_name_en as knowledgeAreaNameEn, " + 
				" ka.knowledge_area_order as knowledgeAreaOrder,"+
				" p.process_order as processOrder,"+
				" r.rela_type as relaType, "+
				" r.rela_order as relaOrder "+
				" from  "+
				" pmp_rela_process_itto r "+
				" left join pmp_process p on r.process_id = p.process_id "+
				" left join pmp_process_itto itto on r.itto_id = itto.itto_id "+
				" left join pmp_dic_knowledge_area ka on p.knowledge_area_id = ka.knowledge_area_id "+
				" where 1=1 ";
		if(MyStringUtils.isNotEmpty(processId)){
			sql += " and p.process_id = ? ";
			param.add(processId);
		}
		
		if(MyStringUtils.isNotEmpty(classify)){
			sql += " and r.rela_type = ? ";
			param.add(classify);
		}
		
		
		if(MyStringUtils.isNotEmpty(ittoName)){
			sql += " and (upper(itto.itto_name) like upper(?) or upper(itto.itto_name_en) like upper(?) or upper(itto.itto_id) like (?))";
			param.add("%" + ittoName + "%");
			param.add("%" + ittoName + "%");
			param.add("%" + ittoName + "%");
			
		}
		
		sql += " order by ka.knowledge_area_order,p.process_order,r.rela_order ";
		
		List l=  this.jdbcDao.query(sql,param.toArray(), null);
		return l;
	};
}
