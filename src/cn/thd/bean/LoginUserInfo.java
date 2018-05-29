/** 
 * Class Description:########
 * Date : 2017年5月28日 上午1:37:02
 * Auth : wanglei 
*/  

package cn.thd.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.thd.pojo.se.SeUser;

public class LoginUserInfo {
	//账号
	private String account;
	//用户姓名
	private String userName;
	//用户角色
	private String userRole;
	//用户ID
	private String userId;
	//登录系统
	private String belongSys;
	//是否可查看统计数据  1:可查看  0：不可查看
	private String canReadCost;
	//用户信息  
	private SeUser seUser;
	
	//系统角色
	private List<String> sysRoles = new ArrayList<String>();
	//参与系统及系统角色信息
	//例如：{SSMIS-A6=[PROJECT-MANAGER], SSMIS-A4=[DEVELOPER, TESTER], SSMIS-EFORM=[DESIGNER, DEVELOPER]}
	private Map<String,List<String>> projects = new HashMap<String,List<String>>();
	
	
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	public String getBelongSys() {
		return belongSys;
	}
	public void setBelongSys(String belongSys) {
		this.belongSys = belongSys;
	}
	public String getCanReadCost() {
		return canReadCost;
	}
	public void setCanReadCost(String canReadCost) {
		this.canReadCost = canReadCost;
	}
	public SeUser getSeUser() {
		return seUser;
	}
	public void setSeUser(SeUser seUser) {
		this.seUser = seUser;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public List<String> getSysRoles() {
		return sysRoles;
	}
	public void setSysRoles(List<String> sysRoles) {
		this.sysRoles = sysRoles;
	}
	public Map<String,List<String>> getProjects() {
		return projects;
	}
	public void setProjects(Map<String,List<String>> projects) {
		this.projects = projects;
	}
}
