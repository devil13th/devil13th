/** 
 * Class Description:########
 * Date : 2017年7月1日 上午9:46:23
 * Auth : wanglei 
*/  

package cn.thd.timer.impl;

import java.util.Date;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import cn.thd.timer.ThdTimer;

public class ClearTempTimer implements ThdTimer{
	Logger log = Logger.getLogger(this.getClass());
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		log.info("Timer [" + this.getName()+ "] Start ...");
		System.out.println(new Date());
		log.info("Timer [" + this.getName()+ "] Finish ...");
	}
	
	
	@Override
	public String getName() {
		return " Clear Temp Files";
	}
	
}
