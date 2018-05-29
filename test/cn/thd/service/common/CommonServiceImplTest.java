package cn.thd.service.common;

import java.util.List;

import junit.framework.TestCase;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.thd.core.dao.JdbcDao;
import com.thd.core.dao.PubDao;

public class CommonServiceImplTest extends TestCase {
	String[] appContext = new String[]{"conf/appContext-include.xml"};
	private ApplicationContext factory=new ClassPathXmlApplicationContext(appContext); 
	
	private PubDao dao = (PubDao)factory.getBean("pubDaoImpl");
	private JdbcDao jdao = (JdbcDao)factory.getBean("jdbcDao");
	
	private HibernateTemplate h = (HibernateTemplate)factory.getBean("hibernateTemplate");
	private CommonService service = (CommonService)factory.getBean("commonService");
	
	@Test
	public void test01(){
		System.out.println(service);
		String json = service.queryDicForJson("backlog_type");
		System.out.println(json);
	}
	
	
	@Test
	public void testqueryXxjtHzsgData(){
		List l = service.queryXxjtHzsgData("c_ms", "asc");
		System.out.println(l);
		//[{jc=75, fsbz=虎豹骑, gjbz=谋事}, {jc=75, fsbz=大戟士, gjbz=谋事}, {jc=75, fsbz=陷阵营, gjbz=谋事}, {jc=75, fsbz=弓骑兵, gjbz=谋事}, {jc=75, fsbz=骑兵, gjbz=谋事}, {jc=75, fsbz=猎射官, gjbz=谋事}, {jc=75, fsbz=白马义从, gjbz=谋事}, {jc=75, fsbz=精锐骑兵, gjbz=谋事}, {jc=75, fsbz=匈奴游骑, gjbz=谋事}, {jc=100, fsbz=御医, gjbz=谋事}, {jc=100, fsbz=先登死士, gjbz=谋事}, {jc=100, fsbz=仙术士, gjbz=谋事}, {jc=100, fsbz=方术士, gjbz=谋事}, {jc=100, fsbz=步兵, gjbz=谋事}, {jc=100, fsbz=军师, gjbz=谋事}, {jc=100, fsbz=无当飞军, gjbz=谋事}, {jc=100, fsbz=矛兵, gjbz=谋事}, {jc=100, fsbz=医官, gjbz=谋事}, {jc=100, fsbz=谋事, gjbz=谋事}, {jc=100, fsbz=精锐矛兵, gjbz=谋事}, {jc=100, fsbz=妖术师, gjbz=谋事}, {jc=100, fsbz=谋略家, gjbz=谋事}, {jc=100, fsbz=车下虎士, gjbz=谋事}, {jc=100, fsbz=弓兵, gjbz=谋事}, {jc=100, fsbz=连弩士, gjbz=谋事}, {jc=125, fsbz=大盾兵, gjbz=谋事}, {jc=125, fsbz=西凉铁骑, gjbz=谋事}, {jc=125, fsbz=白眊军, gjbz=谋事}, {jc=125, fsbz=盾兵, gjbz=谋事}, {jc=125, fsbz=突陈兵, gjbz=谋事}, {jc=125, fsbz=藤甲兵, gjbz=谋事}, {jc=125, fsbz=虎卫军, gjbz=谋事}]
	}
}
