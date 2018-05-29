package cn.thd.service.backlog;

import java.util.List;
import java.util.Map;

import cn.thd.dto.DataTableBean;
import cn.thd.pojo.backlog.BacklogInfo;

import com.thd.core.service.PubService;
import com.thd.util.Page;

public interface BacklogInfoService extends PubService{
	/**
	 * 根据ID查询backlog
	 * @param id
	 * @return
	 */
	public BacklogInfo queryBacklogById(String id);
	/**
	 * 保存backlog(自动取号)
	 * @param bli
	 */
	public void saveBacklogInfo(BacklogInfo bli) throws Exception;
	/**
	 * 更新backlog
	 * @param bli
	 */
	public void updateBacklogInfo(BacklogInfo bli);
	/**
	 * 保存/更新待办
	 * @param bli 待办对象
	 */
	public void updateBacklog(BacklogInfo bli);
	/**
	 * 查询待办
	 * @param m 查询条件
	 * @return 待办列表
	 */
	public List queryBacklog(Map<String,String> m,Page p);
	
	/**
	 * 创建空备忘
	 * @return 待办编号
	 */
	public BacklogInfo createBlankBacklog();
	
	/**
	 * 创建备忘
	 * @return 待办编号
	 */
	public BacklogInfo createBacklog(BacklogInfo bli);
	
	/**
	 * 清空待办
	 * @return 成功返回success
	 * 
	 */
	public String deleteAll();
	/**
	 * 根据id删除某待办
	 * @param blId
	 */
	public void deleteBacklog(String blId);
	/**
	 * 完成某待办
	 * @param blId 待办Id
	 */
	public void fnshOver(String blId);
	/**
	 * 某日完成待办
	 * Method Description : ########
	 * @param blId 待办Id
	 * @param datetime 完成待办时间
	 * @return 成功返回success 否则返回错误原因
	 */
	public String fnshDate(String blId,String datetime);
	/**
	 * 展期某待办
	 * @param blId 待办Id
	 */
	public void delayOneDay(String blId);
	
	/**
	 * 保存/更新 待办记事
	 * @param blId 待办Id
	 * @param note 记事内容
	 */
	public void saveOrUpdateNote(String blId,String note);
	
	/**
	 * 查询待办记事
	 * @param blId 待办Id
	 */
	public String queryNote(String blId);
	
	/**
	 * 某天处理某个待办
	 * @param blId 待办Id
	 * @param date 处理日期
	 * @return 成功返回success 否则返回错误信息
	 */
	public String dealDate(String blId,String date);
	
	/**
	 * 当天处理某个待办
	 * @param blId 待办Id
	 * @return  成功返回success 否则返回错误信息
	 */
	public String dealToday(String blId);
	
	/**
	 * 某天是否处理过某待办
	 * @param blId 待办Id
	 * @param date 处理日期
	 * @return 处理过：true 未处理过:false
	 */
	public String isDealDate(String blId,String date);
	
	/**
	 * 删除某天是否处理过某待办
	 * @param blId 待办Id
	 * @param date 处理日期
	 * @return 处理过：true 未处理过:false
	 */
	public String deleteDealDate(String blId,String date);
	
	public DataTableBean queryBacklogForUser(String userName,String todoStatus,Page p);
	
	public DataTableBean queryBacklogForIndexPlugin(DataTableBean dtb);
	/**
	 * 查询遗留备忘详细信息
	 * @param blId 遗留备忘ID
	 * @return
	 */
	public Map queryBacklogDetail(String blId);
	
	/**
	 * 查询某时间段内开始、完成、参与的待办
 	 * @param startDate 开始日期
	 * @param endDate 结束日期
	 * @return
	 */
	public List queryBacklogForPeriod(String startDate,String endDate);
	
	/**
	 * 计划条目加到待办中
	 * @param id 计划条目ID
	 * @return backlogId
	 */
	public String transferPlanItemToBacklog(String id);
}
