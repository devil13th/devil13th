package cn.thd.service.se;

import java.util.List;
import java.util.Map;

import cn.thd.bean.DataGrid;
import cn.thd.bean.LoginUserInfo;
import cn.thd.bean.MenuBean;
import cn.thd.dto.DataTableBean;
import cn.thd.pojo.se.SeAuth;
import cn.thd.pojo.se.SeDayNote;
import cn.thd.pojo.se.SeDayPlan;
import cn.thd.pojo.se.SeMapProjectUser;
import cn.thd.pojo.se.SeMeeting;
import cn.thd.pojo.se.SeMeetingRecord;
import cn.thd.pojo.se.SeMenu;
import cn.thd.pojo.se.SePersonLog;
import cn.thd.pojo.se.SeProjectDoc;
import cn.thd.pojo.se.SeProjectInfo;
import cn.thd.pojo.se.SePubModule;
import cn.thd.pojo.se.SeRequirementTrace;
import cn.thd.pojo.se.SeRisk;
import cn.thd.pojo.se.SeRole;
import cn.thd.pojo.se.SeTraceDefect;
import cn.thd.pojo.se.SeTraceDefectRepair;
import cn.thd.pojo.se.SeTraceKey;
import cn.thd.pojo.se.SeTraceNote;
import cn.thd.pojo.se.SeTraceTask;
import cn.thd.pojo.se.SeUser;
import cn.thd.pojo.se.SeUserRewardAmerce;

import com.thd.core.service.PubService;
import com.thd.util.Page;
/**
 * file autogenerated by ThirdteenDevils's CodeGenUtil 
 */
public interface SeService extends PubService {
	/**
	 * 查询项目日志列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeDayNote(Map<String,String> m , Page p);
	public DataTableBean querySeDayNote(DataTableBean dtb);
	/**
	 * 保存项目日志
	 * @param obj 项目日志对象
	 */
	public void saveSeDayNote(SeDayNote obj) ;
	/**
	 * 更新项目日志
	 * @param obj 项目日志对象
	 */
	public void updateSeDayNote(SeDayNote obj);
	/**
	 * 根据主键查询项目日志对象
	 * @param pk 主键
	 */
	public SeDayNote querySeDayNoteById(java.lang.String pk);
	/**
	 * 删除项目日志对象
	 * @param pk 主键
	 */
	public void deleteSeDayNoteById(java.lang.String pk);
	/**
	 * 批量删除项目日志对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeDayNoteByIds(String ids);
	
	/**
	 * 查询矩阵属性列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeTraceKey(Map<String,String> m , Page p);
	/**
	 * 用于ajax查找某个矩阵树功能
	 * Method Description : ########
	 * @param m
	 * @param p
	 * @return
	 */
	public List traceFileter(String key);
	/**
	 * 保存矩阵属性
	 * @param obj 矩阵属性对象
	 */
	public void saveSeTraceKey(SeTraceKey obj) ;
	/**
	 * 更新矩阵属性
	 * @param obj 矩阵属性对象
	 */
	public void updateSeTraceKey(SeTraceKey obj);
	/**
	 * 根据主键查询矩阵属性对象
	 * @param pk 主键
	 */
	public SeTraceKey querySeTraceKeyById(java.lang.String pk);
	/**
	 * 删除矩阵属性对象
	 * @param pk 主键
	 */
	public void deleteSeTraceKeyById(java.lang.String pk);
	/**
	 * 批量删除矩阵属性对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeTraceKeyByIds(String ids);
	/**
	 * 查询某矩阵下的属性集合
	 * @param traceId 矩阵ID 
	 * @param proType 属性类型  CLOB:大文本   STRING:非大文本字段  ALL:全部
	 * @return 矩阵属性集合
	 */
	public List queryTracePros(String traceId,String proType);
	/**
	 * 保存矩阵属性
	 * @param traceId 矩阵ID
	 * @param params 矩阵属性集合
	 */
	public void saveTracePros(String traceId,List<Map<String,String>> params);
	/**
	 * 根据矩阵ID与属性名称查询 矩阵属性对象
	 * @param traceId 矩阵ID
	 * @param key 属性名称
	 * @return 矩阵属性对象
	 */
	public SeTraceKey queryTraceKeyByTraceIdAndKey(String traceId,String key);
	/**
	 * 根据矩阵ID与属性名称查询 矩阵属性值
	 * @param traceId 矩阵ID
	 * @param key 属性名称
	 * @return 某矩阵的某属性值
	 */
	public String queryTraceValueByTraceIdAndKey(String traceId,String key);
	/**
	 * 根据矩阵ID与属性名称查询 矩阵属性值对象
	 * @param traceId 矩阵ID
	 * @param key 属性名称
	 * @return 某矩阵的某属性值对象 
	 */
	public Object queryTraceValueObjByTraceIdAndKey(String traceId,String key);
	/**
	 * 拷贝矩阵属性
	 * @param sourceTraceId 源矩阵ID
	 * @param targetTraceId 目标矩阵ID
	 */
	public void copyTracePro(String sourceTraceId,String targetTraceId);
	
	/**
	 * 属性继承
	 * @param traceId 矩阵ID
	 * @param direction 继承方向 U：继承父节点  D:覆盖子孙节点
	 */
	public void traceProExtend(String traceId,String direction);
	
	/**
	 * 根据矩阵ID查询矩阵对象
	 * @param nodeId 矩阵ID
	 * @return 矩阵对象
	 */
	public SeRequirementTrace queryNodeById(String nodeId);
	
	/**
	 * 查询矩阵记事列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeTraceNote(Map<String,String> m , Page p);
	
	/**
	 * 我的矩阵遗留备忘
	 * Method Description : ########
	 * @param dtb
	 * @return
	 */
	public DataTableBean queryMySeTraceNote(DataTableBean dtb);
	/**
	 * 查询遗留备忘具体内容
	 * Method Description : ########
	 * @param noteId 遗留备忘ID
	 * @return
	 */
	public String queryContentOfTraceNote(String noteId);
	/**
	 * 保存矩阵记事
	 * @param obj 矩阵记事对象
	 */
	public void saveSeTraceNote(SeTraceNote obj) ;
	/**
	 * 保存(或落实保存) 遗留备忘
	 * Method Description : ########
	 * @param id 遗留备忘ID
	 * @param content 描述
	 * @param status 1：保存并落实  0：仅保存
	 */
	public void saveSeTraceNoteContent(String id,String content,String status,String modifier) ;
	/**
	 * 更新矩阵记事
	 * @param obj 矩阵记事对象
	 */
	public void updateSeTraceNote(SeTraceNote obj);
	/**
	 * 根据主键查询矩阵记事对象
	 * @param pk 主键
	 */
	public SeTraceNote querySeTraceNoteById(java.lang.String pk);
	/**
	 * 删除矩阵记事对象
	 * @param pk 主键
	 */
	public void deleteSeTraceNoteById(java.lang.String pk);
	/**
	 * 批量删除矩阵记事对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeTraceNoteByIds(String ids);
	/**
	 * 查询项目风险列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeRisk(Map<String,String> m , Page p);
	/**
	 * 保存项目风险
	 * @param obj 项目风险对象
	 */
	public void saveSeRisk(SeRisk obj) ;
	/**
	 * 更新项目风险
	 * @param obj 项目风险对象
	 */
	public void updateSeRisk(SeRisk obj);
	/**
	 * 根据主键查询项目风险对象
	 * @param pk 主键
	 */
	public SeRisk querySeRiskById(java.lang.String pk);
	/**
	 * 删除项目风险对象
	 * @param pk 主键
	 */
	public void deleteSeRiskById(java.lang.String pk);
	/**
	 * 批量删除项目风险对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeRiskByIds(String ids);
	/**
	 * 查询项目风险列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeUser(Map<String,String> m , Page p);
	/**
	 * 查询系统用户(在岗)
	 * @param projectId 系统ID
	 * @return
	 */
	public List queryProjectUser(String projectId);
	/**
	 * 查询系统用户(全部)
	 * @param projectId 系统ID
	 * @return
	 */
	public List queryProjectUserForAll(String projectId);
	/**
	 * 保存项目风险
	 * @param obj 项目风险对象
	 */
	public void saveSeUser(SeUser obj) ;
	/**
	 * 更新项目风险
	 * @param obj 项目风险对象
	 */
	public void updateSeUser(SeUser obj);
	/**
	 * 验证用户名密码
	 * @param userName 用户名
	 * @param password 密码
	 * @return 成功返回success 否则返回错误代码
	 */
	public String validateUserAndPassword(String userName,String password);
	/**
	 * 根据主键查询项目风险对象
	 * @param pk 主键
	 */
	public SeUser querySeUserById(java.lang.String pk);
	/**
	 * 根据用户账号查询用户对象
	 * @param pk 主键
	 */
	public SeUser querySeUserByAccount(String account);
	/**
	 * 删除项目风险对象
	 * @param pk 主键
	 */
	public void deleteSeUserById(java.lang.String pk);
	/**
	 * 批量删除项目风险对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeUserByIds(String ids);
	/**
	 * 查询项目信息列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeProjectInfo(Map<String,String> m , Page p);
	
	/**
	 * 获取项目信息选项
	 * @return
	 */
	public List querySeProjectOptions();
	/**
	 * 保存项目信息
	 * @param obj 项目信息对象
	 */
	public void saveSeProjectInfo(SeProjectInfo obj) ;
	/**
	 * 更新项目信息
	 * @param obj 项目信息对象
	 */
	public void updateSeProjectInfo(SeProjectInfo obj);
	/**
	 * 根据主键查询项目信息对象
	 * @param pk 主键
	 */
	public SeProjectInfo querySeProjectInfoById(java.lang.String pk);
	/**
	 * 删除项目信息对象
	 * @param pk 主键
	 */
	public void deleteSeProjectInfoById(java.lang.String pk);
	/**
	 * 批量删除项目信息对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeProjectInfoByIds(String ids);
	
	/**
	 * 查询项目人员信息列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeMapProjectUser(Map<String,String> m , Page p);
	/**
	 * 保存项目人员信息
	 * @param obj 项目人员信息对象
	 */
	public void saveSeMapProjectUser(SeMapProjectUser obj) ;
	/**
	 * 更新项目人员信息
	 * @param obj 项目人员信息对象
	 */
	public void updateSeMapProjectUser(SeMapProjectUser obj);
	/**
	 * 根据主键查询项目人员信息对象
	 * @param pk 主键
	 */
	public SeMapProjectUser querySeMapProjectUserById(java.lang.String pk);
	/**
	 * 删除项目人员信息对象
	 * @param pk 主键
	 */
	public void deleteSeMapProjectUserById(java.lang.String pk);
	/**
	 * 批量删除项目人员信息对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeMapProjectUserByIds(String ids);
	
	/**
	 * 查询项目日志
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryUserLogForEdit(Map<String,String> m,Page p );
	/**
	 * 查询项目日志
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public DataGrid queryUserLog(Map<String,String> m,Page p );
	/**
	 * 更新日志
	 * @param log
	 */
	public void updateUserLog(SePersonLog log);
	/**
	 * 创建空白日志
	 */
	public SePersonLog createBlankUserLog();
	/**
	 * 删除用户日志对象
	 * @param pk 主键
	 */
	public void deleteSePersonLogById(java.lang.String pk);
	/**
	 * 批量删除用户日志对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSePersonLogByIds(String ids);
	
	/**
	 * 工作日志关联任务
	 * @param logIds 日志ID 多个ID用","隔开
	 * @param taskId 任务ID
	 * @return 成功返回SUCCESS 失败返回原因
	 */
	public String linkTaskForLog(String logIds,String taskId);
	/**
	 * 查询公共组件列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySePubModule(Map<String,String> m , Page p);
	/**
	 * 保存公共组件
	 * @param obj 公共组件对象
	 */
	public void saveSePubModule(SePubModule obj) ;
	/**
	 * 更新公共组件
	 * @param obj 公共组件对象
	 */
	public void updateSePubModule(SePubModule obj);
	/**
	 * 根据主键查询公共组件对象
	 * @param pk 主键
	 */
	public SePubModule querySePubModuleById(java.lang.String pk);
	/**
	 * 删除公共组件对象
	 * @param pk 主键
	 */
	public void deleteSePubModuleById(java.lang.String pk);
	/**
	 * 批量删除公共组件对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSePubModuleByIds(String ids);
	/**
	 * 查询待办任务列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeTraceTask(Map<String,String> m , Page p);
	
	/**
	 * 保存待办任务
	 * @param obj 待办任务对象
	 */
	public void saveSeTraceTask(SeTraceTask obj) ;
	/**
	 * 更新待办任务
	 * @param obj 待办任务对象
	 */
	public void updateSeTraceTask(SeTraceTask obj);
	/**
	 * 用于ajax更新矩阵任务
	 * Method Description : ########
	 * @param id 任务ID
	 * @param obj 更新的对象
	 * @param nullProperties 置空的属性
	 * @return 成功返回SUCCESS 否则返回错误原因
	 */
	public String updateSeTraceTaskForAjax(String id,SeTraceTask obj, Object[] nullProperties);
	/**
	 * 更新任务进度
	 * Method Description : ########
	 * @param taskId 任务ID
	 * @param process 进度
	 */
	public void updateProcessOfTraceTask(String taskId,Integer process);
	/**
	 * 根据主键查询待办任务对象
	 * @param pk 主键
	 */
	public SeTraceTask querySeTraceTaskById(java.lang.String pk);
	/**
	 * 删除待办任务对象
	 * @param pk 主键
	 */
	public void deleteSeTraceTaskById(java.lang.String pk);
	/**
	 * 批量删除待办任务对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeTraceTaskByIds(String ids);
	
	/**
	 * 个人任务转日志
	 * @param userIds 人员ID,多个人员用","隔开
	 * @param taskId 任务ID
	 * @param date 日期
	 * @param workLoad 时长(小时)
	 */
	public void transformATaskToLog(String userIds,String taskId,String date,Float workLoad);
	
	/**
	 * 查询人员奖惩记录列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeUserRewardAmerce(Map<String,String> m , Page p);
	/**
	 * 保存人员奖惩记录
	 * @param obj 人员奖惩记录对象
	 */
	public void saveSeUserRewardAmerce(SeUserRewardAmerce obj) ;
	/**
	 * 更新人员奖惩记录
	 * @param obj 人员奖惩记录对象
	 */
	public void updateSeUserRewardAmerce(SeUserRewardAmerce obj);
	/**
	 * 根据主键查询人员奖惩记录对象
	 * @param pk 主键
	 */
	public SeUserRewardAmerce querySeUserRewardAmerceById(java.lang.String pk);
	/**
	 * 删除人员奖惩记录对象
	 * @param pk 主键
	 */
	public void deleteSeUserRewardAmerceById(java.lang.String pk);
	/**
	 * 批量删除人员奖惩记录对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeUserRewardAmerceByIds(String ids);
	
	/**
	 * 用户视图获取任务信息
	 * @param m
	 * @param p
	 * @return
	 */
	public List queryTaskListForUserView(Map<String,String> m , Page p);
	/**
	 * 用户视图获取备忘信息
	 * @param m
	 * @param p
	 * @return
	 */
	public List queryNoteListForUserView(Map<String,String> m , Page p);
	public List queryLogListForUserView(Map<String,String> m , Page p);
	
	/**
	 * 获取所有节点信息  用于ztree simple data
	 * @param rootId 根节点ID
	 * @return 所有节点列表
	 */
	public List queryAllSeTrace(String rootId);
	
	
	public List seCountWorkLoadGetData(Map<String,String> m );
	public List seCountTaskGetData(Map<String,String> m );
	public List seCountTraceGetData(Map<String,String> m );
	
	public List seCountWorkLoadOfDay(Map<String,String> m);
	
	public DataTableBean seCountWorkLoadGetDataForBootstrap(DataTableBean dtb );
	public DataTableBean seCountTaskGetDataForBootstrap(DataTableBean dtb );
	
	
	
	
	/**
	 * 查询矩阵缺陷列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeTraceDefect(Map<String,String> m , Page p);
	
	public DataTableBean queryMySeTraceDefect(DataTableBean dtb);
	/**
	 * 保存矩阵缺陷
	 * @param obj 矩阵缺陷对象
	 */
	public void saveSeTraceDefect(SeTraceDefect obj) ;
	/**
	 * 更新矩阵缺陷
	 * @param obj 矩阵缺陷对象
	 */
	public void updateSeTraceDefect(SeTraceDefect obj);
	/**
	 * 根据主键查询矩阵缺陷对象
	 * @param pk 主键
	 */
	public SeTraceDefect querySeTraceDefectById(java.lang.String pk);
	/**
	 * 删除矩阵缺陷对象
	 * @param pk 主键
	 */
	public void deleteSeTraceDefectById(java.lang.String pk);
	/**
	 * 批量删除矩阵缺陷对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeTraceDefectByIds(String ids);
	
	/**
	 * 查询某缺陷的图片信息
	 * Method Description : ########
	 * @param defectId 缺陷ID
	 * @return
	 */
	public String queryContentOfTraceDefect(String defectId);
	/**
	 * 更新缺陷状态
	 * Method Description : ########
	 * @param defectId 缺陷ID
	 * @param status 状态
	 * @param userId 操作用户
	 * @param desc 描述
	 */
	public void updateTraceDefectStatus(String defectId,String status,String userId,String desc);
	/**
	 * 查询问题修改状态历史列表
	 * Method Description : ########
	 * @param defectId 缺陷ID
	 * @return
	 */
	public List queryTraceDefectStatusList(String defectId);
	
	/**
	 * 查询矩阵缺陷列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeTraceDefectRepair(Map<String,String> m , Page p);
	/**
	 * 保存矩阵缺陷
	 * @param obj 矩阵缺陷对象
	 */
	public void saveSeTraceDefectRepair(SeTraceDefectRepair obj) ;
	/**
	 * 更新矩阵缺陷
	 * @param obj 矩阵缺陷对象
	 */
	public void updateSeTraceDefectRepair(SeTraceDefectRepair obj);
	/**
	 * 根据主键查询矩阵缺陷对象
	 * @param pk 主键
	 */
	public SeTraceDefectRepair querySeTraceDefectRepairById(java.lang.String pk);
	/**
	 * 删除矩阵缺陷对象
	 * @param pk 主键
	 */
	public void deleteSeTraceDefectRepairById(java.lang.String pk);
	/**
	 * 批量删除矩阵缺陷对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeTraceDefectRepairByIds(String ids);
	
	/**
	 * 查询我的项目
	 * @param userId 用户ID
	 * @return
	 */
	public List queryMyProject(String userId);
	/**
	 * 给某个矩阵任务派工
	 * @param traceTaskId 矩阵任务ID
	 * @param userIds 人员ID  多个人员用","隔开
	 * @return
	 */
	public String assignOperator(String traceTaskId,String userIds);
	/**
	 * 查询系统角色列表(jsp管理界面使用)
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeRoleForList(Map<String,String> m , Page p);
	/**
	 * 查询系统角色列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeRole(Map<String,String> m , Page p);
	/**
	 * 保存系统角色
	 * @param obj 系统角色对象
	 */
	public void saveSeRole(SeRole obj) ;
	/**
	 * 更新系统角色
	 * @param obj 系统角色对象
	 */
	public void updateSeRole(SeRole obj);
	/**
	 * 根据主键查询系统角色对象
	 * @param pk 主键
	 */
	public SeRole querySeRoleById(java.lang.String pk);
	/**
	 * 删除系统角色对象
	 * @param pk 主键
	 */
	public void deleteSeRoleById(java.lang.String pk);
	/**
	 * 批量删除系统角色对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeRoleByIds(String ids);
	
	/**
	 * 查询用户系统/项目 角色
	 * Method Description : ########
	 * @param projectId 如果是null或空字符串则查询系统角色  否则查询项目角色
	 * @param userId 用户ID
	 * @return
	 */
	public List queryUserRole(String projectId,String userId);
	/**
	 * 保存用户角色
	 * Method Description : ########
	 * @param projectId 项目ID(有则是保存项目角色否则为系统角色)
	 * @param userId 用户ID
	 * @param roleCodes 角色CODE
	 * @return 成功返回SUCCESS
	 */
	public String saveUserRole(String projectId,String userId,String roleCodes);
	/**
	 * 	获取登录用户信息
	 * Method Description : ########
	 * @param userAccount 用户账号
	 * @return
	 */
	public LoginUserInfo createLoginUserInfo(String userAccount);
	
	/**
	 * 查询系统菜单列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeMenu(Map<String,String> m , Page p);
	/**
	 * 保存系统菜单
	 * @param obj 系统菜单对象
	 * @param parentId 父节点ID,如果增加根节点请设置为空
	 */
	public void saveSeMenu(SeMenu obj,String parentId) ;
	/**
	 * 更新系统菜单
	 * @param obj 系统菜单对象
	 */
	public void updateSeMenu(SeMenu obj);
	/**
	 * 根据主键查询系统菜单对象
	 * @param pk 主键
	 */
	public SeMenu querySeMenuById(java.lang.String pk);
	/**
	 * 查询菜单列表-treegrid
	 * Method Description : ########
	 * @param m 查询条件
	 * @param id 父节点ID(查询子节点用)
	 * @param p 分页信息(只有第一级节点才使用)  当id参数有值的时候该参数无效
	 * @return
	 */
	public List querySeMenuForDataGrid(String id, Page p);
	/**
	 * 查询菜单列表-ztree
	 * Method Description : ########
	 * @return
	 */
	public List querySeMenuForZtree();
	/**
	 * 根据MenuID查询树形代码
	 * @param menuId 菜单ID
	 * @return
	 */
	public String queryTreeCodeById(String menuId);
	/**
	 * 根据树形代码查询菜单
	 * @param treeCode 树形代码
	 * @return
	 */
	public SeMenu querySeMenuByTreeCode(String treeCode);
	/**
	 * 查询某节点的父节点
	 * Method Description : ########
	 * @param id 子节点ID
	 * @return
	 */
	public SeMenu querySeMenuOfParent(String id);
	/**
	 * 删除系统菜单对象
	 * @param pk 主键
	 */
	public void deleteSeMenuById(java.lang.String pk);
	/**
	 * 批量删除系统菜单对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeMenuByIds(String ids);
	/**
	 * 查询权限字典列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeAuth(Map<String,String> m , Page p);
	/**
	 * 保存权限字典
	 * @param obj 权限字典对象
	 */
	public void saveSeAuth(SeAuth obj) ;
	/**
	 * 更新权限字典
	 * @param obj 权限字典对象
	 */
	public void updateSeAuth(SeAuth obj);
	/**
	 * 根据主键查询权限字典对象
	 * @param pk 主键
	 */
	public SeAuth querySeAuthById(java.lang.String pk);
	/**
	 * 删除权限字典对象
	 * @param pk 主键
	 */
	public void deleteSeAuthById(java.lang.String pk);
	/**
	 * 批量删除权限字典对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeAuthByIds(String ids);
	/**
	 * 查询某角色的权限
	 * Method Description : ########
	 * @param roleCode 角色Code
	 * @return
	 */
	public List queryAuthOfRole(String roleCode);
	/**
	 * 查询某角色的菜单
	 * Method Description : ########
	 * @param roleCode 角色Code
	 * @return
	 */
	public List queryMenuOfRole(String roleCode);
	/**
	 * 保存角色与权限关系
	 * Method Description : ########
	 * @param roleCode 角色CODE
	 * @param authCodes 权限CODE  多个用","隔开
	 * @return
	 */
	public String saveAuthOfRole(String roleCode,String authCodes);
	/**
	 * 保存角色与菜单关系
	 * Method Description : ########
	 * @param roleCode 角色CODE
	 * @param menuIds 菜单ID  多个用","隔开
	 * @return
	 */
	public String saveMenuOfRole(String roleCode,String menuIds);
	/**
	 * 某人在某项目中是否有某权限
	 * Method Description : ########
	 * @param userId 人员ID
	 * @param projectId 项目ID
	 * @param authCode 权限CODE
	 * @return 有权限返回YES  无权限返回NO
	 */
	public String hasAuth(String userId,String projectId,String authCode);
	/**
	 * 某人在某项目中的权限
	 * Method Description : ########
	 * @param userId 人员ID
	 * @param projectId 项目ID
	 * @return Map<authCode,YES>
	 */
	public Map<String,String> queryAuth(String userId,String projectId);
	/**
	 * 查询某人的菜单
	 * Method Description : ########
	 * @param userId 用户
	 * @param parentCode 父节点CODE,例如查询第一级目录则为root
	 * @param level 菜单等级  如果是查询全部子菜单则为null即可
	 * @param onlyLeaf 是否只查询叶子节点  1:是   其他值:否
	 * @return
	 */
	public List<MenuBean> queryMenuOfUser(String userId,String parentCode , Integer level,String onlyLeaf);
	/**
	 * 查询用户权限
	 * Method Description : ########
	 * @param userId 用户ID
	 * @return
	 */
	public List queryAuthOfUser(String userId);
	/**
	 * 查询用户菜单
	 * Method Description : ########
	 * @param userId 用户ID
	 * @return
	 */
	public List queryMenuOfUser(String userId);
	/**
	 * 查询会议列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeMeeting(Map<String,String> m , Page p);
	/**
	 * 查询会议列表
	 * @param dtb DataTableBean 查询条件及分页信息及返回数据
	 * @return
	 */
	public DataTableBean querySeMeetingForBootstrap(DataTableBean dtb);
	
	/**
	 * 查询风险列表
	 * @param dtb DataTableBean 查询条件及分页信息及返回数据
	 * @return
	 */
	public DataTableBean querySeRiskForBootstrap(DataTableBean dtb);
	
	/**
	 * 查询公共模块列表
	 * @param dtb DataTableBean 查询条件及分页信息及返回数据
	 * @return
	 */
	public DataTableBean querySePubModuleForBootstrap(DataTableBean dtb);
	
	/**
	 * 保存会议
	 * @param obj 会议对象
	 */
	public void saveSeMeeting(SeMeeting obj) ;
	/**
	 * 更新会议
	 * @param obj 会议对象
	 */
	public void updateSeMeeting(SeMeeting obj);
	/**
	 * 根据主键查询会议对象
	 * @param pk 主键
	 */
	public SeMeeting querySeMeetingById(java.lang.String pk);
	/**
	 * 删除会议对象
	 * @param pk 主键
	 */
	public void deleteSeMeetingById(java.lang.String pk);
	/**
	 * 批量删除会议对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeMeetingByIds(String ids);
	
	/**
	 * 查询会议记录列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeMeetingRecord(Map<String,String> m , Page p);
	/**
	 * 保存会议记录
	 * @param obj 会议记录对象
	 */
	public void saveSeMeetingRecord(SeMeetingRecord obj) ;
	/**
	 * 更新会议记录
	 * @param obj 会议记录对象
	 */
	public void updateSeMeetingRecord(SeMeetingRecord obj);
	/**
	 * 根据主键查询会议记录对象
	 * @param pk 主键
	 */
	public SeMeetingRecord querySeMeetingRecordById(java.lang.String pk);
	/**
	 * 删除会议记录对象
	 * @param pk 主键
	 */
	public void deleteSeMeetingRecordById(java.lang.String pk);
	/**
	 * 批量删除会议记录对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeMeetingRecordByIds(String ids);
	/**
	 * 查询会议要点
	 * Method Description : ########
	 * @param meetingCode 会议CODE
	 * @param classify 条目分类
	 * @return
	 */
	public DataTableBean querySeMeetingRecordForMetting(String meetingCode,String classify);
	/**
	 * 查询项目文档列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeProjectDoc(Map<String,String> m , Page p);
	/**
	 * 保存项目文档
	 * @param obj 项目文档对象
	 */
	public void saveSeProjectDoc(SeProjectDoc obj) ;
	/**
	 * 更新项目文档
	 * @param obj 项目文档对象
	 */
	public void updateSeProjectDoc(SeProjectDoc obj);
	/**
	 * 根据主键查询项目文档对象
	 * @param pk 主键
	 */
	public SeProjectDoc querySeProjectDocById(java.lang.String pk);
	/**
	 * 删除项目文档对象
	 * @param pk 主键
	 */
	public void deleteSeProjectDocById(java.lang.String pk);
	/**
	 * 根据附件Id删除文档
	 * Method Description : ########
	 * @param attachId 附件ID
	 */
	public void deleteSeProjectDocByAttachId(java.lang.String attachId);
	/**
	 * 批量删除项目文档对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeProjectDocByIds(String ids);
	
	/** 查询个人天计划列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeDayPlan(Map<String,String> m , Page p);
	/**
	 * 保存个人天计划
	 * @param obj 个人天计划对象
	 */
	public void saveSeDayPlan(SeDayPlan obj) ;
	/**
	 * 更新个人天计划
	 * @param obj 个人天计划对象
	 */
	public void updateSeDayPlan(SeDayPlan obj);
	/**
	 * 根据主键查询个人天计划对象
	 * @param pk 主键
	 */
	public SeDayPlan querySeDayPlanById(java.lang.String pk);
	/**
	 * 删除个人天计划对象
	 * @param pk 主键
	 */
	public void deleteSeDayPlanById(java.lang.String pk);
	/**
	 * 批量删除个人天计划对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeDayPlanByIds(String ids);
	/**
	 * 查询天计划-portal
	 * @param dtb 
	 */
	public DataTableBean queryDayPlanForIndexPlugin(DataTableBean dtb);
	/**
	 * 快速保存天计划条目
	 * Method Description : ########
	 * @param planContent 计划内容
	 * @param userId 用户ID
	 * @return 条目ID
	 */
	public String saveSimpleSeDayPlan(String dayPlanId,String planContent,String userId);
	
}
