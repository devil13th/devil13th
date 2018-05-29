package cn.thd.action.login;

import io.jsonwebtoken.Claims;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;

import cn.thd.bean.JwtClaims;
import cn.thd.bean.LoginUserInfo;
import cn.thd.bean.StaticVar;
import cn.thd.pojo.se.SeUser;
import cn.thd.service.se.SeService;
import cn.thd.service.sys.SysService;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.thd.core.action.PubAction;
import com.thd.util.MyDateUtils;
import com.thd.util.MyJwtAssistUtils;

public class LoginAction extends PubAction {
	@Resource
	private SeService seService;
	@Resource
	private SysService sysService;
	/**
	 * 登录页 
	 * url : /login/login!login.do
	 * @return
	 */
	public String login(){
		this.getLog().info("login()");
		try{
			this.setForwardPage("/pages/login/login.jsp");
			
			try{
				JwtClaims claimsAss = new JwtClaims();
				claimsAss.setSercurityStr(StaticVar.JWTSECURITYSTR);
				Claims  claims =MyJwtAssistUtils.getClaims(this.getReq(), "token", claimsAss);
				this.logger.info(claims);
				long nowTime = System.currentTimeMillis();
				long expire = claims.getExpiration().getTime();
				
				
				this.logger.info("token期限：" + MyDateUtils.toString(new Date(expire), "yyyy-MM-dd HH:mm:ss"));
				if(expire <= nowTime){//已过期
					this.setForwardPage("/pages/login/login.jsp");
					return this.SUCCESS;
				}else{//未过期
					
					String loginUserJsonStr = claims.get("loginUserInfo").toString();
					Map loginUserInfoMap = new HashMap();
					loginUserInfoMap.put("loginUserInfo",loginUserJsonStr);
					GsonBuilder builder = new GsonBuilder();
					Gson gson = builder.create();
					LoginUserInfo lui = gson.fromJson(loginUserJsonStr, LoginUserInfo.class);
					this.getRequest().put("loginUserInfo", lui);
					this.setForwardPage("/index.jsp");
					return this.SUCCESS;
				}
			}catch(Exception e){
				e.printStackTrace();
				this.setForwardPage("/pages/login/login.jsp");
				return this.SUCCESS;
			}
			
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	/**
	 * 登录页
	 * @return
	 */
	public String loginSubmit(){
		this.getLog().info("loginSubmit()");
		try{
			String usr = this.getReq().getParameter("username");
			String pwd = this.getReq().getParameter("password");
			
			String result = this.seService.validateUserAndPassword(usr, pwd);
			if(StaticVar.STATUS_SUCCESS.equals(result)){
				this.getRequest().put("msg", StaticVar.STATUS_SUCCESS);
				String ctx = this.getReq().getContextPath();
				
				LoginUserInfo loginUserInfo = new LoginUserInfo();
				loginUserInfo = seService.createLoginUserInfo(usr);
				
				/*
				SeUser seUser = seService.querySeUserByAccount(usr);
				this.getRequest().put("loginUser", seUser);
				
				loginUserInfo.setAccount(seUser.getUserAccount());
				loginUserInfo.setUserId(seUser.getUserId());
				loginUserInfo.setUserName(seUser.getUserName());
				loginUserInfo.setSeUser(seUser);
				if("lwang".equals(usr)){
					loginUserInfo.setUserRole("admin");
					loginUserInfo.setCanReadCost("1");
				}
				this.getSess().setAttribute("user", usr);
				*/
				
				
				sysService.putLoginUserInfoIntoCookie(this.getReq(), this.getResp(), loginUserInfo);
				this.setForwardPage("/index.jsp");
			}else{
				this.getRequest().put("msg", "Login Failure,Check Your UserName or Password");
				this.setForwardPage("/pages/login/login.jsp");
			}
			return this.SUCCESS;
			
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	
	/**
	 * 退出登录
	 * url : /login/login!logout.do
	 * @return
	 */
	public String logout(){
		this.getLog().info("logout()");
		try{
			this.setForwardPage("/index.jsp");
			
			try{
				Cookie cookie = new Cookie("token", null);
				cookie.setMaxAge(0);
				cookie.setPath("/");
				this.getResp().addCookie(cookie);
				this.getReq().getSession().removeAttribute("loginUserInfo");
				return this.SUCCESS;
			}catch(Exception e){
				e.printStackTrace();
				this.setForwardPage("/pages/login/login.jsp");
				return this.SUCCESS;
			}
			
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
}
