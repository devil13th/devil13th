package cn.thd.pojo.process;

import java.util.Date;

/**
 * cn.thd.pojo.se.SeWorkList entity. 
 * file autogenerated by ThirdteenDevils's CodeGenUtil
 */

public class SeWorkList implements java.io.Serializable {
	//PK   
	private java.lang.String jobno;
	private java.lang.String procInsId;

	// 
	private java.lang.String workType;
	// 
	private java.lang.String workName;
	// 
	private java.lang.String startUser;
	// 
	private java.util.Date startTime;
	// 
	private java.lang.String currentStep;
	// 
	private java.lang.String jobStatus;
	// 
	private java.lang.String isDelete;
	// 
	private java.util.Date createTime;
	// 
	private java.util.Date updateTime;
	private java.lang.String projectId;
	
	public void setJobno(java.lang.String jobno){
		this.jobno = jobno;
	}
	public java.lang.String getJobno(){
		return this.jobno;
	}
	public void setWorkType(java.lang.String workType){
		this.workType = workType;
	}
	public java.lang.String getWorkType(){
		return this.workType;
	}
	public void setWorkName(java.lang.String workName){
		this.workName = workName;
	}
	public java.lang.String getWorkName(){
		return this.workName;
	}
	public void setStartUser(java.lang.String startUser){
		this.startUser = startUser;
	}
	public java.lang.String getStartUser(){
		return this.startUser;
	}
	public void setStartTime(java.util.Date startTime){
		this.startTime = startTime;
	}
	public java.util.Date getStartTime(){
		return this.startTime;
	}
	public void setCurrentStep(java.lang.String currentStep){
		this.currentStep = currentStep;
	}
	public java.lang.String getCurrentStep(){
		return this.currentStep;
	}
	public void setJobStatus(java.lang.String jobStatus){
		this.jobStatus = jobStatus;
	}
	public java.lang.String getJobStatus(){
		return this.jobStatus;
	}
	public void setIsDelete(java.lang.String isDelete){
		this.isDelete = isDelete;
	}
	public java.lang.String getIsDelete(){
		return this.isDelete;
	}
	public void setCreateTime(java.util.Date createTime){
		this.createTime = createTime;
	}
	public java.util.Date getCreateTime(){
		return this.createTime;
	}
	public void setUpdateTime(java.util.Date updateTime){
		this.updateTime = updateTime;
	}
	public java.util.Date getUpdateTime(){
		return this.updateTime;
	}
	public java.lang.String getProcInsId() {
		return procInsId;
	}
	public void setProcInsId(java.lang.String procInsId) {
		this.procInsId = procInsId;
	}
	public java.lang.String getProjectId() {
		return projectId;
	}
	public void setProjectId(java.lang.String projectId) {
		this.projectId = projectId;
	}
	
	

}