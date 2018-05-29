/** 
 * Class Description:########
 * Date : 2017年2月20日 下午5:03:49
 * Auth : wanglei 
*/  

package cn.thd.dto;

public class PlanExecutionItem {
	private String taskId;
	private String planTitle;
	private String planStartDate;
	private String planFinishDate;
	private Integer currentProcess;
	private Integer finishProcess;
	private Integer planProcess;
	private String planCode;
	private String remark;
	public String getPlanTitle() {
		return planTitle;
	}
	public void setPlanTitle(String planTitle) {
		this.planTitle = planTitle;
	}
	public String getPlanStartDate() {
		return planStartDate;
	}
	public void setPlanStartDate(String planStartDate) {
		this.planStartDate = planStartDate;
	}
	public String getPlanFinishDate() {
		return planFinishDate;
	}
	public void setPlanFinishDate(String planFinishDate) {
		this.planFinishDate = planFinishDate;
	}
	public Integer getCurrentProcess() {
		return currentProcess;
	}
	public void setCurrentProcess(Integer currentProcess) {
		this.currentProcess = currentProcess;
	}
	public Integer getFinishProcess() {
		return finishProcess;
	}
	public void setFinishProcess(Integer finishProcess) {
		this.finishProcess = finishProcess;
	}
	public Integer getPlanProcess() {
		return planProcess;
	}
	public void setPlanProcess(Integer planProcess) {
		this.planProcess = planProcess;
	}
	public String getPlanCode() {
		return planCode;
	}
	public void setPlanCode(String planCode) {
		this.planCode = planCode;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getTaskId() {
		return taskId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
}
