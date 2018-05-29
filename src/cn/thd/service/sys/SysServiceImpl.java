/** 
 * Class Description:########
 * Date : 2017年5月23日 下午11:32:18
 * Auth : wanglei 
*/  

package cn.thd.service.sys;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import cn.thd.bean.JwtClaims;
import cn.thd.bean.LoginUserInfo;
import cn.thd.bean.StaticVar;
import cn.thd.pojo.sys.SysNo;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.thd.core.dao.JdbcDao;
import com.thd.core.dao.PubDao;
import com.thd.core.service.PubServiceImpl;
import com.thd.util.MyDateUtils;
import com.thd.util.MyJwtAssistUtils;
import com.thd.util.MyJwtUtils;
import com.thd.util.MyListUtils;
@Service("sysService")
public class SysServiceImpl extends PubServiceImpl implements SysService {
	@Resource 
	private PubDao pubDao;
	@Resource
	private JdbcDao jdbcDao;
	
	
	@Override
	public String createNo(String key) {
		String sql = "select no_id as noId,no_count as noCount from sys_no where no_key = ?";
		List params = new ArrayList();
		params.add(key.trim().toUpperCase());
		List l = this.jdbcDao.query(sql, params.toArray(),null);
		int ct = 0;
		SysNo sn = new SysNo();
		if(MyListUtils.isNotEmpty(l)){
			Object obj = l.get(0);
			Map m = (Map)obj;
			ct = Integer.parseInt(m.get("noCount").toString());
			String noId = m.get("noId").toString();
			sn = (SysNo)this.pubDao.findById(SysNo.class, noId);
		}else{
			sn.setNoKey(key.trim().toUpperCase());
			sn.setNoCount(0);
			this.pubDao.save(sn);
		}
		ct++;
		sn.setNoCount(ct);
		int noLen = 5;
		String baseCode = "";
		for(int i = 0 , j = noLen ; i < j ; i++){
			baseCode += "0";
		}
		String code = baseCode + ct;
		code = code.substring(code.length() - baseCode.length() , code.length());
		this.getLog().info(code);
		this.pubDao.update(sn);
		return key.trim().toUpperCase() + code;
	}
	
	
	public LoginUserInfo getLoginUserInfoFromCookie(HttpServletRequest request){
		try{
			JwtClaims claims = new JwtClaims();
			claims.setSercurityStr(StaticVar.JWTSECURITYSTR);
			LoginUserInfo loginUserInfo = (LoginUserInfo)MyJwtAssistUtils.getJsonObj(request, "token", claims, "loginUserInfo",LoginUserInfo.class);
			if(request.getSession().getAttribute("loginUserInfo") == null){
				request.getSession().setAttribute("loginUserInfo",loginUserInfo);
			}
			
			return loginUserInfo;
		}catch(Exception e){
			throw new RuntimeException(e);
		}
	};
	
	public void putLoginUserInfoIntoCookie(HttpServletRequest request,HttpServletResponse response,LoginUserInfo loginUserInfo){
		
		request.getSession().setAttribute("loginUserInfo", loginUserInfo);
		
		JwtClaims claims = new JwtClaims();
		claims.setIat(System.currentTimeMillis());
		long exp = System.currentTimeMillis() + (72 * 60 * 60 * 1000);
		claims.setExpire(exp); 
		claims.setSercurityStr(StaticVar.JWTSECURITYSTR);
		
		
		//System.out.println(System.currentTimeMillis());
		//System.out.println(exp);
		this.getLog().info("token期限：" + MyDateUtils.toString(new Date(exp), "yyyy-MM-dd HH:mm:ss"));
		Map loginUserInfoMap = new HashMap();
		//loginUserInfoMap.put("account", usr);
		
		GsonBuilder builder = new GsonBuilder();
		Gson gson = builder.create();
		String loginUserJsonStr = gson.toJson(loginUserInfo);
		loginUserInfoMap.put("loginUserInfo", loginUserJsonStr);
		String token = MyJwtUtils.sign(claims, loginUserInfoMap);
		
		if (token != null) {
			Cookie cook = new Cookie("token", token);
			//有效时间 3 天
			cook.setMaxAge(72 * 60 * 60 );
			cook.setPath("/");
			// cook.setDomain(".thd.com");
			response.addCookie(cook);
		}

		// 存放系统语言
		Cookie cook = new Cookie("Language", "zh_CN");
		//有效时间 3 天
		cook.setMaxAge(72 * 60 * 60 );
		cook.setPath("/");
		// cook.setDomain(".thd.com");
		response.addCookie(cook);
		// response.addHeader("P3P", "CP=CAO PSA OUR");
		response.addHeader("Access-Control-Allow-Origin", "*");
		
	};

}
