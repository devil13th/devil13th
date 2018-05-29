/** 
 * Class Description:########
 * Date : 2017年12月20日 下午5:06:15
 * Auth : ccse 
*/  

package cn.thd.service.process;


import java.util.HashMap;
import java.util.Map;

import junit.framework.TestCase;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.thd.bean.ProcessMethodBean;
import cn.thd.bean.ProcessStartInfo;
import cn.thd.bean.ProcessStaticVar;


public class SeProcessServiceTest extends TestCase {
	String[] appContext = new String[]{"conf/appContext-include.xml"};
	private ApplicationContext factory=new ClassPathXmlApplicationContext(appContext); 
	
	private SeProcessService service = (SeProcessService)factory.getBean("seProcessService");
	
	@Test
	public void teststartJob() throws Exception{
		ProcessStartInfo processStartInfo = new ProcessStartInfo();
		processStartInfo.setiProcKey("WorkProcess");
		processStartInfo.setiStartUser("lwang");
		processStartInfo.setiJobnoKey("2017WORK");
		Map procVar = new HashMap();
		procVar.put("starter", "lwang");
		processStartInfo.setiProcVar(procVar);
		
		service.startJob(processStartInfo);
		System.out.println("===========================");
		System.out.println(processStartInfo.getoJobno());
		System.out.println(processStartInfo.getoTaskId());
		System.out.println("===========================");
		System.out.println(service);
		System.out.println("SUCCESS");
	}
	
	
	@Test
	public void testnextStep() throws Exception{
		ProcessMethodBean pmb = new ProcessMethodBean();
		
		pmb.setOperator("lwang");
		pmb.setJobno("2017WORK00001");
		pmb.setTaskId("87505");
		
		service.nextStep(pmb);
		System.out.println("SUCCESS");
	}
	
	
	
	
	
}
