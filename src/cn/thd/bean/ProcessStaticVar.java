/** 
 * Class Description:########
 * Date : 2017年12月20日 下午6:40:24
 * Auth : ccse 
*/  

package cn.thd.bean;

public class ProcessStaticVar {
	
	
	//------------------------- 流程 ------------------------------//
	
	public static final String TASKPROCESS = "TaskProcess";
	public static final String WORKPROCESS = "WorkProcess";
	
	//------------------------- 流程步骤 --------------------------//
	
	
	public static final String TASKPROCESS_REGIST = "regist"; //登记
	public static final String TASKPROCESS_PERFORM = "perform";//执行
	public static final String TASKPROCESS_AUDIT = "audit";//审核
	
	public static final String WORKPROCESS_ASSIGN = "WORKPROCESS_ASSIGN"; //派工
	public static final String WORKPROCESS_EXECUTE = "WORKPROCESS_EXECUTE";//执行
	public static final String WORKPROCESS_INSPECT = "WORKPROCESS_INSPECT";//检查
	public static final String WORKPROCESS_DECIDE = "WORKPROCESS_DECIDE";//通知
	
}
