package cn.thd.action.backlog;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;
import cn.thd.bean.LoginUserInfo;
import cn.thd.bean.StaticVar;
import cn.thd.dto.DataTableBean;
import cn.thd.pojo.backlog.BacklogInfo;
import cn.thd.service.backlog.BacklogInfoService;
import cn.thd.service.common.CommonService;
import cn.thd.service.se.SeService;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ibm.icu.util.Calendar;
import com.thd.core.action.PubAction;
import com.thd.util.DateFormart;
import com.thd.util.ExportUtil;
import com.thd.util.JsonObject;

public class BacklogAction extends PubAction {
	@Resource
	private BacklogInfoService backlogInfoService;
	@Resource
	private SeService seService;
	@Resource
	private CommonService commonService;
	private BacklogInfo bli = new BacklogInfo();
	
	private GsonBuilder builder = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss");
	private Gson gson = builder.create();
	private String acceptJson ;
	private String blNo;
	private String note;
	//导出
	private String export;

	
	
	/**
	 * 新增/编辑会议界面
	 * url:/backlog/backlog!backlogInfoForm.do
	 */
	public String backlogInfoForm(){
		try{
			this.logger.info("backlogInfoForm()");
			if(this.bli.getBlId()!=null){
				//seMeeting = this.seService.querySeMeetingById(seMeeting.getMettingCode());	
				this.bli = this.backlogInfoService.queryBacklogById(this.getBli().getBlId());
				this.setOperate("update");
			}else{
				this.setOperate("save");
			}
			
			List blType = this.commonService.queryDicForOption("backlog_type");
			List blSys = this.commonService.queryDicForOption("backlog_sys");
			List userList = this.commonService.queryUserForOptionKV();
			this.getRequest().put("blType", blType);
			this.getRequest().put("blSys", blSys);
			this.getRequest().put("userList", userList);
			
			LoginUserInfo lui = (LoginUserInfo)this.getReq().getSession().getAttribute("loginUserInfo");
			List projectList = seService.queryMyProject(lui.getUserId());
			this.getRequest().put("projectList", projectList);
			
			
			this.setForwardPage("/pages/backlog/backlogInfoForm.jsp");
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	
	/**
	 * 保存或更新会议提交操作
	 * url:/backlog/backlog!backlogInfoFormSubmit.do
	 */
	public String backlogInfoFormSubmit(){
		try{
			this.logger.info("seMeetingEditSubmit()");
			if("save".equals(this.getOperate())){
				this.backlogInfoService.saveBacklogInfo(this.getBli());
			}else{
				this.backlogInfoService.updateBacklogInfo(this.getBli());
			}
			this.setMsg(StaticVar.STATUS_SUCCESS);
//			this.setScriptContent("alert('操作成功');getParent().reloadSeMeetingDg();");
//			this.setUrl("se/se!seMeetingForm.do?seMeeting.mettingCode=" + this.seMeeting.getMettingCode());
//			return "msg";
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
			//return this.err(e);
		}
		return "ajax";
	}
	
	
	/**
	 * 选择界面
	 * @return
	 */
	public String backlogSelect(){
		this.getLog().info("backlogSelect()");
		try{
			this.setForwardPage("/pages/backlog/backlogSelect.jsp");
			System.out.println(this.backlogInfoService);
			this.getLog().info(this.getForwardPage());
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	/**
	 * 主界面
	 * @return
	 */
	public String backlog(){
		this.getLog().info("backlog()");
		try{
			this.setForwardPage("/pages/backlog/backlog.jsp");
			System.out.println(this.backlogInfoService);
			this.getLog().info(this.getForwardPage());
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	/**
	 * ajax获取主页列表
	 * @return
	 */
	public String backlogGetData(){
		this.getLog().info("backlogGetData()");
		try{
			this.setForwardPage("/pages/backlog/backlog.jsp");
			
			Map<String,String> conditions = new HashMap<String,String>();
			conditions.put("blId", this.getReq().getParameter("blId"));
			conditions.put("blContent", this.getReq().getParameter("blContent"));
			conditions.put("blLevel", this.getReq().getParameter("blLevel"));
			conditions.put("blClassify", this.getReq().getParameter("blClassify"));
			conditions.put("blStatus", this.getReq().getParameter("blStatus"));
			conditions.put("blExpireMin", this.getReq().getParameter("blExpireMin"));
			conditions.put("blExpireMax", this.getReq().getParameter("blExpireMax"));
			conditions.put("blStartMin", this.getReq().getParameter("blStartMin"));
			conditions.put("blStartMax", this.getReq().getParameter("blStartMax"));
			conditions.put("blFnshMin", this.getReq().getParameter("blFnshMin"));
			conditions.put("blFnshMax", this.getReq().getParameter("blFnshMax"));
			conditions.put("issuer", this.getReq().getParameter("issuer"));
			conditions.put("executer", this.getReq().getParameter("executer"));
			conditions.put("createMin", this.getReq().getParameter("createMin"));
			conditions.put("createMax", this.getReq().getParameter("createMax"));
			conditions.put("blAlarmStatus", this.getReq().getParameter("blAlarmStatus"));
			conditions.put("dealMin", this.getReq().getParameter("dealMin"));
			conditions.put("dealMax", this.getReq().getParameter("dealMax"));
			conditions.put("blSys", this.getReq().getParameter("blSys"));
			
			if(!"1".equals(this.getExport())){
				this.getLog().info("query backlog data...");
				this.p.setCurrentPage(Integer.parseInt(this.getReq().getParameter("page")));
				this.p.setPageSize(Integer.parseInt(this.getReq().getParameter("rows")));
				
				List l = this.backlogInfoService.queryBacklog(conditions,this.p);
				this.setJsonList(gson.toJson(l));
				this.setTotal(String.valueOf(p.getListSize()));
				return "json";
			}else{
				this.getLog().info(" export excel... ");
				List l = this.backlogInfoService.queryBacklog(conditions,null);
				
				//System.out.println(l);
				String mapProStr = "blId,blContent,blLevel,expireDate,blIssueUser,blExeUser,expireDays,expireStatus,blClassifyName";
				String colNameStr = "编号,待办内容,优先级,期限,签发人,执行人,剩余天,状态,分类";
				
				this.getResp().setContentType("application/vnd.ms-excel");  
				this.getResp().setHeader("Content-Disposition", "inline; filename=backlog.xls");  
	            
				ExportUtil.ExportXlsForMap(l, this.getResp().getOutputStream(), mapProStr, colNameStr);
				
				
				return null;
			}
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	/**
	 * ajax创建一个遗留备忘
	 * @return
	 */
	public String createBlankBacklog(){
		this.getLog().info("createBlankBacklog()");
		JsonObject jo = new JsonObject();
		try{
			//List l = this.backlogInfoService.queryBacklog(new HashMap(),null);
			bli = this.backlogInfoService.createBlankBacklog();
			//this.setJsonList(gson.toJson(l));
			//this.setTotal(String.valueOf(l.size()));
			jo.setStatus("success");
			jo.setObjJson(bli);
		}catch(Exception e){
			jo.setStatus("err");
			jo.setErrMsg(e.getMessage());
			e.printStackTrace();
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	/**
	 * 删除某备忘
	 * @return
	 */
	public String deleteBacklog(){
		this.getLog().info("deleteBacklog()");
		JsonObject jo = new JsonObject();
		try{
			this.backlogInfoService.deleteBacklog(blNo);
			jo.setStatus("success");
		}catch(Exception e){
			jo.setStatus("err");
			jo.setErrMsg(e.getMessage());
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	/**
	 * 完成一个待办
	 * @return
	 */
	public String fnshOver(){
		this.getLog().info("fnshOver()");
		JsonObject jo = new JsonObject();
		try{
			this.backlogInfoService.fnshOver(blNo);
			jo.setStatus("success");
		}catch(Exception e){
			jo.setStatus("err");
			jo.setErrMsg(e.getMessage());
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	/**
	 * 某日完成一个待办
	 * @return
	 */
	public String toFnshOver(){
		this.getLog().info("toFnshOver()");
		JsonObject jo = new JsonObject();
		try{
			String date = DateFormart.toString(new Date());
			if(this.bli.getBlMes()!=null){
				date = this.bli.getBlMes();
			}
			String result = this.backlogInfoService.fnshDate(this.getBlNo(),date);
			if(result.equals("success")){
				jo.setStatus("success");
			}else{
				jo.setStatus("err");
				jo.setErrMsg(result);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			jo.setStatus("err");
			jo.setErrMsg("操作失败");
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	/**
	 * 展期待办
	 * @return
	 */
	public String delayOneDay(){
		this.getLog().info("fnshOver()");
		JsonObject jo = new JsonObject();
		try{
			this.backlogInfoService.delayOneDay(blNo);
			jo.setStatus("success");
		}catch(Exception e){
			jo.setStatus("err");
			jo.setErrMsg(e.getMessage());
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	
	/**
	 * 删除所有遗留备忘
	 * @return
	 */
	public String removeAll(){
		this.getLog().info("removeAll()");
		JsonObject jo = new JsonObject();
		try{
			String r = this.backlogInfoService.deleteAll();
			if("success".equals(r)){
				jo.setStatus("success");
				jo.setObjJson(null);
				this.setMsg(gson.toJson(jo));
				
			}else{
				jo.setStatus("err");
				jo.setErrMsg(r);
				this.setMsg(gson.toJson(jo));
			}
			return "ajax";
		}catch(Exception e){
			jo.setStatus("err");
			jo.setErrMsg(e.getMessage());
			return this.err(e);
		}
	}
	
	/**
	 * 保存所有编辑的遗留备忘
	 * @return
	 */
	public String savePerBackInfo(){
		this.getLog().info("savePerBackInfo()");
		JsonObject jo = new JsonObject();
		try{
			bli = gson.fromJson(this.acceptJson, BacklogInfo.class);
			
			//JSONObject jObj = JSONObject.fromObject(this.acceptJson);
			//BacklogInfo bli = (BacklogInfo)JSONObject.toBean(jObj,BacklogInfo.class);
			
			
			this.backlogInfoService.updateBacklog(bli);
			jo.setStatus("success");
		}catch(Exception e){
			jo.setStatus("err");
			jo.setErrMsg(this.getBlNo());
			e.printStackTrace();
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	
	/**
	 * 新增/修改 待办记事
	 * @return
	 */
	public String saveOrUpdateNote(){
		this.getLog().info("saveOrUpdateNote()");
		JsonObject jo = new JsonObject();
		try{
			this.backlogInfoService.saveOrUpdateNote(this.getBlNo(), this.getNote());
			jo.setStatus("success");
		}catch(Exception e){
			e.printStackTrace();
			jo.setStatus("err");
			jo.setErrMsg(e.getMessage());
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	public String queryNote(){
		this.getLog().info("queryNote()");
		JsonObject jo = new JsonObject();
		try{
			note = this.backlogInfoService.queryNote(this.getBlNo());
			jo.setStatus("success");
			jo.setErrMsg(note);
		}catch(Exception e){
			jo.setStatus("err");
			jo.setErrMsg(e.getMessage());
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	
	public String dealDate(){
		this.getLog().info("dealDate()");
		JsonObject jo = new JsonObject();
		try{
			String date = DateFormart.toString(new Date());
			if(this.bli.getBlMes()!=null){
				date = this.bli.getBlMes();
			}
			if("1".equals(this.bli.getBlStatus())){
				this.backlogInfoService.dealDate(this.getBlNo(),date);
			}else{
				this.backlogInfoService.deleteDealDate(this.getBlNo(), date);
			}
			jo.setStatus("success");
		}catch(Exception e){
			e.printStackTrace();
			jo.setStatus("err");
			jo.setErrMsg("操作失败");
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	
	public String queryDealToday(){
		this.getLog().info("queryDealToday()");
		try{
			String date = DateFormart.toString(new Date());
			this.setMsg(this.backlogInfoService.isDealDate(this.getBlNo(),date));
		}catch(Exception e){
			this.setMsg("false");
		}
		return "ajax";
		
	}
	
	public String queryBacklogInfo(){
		this.getLog().info("queryBacklogInfo()");
		try{
			String date = DateFormart.toString(new Date());
			this.setMsg(this.backlogInfoService.isDealDate(this.getBlNo(),date));
			
			String res = "{";
			res += "\"dealToday\":\"" + this.backlogInfoService.isDealDate(this.getBlNo(),date) + "\",";
			this.bli = (BacklogInfo)this.backlogInfoService.findById(BacklogInfo.class, this.getBlNo());
			res += "\"blStatus\":\"" + this.bli.getBlStatus() + "\"";
			
			res += "}";
			this.setMsg(res);
		}catch(Exception e){
			this.setMsg("false");
		}
		return "ajax";
		
	}
	
	
	
	
	/**
	 * 用户待办展示
	 * @return
	 */
	public String backlogForUser(){
		this.getLog().info("backlogForUser()");
		try{
			this.setForwardPage("/pages/backlog/backlogForUser.jsp");
			System.out.println(this.backlogInfoService);
			this.getLog().info(this.getForwardPage());
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	/**
	 * 用户待办展示 数据获取
	 * @return
	 */
	public String backlogForUserGetData(){
		this.getLog().info("backlogForUserGetData()");
		try{
			this.setForwardPage("/pages/backlog/backlogForUser.jsp");
			
			int start = Integer.parseInt(this.getReq().getParameter("start").toString());
			int pageSize = Integer.parseInt(this.getReq().getParameter("length").toString());
			this.p.setCurrentPage(start/pageSize + 1);
			this.p.setPageSize(pageSize);
			
			DataTableBean dtb = this.backlogInfoService.queryBacklogForUser("", "1",this.p);
			this.getLog().info(this.getForwardPage());
			this.setMsg(gson.toJson(dtb));
			return "ajax";
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	/**
	 * 用户待办展示 详细信息
	 * @return
	 */
	public String backlogForUserDetail(){
		this.getLog().info("backlogForUserDetail()");
		try{
			this.setForwardPage("/pages/backlog/backlogForUserDetail.jsp");
			//bli = (BacklogInfo)this.backlogInfoService.findById(BacklogInfo.class, this.bli.getBlId());
			Map bli = this.backlogInfoService.queryBacklogDetail(this.bli.getBlId());
			String note = this.backlogInfoService.queryNote(this.bli.getBlId());
			this.getRequest().put("bli",bli);
			this.getRequest().put("note",note);
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	/**
	 * 快速创建遗留备忘
	 * @return
	 */
	public String fastCreateBacklog(){
		this.getLog().info("fastCreateBacklog()");
		try{
			this.setForwardPage("/pages/backlog/fastCreateBacklog.jsp");
			
			Calendar c = Calendar.getInstance();
			c.setTime(new Date());
			c.set(Calendar.HOUR, 23);
			c.set(Calendar.MINUTE, 59);
			c.add(Calendar.DAY_OF_MONTH, 1);
			//System.out.println(c.getTime());
			bli.setStartDate(new Date());
			bli.setFnshDate(c.getTime());
			bli.setBlLevel(3);
			bli.setBlClassify("todo");
			bli.setExpireDate(c.getTime());
			
			//init dic option
			List blType = this.commonService.queryDicForOption("backlog_type");
			List blSys = this.commonService.queryDicForOption("backlog_sys");
			List userList = this.commonService.queryUserForOptionKV();
			this.getRequest().put("blType", blType);
			this.getRequest().put("blSys", blSys);
			this.getRequest().put("userList", userList);
			
			LoginUserInfo lui = (LoginUserInfo)this.getReq().getSession().getAttribute("loginUserInfo");
			List projectList = seService.queryMyProject(lui.getUserId());
			this.getRequest().put("projectList", projectList);
			
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	/**
	 * 快速创建遗留备忘 提交数据
	 * @return
	 */
	public String fastCreateBacklogSave(){
		this.getLog().info("fastCreateBacklogSave()");
		try{
			this.setForwardPage("/pages/backlog/fastCreateBacklog.jsp");
			
			JsonObject jo = new JsonObject();
			try{
				GsonBuilder builder = new GsonBuilder().setDateFormat("yyyy-MM-dd");
				Gson gson = builder.create();
				bli = (BacklogInfo)gson.fromJson(this.acceptJson, BacklogInfo.class);
				this.backlogInfoService.createBacklog(bli);
				jo.setStatus("success");
			}catch(Exception e){
				jo.setStatus("err");
				jo.setErrMsg(this.getBlNo());
				e.printStackTrace();
			}
			this.setMsg(gson.toJson(jo));
			return "ajax";
			
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	
	/**
	 * 将计划添加到待办中
	 * @return
	 */
	public String transferPlanItemToBacklog(){
		this.getLog().info("transferPlanItemToBacklog");
		JsonObject jo = new JsonObject();
		try{
			String result = this.backlogInfoService.transferPlanItemToBacklog(this.getIds());
			jo.setStatus("success");
			jo.setObjJson(result);
		}catch(Exception e){
			e.printStackTrace();
			jo.setStatus("err");
			jo.setErrMsg(e.getMessage());
		}
		this.setMsg(gson.toJson(jo));
		return "ajax";
	}
	
	
	
	
	
	
	
	
	
	public String getAcceptJson() {
		return acceptJson;
	}

	public void setAcceptJson(String acceptJson) {
		this.acceptJson = acceptJson;
	}

	public String getBlNo() {
		return blNo;
	}

	public void setBlNo(String blNo) {
		this.blNo = blNo;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}
	
	public BacklogInfo getBli() {
		return bli;
	}

	public void setBli(BacklogInfo bli) {
		this.bli = bli;
	}
	public String getExport() {
		return export;
	}
	public void setExport(String export) {
		this.export = export;
	}
	
}
