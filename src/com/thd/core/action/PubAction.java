package com.thd.core.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.SessionAware;

import cn.thd.bean.LoginUserInfo;
import cn.thd.bean.StaticVarObj;

import com.opensymphony.xwork2.ActionSupport;
import com.thd.util.Page;

public class PubAction extends ActionSupport implements RequestAware, SessionAware {
	
	
	
	//Struts2 封装 HttpServletRequest 
	Map<String,Object> request;
	
	//Struts2 封装  HttpSession
	Map<String,Object> session;
	
	//日志
	private Logger log = Logger.getLogger(this.getClass());
	public Logger logger = Logger.getLogger(this.getClass());
	//分页信息
	public Page p = new Page();
	
	//查询条件
	public Map<String,String> map = new HashMap<String,String>();
	
	//多个id
	private String ids;
	
	private String id;
	
	private String jobno;
	private String taskId;
	
	public String getJobno() {
		return jobno;
	}

	public void setJobno(String jobno) {
		this.jobno = jobno;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	

	//回调函数
	private String cb;
		
	//Struts2 Action 返回的字符串
	public String forward;
	
	//显示信息页 是否是modaiDialog;
	private String modaiDialog;
	
	//信息页执行脚本的内容
	private String scriptContent;
	
	//信息页返回的数据
	private String returnValue;
	
	//信息页显示的信息
	private String msg;
	
	//信息也跳转地址
	private String url;
	
	//html代码
	private String html;
	
	//跳转jsp页地址
	private String forwardPage;
	
	//排序字段
	private String order;
	
	//排序方式
	private String sort;
	
	//json数据
	private String json;
	
	//操作
	private String operate;
	//用于easyui ajax获取列表的总页数 -- 查看json.jsp
	private String total;
	//用于easyui ajax获取列表的列表 -- 查看json.jsp
	private String jsonList;
	
	//easyui 分页
	//当前页
	private int page;
	//每页行数
	private int rows;
	
	private StaticVarObj staticVarObj;
	
	public LoginUserInfo getLoginUserInfo(){
		LoginUserInfo lui = (LoginUserInfo)this.getSession().get("loginUserInfo");
		return lui;
	}

	public String getJsonList() {
		return jsonList;
	}
	
	public void initStaticVarObj(){
		this.staticVarObj = StaticVarObj.getInstance(); 
		this.getReq().setAttribute("staticVarObj", this.getStaticVarObj());
	}

	public void setJsonList(String jsonList) {
		this.jsonList = jsonList;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

	public String getOperate() {
		return operate;
	}

	public void setOperate(String operate) {
		this.operate = operate;
	}

	//Struts2 Action 异常 设置forward
	public String err(Exception e){
		forward = "err";
		request.put("err",e.getMessage());
		return forward;
	}
	
	//获取HttpServletResponse 对象
	protected HttpServletResponse getResp() {
		return ServletActionContext.getResponse();
	}
		
	//获取HttpServletRequest 对象
	protected HttpServletRequest getReq() {
		return ServletActionContext.getRequest();
	}
	
	//获取HttpSession 对象
	protected HttpSession getSess() {
		return ServletActionContext.getRequest().getSession();
	}
	
	//依赖注入HttpServletRequest
	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}
	
	//依赖注入HttpSession
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	public String getModaiDialog() {
		return modaiDialog;
	}

	public void setModaiDialog(String modaiDialog) {
		this.modaiDialog = modaiDialog;
	}

	public String getScriptContent() {
		return scriptContent;
	}

	public void setScriptContent(String scriptContent) {
		this.scriptContent = scriptContent;
	}

	public String getReturnValue() {
		return returnValue;
	}

	public void setReturnValue(String returnValue) {
		this.returnValue = returnValue;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	
	
	public Map<String, Object> getRequest() {
		return request;
	}
	
	public Map<String, Object> getSession() {
		return session;
	}

	public String getJson() {
		return json;
	}

	public void setJson(String json) {
		this.json = json;
	}
	
	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	

	public Page getP() {
		return p;
	}

	public void setP(Page p) {
		this.p = p;
	}

	public String getForward() {
		return forward;
	}

	public void setForward(String forward) {
		this.forward = forward;
	}

	public Logger getLog() {
		return log;
	}

	public String getForwardPage() {
		return forwardPage;
	}

	public void setForwardPage(String forwardPage) {
		this.forwardPage = forwardPage;
	}

	public Map<String, String> getMap() {
		return map;
	}

	public void setMap(Map<String, String> map) {
		this.map = map;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public void setLog(Logger log) {
		this.log = log;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getCb() {
		return cb;
	}

	public void setCb(String cb) {
		this.cb = cb;
	}

	public String getHtml() {
		return html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public StaticVarObj getStaticVarObj() {
		return staticVarObj;
	}

	
	
	
	

}
