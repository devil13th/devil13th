package com.thd.util.activiti;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import junit.framework.TestCase;

import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.IdentityService;
import org.activiti.engine.ManagementService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;
import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.thd.util.MyActivitiUtil;

public class ActivitiTool extends TestCase{
	
	
	public ClassPathXmlApplicationContext context ;
	public ProcessEngine processEngine  ;
	public RuntimeService runtimeService ;
	public RepositoryService repositoryService ;
	public TaskService taskService  ;
	public ManagementService managementService  ;
	public IdentityService identityService  ;
	public HistoryService historyService  ;
	public FormService formService ;
	public MyActivitiUtil util;
	
	public Logger log = Logger.getLogger(this.getClass());
	
	
	@Before  
    public void setUp(){  
		System.out.println(" ----------------------- setUp() -------------------");  
		util = new MyActivitiUtil("com/thd/util/activiti/activiti.cfg.xml");
		ProcessEngine processEngine = util.getProcessEngine();
		RuntimeService runtimeService =util.getRuntimeService();
		RepositoryService repositoryService = util.getRepositoryService();
		TaskService taskService  =util.getTaskService();
		ManagementService managementService =util.getManagementService() ;
		IdentityService identityService =util.getIdentityService() ;
		HistoryService historyService =util.getHistoryService() ;
		FormService formService = util.getFormService();
		
    }  
	
	@After  
    public void tearDown(){  
        System.out.println(" ----------------------- tearDown() -------------------");  
    } 
	
	
	/**
	 * 部署流程
	 * @throws Exception
	 */
	public void test00init() throws Exception{
		System.out.println(this.util.getProcessEngine());
	}
	
	
	/**
	 * 部署流程
	 * @throws Exception
	 */
	public void test01deploy() throws Exception{
		Deployment deployment = this.util.deploy("cn/thd/bpmn/WorkProcess.bpmn");
		System.out.println("deployment id:" + deployment.getId());
		System.out.println("success");
	}
	
	/**
	 * 删除已部署的流程
	 * @throws Exception
	 */
	public void test01deletedeploy() throws Exception{
		this.util.deleteDeploy("4003");
		System.out.println("success");
	}
	
	/**
	 * 启动流程
	 * @throws Exception
	 */
	public void test02beginProcess() throws Exception{
		String jobno = "2016CCSE001";
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("assigner", "devil13th");		
		ProcessInstance processInstance = util.getRuntimeService().startProcessInstanceByKey("taskProcess",jobno,map);
		System.out.println("已成功开启流程：" );
		System.out.println("ActivityId：" +processInstance.getActivityId());
		System.out.println("BusinessKey：" +processInstance.getBusinessKey());
		System.out.println("DeploymentId：" +processInstance.getDeploymentId());
		System.out.println("ID：" +processInstance.getId());
		System.out.println("NAME：" +processInstance.getName());
	}
	
	/**
	 * 完成待办
	 * @throws Exception
	 */
	public void test03completeTask() throws Exception{
		String u1 = "u1";
		String u21 = "u21";
		String u22 = "u22";
		String u3 = "u3";
		String u4 = "u4";
		String u51 = "u51";
		String u52 = "u52";
		String u6 = "u6";
		String u71 = "u71";
		String u72 = "u72";
		String u73 = "u73";
		String u8 = "u8";
		String u91 = "u91";
		String u92 = "u92";
		String u10 = "u10";
		util.claimAndComplateTask("102520", u1, null);
		//util.completeTask("122516", null);
	}
	
	public void test08addVarableToProcessInstance() throws Exception{
		Map map = new HashMap();
		map.put("type6","1");
		util.addVarableToProcessInstance(map, "122501");
	}
	
	
	/**
	 * 获取人的待办
	 * @throws Exception
	 */
	public void test03queryTask() throws Exception{
		
		String tn = util.getTaskService().createTaskQuery().processInstanceBusinessKey("2016CCSE001").singleResult().getName();
		System.out.println(tn);
	}
	
	
	public void test031ClaimTask() throws Exception{
		String u1 = "u1";
		String u21 = "u21";
		String u22 = "u22";
		String u3 = "u3";
		String u4 = "u4";
		String u51 = "u51";
		String u52 = "u52";
		String u6 = "u6";
		String u71 = "u71";
		String u72 = "u72";
		String u73 = "u73";
		String u8 = "u8";
		String u91 = "u91";
		String u92 = "u92";
		String u10 = "u10";
		util.claimTask("105002", u21);
	}
	
	public void test03UnClaimTask() throws Exception{
		String u1 = "u1";
		String u21 = "u21";
		String u22 = "u22";
		String u3 = "u3";
		String u4 = "u4";
		String u51 = "u51";
		String u52 = "u52";
		String u6 = "u6";
		String u71 = "u71";
		String u72 = "u72";
		String u73 = "u73";
		String u8 = "u8";
		String u91 = "u91";
		String u92 = "u92";
		String u10 = "u10";
		util.claimTask("105002", null);
	}
	
	
	
	public void test04assignUser() throws Exception{
		//String user = "zhangsan";
		String user = "lisi";
		//String user = "wangwu";
		//String user = "zhaoliu";
		String taskId = "77504";
		util.getTaskService().addCandidateUser(taskId, "zhangsan");
		util.getTaskService().addCandidateUser(taskId, "lisi");
		util.getTaskService().addCandidateUser(taskId, "wangwu");
		System.out.println("success");
	}
	
	
	
	public void test06queryCurrentTask(){
		List<Task> tasks = util.queryCurrentTaskByBusinessKey("2014DL100001");
		for(Task task : tasks){
			System.out.println(task.getName());
			System.out.println(task.getId());
		}
	}
	
	public void test09queryNextTaskByCurrentTaskId(){
		List<PvmActivity> r = util.queryNextTaskByCurrentTaskId("72507");
		for (PvmActivity ac : r) {
			System.out.println("下一步任务任务NAME：" + ac.getProperty("name"));
			System.out.println("下一步任务任务ID：" + ac.getId());
		}
	}
	
	public void test09queryPrevTaskByCurrentTaskId(){
		List<PvmActivity> r = util.queryPrevTaskByCurrentTaskId("72507");
		for (PvmActivity ac : r) {
			System.out.println("上一步任务任务NAME：" + ac.getProperty("name"));
			System.out.println("上一步任务任务ID：" + ac.getId());
		}
	}
	
	public void test10queryCandidateForTask(){
		String taskId = "35092";
		Task t;
		List<IdentityLink> l = util.queryCandidateForTask(taskId);
		for(IdentityLink lk : l){
			System.out.println(lk.getUserId());
		}
		
		System.out.println(" ------------ claim ------------ ");
		util.getTaskService().claim(taskId, "lwang");
		t  = util.getTaskService().createTaskQuery().taskId(taskId).singleResult();
		System.out.println("assign:" + t.getAssignee());
		
		l = util.queryCandidateForTask(taskId);
		for(IdentityLink lk : l){
			System.out.println(lk.getUserId());
		}
		
		System.out.println(" ------------ un claim  ------------ ");
		util.getTaskService().unclaim(taskId);
		t  = util.getTaskService().createTaskQuery().taskId(taskId).singleResult();
		System.out.println("assign:" +t.getAssignee());
		l = util.queryCandidateForTask(taskId);
		for(IdentityLink lk : l){
			System.out.println(lk.getUserId());
		}
	}
	
	
	public void test10canDo(){
		String taskId = "35092";
		String userId = "lwang";
		System.out.println(util.canDo(taskId, userId));
	}
	
	
	public void test08drawBpmn() throws Exception{
		util.drawBpmn("taskProcess:2:25004", "D://deleteme.jpg");
	}
	
	public void test09drawBpmnWithCurrentTask() throws Exception{
		util.drawBpmnWithCurrentTask("27527", "D://deleteme1.jpg");
	}
	
	public void test10jump(){
		util.jump("75001", "usertask1");
	}
	
	
	
}
