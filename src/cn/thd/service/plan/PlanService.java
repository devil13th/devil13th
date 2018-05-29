/** 
 * Class Description:########
 * Date : 2017年1月24日 上午10:22:10
 * Auth : wanglei 
*/  

package cn.thd.service.plan;

import java.util.List;
import java.util.Map;

import cn.thd.dto.DataTableBean;
import cn.thd.pojo.plan.PlanExecution;
import cn.thd.pojo.plan.PlanInfo;
import cn.thd.pojo.plan.PlanSummary;

import com.thd.core.service.PubService;
import com.thd.util.Page;

public interface PlanService  extends PubService{
	/**
	 * 创建计划编号
	 * @return  PI+4位年份+2位月份+2位周次
	 */
	public String createPlanNo(int year,int count,String planClassify) throws Exception;
	
	/**
	 * 创建计划信息
	 * @param year 年份
	 * @param count 周/月 数(根据planType参数决定是周还是月)
	 * @param planClassify 计划种类  WEEK:周计划  MONTH:月计划  参见 StaticVar.Plan_XXX
	 * @return 成功返回""
	 */
	public PlanInfo createPlanInfo(int year,int count,String planClassify)  throws Exception;
	
	/**
	 * 是否存在某计划
	 * @param year 年份
	 * @param count 周/月 数(根据planType参数决定是周还是月)
	 * @param planClassify 计划种类  WEEK:周计划  MONTH:月计划  参见 StaticVar.Plan_XXX
	 * @return
	 */
	public boolean existPlan(int year,int count,String planClassify) throws Exception;
	
	/**
	 * 查询周/月计划信息
	 * @param year 年份
	 * @param count 周/月 数(根据planType参数决定是周还是月)
	 * @param planClassify 计划种类  WEEK:周计划  MONTH:月计划  参见 StaticVar.Plan_XXX
	 * @return 
	 * @throws Exception
	 */
	public String queryPlanInfo(int year,int count,String planClassify) ;
	/**
	 * 查询计划-datatables
	 * @return DataTableBean
	 */
	public DataTableBean queryPlan();
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 将任务加入到执行计划中
	 * Method Description : ########
	 * @param taskIds  seTraceTask矩阵任务ID  多个ID用","隔开
	 * @param planCode	计划代码
	 * @return
	 */
	public String addTaskToPlan(String taskIds,String planCode);
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 保存任务计划/完成 描述内容
	 * @param projectId 项目ID
	 * @param planCode 计划CODE
	 * @param projectProgress 项目进度
	 * @param planRemark 计划概况
	 * @param finishRemark 完成情况
	 */
	public void saveRemarkOfPlanInfo(String projectId,String planCode,Integer projectProgress,String planRemark,String finishRemark);
	
	
	/**
	 * 根据ID查询计划执行情况
	 * @param planExecutionId 计划执行ID
	 * @return
	 */
	public PlanExecution queryPlanExecutionById(String planExecutionId);
	
	/**
	 * 更新计划执行信息
	 * @param execution 计划执行对象
	 * @return
	 */
	public String updatePlanExecution(PlanExecution execution);
	/**
	 * 更新计划执行条目的进度
	 * Method Description : ########
	 * @param executionId 执行ID
	 * @param progress 进度
	 * @return
	 */
	public String updateProgressOfExecution(String executionId,Integer progress);
	
	/**
	 * 删除计划执行信息
	 * @param executionId 计划执行ID
	 * @return
	 */
	public String removeTaskFromExecution(String executionId);
	
	/**
	 * 根据计划CODE查询计划信息
	 * @param planCode 计划CODE
	 * @return
	 */
	public PlanInfo queryPlanInfoByPlanCode(String planCode);
	/**
	 * 初始化某年的周、月计划
	 * @param year 分
	 * @throws Exception
	 */
	public void initPlanInfo(int year)  throws Exception;
	/**
	 * 查询某年周、月计划列表
	 * @param year 年份
	 */
	public List queryPlanInfoList(int year);
	/**
	 * 查询计划列表
	 * @param userId 人员账号
	 * @param planCode 计划CODE
	 * @param projectID 项目ID
	 * @return
	 */
	public DataTableBean queryPlanList(String userId,String planCode,String projectId);
	public DataTableBean queryPlanList(DataTableBean dtb);
	
	
	/**
	 * 查询上周/月计划
	 * @param planCode 周/月计划  
	 * @return 如果给定参数的分类是周计划则查询上一周计划  否则为上一月计划
	 */
	public PlanInfo queryPrevPlanInfo(String planCode);
	
	/**
	 * 查询下周/月计划
	 * @param planCode 周/月计划  
	 * @return 如果给定参数的分类是周计划则查询下一周计划  否则为下一月计划
	 */
	public PlanInfo queryNextPlanInfo(String planCode);
	
	/**
	 * 查询计划总结列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryPlanSummary(Map<String,String> m , Page p);
	/**
	 * 保存计划总结
	 * @param obj 计划总结关系对象
	 */
	public void savePlanSummary(PlanSummary obj) ;
	/**
	 * 更新计划总结
	 * @param obj 计划总结对象
	 */
	public void updatePlanSummary(PlanSummary obj);
	/**
	 * 根据主键查询计划总结对象
	 * @param pk 主键
	 */
	public PlanSummary queryPlanSummaryById(java.lang.String pk);
	/**
	 * 根据计划code和项目ID查询计划总结对象
	 * @param planCode 主键
	 * @param projectId 项目ID
	 */
	public PlanSummary queryPlanSummaryByPlanCodeAndProjectId(String planCode,String projectId);
	/**
	 * 删除计划总结对象
	 * @param pk 主键
	 */
	public void deletePlanSummaryById(java.lang.String pk);
	/**
	 * 批量删除计划总结对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deletePlanSummaryByIds(String ids);
	/**
	 * 复制计划执行条目到项目计划
	 * Method Description : ########
	 * @param executionId
	 * @param planCode
	 * @return x
	 */
	public String copyPlanExecutionToPlanInfo(String executionId,String planCode);
	/**
	 * 生成计划报告
	 * Method Description : ########
	 * @param webRootPath 项目根目录
	 * @param projectId 项目ID
	 * @param planCode 计划CODE
	 * @param fileType 生成文件类型  StaticVar.REPORTTYPE_WORD;
	 * @return 生成文件的路径
	 */
	public String createPlanReport(String webRootPath,String projectId,String planCode,String fileType);
	/**
	 * 生成计划报告并上传附件和项目文档
	 * Method Description : ########
	 * @param webRootPath webroot路径
	 * @param projectId 项目ID
	 * @param planCode 计划CODE
	 * @param fileType 生成文件类型  StaticVar.REPORTTYPE_WORD;
	 * @param uploader 上传人
	 * @return se_attach.id字段
	 */
	public String createPlanReportAndUpload(String webRootPath,String projectId,String planCode,String fileType,String uploader);
	
}
