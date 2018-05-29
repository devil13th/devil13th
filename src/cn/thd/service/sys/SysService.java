/** 
 * Class Description:########
 * Date : 2017年5月23日 下午11:30:36
 * Auth : wanglei 
*/  

package cn.thd.service.sys;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.thd.bean.LoginUserInfo;

import com.thd.core.service.PubService;

public interface SysService extends PubService{
	/**
	 * 取号
	 * @param key 建
	 * @return 号
	 */
	public String createNo(String key);
	/**
	 * 从cookie中取得登录人信息
	 * @param request
	 * @return
	 */
	public LoginUserInfo getLoginUserInfoFromCookie(HttpServletRequest request);
	/**
	 * 将登录人信息放置到cookie中
	 * @param request
	 * @return
	 */
	public void putLoginUserInfoIntoCookie(HttpServletRequest request,HttpServletResponse response,LoginUserInfo loginUserInfo);
}
