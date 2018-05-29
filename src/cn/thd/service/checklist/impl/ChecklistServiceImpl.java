package cn.thd.service.checklist.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.thd.bean.TreeGrid;
import cn.thd.pojo.checklist.Checklist;
import cn.thd.pojo.checklist.ChecklistImplBatch;
import cn.thd.pojo.checklist.ChecklistImplResult;
import cn.thd.service.checklist.ChecklistService;

import com.thd.core.dao.JdbcDao;
import com.thd.core.dao.PubDao;
import com.thd.core.service.PubServiceImpl;
import com.thd.util.ListUtil;
import com.thd.util.Page;
import com.thd.util.StringUtil;
import com.thd.util.TreeUtil;
@Service("checklistService")
public class ChecklistServiceImpl extends PubServiceImpl implements ChecklistService {
	@Resource 
	private PubDao pubDaoImpl;
	@Resource
	private JdbcDao jdbcDao;
	public List<Map> queryNextChecklists(String code){
		String sql = "select "
				+ " id as id,"
				+ " cklist_name as name ,"
				+ " tree_code as code,"
				+ " is_leaf as leaf "
				+ " from checklist  where is_delete = '1' ";
		sql += " and tree_code like '" + code + ".%' and tree_code not like '" + code + ".%.%'";
		return this.pubDaoImpl.findBySqlToMap(sql);
	};
	
	public Checklist queryChecklistByCode(String code){
		String sql = "select id from checklist where tree_code like '" + code + "'";
		List l = this.pubDaoImpl.findBySql(sql);
		if(ListUtil.isNotEmpty(l)){
			String id = l.get(0).toString();
			return (Checklist)this.pubDaoImpl.findById(Checklist.class, id);
		}else{
			return null;
		}
	};
	
	
	public String queryMaxTreeCode(String code){
		String sql = "select tree_code from checklist where tree_code like '" + code + ".%' and tree_code not like '" + code + ".%.%' order by tree_code desc";
		List l = this.pubDaoImpl.findBySql(sql);
		if(ListUtil.isNotEmpty(l)){
			return l.get(0).toString();
		}else{
			return null;
		}
	};
	
	public String makeChildCode(String code){
		String str = "";
		String maxCode = this.queryMaxTreeCode(code);
		int ct = 1;
		if(StringUtil.isNotEmpty(maxCode)){
			ct = TreeUtil.getCount(maxCode) + 1;
		}
		code = code + "." + TreeUtil.createCode("00000", ct);
		return code;
	}
	
	public void saveChecklist(Checklist checklist){
		String pCode = checklist.getTreeCode();
		Checklist pCklist = this.queryChecklistByCode(pCode);
		if(pCklist != null){
			pCklist.setIsLeaf("0");
			this.pubDaoImpl.update(pCklist);
		}
		checklist.setTreeCode(this.makeChildCode(pCode));
		this.pubDaoImpl.save(checklist);
	};
	
	public String dragNode(String sourceNodeId,String targetNodeId,String position){
		if("inner".equals(position)){
			
		}else if("next".equals(position)){
			
		}else if("prev".equals(position)){
			
		}else{
			return "位置错误!";
		}
		return "SUCCESS";
	};
	
	public Checklist queryRoot(){
		return queryChecklistByCode("root");
	};
	
	
	public Checklist queryChecklistById(String id){
		return (Checklist)this.pubDaoImpl.findById(Checklist.class, id);
	};
	
	public TreeGrid queryAllChecklist(String id){
		Checklist ckList = this.queryChecklistById(id);
		TreeGrid tg = new TreeGrid();
		if(StringUtil.isEmpty(id)){
			return tg;
		}
		tg.setId(ckList.getId());
		tg.setName(ckList.getCklistName());
		tg.setLeaf(ckList.getIsLeaf());
		tg.setCode(ckList.getTreeCode());
		List l = this.queryNextChecklists(ckList.getTreeCode());
		if(ListUtil.isNotEmpty(l)){
			List<TreeGrid> childrens = new ArrayList<TreeGrid>();
			for(Object obj : l){
				Map map = (HashMap)obj;
				TreeGrid c = new TreeGrid();
				String cid = map.get("id")==null ? "" : map.get("id").toString();
				String name = map.get("name")==null ? "" : map.get("name").toString();
				String leaf = map.get("leaf")==null ? "" : map.get("leaf").toString();
				String code  = map.get("code")==null ? "" : map.get("code").toString();
				TreeGrid ctg = queryAllChecklist(cid);
				childrens.add(ctg);
			}
			tg.setChildren(childrens);
		}
		return tg;
	};
	
	public List queryChecklistPerformList(String batchId){
		//检查批次
		ChecklistImplBatch clb = (ChecklistImplBatch)this.pubDaoImpl.findById(ChecklistImplBatch.class, batchId);
		String checklistId = clb.getChecklistId();
		//检查项目表
		Checklist ck = (Checklist)this.pubDaoImpl.findById(Checklist.class, checklistId);
		
		String sql = 
				" select "+
				" ck.id as id, "+
				" ckbatch.id as batchid, "+
				" ckbatch.checklist_id as ckbatchckid, "+
				" ckbatch.check_batch as batchName, "+
				" ckresult.check_res as ck, "+
				" ck.parent_id as _parentId, "+
				" ck.cklist_name as name, "+
				" ck.is_leaf as leaf, "+
				" ck.tree_code as treecode "+
				" FROM  checklist ck  "+
				" left join checklist_impl_result ckresult on ck.id = ckresult.checklist_id  and ckresult.check_batch = ?"+
				" left join checklist_impl_batch ckbatch on  ckbatch.id = ckresult.check_batch "+
				" where 1=1 and ck.tree_code like ? "+
				" order by ckbatch.check_batch desc ,ck.tree_code desc ";
		List params = new ArrayList();
		params.add(batchId);
		params.add(ck.getTreeCode() + ".%");
		
		System.out.println(ck.getTreeCode());
		List l = this.jdbcDao.query(sql, params.toArray(), null);
		
		Map root = new HashMap();
		root.put("id", ck.getId());
		root.put("name", ck.getCklistName());
		l.add(root);
		return l;
		
	};
	
	
	//========================== 检查项目实施 ==========================//
	
	/*
	 * (non-Javadoc)
	 * @see cn.thd.service.checklist.ChecklistImplBatchService#queryChecklistImplBatch(java.util.Map, com.ccse.hr.util.Page)
	 */
	public List queryChecklistImplBatch(Map<String,String> m , Page p){
		List<String> param = new ArrayList<String>();
		
		String sql = "select "+
			" t.ID as ID, " + //0   
			" t.CHECK_BATCH as CHECK_BATCH, " + //0  			
			//" t.CHECK_USER as CHECK_USER, " + //1  			
			" t.CHECK_MODULE as CHECK_MODULE, " + //2  			
			//" t.CHECKED_USER as CHECKED_USER, " + //3  			
			//" t.CHECK_TIME as CHECK_TIME, " + //4  	
			" DATE_FORMAT(t.CHECK_TIME ,'%Y-%m-%d %H:%i')as CHECK_TIME, " + //4  
			" t.IS_DELETE as IS_DELETE, " + //5  			
			" t.CHECK_DESC as CHECK_DESC, " + //6  	
			" c.ID as CKLISTID, " + //7 
			" c.CKLIST_NAME as CKLISTNAME, " + //8
			" u1.USER_NAME as CHECK_USER, " + 
			" u2.USER_NAME as CHECKED_USER " + 
			" from CHECKLIST_IMPL_BATCH t LEFT JOIN CHECKLIST c on t.CHECKLIST_ID = c.ID "+ 
			" left join SE_USER u1 on t.CHECK_USER = u1.USER_ID "+ 
			" left join SE_USER u2 on t.CHECKED_USER = u2.USER_ID "+ 
			" where 1=1 ";
		
		if(m!=null){
			if(StringUtil.isNotEmpty(m.get("ID"))){
				sql += " and t.ID like ? ";
				param.add("%" + m.get("ID").toString().trim() + "%");
			}
			if(StringUtil.isNotEmpty(m.get("CHECK_BATCH"))){
				sql += " and upper(t.CHECK_BATCH) like upper(?) ";
				param.add("%" + m.get("CHECK_BATCH").toString().trim() + "%");
			}
			if(StringUtil.isNotEmpty(m.get("CHECK_USER"))){
				sql += " and upper(t.CHECK_USER) like upper(?) ";
				param.add("%" + m.get("CHECK_USER").toString().trim() + "%");
			}
			if(StringUtil.isNotEmpty(m.get("CHECK_MODULE"))){
				sql += " and upper(t.CHECK_MODULE) like upper(?) ";
				param.add("%" + m.get("CHECK_MODULE").toString().trim() + "%");
			}
			if(StringUtil.isNotEmpty(m.get("CHECKED_USER"))){
				sql += " and upper(t.CHECKED_USER) like upper(?) ";
				param.add("%" + m.get("CHECKED_USER").toString().trim() + "%");
			}
			if(StringUtil.isNotEmpty(m.get("CHECK_TIME"))){
				sql += " and t.CHECK_TIME = ? ";
				param.add(m.get("CHECK_TIME").toString().trim());
			}
			if(StringUtil.isNotEmpty(m.get("IS_DELETE"))){
				sql += " and upper(t.IS_DELETE) like upper(?) ";
				param.add("%" + m.get("IS_DELETE").toString().trim() + "%");
			}
			if(StringUtil.isNotEmpty(m.get("CHECK_DESC"))){
				sql += " and upper(t.CHECK_DESC) like upper(?) ";
				param.add("%" + m.get("CHECK_DESC").toString().trim() + "%");
			}
			
		}
		
		
		//排序
		if(StringUtil.isNotEmpty((String)m.get("sort"))){
			sql+=" order by " + m.get("sort").toString().toUpperCase() + " " +m.get("order").toString().toUpperCase();
		}
		
		
		System.out.println(sql);
		List l = this.pubDaoImpl.findBySqlToMap(sql,param.toArray(), p);	
		return l;

	};
	
	/*
	 * (non-Javadoc)
	 * @see cn.thd.service.checklist.ChecklistImplBatchService#saveChecklistImplBatch(cn.thd.pojo.checklist.ChecklistImplBatch)
	 */
	public void saveChecklistImplBatch(ChecklistImplBatch obj) {
		this.pubDaoImpl.save(obj);
	};
	/*
	 * (non-Javadoc)
	 * @see cn.thd.service.checklist.ChecklistImplBatchService#updateChecklistImplBatch(cn.thd.pojo.checklist.ChecklistImplBatch)
	 */
	public void updateChecklistImplBatch(ChecklistImplBatch obj){
		this.pubDaoImpl.update(obj);
	};

	/*
	 * (non-Javadoc)
	 * @see cn.thd.service.checklist.ChecklistImplBatchService#queryChecklistImplBatchById(java.lang.String)
	 */
	public ChecklistImplBatch queryChecklistImplBatchById(java.lang.String pk){
		return (ChecklistImplBatch)this.pubDaoImpl.findById(ChecklistImplBatch.class,pk);
	};
	
	/*
	 * (non-Javadoc)
	 * @see cn.thd.service.checklist.ChecklistImplBatchService#deleteChecklistImplBatchById(java.lang.String)
	 */
	public void deleteChecklistImplBatchById(java.lang.String pk){
		ChecklistImplBatch obj = this.queryChecklistImplBatchById(pk);
		this.pubDaoImpl.delete(obj);
	};
	
	
	/**
	 * 批量删除检查批次对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteChecklistImplBatchByIds(String ids){
		if(ids!=null && !ids.trim().equals("")){
			String[] idArray = ids.split(",");
			if(idArray.length > 0){
				for(String id : idArray){
					if(id!=null &&  !id.trim().equals("")){
							deleteChecklistImplBatchById(id);
						
						
					}
				}
			}
		}
	};
	
	public String queryCheckResult(String checklistId,String batchId){
		String sql = "select check_res from checklist_impl_result r where r.checklist_id = ? and check_batch = ?";
		List param = new ArrayList();
		param.add(checklistId);
		param.add(batchId);
		List l = this.pubDaoImpl.findBySql(sql, param.toArray());
		if(ListUtil.isNotEmpty(l)){
			String r = ListUtil.getOne(l).toString();
			if(StringUtil.isNotEmpty(r)){
				return r;
			}
		}
		return "";
	};
	
	public String saveCheckResult(String checklistId,String batchId,String value){
		try{
			String sql = "select  id from checklist_impl_result r where r.checklist_id = ? and check_batch = ?";
			List param = new ArrayList();
			param.add(checklistId);
			param.add(batchId);
			List l = this.pubDaoImpl.findBySql(sql, param.toArray());
			ChecklistImplResult result = new ChecklistImplResult();
			if(ListUtil.isNotEmpty(l)){
//				String update_sql = "update checklist_impl_result set check_res = ?  where checklist_id = ? and check_batch = ?";
//				param.clear();
//				param.add(value);
//				param.add(checklistId);
//				param.add(batchId);
//				this.pubDaoImpl.executeSql(update_sql, param.toArray());
				String id = ListUtil.getOne(l).toString();
				result = (ChecklistImplResult)this.pubDaoImpl.findById(ChecklistImplResult.class,id);
				result.setCheckRes(value);
				this.pubDaoImpl.update(result);
				
			}else{
//				String insert_sql = "insert checklist_impl_result(id,checklist_id,check_batch,check_res) values(?,?,?,?)";
//				param.clear();
//				param.add(System.currentTimeMillis());
//				param.add(checklistId);
//				param.add(batchId);
//				param.add(value);
//				this.pubDaoImpl.executeSql(insert_sql, param.toArray());
				result.setChecklistId(checklistId);
				result.setCheckBatch(batchId);
				result.setCheckRes(value);
				this.pubDaoImpl.save(result);
			}
			return "success";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	};
	
	public String saveCheckDesc(String checklistId,String batchId,String desc){
		try{
			String sql = "select  id from checklist_impl_result r where r.checklist_id = ? and  r.check_batch = ? ";
			List param = new ArrayList();
			param.add(checklistId);
			param.add(batchId);
			ChecklistImplResult result = new ChecklistImplResult();
			List l =this.pubDaoImpl.findBySql(sql,param.toArray());
			if(ListUtil.isNotEmpty(l)){
				String id = ListUtil.getOne(l).toString();
				result = (ChecklistImplResult)this.pubDaoImpl.findById(ChecklistImplResult.class,id);
				result.setCheckDesc(desc);
				this.pubDaoImpl.update(result);
			}else{
				result.setChecklistId(checklistId);
				result.setCheckBatch(batchId);
				result.setCheckDesc(desc);
				this.pubDaoImpl.save(result);
			}
			return "success";
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	};
	
	public String queryCheckDesc(String checklistId,String batchId){
		try{
			String sql = "select  id from checklist_impl_result r where r.checklist_id = ? and  r.check_batch = ? ";
			List param = new ArrayList();
			param.add(checklistId);
			param.add(batchId);
			ChecklistImplResult result = new ChecklistImplResult();
			List l =this.pubDaoImpl.findBySql(sql,param.toArray());
			if(ListUtil.isNotEmpty(l)){
				String id = ListUtil.getOne(l).toString();
				result = (ChecklistImplResult)this.pubDaoImpl.findById(ChecklistImplResult.class,id);
				return result.getCheckDesc();
			}else{
				return "";
			}
		}catch(Exception e){
			e.printStackTrace();
			return e.getMessage();
		}
	};
	
	public List exportChecklist(String checklistId){
		String treeCode = "";
		if(StringUtil.isNotEmpty(checklistId)){
			Checklist ck = this.queryChecklistById(checklistId);
			if(ck!=null){
				treeCode = ck.getTreeCode();
			}
		}
		List params = new ArrayList();
		params.add(1);
		String sql = " select ck.id,ck.tree_code,ck.cklist_name,cklist_content,is_valid,is_delete from checklist ck where is_delete=? ";
		if(StringUtil.isNotEmpty(treeCode)){
			sql += " and ck.tree_code like ?";
			params.add(treeCode+"%");
		}
		sql += " order by ck.tree_code asc ";
		List<Map<String,Object>> l =  this.jdbcDao.query(sql, params.toArray(), null);
		if(ListUtil.isNotEmpty(l)){
			for(Map<String,Object> obj : l){
				int tc = obj.get("tree_code").toString().split("\\.").length;
				obj.put("len", tc);
			}
		}
		return l;
	};
	
	

	
}
