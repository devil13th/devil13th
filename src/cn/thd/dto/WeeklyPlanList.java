/** 
 * Class Description:########
 * Date : 2017年8月18日 下午3:16:05
 * Auth : wanglei 
*/  

package cn.thd.dto;

public class WeeklyPlanList {
	private String workName;
	private String beginDate;
	private String finishDate;
	private String traceName;
	private String planProgress;
	public String getWorkName() {
		return workName;
	}
	public void setWorkName(String workName) {
		this.workName = workName;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getTraceName() {
		return traceName;
	}
	public void setTraceName(String traceName) {
		this.traceName = traceName;
	}
	public String getFinishDate() {
		return finishDate;
	}
	public void setFinishDate(String finishDate) {
		this.finishDate = finishDate;
	}
	public String getPlanProgress() {
		return planProgress;
	}
	public void setPlanProgress(String planProgress) {
		this.planProgress = planProgress;
	}
	
}
