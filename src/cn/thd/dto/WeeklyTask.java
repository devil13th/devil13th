/** 
 * Class Description:########
 * Date : 2017年8月18日 下午2:57:38
 * Auth : wanglei 
*/  

package cn.thd.dto;

public class WeeklyTask {
	private String taskTitle;
	private String progress;
	private String beginDate;
	private String finishDate;
	public String getTaskTitle() {
		return taskTitle;
	}
	public void setTaskTitle(String taskTitle) {
		this.taskTitle = taskTitle;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public String getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}
	public String getFinishDate() {
		return finishDate;
	}
	public void setFinishDate(String finishDate) {
		this.finishDate = finishDate;
	}
	
}
