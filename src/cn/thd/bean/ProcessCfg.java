/** 
 * Class Description:########
 * Date : 2017年12月20日 下午6:30:14
 * Auth : ccse 
*/  

package cn.thd.bean;

import java.util.HashMap;
import java.util.Map;

public class ProcessCfg {
	private static ProcessCfg instance;
	private Map<String,ProcessCfgProcessBean> map;
	
	private ProcessCfg(){
		System.out.println("ProcessCfg  初始化");
		map = new HashMap<String,ProcessCfgProcessBean>();
		
		// ------------------------------------------------------------------------ //
		
		ProcessCfgProcessBean pcpbTaskProcess = new ProcessCfgProcessBean(ProcessStaticVar.TASKPROCESS,"通用流程");
		ProcessCfgStepBean pcsbTaskProcessRegist = new ProcessCfgStepBean(ProcessStaticVar.TASKPROCESS_REGIST,"登记");
		ProcessCfgStepBean pcsbTaskProcessPerform = new ProcessCfgStepBean(ProcessStaticVar.TASKPROCESS_PERFORM,"执行");
		ProcessCfgStepBean pcsbTaskProcessAudit = new ProcessCfgStepBean(ProcessStaticVar.TASKPROCESS_AUDIT,"检查");
		pcpbTaskProcess.addStep(pcsbTaskProcessRegist);
		pcpbTaskProcess.addStep(pcsbTaskProcessPerform);
		pcpbTaskProcess.addStep(pcsbTaskProcessAudit);
		map.put(ProcessStaticVar.TASKPROCESS, pcpbTaskProcess);
		
		// ------------------------------------------------------------------------ //
		ProcessCfgProcessBean pcpbWorkProcess = new ProcessCfgProcessBean(ProcessStaticVar.WORKPROCESS,"通用执行流程");
		ProcessCfgStepBean pcpbWorkProcessRegist = new ProcessCfgStepBean(ProcessStaticVar.WORKPROCESS_ASSIGN,"派工");
		ProcessCfgStepBean pcpbWorkProcessPerform = new ProcessCfgStepBean(ProcessStaticVar.WORKPROCESS_EXECUTE,"执行");
		ProcessCfgStepBean pcpbWorkProcessAudit = new ProcessCfgStepBean(ProcessStaticVar.WORKPROCESS_INSPECT,"检查");
		ProcessCfgStepBean pcpbWorkProcessDecide = new ProcessCfgStepBean(ProcessStaticVar.WORKPROCESS_DECIDE,"通知");
		pcpbWorkProcess.addStep(pcpbWorkProcessRegist);
		pcpbWorkProcess.addStep(pcpbWorkProcessPerform);
		pcpbWorkProcess.addStep(pcpbWorkProcessAudit);
		pcpbWorkProcess.addStep(pcpbWorkProcessDecide);
		map.put(ProcessStaticVar.WORKPROCESS, pcpbWorkProcess);
		
		
		
	}
	
	public Map<String,ProcessCfgProcessBean> getMap(){
		return map;
	};
	
	public static ProcessCfg getInstance(){
		if(instance == null){
			instance = new ProcessCfg();
		}
		return instance;
	}
	
	public ProcessCfgProcessBean get(String processCode){
		return this.getMap().get(processCode);
	}
	
}
