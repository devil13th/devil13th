package cn.thd.pojo.se;

import java.util.Date;

/**
 * cn.thd.pojo.se.SeDayPlan entity. 
 * file autogenerated by ThirdteenDevils's CodeGenUtil
 */

public class SeDayPlan implements java.io.Serializable {
	//PK  主键 主键
	private java.lang.String dayPlanId;
	//日计划内容 日计划内容
	private java.lang.String planContent;
	//所属人员 所属人员
	private java.lang.String userId;
	//所属日期 所属日期
	private java.util.Date planDate;
	//备注 备注
	private java.lang.String planRemark;
	//状态 状态
	private java.lang.String status;
	//是否删除 是否删除
	private java.lang.String isDelete;
	
	public void setDayPlanId(java.lang.String dayPlanId){
		this.dayPlanId = dayPlanId;
	}
	public java.lang.String getDayPlanId(){
		return this.dayPlanId;
	}
	public void setPlanContent(java.lang.String planContent){
		this.planContent = planContent;
	}
	public java.lang.String getPlanContent(){
		return this.planContent;
	}
	public void setUserId(java.lang.String userId){
		this.userId = userId;
	}
	public java.lang.String getUserId(){
		return this.userId;
	}
	public void setPlanDate(java.util.Date planDate){
		this.planDate = planDate;
	}
	public java.util.Date getPlanDate(){
		return this.planDate;
	}
	public void setPlanRemark(java.lang.String planRemark){
		this.planRemark = planRemark;
	}
	public java.lang.String getPlanRemark(){
		return this.planRemark;
	}
	public void setStatus(java.lang.String status){
		this.status = status;
	}
	public java.lang.String getStatus(){
		return this.status;
	}
	public void setIsDelete(java.lang.String isDelete){
		this.isDelete = isDelete;
	}
	public java.lang.String getIsDelete(){
		return this.isDelete;
	}
	
	

}