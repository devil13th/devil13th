package cn.thd.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import cn.thd.service.common.CommonService;

import com.thd.util.MyTimerUtils;

/**
 * Servlet implementation class TimerInitServlet
 */
public class TimerInitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Logger log = Logger.getLogger(this.getClass());
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TimerInitServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init() throws ServletException {//在init中编写要运行的程序  
        try{  
        	log.info("TimerInitServlet Running , Loading Timers ...") ;
        	WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
			//ServletContext application = ServletActionContext.getServletContext();
			//ApplicationContext act = ContextLoader.getCurrentWebApplicationContext();
			CommonService commonService = (CommonService) wac.getBean("commonService");
			System.out.println(commonService);
			MyTimerUtils timerUtils = MyTimerUtils.getInstance();
			List l = commonService.querySysTimerList(new HashMap(), null);
				
			for(Object obj : l ){
				try{
					Map m = (Map)obj;
					Class c = Class.forName(m.get("TIMER_CLASS_NAME").toString());
					
					timerUtils.addTimer(m.get("TIMER_CODE").toString(), m.get("TIMER_GROUP").toString(), c,m.get("EXECUTION_PLAN").toString());
					if(!m.get("START_TYPE").toString().equals("1")){
						timerUtils.pauseJob(m.get("TIMER_CODE").toString(), m.get("TIMER_GROUP").toString());
					}
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			
			
			timerUtils.startAllJob();
        }catch(Exception e){
           e.printStackTrace();
        }  
          
    }  
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
