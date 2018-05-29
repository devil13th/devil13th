/** 
 * Class Description:########
 * Date : 2017年12月21日 上午8:36:36
 * Auth : ccse 
*/  

package cn.thd.bean;


public class ProcessMethodBean {
	
	//已初始化状态
	public static  String INITED = "1";
	//未初始化状态
	public static  String UNINITED = "0";
	//是否被初始化过
	private String beInited = ProcessMethodBean.UNINITED;
	//工作控制号
	private String jobno;
	//代办ID
	private String taskId;
	//操作人
	private String operator;
	//流程ID
	private String processId;
	//步骤ID
	private String stepId;
	//流程CODE
	private String processCode;
	//步骤CODE
	private String stepCode;
	//流程Service
	private String processService;
	//流程实例ID
	private String processInstanceId;
	//是否成功
	private String status;
	//消息
	private String message;
	//代办是否有权限执行 参见 StaticVar.HASAUTH_XXX
	private String hasAuth;
	public String getBeInited() {
		return beInited;
	}
	public void setBeInited(String beInited) {
		this.beInited = beInited;
	}
	public String getJobno() {
		return jobno;
	}
	public void setJobno(String jobno) {
		this.jobno = jobno;
	}
	public String getTaskId() {
		return taskId;
	}
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getProcessId() {
		return processId;
	}
	public void setProcessId(String processId) {
		this.processId = processId;
	}
	public String getStepId() {
		return stepId;
	}
	public void setStepId(String stepId) {
		this.stepId = stepId;
	}
	public String getProcessCode() {
		return processCode;
	}
	public void setProcessCode(String processCode) {
		this.processCode = processCode;
	}
	public String getStepCode() {
		return stepCode;
	}
	public void setStepCode(String stepCode) {
		this.stepCode = stepCode;
	}
	public String getProcessService() {
		return processService;
	}
	public void setProcessService(String processService) {
		this.processService = processService;
	}
	public String getProcessInstanceId() {
		return processInstanceId;
	}
	public void setProcessInstanceId(String processInstanceId) {
		this.processInstanceId = processInstanceId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getHasAuth() {
		return hasAuth;
	}
	public void setHasAuth(String hasAuth) {
		this.hasAuth = hasAuth;
	}
	
	
	
	
	
}
