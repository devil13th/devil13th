/** 
 * Class Description:########
 * Date : 2017年7月1日 上午9:31:00
 * Auth : wanglei 
*/  

package cn.thd.timer;

import org.quartz.Job;


public interface ThdTimer extends Job{
	public String getName();
}
