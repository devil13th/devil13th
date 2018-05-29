/** 
 * Class Description:########
 * Date : 2017年12月20日 下午6:35:06
 * Auth : ccse 
*/  

package cn.thd.bean;

import java.util.HashMap;
import java.util.Map;

public class ProcessCfgProcessBean {
	private String processName;
	private String processCode;
	private String processMethodObjectName;
	
	public String getProcessMethodObjectName() {
		return processMethodObjectName;
	}
	public void setProcessMethodObjectName(String processMethodObjectName) {
		this.processMethodObjectName = processMethodObjectName;
	}

	private Map<String,ProcessCfgStepBean> stepMap = new HashMap<String,ProcessCfgStepBean>();
	public void addStep(ProcessCfgStepBean pcsb){
		pcsb.setProcessBean(this);
		stepMap.put(pcsb.getStepCode(), pcsb);
	}
	public ProcessCfgStepBean getStep(String stepCode){
		return stepMap.get(stepCode);
	}
	public String getProcessCode() {
		return processCode;
	}

	public void setProcessCode(String processCode) {
		this.processCode = processCode;
	}

	public Map<String, ProcessCfgStepBean> getStepMap() {
		return stepMap;
	}

	public void setStepMap(Map<String, ProcessCfgStepBean> stepMap) {
		this.stepMap = stepMap;
	}

	public String getProcessName() {
		return processName;
	}
	
	public void setProcessName(String processName) {
		this.processName = processName;
	}

	public ProcessCfgProcessBean(String processCode,String processName) {
		super();
		this.processName = processName;
		this.processCode = processCode;
	}
	
	public ProcessCfgProcessBean(String processCode,String processName,String processMethodObjectName) {
		super();
		this.processName = processName;
		this.processCode = processCode;
		this.processMethodObjectName = processMethodObjectName;
	}
	
}
