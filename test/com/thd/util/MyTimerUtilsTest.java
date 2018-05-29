/** 
 * Class Description:########
 * Date : 2017年7月1日 上午11:30:29
 * Auth : wanglei 
*/  

package com.thd.util;

import junit.framework.TestCase;

import org.junit.Test;

import cn.thd.timer.impl.ClearTempTimer;

public class MyTimerUtilsTest extends TestCase{
	@Test
	public void test01() throws Exception{
		MyTimerUtils util = MyTimerUtils.getInstance();
		util.addTimer("a", "a", ClearTempTimer.class, "0/1 * * * * ?");
		util.startAllJob();
		
		util.queryJob();
		Thread.sleep(3000);
		
		util.updateJob("a", "a", "0/3 * * * * ?");
		Thread.sleep(10000);
	}

}
