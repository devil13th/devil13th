package cn.thd.pojo.se;

import java.util.Date;

/**
 * cn.thd.pojo.se.SeProjectDoc entity. 
 * file autogenerated by ThirdteenDevils's CodeGenUtil
 */

public class SeProjectDoc implements java.io.Serializable {
	//PK  文档ID 文档ID
	private java.lang.String docId;
	//项目ID 项目ID
	private java.lang.String projectId;
	//文档名称 文档名称
	private java.lang.String docName;
	//标准文档CODE 标准文档CODE
	private java.lang.String docCode;
	//附件ID 附件ID
	private java.lang.String attachId;
	//版本 版本
	private java.lang.String docVersoin;
	//文档说明 文档说明
	private java.lang.String docDesc;
	//上传人 上传人
	private java.lang.String uploader;
	//上传时间 上传时间
	private java.util.Date uploadTime;
	//是否删除 是否删除
	private java.lang.String isDelete;
	
	public void setDocId(java.lang.String docId){
		this.docId = docId;
	}
	public java.lang.String getDocId(){
		return this.docId;
	}
	public void setProjectId(java.lang.String projectId){
		this.projectId = projectId;
	}
	public java.lang.String getProjectId(){
		return this.projectId;
	}
	public void setDocName(java.lang.String docName){
		this.docName = docName;
	}
	public java.lang.String getDocName(){
		return this.docName;
	}
	public void setDocCode(java.lang.String docCode){
		this.docCode = docCode;
	}
	public java.lang.String getDocCode(){
		return this.docCode;
	}
	
	public java.lang.String getAttachId() {
		return attachId;
	}
	public void setAttachId(java.lang.String attachId) {
		this.attachId = attachId;
	}
	public void setDocVersoin(java.lang.String docVersoin){
		this.docVersoin = docVersoin;
	}
	public java.lang.String getDocVersoin(){
		return this.docVersoin;
	}
	public void setDocDesc(java.lang.String docDesc){
		this.docDesc = docDesc;
	}
	public java.lang.String getDocDesc(){
		return this.docDesc;
	}
	public void setUploader(java.lang.String uploader){
		this.uploader = uploader;
	}
	public java.lang.String getUploader(){
		return this.uploader;
	}
	public void setUploadTime(java.util.Date uploadTime){
		this.uploadTime = uploadTime;
	}
	public java.util.Date getUploadTime(){
		return this.uploadTime;
	}
	public void setIsDelete(java.lang.String isDelete){
		this.isDelete = isDelete;
	}
	public java.lang.String getIsDelete(){
		return this.isDelete;
	}
	
	

}