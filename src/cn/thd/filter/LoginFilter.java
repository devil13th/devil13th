package cn.thd.filter;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import cn.thd.bean.JwtClaims;
import cn.thd.bean.LoginUserInfo;
import cn.thd.bean.StaticVar;
import cn.thd.service.sys.SysService;

import com.auth0.jwt.JWTExpiredException;
import com.thd.util.MyJwtUtils;
import com.thd.util.MyStringUtils;

/**
 * Servlet Filter implementation class LoginFilter
 */
public class LoginFilter implements Filter {
	
    /**
     * Default constructor. 
     */
    public LoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		Logger log = Logger.getLogger(this.getClass());
		
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		HttpSession session = req.getSession();
		
		
		String url = req.getServletPath();
		if(url.indexOf("/login/") != -1){
			chain.doFilter(request, response);
			return;
		}
		/*
		if(session.getAttribute("loginUserInfo") == null){
			System.out.println("cn.thd.filter.LoginFilter : must login !!" );
			res.sendRedirect(req.getContextPath()+"/login/login!login.do");
			return;
		}
		*/
		
		String token = "";
		try{
			Cookie[] cookies = req.getCookies();
			for(Cookie ck:cookies){
				if(ck.getName().equals("token")){
					token = ck.getValue();
					if(MyStringUtils.isNotEmpty(token)){
						JwtClaims claim = new JwtClaims();
						claim.setSercurityStr(StaticVar.JWTSECURITYSTR);
						Claims claims = MyJwtUtils.parse(claim, token);
						//System.out.println(claims);
						//String account = claims.get("account").toString();
						long exp = claims.getExpiration().getTime();
						long n = System.currentTimeMillis();
						
						double toDays = (exp - n)/ (24*60*60*1000);
						log.info(String.valueOf(toDays));
						
						ServletContext servletContext = req.getSession().getServletContext();  
						ApplicationContext appctx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);  
						SysService sysService = (SysService)appctx.getBean("sysService"); 
						LoginUserInfo lui = sysService.getLoginUserInfoFromCookie(req);
						
						//如果session失效了 则从cookie中获取登录信息放入到session中
						if( null == req.getSession().getAttribute("loginUserInfo")){
							req.getSession().setAttribute("loginUserInfo", lui);
						}
						
						if(toDays < 2){//token即将到期
							log.info("TOKEN WILL BE EXPIRED , RESET TOKEN ...");
							sysService.putLoginUserInfoIntoCookie(req, res,lui );
						}
					}
				}
			}
		} catch (ExpiredJwtException e) {
			System.out.println("jwt 已过期");
			res.sendRedirect(req.getContextPath()+"/login/login!login.do");
		} catch(JWTExpiredException e){
			System.out.println("jwt 已过期");
			res.sendRedirect(req.getContextPath()+"/login/login!login.do");
		} catch(Exception e){
			e.printStackTrace();
			res.sendRedirect(req.getContextPath()+"/login/login!login.do");
		}
		
		if(MyStringUtils.isEmpty(token)){
			System.out.println("尚未登录");
			res.sendRedirect(req.getContextPath()+"/login/login!login.do");
		}else{
			//System.out.println("登录token:" + token);
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
