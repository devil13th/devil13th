package cn.thd.pojo.vita;

import java.util.Date;

/**
 * cn.thd.pojo.vita.VitaEduHis entity. 
 * file autogenerated by ThirdteenDevils's CodeGenUtil
 */

public class VitaEduHis implements java.io.Serializable {
	//PK   
	private java.lang.String eduHisId;
	// 
	private java.lang.String vitaId;
	// 
	private java.lang.String schoolName;
	// 
	private java.util.Date beginDate;
	// 
	private java.util.Date finishDate;
	// 
	private java.lang.String eduLevel;
	// 
	private java.lang.String isValid;
	// 
	private java.util.Date createTime;
	
	public void setEduHisId(java.lang.String eduHisId){
		this.eduHisId = eduHisId;
	}
	public java.lang.String getEduHisId(){
		return this.eduHisId;
	}
	public void setVitaId(java.lang.String vitaId){
		this.vitaId = vitaId;
	}
	public java.lang.String getVitaId(){
		return this.vitaId;
	}
	public void setSchoolName(java.lang.String schoolName){
		this.schoolName = schoolName;
	}
	public java.lang.String getSchoolName(){
		return this.schoolName;
	}
	public void setBeginDate(java.util.Date beginDate){
		this.beginDate = beginDate;
	}
	public java.util.Date getBeginDate(){
		return this.beginDate;
	}
	public void setFinishDate(java.util.Date finishDate){
		this.finishDate = finishDate;
	}
	public java.util.Date getFinishDate(){
		return this.finishDate;
	}
	public void setEduLevel(java.lang.String eduLevel){
		this.eduLevel = eduLevel;
	}
	public java.lang.String getEduLevel(){
		return this.eduLevel;
	}
	public void setIsValid(java.lang.String isValid){
		this.isValid = isValid;
	}
	public java.lang.String getIsValid(){
		return this.isValid;
	}
	public void setCreateTime(java.util.Date createTime){
		this.createTime = createTime;
	}
	public java.util.Date getCreateTime(){
		return this.createTime;
	}
	
	

}