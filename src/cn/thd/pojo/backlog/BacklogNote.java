package cn.thd.pojo.backlog;

import java.util.Date;

/**
 * BacklogInfo entity. @author MyEclipse Persistence Tools
 */

public class BacklogNote implements java.io.Serializable {


	private String blId;
	private String blNote;
	public String getBlId() {
		return blId;
	}
	public void setBlId(String blId) {
		this.blId = blId;
	}
	public String getBlNote() {
		return blNote;
	}
	public void setBlNote(String blNote) {
		this.blNote = blNote;
	}

}