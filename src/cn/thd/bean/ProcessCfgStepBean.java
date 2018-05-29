/** 
 * Class Description:########
 * Date : 2017年12月20日 下午6:35:06
 * Auth : ccse 
*/  

package cn.thd.bean;

public class ProcessCfgStepBean {
	private String stepName;
	private String stepCode;
	private ProcessCfgProcessBean processBean;
	public String getStepCode() {
		return stepCode;
	}

	public void setStepCode(String stepCode) {
		this.stepCode = stepCode;
	}

	public String getStepName() {
		return stepName;
	}

	public void setStepName(String stepName) {
		this.stepName = stepName;
	}

	public ProcessCfgStepBean(String stepCode,String stepName) {
		super();
		this.stepName = stepName;
		this.stepCode = stepCode;
	}

	public ProcessCfgProcessBean getProcessBean() {
		return processBean;
	}

	public void setProcessBean(ProcessCfgProcessBean processBean) {
		this.processBean = processBean;
	}

	
}
