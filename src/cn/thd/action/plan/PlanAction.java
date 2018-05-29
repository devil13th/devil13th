/** 
 * Class Description:########
 * Date : 2017年1月24日 上午10:33:48
 * Auth : wanglei 
*/  

package cn.thd.action.plan;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import cn.thd.bean.LoginUserInfo;
import cn.thd.bean.Option;
import cn.thd.bean.StaticVar;
import cn.thd.dto.DataTableBean;
import cn.thd.dto.PlanExecutionItem;
import cn.thd.pojo.common.SeAttach;
import cn.thd.pojo.plan.PlanExecution;
import cn.thd.pojo.plan.PlanInfo;
import cn.thd.pojo.plan.PlanItem;
import cn.thd.pojo.plan.PlanSummary;
import cn.thd.pojo.se.SeProjectDoc;
import cn.thd.pojo.se.SeProjectInfo;
import cn.thd.pojo.se.SeRequirementTrace;
import cn.thd.pojo.se.SeTraceTask;
import cn.thd.service.backlog.BacklogInfoService;
import cn.thd.service.common.CommonService;
import cn.thd.service.plan.PlanService;
import cn.thd.service.se.SeRequirementTraceService;
import cn.thd.service.se.SeService;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ibm.icu.util.Calendar;
import com.thd.core.action.PubAction;
import com.thd.util.MyDateUtils;
import com.thd.util.MyStringUtils;

public class PlanAction extends PubAction {
	@Resource
	private PlanService planService;
	@Resource
	private BacklogInfoService backlogInfoService;
	@Resource
	private CommonService commonService;
	@Resource
	private SeService seService;
	@Resource
	private SeRequirementTraceService seRequirementTraceService;
	
	private GsonBuilder builder = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss");
	private Gson gson = builder.create();
	
	private PlanInfo planInfo = new PlanInfo();
	private PlanItem planItem = new PlanItem();
	private PlanSummary planSummary = new PlanSummary();
	private PlanExecution planExecution = new PlanExecution();
	private int year;
	private int month;
	private int week;
	private String acceptJson ;
	private PlanExecutionItem planExecutionItem = new PlanExecutionItem();
	private String projectId;
	/**
	 * 新增计划
	 * url : /plan/plan!planForm.do
	 * @return
	 */
	public String planForm(){
		this.getLog().info("planForm()");
		try{
			this.setForwardPage("/pages/plan/planForm.jsp");
			//System.out.println(this.planService);
			this.getLog().info(this.getForwardPage());
			this.setMsg(StaticVar.STATUS_SUCCESS);
			return "ajax";
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	/**
	 * 初始化某年整年的月计划和周计划
	 * url : /plan/plan!initPlanInfo.do
	 * @return
	 */
	public String initPlanInfo(){
		this.getLog().info("initPlanInfo()");
		try{
			this.setForwardPage("/pages/plan/planForm.jsp");
			planService.initPlanInfo(year);
			this.setMsg(StaticVar.STATUS_SUCCESS);
			return "ajax";
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	/**
	 * 计划列表
	 * url : /plan/plan!planList.do
	 * @return
	 */
	public String planList(){
		this.getLog().info("planForm()");
		try{
			this.setForwardPage("/pages/plan/planList.jsp");
			
			
			Calendar c = Calendar.getInstance();
			int currentWeek = MyDateUtils.getWeekOfYear(MyDateUtils.toString(c.getTime()));
			int currentYear = c.get(Calendar.YEAR);
			int currentMonth = (c.get(Calendar.MONTH) + 1);
			int dayOfWeek = MyDateUtils.getDayOfWeek(c.get(Calendar.YEAR) + "-01-01");
			if(dayOfWeek != 1){
				currentWeek--;
			}
			this.getRequest().put("currentWeek", currentWeek);
			this.getRequest().put("currentYear", currentYear);
			
			if(year ==0){
				year = currentYear;
			}
			List l = planService.queryPlanInfoList(year);
			this.getRequest().put("planList",l);
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	/**
	 * 计划列表
	 * url : /plan/plan!planView.do
	 * @return
	 */
	public String planView(){
		this.getLog().info("planView");
		try{
			this.setForwardPage("/pages/plan/planView.jsp");
			planInfo = planService.queryPlanInfoByPlanCode(planInfo.getPlanCode());
			planSummary = planService.queryPlanSummaryByPlanCodeAndProjectId(planInfo.getPlanCode(), this.getProjectId());
			if(planSummary == null){
				planSummary = new PlanSummary();
				planSummary.setPlanCode(planInfo.getPlanCode());
				planSummary.setProjectId( this.getProjectId());
				this.commonService.save(planSummary);
			}
			
			String planClassifyStr = "";
			if(StaticVar.PLAN_MONTH.equals(planInfo.getPlanClassify())){
				planClassifyStr = "月";
			}else if(StaticVar.PLAN_WEEK.equals(planInfo.getPlanClassify())){
				planClassifyStr = "周";
			}
			PlanInfo prevPlanInfo = planService.queryPrevPlanInfo(planInfo.getPlanCode());
			this.getRequest().put("prevPlanInfo", prevPlanInfo);
			this.getRequest().put("planClassifyStr",planClassifyStr);
			
			PlanInfo nextPlanInfo = planService.queryNextPlanInfo(planInfo.getPlanCode());
			this.getRequest().put("nextPlanInfo", nextPlanInfo);
			
			//日志查询使用,起始日期
			String blQueryStartDate = MyDateUtils.toString(planInfo.getStartDate());
			String blQueryFinishDate =MyDateUtils.toString(planInfo.getFinishDate());
			
			this.getRequest().put("blQueryStartDate",blQueryStartDate);
			this.getRequest().put("blQueryFinishDate",blQueryFinishDate);
			
			//List userList = this.commonService.queryUserForOption();
			//this.getRequest().put("userList", userList);
			
			List<Option> userList = commonService.queryUserForOptionKV();
			this.getRequest().put("userList", userList);
			
			
			if(MyStringUtils.isNotEmpty(this.getProjectId())){
				SeProjectInfo project = this.seService.querySeProjectInfoById(this.getProjectId());
				this.getRequest().put("project", project);
			}
			
			this.getLog().info(this.getForwardPage());
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	
	/**
	 * 计划列表
	 * url : /plan/plan!planListGetData.do
	 * @return
	 */
	public String planListGetData(){
		this.getLog().info("planListGetData");
		try{
			GsonBuilder builder = new GsonBuilder();
			Gson gson = builder.setDateFormat("yyyy-MM-dd").create();
			DataTableBean dtb = planService.queryPlanList(null,planInfo.getPlanCode(),projectId);
			this.setMsg( gson.toJson(dtb));
			return "ajax";
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	
	
	
	/**
	 * 将计划加入
	 * url : /plan/plan!addTaskToPlan.do
	 * @return
	 */
	public String addTaskToPlan(){
		this.getLog().info("addTaskToPlan");
		try{
			
			String taskIds = this.getPlanExecution().getTaskId();
			String planCode = this.getPlanExecution().getPlanCode();
			this.planService.addTaskToPlan(taskIds, planCode);
			this.setMsg(StaticVar.STATUS_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(StaticVar.STATUS_FAILURE);
		}
		return "ajax";
	}
	
	
	
	/**
	 * 复制计划执行条目到项目计划
	 * url : /plan/plan!copyPlanExecutionToPlanInfo.do
	 * @return
	 */
	public String copyPlanExecutionToPlanInfo(){
		this.getLog().info("copyPlanExecutionToPlanInfo");
		try{
			this.planService.copyPlanExecutionToPlanInfo(this.planExecution.getId(), this.planExecution.getPlanCode());
			this.setMsg(StaticVar.STATUS_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(StaticVar.STATUS_FAILURE);
		}
		return "ajax";
	}
	
	
	
	
	/**
	 * 矩阵任务信息
	 * url:/se/se!planTaskDetail.do?id=xxx
	 */
	public String planTaskDetail(){
		try{
			this.logger.info("planTaskDetail()");
			this.setForwardPage("/pages/plan/planTaskDetail.jsp");
			planExecution = planService.queryPlanExecutionById(this.getId());
			
			SeTraceTask task = this.seService.querySeTraceTaskById(planExecution.getTaskId());
			this.getRequest().put("task", task);
			
			if(MyStringUtils.isNotEmpty(task.getTraceId())){
				SeRequirementTrace trace = seRequirementTraceService.queryNodeById(task.getTraceId());
				this.getRequest().put("trace", trace);
			}
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 创建计划条目执行情况
	 * url : /plan/plan!saveRemarkOfPlanInfo.do
	 * @return
	 */
	public String saveRemarkOfPlanInfo(){
		this.getLog().info("saveRemarkOfPlanInfo");
		try{
			planService.saveRemarkOfPlanInfo(this.getProjectId(),planSummary.getPlanCode().trim(),planSummary.getProjectProgress(),planSummary.getPlanContent(),planSummary.getPlanSummary());
			this.setMsg(StaticVar.STATUS_SUCCESS);
			return "ajax";
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
			return "ajax";
		}
	}
	
	
	/**
	 * 查询计划期间的待办
	 * url : /plan/plan!queryBacklog.do
	 * @return
	 */
	public String queryBacklog(){
		this.getLog().info("queryBacklog");
		try{
			//planInfo = planService.queryPlanInfoByPlanCode(planInfo.getPlanCode());
			//List l = backlogInfoService.queryBacklogForPeriod(MyDateUtils.toString(planInfo.getStartDate()),MyDateUtils.toString(planInfo.getFinishDate()));
			
			String blQueryStartDate = this.getReq().getParameter("blQueryStartDate");
			String blQueryFinishDate = this.getReq().getParameter("blQueryFinishDate");
			
			//System.out.println(blQueryStartDate+"||" + blQueryFinishDate);
			List l = backlogInfoService.queryBacklogForPeriod(blQueryStartDate,blQueryFinishDate);
			this.setMsg(StaticVar.STATUS_SUCCESS);
			
			DataTableBean dtb = new DataTableBean();
			dtb.setData(l);
			dtb.setCurrentPage(1);
			dtb.setRecordsTotal(l.size());
			dtb.setRecordsFiltered(l.size());
			
			GsonBuilder builder = new GsonBuilder();
			Gson gson = builder.setDateFormat("yyyy-MM-dd").create();
			this.setMsg( gson.toJson(dtb));
			return "ajax";
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
			return "ajax";
		}
	}
	
	
	
	/**
	 * 查询计划期间执行的需求任务
	 * url : /plan/plan!queryTraceTask.do
	 * @return
	 */
	public String queryTraceTask(){
		this.getLog().info("queryTraceTask");
		try{
			
			String blQueryStartDate = this.getReq().getParameter("blQueryStartDate");
			String blQueryFinishDate = this.getReq().getParameter("blQueryFinishDate");
			//System.out.println(blQueryStartDate+"||" + blQueryFinishDate);
			Map m = new HashMap();
			m.put("logDateL", blQueryStartDate);
			m.put("logDateH", blQueryFinishDate);
			m.put("projectId", this.getProjectId());
			DataTableBean dtb = new DataTableBean();
			dtb.setConditions(m);
			this.seService.seCountTaskGetDataForBootstrap(dtb);
			
			GsonBuilder builder = new GsonBuilder();
			Gson gson = builder.setDateFormat("yyyy-MM-dd").create();
			this.setMsg( gson.toJson(dtb));
			return "ajax";
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
			return "ajax";
		}
	}
	
	
	/**
	 * 查询计划期间的用户日志
	 * url : /plan/plan!queryUserlog.do
	 * @return
	 */
	public String queryUserlog(){
		this.getLog().info("queryUserlog");
		try{
			
			String blQueryStartDate = this.getReq().getParameter("blQueryStartDate");
			String blQueryFinishDate = this.getReq().getParameter("blQueryFinishDate");
			//System.out.println(blQueryStartDate+"||" + blQueryFinishDate);
			Map m = new HashMap();
			m.put("logDateL", blQueryStartDate);
			m.put("logDateH", blQueryFinishDate);
			m.put("projectId", this.getProjectId());
			DataTableBean dtb = new DataTableBean();
			dtb.setConditions(m);
			this.seService.seCountWorkLoadGetDataForBootstrap(dtb);
			
			GsonBuilder builder = new GsonBuilder();
			Gson gson = builder.setDateFormat("yyyy-MM-dd").create();
			this.setMsg( gson.toJson(dtb));
			return "ajax";
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
			return "ajax";
		}
	}
	
	
	
	/**
	 * 生成计划
	 * url:/se/se!createPlanDoc.do?planInfo.planCode=xxx&projectId=xxx
	 */
	public String createPlanDoc(){
		this.logger.info("createPlanDoc()");
		try{
			
			LoginUserInfo lui = (LoginUserInfo)this.getSession().get("loginUserInfo");
			
			this.setForwardPage("/pages/plan/createPlanDoc.jsp");
			String webRootPath = this.getReq().getSession().getServletContext().getRealPath("/");
			
			String planDocAttachId = this.planService.createPlanReportAndUpload(webRootPath,this.getProjectId(), this.planInfo.getPlanCode(), StaticVar.REPORTTYPE_RTF,lui.getUserId());
			/*
			String reportFilePath = this.planService.createPlanReport(webRootPath,this.getProjectId(), this.planInfo.getPlanCode(), StaticVar.REPORTTYPE_RTF);
			
			String projectPath = this.getReq().getRealPath("/");
			String savePath = projectPath + "attached" + File.separator + "commonUpload";
			PlanInfo planInfo = this.planService.queryPlanInfoByPlanCode(this.getPlanInfo().getPlanCode());
			SeProjectInfo projectInfo = this.seService.querySeProjectInfoById(projectId);
			PlanSummary summary = this.planService.queryPlanSummaryByPlanCodeAndProjectId(this.getPlanInfo().getPlanCode(), projectId);
			
			//删除当前周/月  的周月报
			SeAttach oldWeeklyDocAttach = this.commonService.queryAttachByKeyAndId(StaticVar.ATTACHKEY_PLANSUMMARY, summary.getId());
			if(oldWeeklyDocAttach != null){
				this.commonService.deleteCommonAttach(oldWeeklyDocAttach.getAttachId());
			}
			//String deleteResult = this.commonService.deleteAttachByKeyAndId(StaticVar.ATTACHKEY_PLANSUMMARY, summary.getId());
			
			//删除周报文档
			seService.deleteSeProjectDocByAttachId(oldWeeklyDocAttach.getAttachId());
			
			//上传附件
			String fileName = projectInfo.getProName() + "周报-" + planInfo.getPlanYear() + planInfo.getPlanMonth() + planInfo.getPlanWeek()  + ".rtf";
			SeAttach attach = this.commonService.uploadFile(new File(reportFilePath),savePath, fileName,  "PLAN_SUMMARY", summary.getId());
			
			
			
			//项目周报文档
			SeProjectDoc doc = new SeProjectDoc();
			doc.setDocCode("PROJECT_WEEKLY");
			doc.setDocDesc("项目周报" +  MyDateUtils.toString(planInfo.getStartDate()) + "-" + MyDateUtils.toString(planInfo.getFinishDate()));
			doc.setDocName("项目周报" +  MyDateUtils.toString(planInfo.getStartDate()) + "-" + MyDateUtils.toString(planInfo.getFinishDate()));
			doc.setDocVersoin("1.0");
			doc.setProjectId(projectId);
			doc.setUploader(lui.getUserId());
			doc.setAttachId(attach.getAttachId());
			doc.setUploadTime(new Date());
			seService.saveSeProjectDoc(doc);
			*/
			this.setUrl("/common/common!commondownload.do?id=" + planDocAttachId);
			
			return "msg";
			
			
			/*planInfo = planService.queryPlanInfoByPlanCode(planInfo.getPlanCode());
			String planClassifyStr = "";
			if(StaticVar.PLAN_MONTH.equals(planInfo.getPlanClassify())){
				planClassifyStr = "月";
			}else if(StaticVar.PLAN_WEEK.equals(planInfo.getPlanClassify())){
				planClassifyStr = "周";
			}
			
			this.getRequest().put("planClassifyStr",planClassifyStr);
			
			//日志查询使用,起始日期
			String blQueryStartDate = MyDateUtils.toString(planInfo.getStartDate());
			String blQueryFinishDate =MyDateUtils.toString(planInfo.getFinishDate());
			
			this.getRequest().put("blQueryStartDate",blQueryStartDate);
			this.getRequest().put("blQueryFinishDate",blQueryFinishDate);
			
			//List userList = this.commonService.queryUserForOption();
			//this.getRequest().put("userList", userList);
			
			SeProjectInfo projectInfo = this.seService.querySeProjectInfoById(this.getProjectId());
			this.getRequest().put("projectInfo", projectInfo);

			Map m = new HashMap();
			m.put("logDateL", blQueryStartDate);
			m.put("logDateH", blQueryFinishDate);
			m.put("projectId", this.getProjectId());
			
			PlanInfo prevPlanInfo = planService.queryPrevPlanInfo(planInfo.getPlanCode());
			this.getRequest().put("prevPlanInfo", prevPlanInfo);
			
			DataTableBean planList = planService.queryPlanList(null,planInfo.getPlanCode(),projectId);
			this.getRequest().put("planList", planList);
			
			List taskList = this.seService.seCountTaskGetData(m);
			this.getRequest().put("taskList", taskList);
			
			List workLoadList = this.seService.seCountWorkLoadGetData(m);
			this.getRequest().put("workLoadList", workLoadList);
			
			
			this.getLog().info(this.getForwardPage());
			return this.SUCCESS;*/
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
		
	}
	
	/**
	 * 编辑计划任务
	 * url:/plan/plan!updatePlanExecution.do
	 */
	public String updatePlanExecution(){
		try{
			this.logger.info("planTaskDetail()");
			this.setForwardPage("/pages/plan/planTaskDetail.jsp");
			this.planService.updatePlanExecution(planExecution);
			this.setUrl("plan/plan!planTaskDetail.do?id=" + planExecution.getId());
			return "msg";
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	/**
	 * 更新计划条目的进度
	 * url:/plan/plan!updateProgressOfExecution.do
	 */
	public String updateProgressOfExecution(){
		try{
			this.logger.info("updateProgressOfExecution()");
			this.setForwardPage("/pages/plan/updateProgressOfExecution.jsp");
			String r = this.planService.updateProgressOfExecution(planExecution.getId(),planExecution.getFinishProgress());
			this.setMsg(r);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	
	
	/**
	 * 删除计划任务
	 * url:/plan/plan!removeTaskFromExecution.do
	 */
	public String removeTaskFromExecution(){
		try{
			this.logger.info("removeTaskFromExecution()");
			this.planService.removeTaskFromExecution(this.planExecution.getId());
			this.setMsg(StaticVar.STATUS_SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.toString());
			return this.err(e);
		}
		return "ajax";
	}	
	
	

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getWeek() {
		return week;
	}

	public void setWeek(int week) {
		this.week = week;
	}

	public PlanInfo getPlanInfo() {
		return planInfo;
	}

	public void setPlanInfo(PlanInfo planInfo) {
		this.planInfo = planInfo;
	}

	public PlanItem getPlanItem() {
		return planItem;
	}

	public void setPlanItem(PlanItem planItem) {
		this.planItem = planItem;
	}

	public PlanExecution getPlanExecution() {
		return planExecution;
	}

	public void setPlanExecution(PlanExecution planExecution) {
		this.planExecution = planExecution;
	}
	public String getAcceptJson() {
		return acceptJson;
	}
	public void setAcceptJson(String acceptJson) {
		this.acceptJson = acceptJson;
	}
	public PlanExecutionItem getPlanExecutionItem() {
		return planExecutionItem;
	}
	public void setPlanExecutionItem(PlanExecutionItem planExecutionItem) {
		this.planExecutionItem = planExecutionItem;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public PlanSummary getPlanSummary() {
		return planSummary;
	}
	public void setPlanSummary(PlanSummary planSummary) {
		this.planSummary = planSummary;
	}
	
}
