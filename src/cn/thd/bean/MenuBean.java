/** 
 * Class Description:########
 * Date : 2017年7月21日 上午10:07:03
 * Auth : wanglei 
*/  

package cn.thd.bean;

import java.util.List;

public class MenuBean {
	private String name;
	private String nameEn;
	private String url;
	private String openType;
	private String treeCode;
	private String ico;
	private List<MenuBean> childs;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getTreeCode() {
		return treeCode;
	}
	public void setTreeCode(String treeCode) {
		this.treeCode = treeCode;
	}
	public String getOpenType() {
		return openType;
	}
	public void setOpenType(String openType) {
		this.openType = openType;
	}
	public String getIco() {
		return ico;
	}
	public void setIco(String ico) {
		this.ico = ico;
	}
	public List<MenuBean> getChilds() {
		return childs;
	}
	public void setChilds(List<MenuBean> childs) {
		this.childs = childs;
	}
	public String getNameEn() {
		return nameEn;
	}
	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}
}
