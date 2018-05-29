/** 
 * Class Description:########
 * Date : 2017年5月28日 上午8:42:46
 * Auth : wanglei 
*/  

package cn.thd.bean;

import java.util.List;
import java.util.Map;
/**
 * 
 * @author wanglei
 *	该类属性中以i开头的为输入参数 以o开头的为输出参数
 */
public class ProcessStartInfo {
	// ======== 输入参数
	
	//工作控制号标记(取号用)
	private String iJobnoKey;
	//流程定义key(用于启动流程)
	private String iProcKey;
	//流程变量
	private Map<String,Object> iProcVar;
	//流程启动人
	private String iStartUser;
	
	// ======== 输出参数
	//工作控制号
	private String oJobno;
	//任务id
	private String oTaskId;
	//流程实例id
	private String procInsId;
	public String getiJobnoKey() {
		return iJobnoKey;
	}
	public void setiJobnoKey(String iJobnoKey) {
		this.iJobnoKey = iJobnoKey;
	}
	public String getiProcKey() {
		return iProcKey;
	}
	public void setiProcKey(String iProcKey) {
		this.iProcKey = iProcKey;
	}
	public Map<String, Object> getiProcVar() {
		return iProcVar;
	}
	public void setiProcVar(Map<String, Object> iProcVar) {
		this.iProcVar = iProcVar;
	}
	public String getiStartUser() {
		return iStartUser;
	}
	public void setiStartUser(String iStartUser) {
		this.iStartUser = iStartUser;
	}
	public String getoJobno() {
		return oJobno;
	}
	public void setoJobno(String oJobno) {
		this.oJobno = oJobno;
	}
	public String getoTaskId() {
		return oTaskId;
	}
	public void setoTaskId(String oTaskId) {
		this.oTaskId = oTaskId;
	}
	public String getProcInsId() {
		return procInsId;
	}
	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	
	
	
	
	
	
}
