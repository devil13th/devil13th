package cn.thd.pojo.backlog;

import java.util.Date;

/**
 * BacklogInfo entity. @author MyEclipse Persistence Tools
 */

public class BacklogDeal implements java.io.Serializable {

	// Fields

	private String blId;
	private String rId;
	private Date dealDate;

	/** default constructor */
	public BacklogDeal() {
	}

	public String getBlId() {
		return blId;
	}

	public void setBlId(String blId) {
		this.blId = blId;
	}

	public String getrId() {
		return rId;
	}

	public void setrId(String rId) {
		this.rId = rId;
	}

	public Date getDealDate() {
		return dealDate;
	}

	public void setDealDate(Date dealDate) {
		this.dealDate = dealDate;
	}


}