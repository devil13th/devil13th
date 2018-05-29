/** 
 * Class Description:########
 * Date : 2017年12月20日 下午7:59:07
 * Auth : ccse 
*/  

package cn.thd.service.process;

import cn.thd.bean.ProcessMethodBean;

public interface ProcessMethodService {
	//开启流程后置方法
	public ProcessMethodBean afterStartProcess(ProcessMethodBean processMethodBean); 
	//流程扭转后端验证
	public ProcessMethodBean validate(ProcessMethodBean processMethodBean);
	//设置流程变量
	public ProcessMethodBean setProcInstVar(ProcessMethodBean processMethodBean); 
	
	//流程扭转后置方法
	public ProcessMethodBean afterCompleteTask(ProcessMethodBean processMethodBean); 
	//流程扭转前置方法
	public ProcessMethodBean beforeCompleteTask(ProcessMethodBean processMethodBean); 
	
	//关闭工作前置方法
	public ProcessMethodBean beforeCloseProcess(ProcessMethodBean processMethodBean); 
	//关闭工作后置方法
	public ProcessMethodBean afterCloseProcess(ProcessMethodBean processMethodBean); 
	
	//判断某个代办某人是否有权限
	public ProcessMethodBean hasTaskPerformAuth(ProcessMethodBean processMethodBean);
}
