package cn.thd.pojo.se;

import java.util.Date;

/**
 * cn.thd.pojo.se.SeDayNote entity. 
 * file autogenerated by ThirdteenDevils's CodeGenUtil
 */

public class SeDayNote implements java.io.Serializable {
	//PK  日记id 日记id
	private java.lang.String noteId;
	//项目id 项目id
	private java.lang.String projectId;
	//记事类型 记事类型
	private java.lang.String noteType;
	//日记日期 日记日期
	private java.util.Date noteDate;
	//日记标题 日记标题
	private java.lang.String noteTitle;
	//日记内容 日记内容
	private java.lang.String noteContent;
	//是否有效 是否有效
	private java.lang.String isValid;
	//是否删除 是否删除 
	private java.lang.String isDelete;
	//创建时间 创建时间
	private java.util.Date createTime;
	//修改时间 修改时间
	private java.util.Date updateTime;
	
	public void setNoteId(java.lang.String noteId){
		this.noteId = noteId;
	}
	public java.lang.String getNoteId(){
		return this.noteId;
	}
	public void setProjectId(java.lang.String projectId){
		this.projectId = projectId;
	}
	public java.lang.String getProjectId(){
		return this.projectId;
	}
	public void setNoteDate(java.util.Date noteDate){
		this.noteDate = noteDate;
	}
	public java.util.Date getNoteDate(){
		return this.noteDate;
	}
	public void setNoteTitle(java.lang.String noteTitle){
		this.noteTitle = noteTitle;
	}
	public java.lang.String getNoteTitle(){
		return this.noteTitle;
	}
	public void setNoteContent(java.lang.String noteContent){
		this.noteContent = noteContent;
	}
	public java.lang.String getNoteContent(){
		return this.noteContent;
	}
	public void setIsValid(java.lang.String isValid){
		this.isValid = isValid;
	}
	public java.lang.String getIsValid(){
		return this.isValid;
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
	public java.lang.String getNoteType() {
		return noteType;
	}
	public void setNoteType(java.lang.String noteType) {
		this.noteType = noteType;
	}
	
	

}