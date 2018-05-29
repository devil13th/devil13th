/** 
 * Class Description:########
 * Date : 2017年8月18日 上午11:24:40
 * Auth : wanglei 
*/  

package cn.thd.dto;

import java.util.List;

import cn.thd.pojo.plan.PlanInfo;
import cn.thd.pojo.plan.PlanSummary;
import cn.thd.pojo.se.SeProjectInfo;

/**
 * 项目周报对象
 * @author wanglei
 *
 */
public class Weekly {
	//计划结束日期
	private String beginDate;
	//计划开始日期
	private String endDate;
	//项目成员
	private String projectMember;
	//填报日期
	private String reportDate;
	//项目信息
	private SeProjectInfo seProjectInfo;
	//项目计划
	private PlanSummary planSummary;
	//计划信息
	private PlanInfo planInfo;
	//日志列表
	private List logList;
	//本周工作列表
	private List taskList;
	//本周计划列表
	private List currentPlanList;
	//下周计划列表
	private List nextPlanList;
	//风险列表
	private List riskList;
	public SeProjectInfo getSeProjectInfo() {
		return seProjectInfo;
	}
	public void setSeProjectInfo(SeProjectInfo seProjectInfo) {
		this.seProjectInfo = seProjectInfo;
	}
	public PlanSummary getPlanSummary() {
		return planSummary;
	}
	public void setPlanSummary(PlanSummary planSummary) {
		this.planSummary = planSummary;
	}
	public PlanInfo getPlanInfo() {
		return planInfo;
	}
	public void setPlanInfo(PlanInfo planInfo) {
		this.planInfo = planInfo;
	}
	public List getLogList() {
		return logList;
	}
	public void setLogList(List logList) {
		this.logList = logList;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public List getTaskList() {
		return taskList;
	}
	public void setTaskList(List taskList) {
		this.taskList = taskList;
	}
	public List getCurrentPlanList() {
		return currentPlanList;
	}
	public void setCurrentPlanList(List currentPlanList) {
		this.currentPlanList = currentPlanList;
	}
	public List getNextPlanList() {
		return nextPlanList;
	}
	public void setNextPlanList(List nextPlanList) {
		this.nextPlanList = nextPlanList;
	}
	public List getRiskList() {
		return riskList;
	}
	public void setRiskList(List riskList) {
		this.riskList = riskList;
	}
	public String getProjectMember() {
		return projectMember;
	}
	public void setProjectMember(String projectMember) {
		this.projectMember = projectMember;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	
}
