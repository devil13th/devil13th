package cn.thd.pojo.backlog;

import java.util.Date;

/**
 * BacklogInfo entity. @author MyEclipse Persistence Tools
 */

public class BacklogInfo implements java.io.Serializable {

	// Fields

	private String blId;
	private String blContent;
	private Integer blLevel;
	private Date startDate;
	private Date fnshDate;
	private Date expireDate;
	private String blClassify;
	private String blStatus;
	private String blMes;
	private String blDes;
	private String blIssueUser;
	private String blExeUser;
	private Integer alarmDays;
	private Date createDate;
	private String blSys;
	// Constructors

	/** default constructor */
	public BacklogInfo() {
	}


	// Property accessors

	public String getBlId() {
		return this.blId;
	}

	public void setBlId(String blId) {
		this.blId = blId;
	}

	public String getBlContent() {
		return this.blContent;
	}

	public void setBlContent(String blContent) {
		this.blContent = blContent;
	}

	public Integer getBlLevel() {
		return this.blLevel;
	}

	public void setBlLevel(Integer blLevel) {
		this.blLevel = blLevel;
	}

	public Date getStartDate() {
		return this.startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getFnshDate() {
		return this.fnshDate;
	}

	public void setFnshDate(Date fnshDate) {
		this.fnshDate = fnshDate;
	}

	public Date getExpireDate() {
		return this.expireDate;
	}

	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}

	public String getBlClassify() {
		return blClassify;
	}


	public void setBlClassify(String blClassify) {
		this.blClassify = blClassify;
	}


	public String getBlStatus() {
		return this.blStatus;
	}

	public void setBlStatus(String blStatus) {
		this.blStatus = blStatus;
	}

	public String getBlMes() {
		return this.blMes;
	}

	public void setBlMes(String blMes) {
		this.blMes = blMes;
	}

	public String getBlDes() {
		return this.blDes;
	}

	public void setBlDes(String blDes) {
		this.blDes = blDes;
	}

	public String getBlIssueUser() {
		return this.blIssueUser;
	}

	public void setBlIssueUser(String blIssueUser) {
		this.blIssueUser = blIssueUser;
	}

	public String getBlExeUser() {
		return this.blExeUser;
	}

	public void setBlExeUser(String blExeUser) {
		this.blExeUser = blExeUser;
	}

	public Integer getAlarmDays() {
		return this.alarmDays;
	}

	public void setAlarmDays(Integer alarmDays) {
		this.alarmDays = alarmDays;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public String getBlSys() {
		return blSys;
	}


	public void setBlSys(String blSys) {
		this.blSys = blSys;
	}

}