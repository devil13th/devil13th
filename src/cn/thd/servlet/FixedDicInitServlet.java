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

import cn.thd.bean.Option;
import cn.thd.service.common.CommonService;
import cn.thd.staticbean.FixDicCollection;
import cn.thd.staticbean.FixedDicCollectionBean;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.thd.util.MyListUtils;
import com.thd.util.MyTimerUtils;

/**
 * Servlet implementation class TimerInitServlet
 */
public class FixedDicInitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Logger log = Logger.getLogger(this.getClass());
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FixedDicInitServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init() throws ServletException {//在init中编写要运行的程序  
        try{  
        	log.info("Fixed Dic Init Servlet Running , Loading Dic ...") ;
        	WebApplicationContext wac = WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
			//ServletContext application = ServletActionContext.getServletContext();
			//ApplicationContext act = ContextLoader.getCurrentWebApplicationContext();
			CommonService commonService = (CommonService) wac.getBean("commonService");
			commonService.initFixedDic();
			
			this.getServletContext().setAttribute("fixedDic", FixDicCollection.DIC_CONTAINER);
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
