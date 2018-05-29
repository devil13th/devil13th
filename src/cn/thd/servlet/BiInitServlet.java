package cn.thd.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.thd.util.RtfTemplateUtil;

/**
 * Servlet implementation class TimerInitServlet
 */
public class BiInitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private Logger log = Logger.getLogger(this.getClass());
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BiInitServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init() throws ServletException {//在init中编写要运行的程序  
        try{
           log.info("BiInitServlet Running , create BiPublisher xdo.cfg ...");
           String path = this.getServletContext().getRealPath("/");
           // path = E:\thdsvn\java_project\devil13th\WebRoot\
           String xdoPath = path + File.separator + "WEB-INF" + File.separator + "xdo.cfg";
           String fontFolderPath = path + "WEB-INF" + File.separator + "font";
           RtfTemplateUtil rtUtil = new RtfTemplateUtil();
           rtUtil.generateXdoCfg(xdoPath, fontFolderPath);
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
