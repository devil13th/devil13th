package cn.thd.dto;

import java.util.List;
import java.util.Map;
/**
 * 此类用于Ajax请求后返回的数据 
 */
public class DataTableBean  implements java.io.Serializable {
	private static final long serialVersionUID = -8110598292660842271L;
	
	/* 以下是公共属性 */
	private List data ;
	private int currentPage; //当前页数
	private int pageSize;//每页记录数量
	private int recordsTotal;  //总记录数
	
	private Map conditions;//查询条件
	
	/* 以下为datatables 用到的属性 */
	private int recordsFiltered;  //过滤后记录数
	private int draw = 0;  //请求次数
	
	
	
	
	
	
	
	
	
	public int getRecordsTotal() {
		return recordsTotal;
	}

	public void setRecordsTotal(int recordsTotal) {
		this.recordsTotal = recordsTotal;
	}

	public int getRecordsFiltered() {
		return recordsFiltered;
	}

	public void setRecordsFiltered(int recordsFiltered) {
		this.recordsFiltered = recordsFiltered;
	}

	public int getDraw() {
		return draw;
	}

	public void setDraw(int draw) {
		this.draw = draw;
	}

	public List getData() {
		return data;
	}

	public void setData(List data) {
		this.data = data;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public Map getConditions() {
		return conditions;
	}

	public void setConditions(Map conditions) {
		this.conditions = conditions;
	}

}
