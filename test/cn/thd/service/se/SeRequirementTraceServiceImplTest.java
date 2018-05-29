package cn.thd.service.se;

import java.util.List;

import junit.framework.TestCase;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import cn.thd.pojo.se.SeRequirementTrace;

import com.thd.util.ListUtil;

public class SeRequirementTraceServiceImplTest extends TestCase{
	String[] appContext = new String[]{"conf/appContext-include.xml"};
	private ApplicationContext factory=new ClassPathXmlApplicationContext(appContext); 
	
	
	private SeRequirementTraceService service = (SeRequirementTraceService)factory.getBean("seRequirementTraceService");
	
	@Test
	public void testqueryNodeById(){
		SeRequirementTrace t = service.queryNodeById("1");
		System.out.println(t.getTreeCode());
	}
	
	@Test
	public void testqueryRoot(){
		SeRequirementTrace t = service.queryRoot("SSMIS-A6");
		System.out.println(t.getTreeCode());
	}
	
	@Test
	public void testqueryNextNodeByCode(){
		List l  = service.queryNextNodeByCode("SSMIS-A6","root");
		if(ListUtil.isNotEmpty(l)){
			for(Object obj : l){
				SeRequirementTrace t = (SeRequirementTrace)obj;
				System.out.println(t.getTreeCode());
			}
		}
	}
	
	@Test
	public void testqueryNextNodeById(){
		List l  = service.queryNextNodeById("1.1");
		if(ListUtil.isNotEmpty(l)){
			for(Object obj : l){
				SeRequirementTrace t = (SeRequirementTrace)obj;
				System.out.println(t.getTreeCode());
			}
		}
	}
	
	@Test
	public void testqueryNextNodeJsonById(){
		String str  = service.queryNextNodeJsonById("1.1");
		System.out.println(str);
	}
	
	@Test
	public void testmoveNode(){
		//String str  = service.moveNode("1.1.1","1.1.2","append");
		
		//String str  = service.moveNode("1.1","1.1.1","top");
		
		String str  = service.moveNode("1.1.1.2","1.1.1.1","bottom");
		
		System.out.println(str);
	}
	
	
	
	
	
	
	
	
}
