/** 
 * Class Description:########
 * Date : 2017年7月1日 上午9:46:23
 * Auth : wanglei 
*/  

package cn.thd.timer.impl;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoader;

import cn.thd.service.common.CommonService;
import cn.thd.timer.ThdTimer;

public class TaskTimer implements ThdTimer{
	Logger log = Logger.getLogger(this.getClass());
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		log.info("Timer [" + this.getName()+ "] Start ...");
		System.out.println(this.getName() + " run ...");
		
		ApplicationContext act = ContextLoader.getCurrentWebApplicationContext();
		CommonService commonService = (CommonService) act.getBean("commonService");
		System.out.println(commonService);
		
		log.info("Timer [" + this.getName()+ "] Finish ...");
	}
	
	
	@Override
	public String getName() {
		return " Task Timer";
	}
	
}
