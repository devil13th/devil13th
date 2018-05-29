/** 
 * Class Description:########
 * Date : 2017年12月20日 下午6:20:20
 * Auth : ccse 
*/  

package cn.thd.bean;

import java.util.Map;

public class ProcessNextStepBean {
	private String jobno;
	private String stepCode;
	private String taskId;
	private String claimUser;
	private Map procVar;
	public String getJobno() {
		return jobno;
	}
	public void setJobno(String jobno) {
		this.jobno = jobno;
	}
	public String getStepCode() {
		return stepCode;
	}
	public void setStepCode(String stepCode) {
		this.stepCode = stepCode;
	}
	public String getTaskId() {
		return taskId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	public String getClaimUser() {
		return claimUser;
	}
	public void setClaimUser(String claimUser) {
		this.claimUser = claimUser;
	}
	public Map getProcVar() {
		return procVar;
	}
	public void setProcVar(Map procVar) {
		this.procVar = procVar;
	}
}
