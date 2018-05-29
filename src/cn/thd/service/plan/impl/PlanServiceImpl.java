/** 
 * Class Description:########
 * Date : 2017年1月24日 上午10:30:05
 * Auth : wanglei 
*/  

package cn.thd.service.plan.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import oracle.apps.xdo.template.FOProcessor;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import cn.thd.bean.DataGrid;
import cn.thd.bean.StaticVar;
import cn.thd.dto.DataTableBean;
import cn.thd.dto.Weekly;
import cn.thd.dto.WeeklyPlanList;
import cn.thd.dto.WeeklyRisk;
import cn.thd.dto.WeeklyTask;
import cn.thd.dto.WeeklyUserLog;
import cn.thd.pojo.common.SeAttach;
import cn.thd.pojo.plan.PlanExecution;
import cn.thd.pojo.plan.PlanInfo;
import cn.thd.pojo.plan.PlanSummary;
import cn.thd.pojo.se.SeProjectDoc;
import cn.thd.pojo.se.SeProjectInfo;
import cn.thd.pojo.se.SeTraceTask;
import cn.thd.service.common.CommonService;
import cn.thd.service.plan.PlanService;
import cn.thd.service.se.SeService;

import com.thd.core.dao.JdbcDao;
import com.thd.core.dao.PubDao;
import com.thd.core.service.PubServiceImpl;
import com.thd.util.ListUtil;
import com.thd.util.MyBeanUtils;
import com.thd.util.MyDateUtils;
import com.thd.util.MyListUtils;
import com.thd.util.MyStringUtils;
import com.thd.util.MyUuidUtils;
import com.thd.util.Page;
import com.thd.util.RtfTemplateUtil;
import com.thd.util.StringUtil;
import com.thoughtworks.xstream.XStream;
@Service("planService")
public class PlanServiceImpl extends PubServiceImpl implements PlanService {
	@Resource 
	private PubDao pubDaoImpl;
	@Resource
	private JdbcDao jdbcDao;
	@Resource
	private CommonService commonService;
	@Resource
	private SeService seService;
	
	@Override
	public String createPlanNo(int year,int count,String planClassify) throws Exception {
		String planCode = "PL";
		String planCountStr ;
		if(StaticVar.PLAN_WEEK.equals(planClassify)){
			
			//周次第一天所在月份
			String firstDate = MyDateUtils.getFirstDayOfWeekNo(year, count);
			Calendar calendar = Calendar.getInstance();  
			calendar.setTime(MyDateUtils.toDate(firstDate));
			int month = calendar.get(Calendar.MONTH)+1;
			
			
			planCountStr = year + "" + (month < 10 ? ("0" + month) : month) + (count < 10 ? ("0" + count) : count) ;
		}else if(StaticVar.PLAN_MONTH.equals(planClassify)){
			planCountStr =  year + "" + (count < 10 ? ("0" + count) : count)  + "00";
		}else{
			throw new Exception( "invalid planClassify !");
		}
		return planCode + planCountStr;
	}

	@Override
	public PlanInfo createPlanInfo(int year,int count,String planClassify) throws Exception{
		if(this.existPlan(year, count, planClassify)){
			throw new Exception( "plan already be created !");
		}
		PlanInfo pi = new PlanInfo();
		pi.setPlanYear(year);
		if(StaticVar.PLAN_WEEK.equals(planClassify)){
			pi.setPlanClassify(StaticVar.PLAN_WEEK);
			pi.setPlanWeek(count);
			
			//周次第一天所在月份
			String firstDate = MyDateUtils.getFirstDayOfWeekNo(year, count);
			Calendar calendar = Calendar.getInstance();  
			calendar.setTime(MyDateUtils.toDate(firstDate));
			pi.setPlanMonth(calendar.get(Calendar.MONTH)+1);
			
			pi.setStartDate(MyDateUtils.toDate(MyDateUtils.getFirstDayOfWeekNo(year, count)));
			pi.setFinishDate(MyDateUtils.toDate(MyDateUtils.getLastDayOfWeekNo(year, count)));
			
			pi.setPlanCode("PLW");
		}else if(StaticVar.PLAN_MONTH.equals(planClassify)){
			pi.setPlanClassify(StaticVar.PLAN_MONTH);
			pi.setPlanMonth(count);
			pi.setPlanWeek(0);
			pi.setStartDate(MyDateUtils.toDate(MyDateUtils.getFirstDayOfMonth(year, count)));
			pi.setFinishDate(MyDateUtils.toDate(MyDateUtils.getLastDayOfMonth(year, count)));
		}else{
			throw new Exception( "invalid planClassify !");
		}
		pi.setCreTime(new Date());
		String planCode = this.createPlanNo(year,count,planClassify);
		pi.setPlanCode(planCode);
		this.pubDaoImpl.save(pi);
		return pi;
	}
	
	public boolean existPlan(int year,int count,String planClassify) throws Exception{
		String sql = "select plan_code from plan_info where plan_year = ? ";
		List params = new ArrayList();
		params.add(year);
		if(StaticVar.PLAN_WEEK.equals(planClassify)){
			sql += " and plan_week = ? ";
			params.add(count);
		}else if(StaticVar.PLAN_MONTH.equals(planClassify)){
			sql += " and plan_week = ? ";
			params.add(0);
			sql += " and plan_month = ? ";
			params.add(count);
		}
		sql += " and plan_classify = ? "  ;
		params.add(planClassify);
		int ct = this.jdbcDao.queryCount(sql, params.toArray());
		return ct != 0;
	};
	
	
	public String queryPlanInfo(int year,int count,String planClassify) {
		String sql = "select plan_code from plan_info where plan_year = ? ";
		List params = new ArrayList();
		params.add(year);
		if(StaticVar.PLAN_WEEK.equals(planClassify)){
			sql += " and plan_week = ? ";
			params.add(count);
		}else if(StaticVar.PLAN_MONTH.equals(planClassify)){
			sql += " and plan_week = ? ";
			params.add(0);
			sql += " and plan_month = ? ";
			params.add(count);
		}else{
			throw new RuntimeException(" Plan Classify Error !");
		}
		sql += " and plan_classify = ? "  ;
		params.add(planClassify);
		List r  = this.jdbcDao.query(sql, params.toArray(), null);
		if(ListUtil.isNotEmpty(r)){
			if(r.get(0) != null){
				Map m = (HashMap)r.get(0);
				return m.get("plan_code").toString();
			}
		}
		return null;
	};

	@Override
	public DataTableBean queryPlan() {
		return null;
	}
	
	
	
	
	
	public String addTaskToPlan(String taskIds,String planCode){
		if(MyStringUtils.isNotEmpty(taskIds)){
			String[] taskIdArray = taskIds.split(",");
			for(String taskId : taskIdArray){
				try{
					if(MyStringUtils.isNotEmpty(taskId)){
						SeTraceTask task = (SeTraceTask)this.findById(SeTraceTask.class, taskId);
						if(task == null){
							throw new Exception("未找到SeTraceTask:" + taskId);
						}
						PlanExecution exe = new PlanExecution();
						this.pubDaoImpl.save(exe);
						String sql = "select "
								+ " m.user_id as userId, "
								+ " u.user_name as userName "
								+ " from se_map_user m left join se_user u on m.user_id = u.user_id "
								+ " where m.tab_key_value = ? " ;
						List params = new ArrayList();
						params.add(taskId);
						List us = this.jdbcDao.query(sql, params.toArray(),null);
						String userNames = "";
						String userIds = "";
						if(MyListUtils.isNotEmpty(us)){
							userNames = MyListUtils.listMapToString(us, "userName", ",");
							
							//不再保存关系表,使用traceTask的关系即可
							//userIds = MyListUtils.listMapToString(us, "userId", ",");
							//commonService.saveMapUser("plan_execution", exe.getId(), userIds);
						}
						exe.setExeUser(userNames);
						exe.setPlanCode(planCode);
						exe.setTaskId(task.getTaskId());
						exe.setWorkName(task.getTaskTitle());
						exe.setModTime(new Date());
						exe.setCreTime(new Date());
						this.pubDaoImpl.update(exe);
					}
				}catch(Exception e){
					e.printStackTrace();
				}
				
			}
		}
		return StaticVar.STATUS_SUCCESS;
	};
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public void saveRemarkOfPlanInfo(String projectId,String planCode,Integer projectProgress,String planRemark,String finishRemark){
		PlanSummary ps = this.queryPlanSummaryByPlanCodeAndProjectId(planCode,projectId);
		if(ps == null){
			ps = new PlanSummary();
			ps.setPlanCode(planCode);
			ps.setProjectId(projectId);
			ps.setProjectProgress(projectProgress);
			ps.setPlanContent(planRemark);
			ps.setPlanSummary(finishRemark);
			this.pubDaoImpl.save(ps);
		}else{
			ps.setProjectProgress(projectProgress);
			ps.setPlanContent(planRemark);
			ps.setPlanSummary(finishRemark);
			this.pubDaoImpl.update(ps);
		}
		
	};
	
	
	public PlanInfo queryPlanInfoByPlanCode(String planCode){
		PlanInfo pi = (PlanInfo)this.getPubDaoImpl().findById(PlanInfo.class,planCode);
		return pi;
	};
	
	
	public PlanExecution queryPlanExecutionById(String planExecutionId){
		PlanExecution pe = (PlanExecution)this.getPubDaoImpl().findById(PlanExecution.class,planExecutionId);
		return pe;
	};
	
	public void initPlanInfo(int year) throws Exception{
		for(int i = 1 , j = 12 ; i <= j; i++){
			this.createPlanInfo(year, i, StaticVar.PLAN_MONTH);
		}
		for(int i = 1 , j = 52 ; i <= j; i++){
			this.createPlanInfo(year, i, StaticVar.PLAN_WEEK);
		}
	}
	
	public List queryPlanInfoList(int year){
		String sql = " select "
				+ " "
				+ " t.plan_code as planCode,"
				+ " t.plan_classify as planClassify,"
				+ " t.plan_year as planYear, "
				+ " t.plan_month as planMonth,"
				+ " t.plan_week as planWeek,"
				+ " t.start_date as startDate,"
				+ " t.finish_date as finishDate "
				+ " from plan_info t where t.plan_year = ? order by t.plan_year,t.plan_month,t.plan_week";
		List params = new ArrayList();
		params.add(year);
		List l = this.jdbcDao.query(sql, params.toArray(),null);
		return l;
	}
	
	
	
	
	public DataTableBean queryPlanList(DataTableBean dtb){
		String sql = 
				" select "+
				" task.task_title as taskTitle, "+ //任务标题
				" task.begin_date as beginDate, "+ //任务计划开始日期
				" task.finish_date as finishDate, "+ //任务计划完成日期
				" task.current_process as currentProcess, " + //任务进度
				" trace.trace_name as traceName, "+ //矩阵名称 
				" task.operator as exeUser, "+//执行人
				" pi.plan_year as planYear, "+//年份
				" pi.plan_month as planMonth, "+//月
				" pi.plan_week as planWeek, "+//周
				" pi.plan_classify as planClassify, "+//计划分类
				" task.task_id as taskId, "+
				" trace.trace_id as traceId, "+
				" pe.id as executionId, "+
				" pi.plan_code as planCode, "+
				" project.pro_name as projectName, " + 
				" project.project_id as projectId" + 
				" from plan_execution pe "+ 
				" left join se_trace_task task on pe.task_id = task.task_id "+
				" left join plan_info pi on pe.plan_code = pi.plan_code "+
				" left join se_requirement_trace trace on task.trace_id = trace.trace_id "+ 
				" left join se_project_info project on trace.project_id = project.project_id "+ 
				"where 1=1 ";
		String userId = dtb.getConditions().get("userId") == null ? null : dtb.getConditions().get("userId").toString();
		String planCode = dtb.getConditions().get("planCode") == null ? null : dtb.getConditions().get("planCode").toString();
		String projectId = dtb.getConditions().get("projectId") == null ? null : dtb.getConditions().get("projectId").toString();
		List params = new ArrayList();
		if(MyStringUtils.isNotEmpty(planCode)){
			sql += " and pi.plan_code = ? ";
			params.add(planCode);
		}
		if(MyStringUtils.isNotEmpty(projectId)){
			sql += " and trace.project_id = ? ";
			params.add(projectId);
		}
		if(MyStringUtils.isNotEmpty(userId)){
			sql += " and task.task_id in (select distinct tab_key_value from se_map_user where rela_tab = 'TASK' and user_id = ?) ";
			params.add(userId);
		}
		Page p = new Page();
		p.setCurrentPage(dtb.getCurrentPage());
		p.setPageSize(dtb.getPageSize());
		List r = this.jdbcDao.query(sql, params.toArray(), p);
		
		dtb.setRecordsTotal(p.getListSize());
		dtb.setRecordsFiltered(p.getListSize());
		
		dtb.setData(r);
		return dtb;
	};
	
	public DataTableBean queryPlanList(String userId,String planCode,String projectId){
		/*String sql = "select "+
			" p.plan_code as planCode, "+
			" e.plan_progress as planProgress, "+
			" e.finish_progress as finishProgress, "+
			" i.current_progress as currentProgress, "+
			" i.plan_item_title as planItemTitle,"+
			" i.plan_item_id as planItemId, "+
			" e.id as planExecutionId " + 
			" from plan_execution e "+
			" left join plan_info p on p.plan_code = e.plan_code "+
			" left join plan_item i on i.plan_item_id = e.plan_item_id"+
			" where p.plan_code = ?";
		*/
		String sql = 
				" select "+
				" task.task_title as taskTitle, "+ //任务标题
				" task.begin_date as beginDate, "+ //任务计划开始日期
				" task.finish_date as finishDate, "+ //任务计划完成日期
				" task.current_process as currentProcess, " + //任务进度
				" trace.trace_name as traceName, "+ //矩阵名称 
				" task.operator as exeUser, "+//执行人
				" pi.plan_year as planYear, "+//年份
				" pi.plan_month as planMonth, "+//月
				" pi.plan_week as planWeek, "+//周
				" pi.plan_classify as planClassify, "+//计划分类
				" task.task_id as taskId, "+
				" trace.trace_id as traceId, "+
				" pe.work_name as workName,"+
				" pe.id as executionId, "+
				" pe.plan_progress as planProgress,"+
				" pe.finish_progress as finishProgress,"+
				" pi.plan_code as planCode, "+
				" project.pro_name as projectName, " + 
				" project.project_id as projectId" + 
				" from plan_execution pe "+ 
				" left join se_trace_task task on pe.task_id = task.task_id "+
				" left join plan_info pi on pe.plan_code = pi.plan_code "+
				" left join se_requirement_trace trace on task.trace_id = trace.trace_id "+ 
				" left join se_project_info project on trace.project_id = project.project_id "+ 
				"where 1=1 ";
		List params = new ArrayList();
		if(MyStringUtils.isNotEmpty(planCode)){
			sql += " and pi.plan_code = ? ";
			params.add(planCode);
		}
		if(MyStringUtils.isNotEmpty(projectId)){
			sql += " and trace.project_id = ? ";
			params.add(projectId);
		}
		if(MyStringUtils.isNotEmpty(userId)){
			sql += " and task.task_id in (select distinct tab_key_value from se_map_user where rela_tab = 'TASK' and user_id = ?) ";
			params.add(userId);
		}
		
		List r = this.jdbcDao.query(sql, params.toArray(), null);
		DataTableBean db = new DataTableBean();
		db.setData(r);
		return db;
	} 
	
	
	
	
	
	
	public PlanInfo queryPrevPlanInfo(String planCode){
		PlanInfo planInfo = this.queryPlanInfoByPlanCode(planCode);
		int year = planInfo.getPlanYear();
		int month = planInfo.getPlanMonth();
		int week = planInfo.getPlanWeek();
		
		if(StaticVar.PLAN_MONTH.equals(planInfo.getPlanClassify())){
			if(month == 1){
				month = 12;
				year--;
			}else{
				month--;
			}
			String prevPlanCode = this.queryPlanInfo(year, month, StaticVar.PLAN_MONTH);
			return this.queryPlanInfoByPlanCode(prevPlanCode);
		}else if(StaticVar.PLAN_WEEK.equals(planInfo.getPlanClassify())){
			if(week == 1){
				week = 52;
				year--;
			}else{
				week--;
			}
			String prevPlanCode = this.queryPlanInfo(year, week, StaticVar.PLAN_WEEK);
			if(StringUtil.isNotEmpty(prevPlanCode)){
				return this.queryPlanInfoByPlanCode(prevPlanCode);
			}else{
				return null;
			}
		}else{
			throw new RuntimeException(" Plan Classify Error !");
		}
		
		/*
		 PlanInfo planInfo = this.queryPlanInfoByPlanCode(planCode);
		Date firstDay = planInfo.getStartDate();
		
		Calendar c = Calendar.getInstance();
		c.setTime(firstDay);
		c.add(Calendar.DAY_OF_YEAR, -1);
		
		int year = c.get(Calendar.YEAR);
		PlanInfo prevPlanInfo ;
		if(StaticVar.PLAN_MONTH.equals(planInfo.getPlanClassify())){
			int month = (c.get(Calendar.MONTH) + 1);
			System.out.println(year + "|" + month);
			prevPlanInfo = this.queryPlanInfoByPlanCode(this.queryPlanInfo(year, month, StaticVar.PLAN_MONTH));
		}else if(StaticVar.PLAN_WEEK.equals(planInfo.getPlanClassify())){
			String date = MyDateUtils.toString(c.getTime());
			System.out.println(date);
			int week = MyDateUtils.getWeekOfYear(date);
			System.out.println(year + "|" + week);
			prevPlanInfo = this.queryPlanInfoByPlanCode(this.queryPlanInfo(year, week, StaticVar.PLAN_WEEK));
		}else{
			throw new RuntimeException(" Plan Classify Error !");
		}
		return prevPlanInfo;*/
	};
	
	public PlanInfo queryNextPlanInfo(String planCode){
		PlanInfo planInfo = this.queryPlanInfoByPlanCode(planCode);
		int year = planInfo.getPlanYear();
		int month = planInfo.getPlanMonth();
		int week = planInfo.getPlanWeek();
		
		if(StaticVar.PLAN_MONTH.equals(planInfo.getPlanClassify())){
			if(month == 12){
				month = 1;
				year++;
			}else{
				month++;
			}
			String prevPlanCode = this.queryPlanInfo(year, month, StaticVar.PLAN_MONTH);
			return this.queryPlanInfoByPlanCode(prevPlanCode);
		}else if(StaticVar.PLAN_WEEK.equals(planInfo.getPlanClassify())){
			if(week == 52){
				week = 1;
				year++;
			}else{
				week++;
			}
			String prevPlanCode = this.queryPlanInfo(year, week, StaticVar.PLAN_WEEK);
			return this.queryPlanInfoByPlanCode(prevPlanCode);
		}else{
			throw new RuntimeException(" Plan Classify Error !");
		}
	};
	
	
	/**
	 * 更新计划执行信息
	 * @param execution 计划执行对象
	 * @return
	 */
	public String updatePlanExecution(PlanExecution execution){
		PlanExecution planExecution = this.queryPlanExecutionById(execution.getId());
		planExecution.setFinishProgress(execution.getFinishProgress());
		planExecution.setPlanProgress(execution.getPlanProgress());
		planExecution.setPlanRemark(execution.getPlanRemark());
		this.pubDaoImpl.update(planExecution);
		
		if(MyStringUtils.isNotEmpty(planExecution.getTaskId()) && planExecution.getFinishProgress()!=null){
			SeTraceTask t = (SeTraceTask)this.findById(SeTraceTask.class, planExecution.getTaskId());
			t.setCurrentProcess(planExecution.getFinishProgress());
		}
		
		return StaticVar.STATUS_SUCCESS;
	};
	
	public String updateProgressOfExecution(String executionId,Integer progress){
		try {
			PlanExecution planExecution = this.queryPlanExecutionById(executionId);
			if (planExecution == null) {
				throw new RuntimeException("can't find plan execution object");
			}
			planExecution.setFinishProgress(progress);
			if (MyStringUtils.isNotEmpty(planExecution.getTaskId())) {
				SeTraceTask task = (SeTraceTask) this.findById(
						SeTraceTask.class, planExecution.getTaskId());
				if (task == null) {
					throw new RuntimeException("can't find seTraceTask object");
				}
				task.setCurrentProcess(progress);
				this.save(task);
			}
			return StaticVar.STATUS_SUCCESS;
		} catch (Exception e) {
			return e.getMessage();
		}
			
		
	};
	/**
	 * 删除计划执行信息
	 * @param executionId 计划执行ID
	 * @return
	 */
	public String removeTaskFromExecution(String executionId){
		this.deleteById(PlanExecution.class, executionId);
		return StaticVar.STATUS_SUCCESS;
	};
	
	/*
	 * (non-Javadoc)
	 * @see cn.thd.service.se.PlanSummaryService#queryPlanSummary(java.util.Map, com.ccse.hr.util.Page)
	 */
	public List queryPlanSummary(Map<String,String> m , Page p){
		List<String> param = new ArrayList<String>();
		
		String sql = "select "+
			" t.PLAN_CODE as PLAN_CODE, " + //0  计划代码 
			" t.PROJECT_ID as PROJECT_ID, " + //0 项目ID 			
			" t.PLAN_CONTENT as PLAN_CONTENT, " + //1 计划内容 			
			" t.PLAN_SUMMARY as PLAN_SUMMARY " + //2 计划总结 			
			
			" from PLAN_SUMMARY t  where 1=1 ";
		
		if(m!=null){
			if(StringUtil.isNotEmpty(m.get("PLAN_CODE"))){
				sql += " and t.PLAN_CODE like ? ";
				param.add("%" + m.get("PLAN_CODE").toString().trim() + "%");
			}
				if(StringUtil.isNotEmpty(m.get("PROJECT_ID"))){
					sql += " and upper(t.PROJECT_ID) like upper(?) ";
					param.add("%" + m.get("PROJECT_ID").toString().trim() + "%");
				}
				if(StringUtil.isNotEmpty(m.get("PLAN_CONTENT"))){
					sql += " and upper(t.PLAN_CONTENT) like upper(?) ";
					param.add("%" + m.get("PLAN_CONTENT").toString().trim() + "%");
				}
				if(StringUtil.isNotEmpty(m.get("PLAN_SUMMARY"))){
					sql += " and upper(t.PLAN_SUMMARY) like upper(?) ";
					param.add("%" + m.get("PLAN_SUMMARY").toString().trim() + "%");
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
	 * @see cn.thd.service.se.PlanSummaryService#savePlanSummary(cn.thd.pojo.plan.PlanSummary)
	 */
	public void savePlanSummary(PlanSummary obj) {
		this.pubDaoImpl.save(obj);
	};
	/*
	 * (non-Javadoc)
	 * @see cn.thd.service.se.PlanSummaryService#updatePlanSummary(cn.thd.pojo.plan.PlanSummary)
	 */
	public void updatePlanSummary(PlanSummary obj){
		this.pubDaoImpl.update(obj);
	};

	/*
	 * (non-Javadoc)
	 * @see cn.thd.service.se.PlanSummaryService#queryPlanSummaryById(java.lang.String)
	 */
	public PlanSummary queryPlanSummaryById(java.lang.String pk){
		return (PlanSummary)this.pubDaoImpl.findById(PlanSummary.class,pk);
	};
	
	public PlanSummary queryPlanSummaryByPlanCodeAndProjectId(String planCode,String projectId){
		if(MyStringUtils.isEmpty(planCode)){
			throw new RuntimeException("planCode can not be found ");
		}
		if(MyStringUtils.isEmpty(projectId)){
			throw new RuntimeException("projectId can not be found ");
		}
		String sql = "select id,plan_code,project_id from plan_summary where plan_code = ? and project_id = ? ";
		List params = new ArrayList();
		params.add(planCode);
		params.add(projectId);
		List l = this.jdbcDao.query(sql, params.toArray(),null);
		if(MyListUtils.isEmpty(l)){
			return null;
		}
		
		try{
			Object obj = l.get(0);
			Map m = (Map)obj;
			String id = m.get("id").toString();
			return this.queryPlanSummaryById(id);
		}catch(Exception e){
			return null;
		}
		
	};
	
	/*
	 * (non-Javadoc)
	 * @see cn.thd.service.se.PlanSummaryService#deletePlanSummaryById(java.lang.String)
	 */
	public void deletePlanSummaryById(java.lang.String pk){
		PlanSummary obj = this.queryPlanSummaryById(pk);
		this.pubDaoImpl.delete(obj);
	};
	
	
	/**
	 * 批量删除角色权限关系对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deletePlanSummaryByIds(String ids){
		if(ids!=null && !ids.trim().equals("")){
			String[] idArray = ids.split(",");
			if(idArray.length > 0){
				for(String id : idArray){
					if(id!=null &&  !id.trim().equals("")){
							deletePlanSummaryById(id);
						
						
					}
				}
			}
		}
	};
	
	public String copyPlanExecutionToPlanInfo(String executionId,String planCode){
		try {
			PlanExecution execution = this.queryPlanExecutionById(executionId);
			PlanExecution newEexecution = new PlanExecution();
			BeanUtils.copyProperties(execution, newEexecution);
			newEexecution.setCreTime(new Date());
			newEexecution.setModTime(new Date());
			newEexecution.setPlanCode(planCode);
			this.pubDaoImpl.save(newEexecution);
			return StaticVar.STATUS_SUCCESS;
		} catch (Exception e) {
			return e.getMessage();
		}
	};
	
	public String createPlanReport(String webRootPath,String projectId,String planCode,String fileType){
		
		
		Weekly report = new Weekly();
		
		//计划信息
		PlanInfo planInfo = this.queryPlanInfoByPlanCode(planCode);
		String planClassifyStr = "";
		if(StaticVar.PLAN_MONTH.equals(planInfo.getPlanClassify())){
			planClassifyStr = "月";
		}else if(StaticVar.PLAN_WEEK.equals(planInfo.getPlanClassify())){
			planClassifyStr = "周";
		}
		
		report.setPlanInfo(planInfo);
		
		
		//下周计划
		PlanInfo nextPlanInfo = this.queryNextPlanInfo(planInfo.getPlanCode());
		
		report.setBeginDate(MyDateUtils.toString(planInfo.getStartDate()));
		report.setEndDate(MyDateUtils.toString(planInfo.getFinishDate()));
		//项目信息
		SeProjectInfo projectInfo = this.seService.querySeProjectInfoById(projectId);
		
		PlanSummary summary = this.queryPlanSummaryByPlanCodeAndProjectId(planCode, projectId);
		
		report.setSeProjectInfo(projectInfo);
		report.setPlanSummary(summary);
		
		
		Map puMap = new HashMap();
		puMap.put("PROJECT_ID", projectId);
		List u = this.seService.querySeMapProjectUser(puMap, null);
		String projectMember = MyListUtils.listMapToString(u, "USER_NAME", ",");
		report.setProjectMember(projectMember);
		
		report.setReportDate(MyDateUtils.toString(new Date()));
		
		Map m = new HashMap();
		m.put("logDateL", MyDateUtils.toString(planInfo.getStartDate()));
		m.put("logDateH", MyDateUtils.toString(planInfo.getFinishDate()));
		m.put("projectId", projectId);
		
		//本周计划列表
		DataTableBean planList = this.queryPlanList(null,planInfo.getPlanCode(),projectId);
		List currentPlanListData = MyBeanUtils.listMapToListBean(planList.getData(), WeeklyPlanList.class.getName());
		report.setCurrentPlanList(currentPlanListData);
		
		//下周计划列表
		DataTableBean nextPlanList = this.queryPlanList(null,nextPlanInfo.getPlanCode(),projectId);
		List nextPlanListData = MyBeanUtils.listMapToListBean(nextPlanList.getData(), WeeklyPlanList.class.getName());
		report.setNextPlanList(nextPlanListData);
		
		
		//人员工作任务列表
		List taskList = this.seService.seCountTaskGetData(m);
		List taskListData = MyBeanUtils.listMapToListBean(taskList, WeeklyTask.class.getName());
		report.setTaskList(taskListData);
		
		
		List workLoadList = this.seService.seCountWorkLoadGetData(m);
		
		
		//本周日志列表
		m.put("sort", "u.user_id");
		m.put("order", "desc");
		DataGrid logList = this.seService.queryUserLog(m, null);
		List logListData = MyBeanUtils.listMapToListBean(logList.getRows(), WeeklyUserLog.class.getName());
		report.setLogList(logListData);
		
		//项目风险
		Map riskCondition = new HashMap();
		riskCondition.put("PROJECT_ID", projectInfo.getProjectId());
		List riskList = this.seService.querySeRisk(riskCondition, null);
		List riskListData = new ArrayList();
		if(MyListUtils.isNotEmpty(riskList)){
			for(Object obj : riskList){
				Map riskMap = (Map)obj;
				WeeklyRisk risk = new WeeklyRisk();
				
				risk.setRiskContent(riskMap.get("RISK_CONTENT")==null ? "" : riskMap.get("RISK_CONTENT").toString());
				risk.setRiskStatus(riskMap.get("RISK_STATUS")==null ? "" : riskMap.get("RISK_STATUS").toString());
				riskListData.add(risk);
			}
		}
		report.setRiskList(riskListData);
		
		
		
		
		
		

		
		this.getLog().info(webRootPath);
		
		
		
		//输出文件种类
		byte outputFormat = FOProcessor.FORMAT_PDF;
		String fileFixed = ".pdf";
		if(StaticVar.REPORTTYPE_RTF.equals(fileType)){
			outputFormat = FOProcessor.FORMAT_RTF;
			fileFixed = ".rtf";
		}
		if(StaticVar.REPORTTYPE_PDF.equals(fileType)){
			outputFormat = FOProcessor.FORMAT_PDF;
			fileFixed = ".pdf";
		}
				
				
				
		//rtf模板路径
		//String rtfTemplateFilePath="D://deleteme1//CSE(CHN)2.50.rtf";
		String rtfTemplateFilePath=webRootPath + "rtfTemplate" + File.separator + "weekly.rtf";
		
		String tempFileNamePre = new Date().getTime() + "-" + MyUuidUtils.getUuid();
		
		//中间过程生成的xsl路径
		String xslFilePath= webRootPath + "temp" + File.separator + tempFileNamePre + "-bixsl" + ".xsl";
		//xml数据路径
		String xmlFilePath= webRootPath + "temp" + File.separator + tempFileNamePre + "-bix.l" + ".xml";
		//配置文件位置
		String cfgFilePath= webRootPath + "WEB-INF" + File.separator + "xdo.cfg";
		//输出最终文件位置
		String resultPdfFilePath = webRootPath  + "temp" + File.separator +  tempFileNamePre + "-result" +  fileFixed; 
		
		
		
		
		
		XStream xstream = new XStream();
		//去掉生成xml标签的包名前缀
		xstream.aliasPackage("", "cn.thd.pojo.plan");
		xstream.aliasPackage("", "cn.thd.pojo.se");
		xstream.aliasPackage("", "cn.thd.dto");
		
		
		String hlStr = xstream.toXML(report);
		String outStr = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>";
		outStr += hlStr;
		
		System.out.println(hlStr);
		
		
		
		//写入到文件
		FileWriter fw = null;
		File xmlFile = new File(xmlFilePath);
		try {
			if (!xmlFile.exists()) {
				xmlFile.createNewFile();
			}
			fw = new FileWriter(xmlFile);
			//BufferedWriter out = new BufferedWriter(fw,"UTF8");
			OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(xmlFile),"UTF-8"); 
			BufferedWriter out=new BufferedWriter(write);
			out.write(outStr, 0, outStr.length());
			out.close();
			write.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		

		RtfTemplateUtil rtfUtil = new RtfTemplateUtil(  
				rtfTemplateFilePath,  
				xslFilePath,
				 xmlFilePath,  
				 cfgFilePath,  
				 resultPdfFilePath,outputFormat);
		
		rtfUtil.genarateReportPdf();
		
		return resultPdfFilePath;
				
			
		
		
		
		
	};
	
	
	public String createPlanReportAndUpload(String webRootPath,String projectId,String planCode,String fileType,String uploader){
		String reportFilePath = this.createPlanReport(webRootPath,projectId,planCode, StaticVar.REPORTTYPE_RTF);
		
		String savePath = webRootPath + "attached" + File.separator + "commonUpload";
		PlanInfo planInfo = this.queryPlanInfoByPlanCode(planCode);
		SeProjectInfo projectInfo = this.seService.querySeProjectInfoById(projectId);
		PlanSummary summary = this.queryPlanSummaryByPlanCodeAndProjectId(planCode, projectId);
		
		
		//SeAttach oldWeeklyDocAttach = this.commonService.queryAttachByKeyAndId(StaticVar.ATTACHKEY_PLANSUMMARY, summary.getId());
		if(MyStringUtils.isNotEmpty(summary.getDocAttachId())){
			//删除原先生成的周月报附件
			this.commonService.deleteCommonAttach(summary.getDocAttachId());
			
			//删除周报文档
			seService.deleteSeProjectDocByAttachId(summary.getDocAttachId());
		}
		
		
		
		//上传附件
		String fileName = projectInfo.getProName() + "周报-" + planInfo.getPlanYear() + planInfo.getPlanMonth() + planInfo.getPlanWeek()  + ".rtf";
		SeAttach attach = this.commonService.uploadFile(new File(reportFilePath),savePath, fileName,  "PLAN_SUMMARY", summary.getId());
		
		//更新周报附件ID
		summary.setDocAttachId(attach.getAttachId());
		this.savePlanSummary(summary);
		
		//项目周报文档
		SeProjectDoc doc = new SeProjectDoc();
		doc.setDocCode("PROJECT_WEEKLY");
		doc.setDocDesc("项目周报" +  MyDateUtils.toString(planInfo.getStartDate()) + "-" + MyDateUtils.toString(planInfo.getFinishDate()));
		doc.setDocName("项目周报" +  MyDateUtils.toString(planInfo.getStartDate()) + "-" + MyDateUtils.toString(planInfo.getFinishDate()));
		doc.setDocVersoin("1.0");
		doc.setProjectId(projectId);
		doc.setUploader(uploader);
		doc.setAttachId(attach.getAttachId());
		doc.setUploadTime(new Date());
		seService.saveSeProjectDoc(doc);
		
		return attach.getAttachId();
	};
	
	
}
