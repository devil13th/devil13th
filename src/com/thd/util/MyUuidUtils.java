/** 
 * Class Description:########
 * Date : 2017年1月24日 下午2:27:22
 * Auth : wanglei 
*/  

package com.thd.util;

import java.util.UUID;

public class MyUuidUtils {
	public static String getUuid(){
		String uuid = UUID.randomUUID().toString();
		String str = uuid.replace("-", "");
		return str;
	}
}
