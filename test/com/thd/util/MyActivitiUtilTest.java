/** 
 * Class Description:########
 * Date : 2017年12月20日 下午5:14:52
 * Auth : ccse 
*/  

package com.thd.util;

import java.util.HashMap;
import java.util.Map;

import junit.framework.TestCase;

import org.activiti.engine.repository.Deployment;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.thd.bean.ProcessStartInfo;

public class MyActivitiUtilTest extends TestCase {
	String[] appContext = new String[]{"conf/appContext-include.xml"};
	private ApplicationContext factory=new ClassPathXmlApplicationContext(appContext); 
	private MyActivitiUtil activitiUtil = (MyActivitiUtil)factory.getBean("myActivitiUtil");
	
	private String procInstId = "87501";
	/**
	 * 部署流程
	 * @throws Exception
	 */
	@Test
	public void testDeploy() throws Exception{
		Deployment deployment = activitiUtil.deploy("cn/thd/bpmn/WorkProcess.bpmn");
		System.out.println("deployment id:" + deployment.getId());
		System.out.println("success");
	}
	
	/**
	 * 设置流程变量
	 * Method Description : ########
	 * @throws Exception
	 */
	@Test
	public void testaddVarableToProcessInstance() throws Exception{
		Map<String,String> procVar = new HashMap<String,String>();
		System.out.println(procInstId);
		procVar.put("WORKPROCESS_EXECUTE", "jxu");
		procVar.put("WORKPROCESS_INSPECT", "ywliu");
		procVar.put("WORKPROCESS_DECIDE", "lwang");
		activitiUtil.addVarableToProcessInstance(procVar, procInstId);
		System.out.println("success");
	}
	
	
	/**
	 * 获取流程变量
	 * Method Description : ########
	 * @throws Exception
	 */
	@Test
	public void testgetVarableToProcessInstance() throws Exception{
		System.out.println(procInstId);
		Map m = activitiUtil.getVariableInstances(procInstId);
		System.out.println(m);
		System.out.println("success");
	}
	
	
	
	
	
	
	
}
