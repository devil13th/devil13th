package cn.thd.service.common;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.thd.bean.Option;
import cn.thd.pojo.common.SeAttach;
import cn.thd.pojo.common.SysDay;
import cn.thd.pojo.common.SysDicFunction;
import cn.thd.pojo.common.SysDicProcess;
import cn.thd.pojo.common.SysDicProcessStep;
import cn.thd.pojo.common.SysDicPub;
import cn.thd.pojo.common.SysDicStandardDoc;
import cn.thd.pojo.common.SysTimerList;

import com.thd.core.service.PubService;
import com.thd.util.Page;
/**
 * file autogenerated by ThirdteenDevils's CodeGenUtil 
 */
public interface CommonService extends PubService {
	
	/**
	 * 查询用户关系
	 * @param tab 表名
	 * @param kId 表主键的值
	 * @return 用户列表
	 */
	public List queryMapUser(String tab,String kId);
	
	/**
	 * 保存用户关系
	 * Method Description : ########
	 * @param tab 表
	 * @param kId 值
	 * @param userIds 用户ID
	 * @return
	 */
	public String saveMapUser(String tab,String kId,String userIds);
	
	/**
	 * 查询系统公共字典列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySysDicPub(Map<String,String> m , Page p);
	/**
	 * 获取字典分类列表-用于Servlet初始化
	 * Method Description : ########
	 * @return
	 */
	public List querySysDicClassify();
	/**
	 * 保存系统公共字典
	 * @param obj 系统公共字典对象
	 */
	public void saveSysDicPub(SysDicPub obj) ;
	/**
	 * 更新系统公共字典
	 * @param obj 系统公共字典对象
	 */
	public void updateSysDicPub(SysDicPub obj);
	/**
	 * 根据主键查询系统公共字典对象
	 * @param pk 主键
	 */
	public SysDicPub querySysDicPubById(java.lang.String pk);
	/**
	 * 初始化静态字典
	 * Method Description : ########
	 */
	public void initFixedDic();
	/**
	 * 获取固定字典列表
	 * Method Description : ########
	 * @param dicClassify 字典分类
	 * @return
	 */
	public List<Option> getFixedDicList(String dicClassify);
	/**
	 * 获取固定字典
	 * Method Description : ########
	 * @param dicClassify 字典分类
	 * @return
	 */
	public Map<String,String> getFixedDicMap(String dicClassify);
	
	
	/**
	 * 删除系统公共字典对象
	 * @param pk 主键
	 */
	public void deleteSysDicPubById(java.lang.String pk);
	/**
	 * 批量删除系统公共字典对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSysDicPubByIds(String ids);
	
	/**
	 * 根据字典类型查询字典值并转换成JSON字符串
	 * @param dicType 字典类型
	 * @return JSON字符串
	 */
	public String queryDicForJson(String dicType);
	/**
	 * 根据字典类型查询字典值
	 * @param dicType 字典类型
	 * @return List<Param>
	 */
	public List<Option> queryDicForOption(String dicType);
	/**
	 * 查询特殊字典-下拉菜单
	 * @param tabName 表名
	 * @param keyColumn 字典名称
	 * @param valueColumn 字典值
	 * @param isDeleteColumn 是否删除字段名
	 * @return
	 */
	public List<Option> querySpecialDicForOption(String tabName,String keyColumn,String valueColumn,String isDeleteColumn);
	
	/**
	 * 查询人员列表
	 * @return List<Param>
	 */
	public List<Option> queryUserForOption();
	
	/**
	 * 查询人员列表
	 * @return List<Param>
	 */
	public List<Option> queryUserForOptionKV();
	
	/**
	 * 查询某项目的人员列表
	 * @return List<Param>
	 */
	public List<Option> queryUserForOptionKV(String projectId);
	
	public List<Option> queryUserForOption(String SysId);
	
	
	/**
	 * 小小军团合战三国兵种攻击加成数据查询
	 * @param soliderType 兵种
	 * @param target 攻击|防守   gj|fs
	 * @return 数据列表
	 */
	public List queryXxjtHzsgData(String soliderType,String order);
	/**
	 * 修改密码
	 * Method Description : ########
	 * @param userId
	 * @param pwd
	 * @return
	 */
	public String updatePwd(String userId,String pwd);
	
	/**
	 * 查询定时器列表列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySysTimerList(Map<String,String> m , Page p);
	/**
	 * 保存定时器列表
	 * @param obj 定时器列表对象
	 */
	public void saveSysTimerList(SysTimerList obj) ;
	/**
	 * 更新定时器列表
	 * @param obj 定时器列表对象
	 */
	public void updateSysTimerList(SysTimerList obj);
	/**
	 * 根据主键查询定时器列表对象
	 * @param pk 主键
	 */
	public SysTimerList querySysTimerListById(java.lang.String pk);
	/**
	 * 删除定时器列表对象
	 * @param pk 主键
	 */
	public void deleteSysTimerListById(java.lang.String pk);
	/**
	 * 批量删除定时器列表对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSysTimerListByIds(String ids);
	/**
	 * 添加某定时任务
	 * Method Description : ########
	 * @param timerId
	 * @return
	 */
	public String addTimer(String timerId);
	/**
	 * 手工启动某定时任务
	 * Method Description : ########
	 * @param id
	 * @return
	 */
	public String startTimer(String timerId);
	/**
	 * 暂停某定时任务
	 * Method Description : ########
	 * @param id
	 * @return
	 */
	public String pauseTimer(String timerId);
	/**
	 * 立即执行一次定时任务
	 * Method Description : ########
	 * @param timerId
	 * @return
	 */
	public String runATimeTimer(String timerId);
	/**
	 * 重新加载定时任务
	 * Method Description : ########
	 * @param timerId
	 * @return
	 */
	public String reloadTimer(String timerId);
	
	
	
	/**
	 * 初始化某年工作日及休息日
	 * Method Description : ########
	 * @param year
	 * @return
	 */
	public String initYearDay(String year);
	/**
	 * 删除某年分下的所有自然日
	 * Method Description : ########
	 * @param year
	 * @return
	 */
	public String deleteYear(String year);
	/**
	 * 查询系统日历列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySysDay(Map<String,String> m , Page p);
	
	/**
	 * 查询系统日历年份列表
	 * Method Description : ########
	 * @param m
	 * @param p
	 * @return
	 */
	public List querySysDayYear(Map<String,String> m);
	/**
	 * 保存系统日历
	 * @param obj 系统日历对象
	 */
	public void saveSysDay(SysDay obj) ;
	/**
	 * 更新系统日历
	 * @param obj 系统日历对象
	 */
	public void updateSysDay(SysDay obj);
	/**
	 * 根据主键查询系统日历对象
	 * @param pk 主键
	 */
	public SysDay querySysDayById(java.lang.String pk);
	/**
	 * 删除系统日历对象
	 * @param pk 主键
	 */
	public void deleteSysDayById(java.lang.String pk);
	/**
	 * 批量删除系统日历对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSysDayByIds(String ids);
	/**
	 * 批量转换自然日类型
	 * Method Description : ########
	 * @param ids 自然日ID 多个ID用","隔开
	 * @return
	 */
	public String changetypeOfDay(String ids);
	
	/**
	 * 备份某表
	 * Method Description : ########
	 * @param className 类名
	 * @return
	 */
	public String backup(String className);
	/**
	 * 附件上传
	 * Method Description : ########
	 * @param file 附件
	 * @param path 保存位置
	 * @param fileName 文件名称
	 * @param fkey 外键类型
	 * @param fid 外键
	 * @return
	 */
	public SeAttach uploadFile(File file,String path,String fileName,String fkey,String fid);
	
	/**
	 * 删除某分类下的所有附件
	 * Method Description : ########
	 * @param key 类型
	 * @param id 类型对应的表ID
	 */
	public String deleteAttachByKeyAndId(String key,String id );
	
	/**
	 * 根据KEY和ID查询附件
	 * Method Description : ########
	 * @param key 类型
	 * @param id 类型对应的表ID
	 * @return
	 */
	public SeAttach queryAttachByKeyAndId(String key,String id);
	/**
	 * 下载文件
	 * @param id seAttach.id
	 */
	public void downloadFile(String id,HttpServletResponse res,HttpServletRequest req);
	/**
	 * 查询附件
	 * Method Description : ########
	 * @param key
	 * @param id
	 * @return
	 */
	public List queryCommonFileList(String key,String id);
	/**
	 * 删除公共附件
	 * Method Description : ########
	 * @param attachId 附件ID
	 * @return
	 */
	public String deleteCommonAttach(String attachId);
	/**
	 * 查询标准文档字典列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySysDicStandardDoc(Map<String,String> m , Page p);
	/**
	 * 保存标准文档字典
	 * @param obj 标准文档字典对象
	 */
	public void saveSysDicStandardDoc(SysDicStandardDoc obj) ;
	/**
	 * 更新标准文档字典
	 * @param obj 标准文档字典对象
	 */
	public void updateSysDicStandardDoc(SysDicStandardDoc obj);
	/**
	 * 根据主键查询标准文档字典对象
	 * @param pk 主键
	 */
	public SysDicStandardDoc querySysDicStandardDocById(java.lang.String pk);
	/**
	 * 删除标准文档字典对象
	 * @param pk 主键
	 */
	public void deleteSysDicStandardDocById(java.lang.String pk);
	/**
	 * 批量删除标准文档字典对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSysDicStandardDocByIds(String ids);
	
	
	
	
	/**
	 * 查询流程信息列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySysDicProcess(Map<String,String> m , Page p);
	/**
	 * 保存流程信息
	 * @param obj 流程信息对象
	 */
	public void saveSysDicProcess(SysDicProcess obj) ;
	/**
	 * 更新流程信息
	 * @param obj 流程信息对象
	 */
	public void updateSysDicProcess(SysDicProcess obj);
	/**
	 * 根据主键查询流程信息对象
	 * @param pk 主键
	 */
	public SysDicProcess querySysDicProcessById(java.lang.String pk);
	/**
	 * 删除流程信息对象
	 * @param pk 主键
	 */
	public void deleteSysDicProcessById(java.lang.String pk);
	/**
	 * 批量删除流程信息对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSysDicProcessByIds(String ids);
	
	/**
	 * 查询流程信息列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySysDicProcessStep(Map<String,String> m , Page p);
	/**
	 * 保存流程信息
	 * @param obj 流程信息对象
	 */
	public void saveSysDicProcessStep(SysDicProcessStep obj) ;
	/**
	 * 更新流程信息
	 * @param obj 流程信息对象
	 */
	public void updateSysDicProcessStep(SysDicProcessStep obj);
	/**
	 * 根据主键查询流程信息对象
	 * @param pk 主键
	 */
	public SysDicProcessStep querySysDicProcessStepById(java.lang.String pk);
	/**
	 * 根据主键查询流程信息对象
	 * @param pk 主键
	 */
	public SysDicProcessStep querySysDicProcessStepByStepCode(java.lang.String stepCode);
	/**
	 * 删除流程信息对象
	 * @param pk 主键
	 */
	public void deleteSysDicProcessStepById(java.lang.String pk);
	/**
	 * 批量删除流程信息对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSysDicProcessStepByIds(String ids);
	/**
	 * 同步流程
	 * @param deployId 流程部署ID
	 */
	public String syncProcess(String deployId);
	/**
	 * 查询功能字典列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySysDicFunction(Map<String,String> m , Page p);
	/**
	 * 保存功能字典
	 * @param obj 功能字典对象
	 */
	public void saveSysDicFunction(SysDicFunction obj) ;
	/**
	 * 更新功能字典
	 * @param obj 功能字典对象
	 */
	public void updateSysDicFunction(SysDicFunction obj);
	/**
	 * 根据主键查询功能字典对象
	 * @param pk 主键
	 */
	public SysDicFunction querySysDicFunctionById(java.lang.String pk);
	/**
	 * 删除功能字典对象
	 * @param pk 主键
	 */
	public void deleteSysDicFunctionById(java.lang.String pk);
	/**
	 * 批量删除功能字典对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSysDicFunctionByIds(String ids);
	/**
	 * 查询已选择的功能
	 * @param id 关联表ID
	 * @param classify 分类
	 */
	public List querySelectedFun(String id,String classify);
	/**
	 * 保存功能关系
	 * Method Description : ########
	 * @param id 关联表ID
	 * @param classify 分类
	 * @param funs 功能列表
	 */
	public void saveSelectedFun(String id,String classify,List funs);
	
	/**
	 * 查询菜单关系
	 * Method Description : ########
	 * @param classify 分类
	 * @param tabId 表ID
	 */
	public List queryFunByTabidAndClassify(String classify,String tabId);
	
}