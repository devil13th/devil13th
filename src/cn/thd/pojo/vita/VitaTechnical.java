package cn.thd.pojo.vita;

import java.util.Date;

/**
 * cn.thd.pojo.vita.VitaTechnical entity. 
 * file autogenerated by ThirdteenDevils's CodeGenUtil
 */

public class VitaTechnical implements java.io.Serializable {
	//PK   
	private java.lang.String tecId;
	// 
	private java.lang.String vitaId;
	// 
	private java.lang.String tecName;
	// 
	private java.util.Date beginTime;
	// 
	private java.lang.String proficiency;
	// 
	private java.lang.String isValid;
	// 
	private java.util.Date createTime;
	
	public void setTecId(java.lang.String tecId){
		this.tecId = tecId;
	}
	public java.lang.String getTecId(){
		return this.tecId;
	}
	public void setVitaId(java.lang.String vitaId){
		this.vitaId = vitaId;
	}
	public java.lang.String getVitaId(){
		return this.vitaId;
	}
	public void setTecName(java.lang.String tecName){
		this.tecName = tecName;
	}
	public java.lang.String getTecName(){
		return this.tecName;
	}
	public void setBeginTime(java.util.Date beginTime){
		this.beginTime = beginTime;
	}
	public java.util.Date getBeginTime(){
		return this.beginTime;
	}
	public void setProficiency(java.lang.String proficiency){
		this.proficiency = proficiency;
	}
	public java.lang.String getProficiency(){
		return this.proficiency;
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