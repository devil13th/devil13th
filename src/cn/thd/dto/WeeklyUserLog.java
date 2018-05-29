/** 
 * Class Description:########
 * Date : 2017年8月18日 下午2:01:08
 * Auth : wanglei 
*/  

package cn.thd.dto;

public class WeeklyUserLog {
	private String userName;
	private String date;
	private String plogDate;
	private String plogWorkload;
	private String plogRemark;
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getPlogDate() {
		return plogDate;
	}
	public void setPlogDate(String plogDate) {
		this.plogDate = plogDate;
	}
	public String getPlogWorkload() {
		return plogWorkload;
	}
	public void setPlogWorkload(String plogWorkload) {
		this.plogWorkload = plogWorkload;
	}
	public String getPlogRemark() {
		return plogRemark;
	}
	public void setPlogRemark(String plogRemark) {
		this.plogRemark = plogRemark;
	}
	
}
