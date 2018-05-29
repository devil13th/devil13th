package cn.thd.action.checklist;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import cn.thd.bean.DataGrid;
import cn.thd.bean.PropertyGrid;
import cn.thd.bean.PropertyGridItem;
import cn.thd.bean.TreeGrid;
import cn.thd.pojo.checklist.Checklist;
import cn.thd.pojo.checklist.ChecklistImplBatch;
import cn.thd.pojo.checklist.ChecklistImplResult;
import cn.thd.pojo.se.SeRequirementTrace;
import cn.thd.service.checklist.ChecklistService;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.thd.core.action.PubAction;
import com.thd.util.DateFormart;
import com.thd.util.MyDateUtils;
import com.thd.util.MyStringUtils;
import com.thd.util.StringUtil;
import com.thd.util.TreeUtil;

public class ChecklistAction extends PubAction {
	@Resource
	private ChecklistService checklistService;
	
	private Checklist checklist = new Checklist();
	

	private ChecklistImplBatch  checklistImplBatch = new ChecklistImplBatch();
	private ChecklistImplResult  checklistImplResult = new ChecklistImplResult();
	// 以下是选择所用参数
	
	//选择框类型 checkbox radio
	private String ckType ;
	//获取焦点的code  多个code用","隔开
	private String focusCodes;
	//打开节点code 多个code用","隔开
	private String openCodes;
	//被选中的code 多个code用","隔开
	private String checkCodes;
	
	//回调函数
	private String callBackPath;
	




	//frameset页
	//url:/checklist/checklist!index.do
	public String index(){
		try{
			this.setForwardPage("/pages/checklist/checklistFrame.jsp");
			Checklist t = new Checklist();
			if(StringUtil.isNotEmpty(checklist.getId())){
				t = this.checklistService.queryChecklistById(checklist.getId());
			}else{
				t = this.checklistService.queryRoot();
			}
			if(t!=null){
				this.checklist = t;
				return this.SUCCESS;
			}else{
				throw new Exception("未找到根节点");
			}
		}catch(Exception e){
			return this.err(e);
		}
	}
	
		
	//树形目录
	public String tree(){
		try{
			this.setForwardPage("/pages/checklist/checklist.jsp");
			Checklist t = new Checklist();
			if(StringUtil.isNotEmpty(checklist.getId())){
				t = this.checklistService.queryChecklistById(checklist.getId());
			}else{
				t = this.checklistService.queryRoot();
			}
			if(t!=null){
				this.checklist = t;
				return this.SUCCESS;
			}else{
				throw new Exception("未找到根节点");
			}
		}catch(Exception e){
			return this.err(e);
		}
	}
	
	//选择器
	public String checklistSelector(){
		try{
			this.setForwardPage("/pages/checklist/checklistSelector.jsp");
			Checklist t = new Checklist();
			if(StringUtil.isNotEmpty(checklist.getId())){
				t = this.checklistService.queryChecklistById(checklist.getId());
			}else{
				t = this.checklistService.queryRoot();
			}
			if(t!=null){
				this.checklist = t;
				return this.SUCCESS;
			}else{
				throw new Exception("未找到根节点");
			}
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	//下级节点获取数据
	//url:/checklist/checklist!getData.do
	public String getData(){
		try{
			this.setForwardPage("/pages/checklist/getData.jsp");
			String code = StringUtil.isEmpty(checklist.getTreeCode()) ? "root" : checklist.getTreeCode().trim();
			List<Map> l =  checklistService.queryNextChecklists(code);
			
//			GsonBuilder builder = new GsonBuilder();
//			Gson gson = builder.create();
//			String listStr = gson.toJson(l);
			this.getRequest().put("checklists", l);
			return this.SUCCESS;
		}catch(Exception e){
			return this.err(e);
		}
	}
	
	//编辑
	//url:/checklist/checklist!edit.do
	public String edit(){
		try{
			this.setForwardPage("/pages/checklist/edit.jsp");
			if(StringUtil.isEmpty(checklist.getId())){
				throw new Exception("未获取到树形代码");
			}
			checklist = checklistService.queryChecklistById(checklist.getId());
			if(checklist == null){
				throw new Exception("未找到该节点");
			}
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	//新增
	//url:/checklist/checklist!add.do
	public String add(){
		try{
			this.setForwardPage("/pages/checklist/checklistResult.jsp");
			if(StringUtil.isEmpty(checklist.getTreeCode())){
				throw new Exception("未获取到树形代码");
			}
			//tree.setTreeCode(tree.getTreeCode());
			
			Checklist parent = this.checklistService.queryChecklistByCode(checklist.getTreeCode());
			if(parent == null){
				throw new Exception("未找到父节点");
			}
			checklist.setParentId(parent.getId());
			checklist.setCklistName("新增子节点");
			checklist.setIsLeaf("1");
			checklist.setIsValid("1");
			checklist.setIsDelete("1");
			checklistService.saveChecklist(checklist);
			//this.setMsg("新增节点操作成功");
			
			//设置刷新节点的父节点
			//this.getRequest().put("refreshParent",TreeUtil.parentCode(tree.getTreeCode()));
			//设置刷新节点
			this.getRequest().put("refresh",TreeUtil.parentCode(checklist.getTreeCode()));
			//设置树形菜单焦点
			this.getRequest().put("focus",checklist.getTreeCode());
			
			
			this.setUrl("checklist!edit.do?operate=edit&checklist.id=" + checklist.getId());
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	
	//编辑提交
	//url:/checklist/checklist!editSubmit.do
	public String editSubmit(){
		try{
			this.setForwardPage("/pages/checklist/checklistResult.jsp");
			if(StringUtil.isNotEmpty(checklist.getId()) ){
				//编辑
				checklistService.update(checklist);
				this.setMsg("编辑操作成功");
				
				//设置刷新节点的父节点
				this.getRequest().put("refreshParent",checklist.getTreeCode());
				//设置树形菜单焦点
				this.getRequest().put("focus",checklist.getTreeCode());
			}
			this.setUrl("checklist!edit.do?operate=edit&checklist.id=" + checklist.getId());
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	
	//删除节点
	public String delete(){
		try{
			if(StringUtil.isEmpty(checklist.getId()) ){
				throw new Exception("请指定删除节点的id");
			}
			this.getLog().info("删除节点：" + checklist.getId());
			checklistService.deleteById(Checklist.class, checklist.getId());
			this.setMsg("success");
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	
	//检验项目表
	//url:/checklist/checklist!checklistTree.do
	public String checklistTree(){
		try{
			this.setForwardPage("/pages/checklist/checklistTree.jsp");
			System.out.println("1324");
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
		
	//检验项目表
	//url:/checklist/checklist!checklistTree.do
	public String checklistTreeGetData(){
		try{
			
			String checkListId ;
			if(StringUtil.isEmpty(this.checklist.getId())){
				checkListId = checklistService.queryRoot().getId();
			}else{
				checkListId = this.checklist.getId();
			}
			//TreeGrid tg = this.checklistService.queryAllChecklist(checkListId);
			List list = this.checklistService.queryChecklistPerformList(checkListId);
			DataGrid dg = new DataGrid();
			dg.setTotal(list.size());
			dg.setRows(list);
			GsonBuilder builder = new GsonBuilder();
			Gson gson = builder.create();
			String dataJson = gson.toJson(dg);
			this.setMsg(dataJson);
			return "ajax";
//			this.setForwardPage("/pages/checklist/xx.jsp");
//			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	
	
	
	
	
	//========================== 检查项目实施 ==========================//

	/**
	 *  检查批次列表展示界面
	 *  url:/checklist/checklist!checklistImplBatchList.do
	 */
	public String checklistImplBatchList(){
		try{
			this.logger.info("checklistImplBatchList()");
			this.setForwardPage("/pages/checklist/checklistImplBatchList.jsp");
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	/**
	 * ajax获取检查批次列表数据
	 * url:/checklist/checklist!checklistImplBatchListGetDate.do
	 */
	public String checklistImplBatchListGetDate(){
		try{
			this.logger.info("checklistImplBatchListGetDate()");
			
			StringBuffer json = new StringBuffer();
			GsonBuilder builder = new GsonBuilder();
			//Gson gson = builder.setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			Gson gson = builder.setDateFormat("yyyy-MM-dd").create();
			map.put("ID", this.getReq().getParameter("ID"));
			
			//
			map.put("CHECK_BATCH", this.getReq().getParameter("CHECK_BATCH"));
			//
			map.put("CHECK_USER", this.getReq().getParameter("CHECK_USER"));
			//
			map.put("CHECK_MODULE", this.getReq().getParameter("CHECK_MODULE"));
			//
			map.put("CHECKED_USER", this.getReq().getParameter("CHECKED_USER"));
			//
			map.put("CHECK_TIME", this.getReq().getParameter("CHECK_TIME"));
			//
			map.put("IS_DELETE", this.getReq().getParameter("IS_DELETE"));
			//
			map.put("CHECK_DESC", this.getReq().getParameter("CHECK_DESC"));
			
			//排序
			map.put("sort",getReq().getParameter("sort"));	
			map.put("order",getReq().getParameter("order"));	
			if(this.getRows() != 0){
				this.p.setPageSize(this.getRows());
			}
			if(this.getPage()!=0){
				this.p.setCurrentPage(this.getPage());
			}
			List l = this.checklistService.queryChecklistImplBatch(this.map, this.p);
			
			String listStr = gson.toJson(l);
			json.append("{\"total\":" + p.getListSize() + ",\"rows\":");
			if(l==null || l.size() < 1){
				listStr = "[]";
			}
			json.append(listStr);
			json.append("}");
			
			this.setMsg(json.toString());
			return "ajax";
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}

	/**
	 * 保存或更新检查批次提交操作
	 * url:/checklist/checklist!checklistImplBatchFormSubmit.do
	 */
	public String checklistImplBatchFormSubmit(){
		try{
			this.logger.info("checklistImplBatchEditSubmit()");
			if("save".equals(this.getOperate())){
				this.checklistService.saveChecklistImplBatch(this.checklistImplBatch);
			}else{
				this.checklistService.updateChecklistImplBatch(this.checklistImplBatch);
			}			
			this.setScriptContent("alert('操作成功');getParent().reloadDg();window.close()");
			return "msg";
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	/**
	 * 新增/编辑检查批次界面
	 * url:/checklist/checklist!checklistImplBatchForm.do
	 */
	public String checklistImplBatchForm(){
		try{
			this.logger.info("checklistImplBatchForm()");
			if(this.checklistImplBatch.getId()!=null){
				checklistImplBatch = this.checklistService.queryChecklistImplBatchById(checklistImplBatch.getId());				
				if(MyStringUtils.isNotEmpty(checklistImplBatch.getTraceId())){
					SeRequirementTrace trace = (SeRequirementTrace)this.checklistService.findById(SeRequirementTrace.class, checklistImplBatch.getTraceId());
					this.getRequest().put("trace", trace);
				}
				Checklist ckl = this.checklistService.queryChecklistById(checklistImplBatch.getChecklistId());
				this.getRequest().put("ckl",ckl);
				
				this.setOperate("update");
			}else{
				checklistImplBatch.setCheckBatch(MyDateUtils.toString(new Date(), "yyyyMMdd"));
				checklistImplBatch.setIsDelete("1");
				checklistImplBatch.setCheckTime(new Date());
				this.setOperate("save");
			}
			this.setForwardPage("/pages/checklist/checklistImplBatchForm.jsp");
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			return this.err(e);
		}
	}
	
	/**
	 * 删除单个检查批次对象操作
	 * url:/checklist/checklist!deleteChecklistImplBatchById.do?checklistImplBatch.id=xxx
	 */
	public String deleteChecklistImplBatchById(){
		try{
			this.logger.info("deleteChecklistImplBatchById()");
			this.checklistService.deleteChecklistImplBatchById(checklistImplBatch.getId());
			this.setMsg("success");
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	
	/**
	 * 批量删除检查批次对象操作
	 * url:/checklist/checklist!deleteChecklistImplBatchByIds.do?$ids=xxx
	 */
	public String deleteChecklistImplBatchByIds(){
		try{
			this.logger.info("deleteChecklistImplBatchByIds()");
			this.checklistService.deleteChecklistImplBatchByIds(this.getIds());
			this.setMsg("success");
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	
	
	/**
	 * 查询批次信息
	 * url:/checklist/checklist!queryChecklistImplBatchInfo.do?checklistImplBatch.id=xxx
	 */
	public String queryChecklistImplBatchInfo(){
		try{
			this.logger.info("deleteChecklistImplBatchByIds()");
			GsonBuilder builder = new GsonBuilder();
			Gson gson = builder.create();
			String jsonStr = ""; 
			PropertyGrid pd = new PropertyGrid();
			if(StringUtil.isNotEmpty(checklistImplBatch.getId())){
				checklistImplBatch = (ChecklistImplBatch)this.checklistService.findById(ChecklistImplBatch.class, checklistImplBatch.getId());
				pd.getRows().add( new PropertyGridItem("批次",checklistImplBatch.getCheckBatch(),"检查信息","text"));
				pd.getRows().add( new PropertyGridItem("检查人",checklistImplBatch.getCheckedUser(),"检查信息","text"));
				pd.getRows().add( new PropertyGridItem("检查时间",DateFormart.toString(checklistImplBatch.getCheckTime(),"yyyy-MM-dd HH:mm:ss"),"检查信息","datetimebox"));
				pd.getRows().add( new PropertyGridItem("备注",checklistImplBatch.getCheckDesc(),"检查信息","text"));
				pd.getRows().add( new PropertyGridItem("模块",checklistImplBatch.getCheckModule(),"检查对象信息","text"));
				pd.getRows().add( new PropertyGridItem("开发人",checklistImplBatch.getCheckUser(),"检查对象信息","text"));
				pd.setTotal(6);
				jsonStr = gson.toJson(pd);
			}else{
				jsonStr = gson.toJson(pd);
			}
			this.setMsg(jsonStr);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	
	
	/**
	 * 查询批次信息
	 * url:/checklist/checklist!queryChecklistInfoForJson.do?checklist.id=xxx
	 */
	public String queryChecklistInfoForJson(){
		try{
			this.logger.info("queryChecklistInfoForJson()");
			checklist = this.checklistService.queryChecklistById(checklist.getId());
			
			GsonBuilder builder = new GsonBuilder();
			Gson gson = builder.create();
			String jsonStr = gson.toJson(checklist);
			this.setMsg(jsonStr);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	
	/**
	 * 查询批次信息
	 * url:/checklist/checklist!queryCheckResult.do?checklist.id=xxx&checklistImplBatch.id=xxx
	 */
	public String queryCheckResult(){
		try{
			this.logger.info("queryChecklistInfoForJson()");
			String r = this.checklistService.queryCheckResult(checklist.getId(),checklistImplBatch.getId());
			this.setMsg(r);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	
	/**
	 * 查询批次信息
	 * url:/checklist/checklist!saveCheckResult.do?checklist.id=xxx&checklistImplBatch.id=xxx&checklistImplBatch.checkDesc=xxx
	 */
	public String saveCheckResult(){
		try{
			this.logger.info("saveCheckResult()");
			String r = this.checklistService.saveCheckResult(checklist.getId(),checklistImplBatch.getId(),checklistImplBatch.getCheckDesc());
			this.setMsg(r);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	/**
	 * 保存检查备注
	 * url:/checklist/checklist!queryCheckDesc.do
	 */
	public String queryCheckDesc(){
		try{
			this.logger.info("queryCheckDesc()");
			String r = this.checklistService.queryCheckDesc(checklistImplResult.getChecklistId(),checklistImplResult.getCheckBatch());
			this.setMsg(r);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	/**
	 * 保存检查备注
	 * url:/checklist/checklist!saveCheckDesc.do
	 */
	public String saveCheckDesc(){
		try{
			this.logger.info("saveCheckDesc()");
			String r = this.checklistService.saveCheckDesc(checklistImplResult.getChecklistId(),checklistImplResult.getCheckBatch(),checklistImplResult.getCheckDesc());
			this.setMsg(r);
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	
	
	/**
	 * 保存检查备注
	 * url:/checklist/checklist!export.do
	 */
	public String export(){
		try{
			this.logger.info("export()");
			this.setForwardPage("/pages/checklist/export.jsp");
			List l = this.checklistService.exportChecklist(this.getChecklist().getId());
			System.out.println(l);
			this.getRequest().put("ckList", l);
			return this.SUCCESS;
		}catch(Exception e){
			e.printStackTrace();
			this.setMsg(e.getMessage());
		}
		return "ajax";
	}
	
	
	public void setChecklistImplBatch( ChecklistImplBatch checklistImplBatch) {
		this.checklistImplBatch = checklistImplBatch;
	}
	public ChecklistImplBatch getChecklistImplBatch() {
		return checklistImplBatch;
	}
	public Checklist getChecklist() {
		return checklist;
	}



	public void setChecklist(Checklist checklist) {
		this.checklist = checklist;
	}



	public String getFocusCodes() {
		return focusCodes;
	}

	public void setFocusCodes(String focusCodes) {
		this.focusCodes = focusCodes;
	}

	public String getOpenCodes() {
		return openCodes;
	}

	public void setOpenCodes(String openCodes) {
		this.openCodes = openCodes;
	}

	public String getCheckCodes() {
		return checkCodes;
	}

	public void setCheckCodes(String checkCodes) {
		this.checkCodes = checkCodes;
	}

	public String getCkType() {
		return ckType;
	}

	public void setCkType(String ckType) {
		this.ckType = ckType;
	}
	
	public String getCallBackPath() {
		return callBackPath;
	}

	public void setCallBackPath(String callBackPath) {
		this.callBackPath = callBackPath;
	}


	public ChecklistImplResult getChecklistImplResult() {
		return checklistImplResult;
	}


	public void setChecklistImplResult(ChecklistImplResult checklistImplResult) {
		this.checklistImplResult = checklistImplResult;
	}
}
