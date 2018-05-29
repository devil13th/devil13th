package cn.thd.pojo.se;

import java.util.Date;

/**
 * cn.thd.pojo.se.SeTraceTask entity. 
 * file autogenerated by ThirdteenDevils's CodeGenUtil
 */

public class SeTraceTask implements java.io.Serializable {
	//PK  任务ID 任务ID
	private java.lang.String taskId;
	//矩阵ID 矩阵ID
	private java.lang.String traceId;
	//开始日期 开始日期
	private java.util.Date beginDate;
	//结束日期 结束日期
	private java.util.Date finishDate;
	//工作量 工作量
	private java.lang.Double workLoad;
	//标题 标题
	private java.lang.String taskTitle;
	//要求 要求
	private java.lang.String taskRequire;
	//状态 状态
	private java.lang.String taskStatus;
	
	//当前进度
	private java.lang.Integer currentProcess;
	//执行人-冗余
	private java.lang.String operator;	
	//实际开始日期
	private java.util.Date actBeginDate;
	//实际结束日期
	private java.util.Date actFinishDate;
	//执行备注
	private java.lang.String execNote;
	public void setTaskId(java.lang.String taskId){
		this.taskId = taskId;
	}
	public java.lang.String getTaskId(){
		return this.taskId;
	}
	public void setTraceId(java.lang.String traceId){
		this.traceId = traceId;
	}
	public java.lang.String getTraceId(){
		return this.traceId;
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
	public void setWorkLoad(java.lang.Double workLoad){
		this.workLoad = workLoad;
	}
	public java.lang.Double getWorkLoad(){
		return this.workLoad;
	}
	public void setTaskTitle(java.lang.String taskTitle){
		this.taskTitle = taskTitle;
	}
	public java.lang.String getTaskTitle(){
		return this.taskTitle;
	}
	public void setTaskRequire(java.lang.String taskRequire){
		this.taskRequire = taskRequire;
	}
	public java.lang.String getTaskRequire(){
		return this.taskRequire;
	}
	public void setTaskStatus(java.lang.String taskStatus){
		this.taskStatus = taskStatus;
	}
	public java.lang.String getTaskStatus(){
		return this.taskStatus;
	}
	public java.lang.Integer getCurrentProcess() {
		return currentProcess;
	}
	public void setCurrentProcess(java.lang.Integer currentProcess) {
		this.currentProcess = currentProcess;
	}
	public java.lang.String getOperator() {
		return operator;
	}
	public void setOperator(java.lang.String operator) {
		this.operator = operator;
	}
	public java.util.Date getActBeginDate() {
		return actBeginDate;
	}
	public void setActBeginDate(java.util.Date actBeginDate) {
		this.actBeginDate = actBeginDate;
	}
	
	public java.util.Date getActFinishDate() {
		return actFinishDate;
	}
	public void setActFinishDate(java.util.Date actFinishDate) {
		this.actFinishDate = actFinishDate;
	}
	public java.lang.String getExecNote() {
		return execNote;
	}
	public void setExecNote(java.lang.String execNote) {
		this.execNote = execNote;
	}
	
	

}