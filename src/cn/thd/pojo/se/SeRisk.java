package cn.thd.pojo.se;

import java.util.Date;

/**
 * cn.thd.pojo.se.SeRisk entity. 
 * file autogenerated by ThirdteenDevils's CodeGenUtil
 */

public class SeRisk implements java.io.Serializable {
	//PK  风险ID 风险ID
	private java.lang.String riskId;
	//项目ID 项目ID
	private java.lang.String projectId;
	//识别日期 识别日期
	private java.util.Date identDate;
	//风险类别 风险类别
	private java.lang.String riskClassify;
	//风险描述 风险描述
	private java.lang.String riskContent;
	//概率 概率
	private java.lang.String riskProbability;
	//影响 影响
	private java.lang.String riskSway;
	//风险值 风险值
	private java.lang.Integer riskValue;
	//风险等级 风险等级
	private java.lang.String riskLevel;
	//优先级 优先级
	private java.lang.String riskPriority;
	//应对方式 应对方式
	private java.lang.String dealType;
	//应急预案 应急预案
	private java.lang.String emergencyPreplan;
	//责任人 责任人
	private java.lang.String personInCharge;
	//风险处理措施 风险处理措施
	private java.lang.String riskDealContent;
	//状态 状态
	private java.lang.String riskStatus;
	//监控人 监控人
	private java.lang.String monitor;
	//是否关闭 是否关闭
	private java.lang.String isClose;
	//关闭日期 关闭日期
	private java.util.Date closeDate;
	//是否删除
	private java.lang.String isDelete;
	
	public void setRiskId(java.lang.String riskId){
		this.riskId = riskId;
	}
	public java.lang.String getRiskId(){
		return this.riskId;
	}
	public void setProjectId(java.lang.String projectId){
		this.projectId = projectId;
	}
	public java.lang.String getProjectId(){
		return this.projectId;
	}
	public void setIdentDate(java.util.Date identDate){
		this.identDate = identDate;
	}
	public java.util.Date getIdentDate(){
		return this.identDate;
	}
	public void setRiskClassify(java.lang.String riskClassify){
		this.riskClassify = riskClassify;
	}
	public java.lang.String getRiskClassify(){
		return this.riskClassify;
	}
	public void setRiskContent(java.lang.String riskContent){
		this.riskContent = riskContent;
	}
	public java.lang.String getRiskContent(){
		return this.riskContent;
	}
	public void setRiskProbability(java.lang.String riskProbability){
		this.riskProbability = riskProbability;
	}
	public java.lang.String getRiskProbability(){
		return this.riskProbability;
	}
	public void setRiskSway(java.lang.String riskSway){
		this.riskSway = riskSway;
	}
	public java.lang.String getRiskSway(){
		return this.riskSway;
	}
	public void setRiskValue(java.lang.Integer riskValue){
		this.riskValue = riskValue;
	}
	public java.lang.Integer getRiskValue(){
		return this.riskValue;
	}
	public void setRiskLevel(java.lang.String riskLevel){
		this.riskLevel = riskLevel;
	}
	public java.lang.String getRiskLevel(){
		return this.riskLevel;
	}
	public void setRiskPriority(java.lang.String riskPriority){
		this.riskPriority = riskPriority;
	}
	public java.lang.String getRiskPriority(){
		return this.riskPriority;
	}
	public void setDealType(java.lang.String dealType){
		this.dealType = dealType;
	}
	public java.lang.String getDealType(){
		return this.dealType;
	}
	public void setEmergencyPreplan(java.lang.String emergencyPreplan){
		this.emergencyPreplan = emergencyPreplan;
	}
	public java.lang.String getEmergencyPreplan(){
		return this.emergencyPreplan;
	}
	public void setPersonInCharge(java.lang.String personInCharge){
		this.personInCharge = personInCharge;
	}
	public java.lang.String getPersonInCharge(){
		return this.personInCharge;
	}
	public void setRiskDealContent(java.lang.String riskDealContent){
		this.riskDealContent = riskDealContent;
	}
	public java.lang.String getRiskDealContent(){
		return this.riskDealContent;
	}
	public void setRiskStatus(java.lang.String riskStatus){
		this.riskStatus = riskStatus;
	}
	public java.lang.String getRiskStatus(){
		return this.riskStatus;
	}
	public void setMonitor(java.lang.String monitor){
		this.monitor = monitor;
	}
	public java.lang.String getMonitor(){
		return this.monitor;
	}
	public void setIsClose(java.lang.String isClose){
		this.isClose = isClose;
	}
	public java.lang.String getIsClose(){
		return this.isClose;
	}
	public void setCloseDate(java.util.Date closeDate){
		this.closeDate = closeDate;
	}
	public java.util.Date getCloseDate(){
		return this.closeDate;
	}
	public java.lang.String getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(java.lang.String isDelete) {
		this.isDelete = isDelete;
	}
	
	

}