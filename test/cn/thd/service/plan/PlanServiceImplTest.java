/** 
 * Class Description:########
 * Date : 2017年1月24日 下午2:49:00
 * Auth : wanglei 
*/  

package cn.thd.service.plan;

import java.util.ArrayList;
import java.util.List;

import junit.framework.TestCase;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.thd.bean.StaticVar;
import cn.thd.pojo.plan.PlanExecution;
import cn.thd.pojo.plan.PlanInfo;

public class PlanServiceImplTest extends TestCase {
	String[] appContext = new String[]{"conf/appContext-include.xml"};
	private ApplicationContext factory=new ClassPathXmlApplicationContext(appContext); 
	
	private PlanService service = (PlanService)factory.getBean("planService");
	
	@Test
	public void testcreatePlanNo() throws Exception{
		String code = service.createPlanNo(2017, 1, StaticVar.PLAN_WEEK);
		System.out.println(code);
		String code2 = service.createPlanNo(2017,1, StaticVar.PLAN_MONTH);
		System.out.println(code2);
	}
	@Test
	public void testcreatePlanInfo()  throws Exception{
		PlanInfo pi = service.createPlanInfo(2017, 1, StaticVar.PLAN_WEEK);
		System.out.println(pi.getPlanCode());
		PlanInfo r1 = service.createPlanInfo(2017, 1, StaticVar.PLAN_MONTH);
		System.out.println(r1);
	}
	
	
	@Test
	public void testexistPlan() throws Exception {
		boolean r1 = service.existPlan(2017, 2, StaticVar.PLAN_MONTH);
		System.out.println(r1);
	}
	
	@Test
	public void testcreatePlanItemNo() throws Exception{
		//String code = service.createPlanItemNo();
		//System.out.println(code);
	}
	
	@Test
	public void testcreatePlanItem() throws Exception{
		//service.createPlanItem("测试", "PL20170100");
		System.out.println("success");
	}
	
	@Test
	public void testqueryPlanByPlanCodeAndPlanItemId(){
		//PlanExecution pe = service.queryPlanByPlanCodeAndPlanItemId(planCode, planItemId);
	}
	
	@Test
	public void testaddPlanItemToPlanInfo(){
		//service.addPlanItemToPlanInfo("PL20170124003", "PL20170101");
		//System.out.println("success");
	}
	
	@Test
	public void testinitPlanInfo() throws Exception{
		service.initPlanInfo(2017);
		System.out.println("success");
	}
	
	@Test
	public void testqueryPrevPlanInfo() throws Exception{
		PlanInfo pi = service.queryPrevPlanInfo("PL20170100");
		System.out.println(pi.getPlanCode());
		
		PlanInfo pi2 = service.queryPrevPlanInfo("PL20170101");
		System.out.println(pi2.getPlanCode());
	}
	
	
	@Test
	public void testqueryNextPlanInfo() throws Exception{
		PlanInfo pi = service.queryNextPlanInfo("PL20171200");
		System.out.println(pi.getPlanCode());
		
		PlanInfo pi2 = service.queryNextPlanInfo("PL20171252");
		System.out.println(pi2.getPlanCode());
	}
	
	
}
