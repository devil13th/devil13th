/** 
 * Class Description:########
 * Date : 2017年1月24日 下午5:03:45
 * Auth : wanglei 
*/  

package cn.thd.dto;

import java.util.Date;

public class Plan {
	private String year;
	private String month;
	private String week;
	private Date firstDate;
	private Date lastDate;
	private String planCode;
	private String planClassify;
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	
	public Date getFirstDate() {
		return firstDate;
	}
	public void setFirstDate(Date firstDate) {
		this.firstDate = firstDate;
	}
	public Date getLastDate() {
		return lastDate;
	}
	public void setLastDate(Date lastDate) {
		this.lastDate = lastDate;
	}
	public String getPlanCode() {
		return planCode;
	}
	public void setPlanCode(String planCode) {
		this.planCode = planCode;
	}
	public String getPlanClassify() {
		return planClassify;
	}
	public void setPlanClassify(String planClassify) {
		this.planClassify = planClassify;
	}
	
}
