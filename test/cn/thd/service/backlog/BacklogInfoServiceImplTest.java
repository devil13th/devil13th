package cn.thd.service.backlog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import junit.framework.TestCase;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateTemplate;

import cn.thd.pojo.backlog.BacklogInfo;

import com.thd.core.dao.JdbcDao;
import com.thd.core.dao.PubDao;

public class BacklogInfoServiceImplTest extends TestCase{
	String[] appContext = new String[]{"conf/appContext-include.xml"};
	private ApplicationContext factory=new ClassPathXmlApplicationContext(appContext); 
	
	private PubDao dao = (PubDao)factory.getBean("pubDaoImpl");
	private JdbcDao jdao = (JdbcDao)factory.getBean("jdbcDao");
	
	private HibernateTemplate h = (HibernateTemplate)factory.getBean("hibernateTemplate");
	private BacklogInfoService service = (BacklogInfoService)factory.getBean("backlogInfoService");
	
	
	
	@Test
	public void test01(){
		System.out.println(h);
		System.out.println(dao);
		System.out.println(jdao);
		System.out.println(service);
		BacklogInfo bli = new BacklogInfo();
		//service.saveOrUpdateBacklog(bli);
//		System.out.println("finish");
	}
	
	
	@Test
	public void testqueryBacklog(){
		Map<String,String> m = new HashMap<String,String>();
		m.put("order", "bl_level");
		m.put("asc", "desc");
		service.queryBacklog(m,null);
	}
	
	@Test
	public void testcreateBlankBacklog(){
		BacklogInfo bli = service.createBlankBacklog();
		System.out.println(bli.getBlId());
	}
	
	@Test
	public void testsaveOrUpdateNote(){
		service.saveOrUpdateNote("BL20150130004", "5555555555555555555555555");
		System.out.println("finish");
	}
	
	@Test
	public void testdealDate(){
		String str = service.dealDate("BL20150129001", "2014-02-03");
		System.out.println(str);
	}
	
	@Test
	public void testdealToday(){
		String str = service.dealToday("BL20150129001");
		System.out.println(str);
	}
	
	@Test
	public void testisDealDate(){
		String str = service.isDealDate("BL20150129001", "2014-02-03");
		System.out.println(str);
	}
	
	@Test
	public void testdeleteDealDate(){
		String str = service.deleteDealDate("BL20150129001", "2014-02-03");
		System.out.println(str);
	}
	
	@Test
	public void testqueryBacklogForPeriod(){
		List l = service.queryBacklogForPeriod("2017-02-05", "2017-02-10");
		System.out.println(l);
	}
	
	
	
	
}
