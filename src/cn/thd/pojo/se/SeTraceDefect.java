package cn.thd.pojo.se;

import java.util.Date;

/**
 * cn.thd.pojo.se.SeTraceDefect entity. 
 * file autogenerated by ThirdteenDevils's CodeGenUtil
 */

public class SeTraceDefect implements java.io.Serializable {
	//PK  记录id 记录id
	private java.lang.String defectId;
	//矩阵id 矩阵id
	private java.lang.String traceId;
	//缺陷描述 缺陷描述
	private java.lang.String defectDesc;
	//截图 截图
	private java.lang.String defectPic;
	//缺陷分类 缺陷分类
	private java.lang.String defectClassify;
	//缺陷状态 缺陷状态
	private java.lang.String defectStatus;
	//开发人员 开发人员
	private java.lang.String developer;
	//测试人员 测试人员
	private java.lang.String testUser;
	//创建时间 创建时间
	private java.util.Date createTime;
	//更新时间 更新时间
	private java.util.Date updateTime;
	//是否删除
	private java.lang.String isDelete;
	
	public void setDefectId(java.lang.String defectId){
		this.defectId = defectId;
	}
	public java.lang.String getDefectId(){
		return this.defectId;
	}
	public void setTraceId(java.lang.String traceId){
		this.traceId = traceId;
	}
	public java.lang.String getTraceId(){
		return this.traceId;
	}
	public void setDefectDesc(java.lang.String defectDesc){
		this.defectDesc = defectDesc;
	}
	public java.lang.String getDefectDesc(){
		return this.defectDesc;
	}
	public void setDefectPic(java.lang.String defectPic){
		this.defectPic = defectPic;
	}
	public java.lang.String getDefectPic(){
		return this.defectPic;
	}
	public void setDefectClassify(java.lang.String defectClassify){
		this.defectClassify = defectClassify;
	}
	public java.lang.String getDefectClassify(){
		return this.defectClassify;
	}
	public void setDefectStatus(java.lang.String defectStatus){
		this.defectStatus = defectStatus;
	}
	public java.lang.String getDefectStatus(){
		return this.defectStatus;
	}
	public void setDeveloper(java.lang.String developer){
		this.developer = developer;
	}
	public java.lang.String getDeveloper(){
		return this.developer;
	}
	public void setTestUser(java.lang.String testUser){
		this.testUser = testUser;
	}
	public java.lang.String getTestUser(){
		return this.testUser;
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
	public java.lang.String getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(java.lang.String isDelete) {
		this.isDelete = isDelete;
	}
	
	

}