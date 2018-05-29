package cn.thd.service.checklist;

import java.util.List;
import java.util.Map;

import cn.thd.bean.TreeGrid;
import cn.thd.pojo.checklist.Checklist;
import cn.thd.pojo.checklist.ChecklistImplBatch;

import com.thd.core.service.PubService;
import com.thd.util.Page;

public interface ChecklistService extends PubService {
	/**
	 * 根据树形代码获取下级子节点
	 * @param code 树形代码
	 * @return 子节点集合
	 */
	public List<Map> queryNextChecklists(String code);
	
	/**
	 * 根据树形代码查询节点对象
	 * @param code 树形代码
	 * @return 节点对象
	 */
	public Checklist queryChecklistByCode(String code);
	
	/**
	 * 查询最大属性代码的子节点
	 * @param code 树形代码
	 * @return 子节点中最大的属性代码
	 */
	public String queryMaxTreeCode(String code);
	
	/**
	 * 根据树形代码生成子节点代码
	 * @param code 树形代码
	 * @return 子节点代码
	 */
	public String makeChildCode(String code);
	/**
	 * 保存节点对象
	 * @return
	 */
	public void saveChecklist(Checklist checklist);
	
	
	/**
	 * 查询根节点
	 * Method Description : ########
	 * @return
	 */
	public Checklist queryRoot();
	
	/**
	 * 根据ID查询节点
	 * Method Description : ########
	 * @param id
	 * @return
	 */
	public Checklist queryChecklistById(String id);
	
	public TreeGrid queryAllChecklist(String id);
	/**
	 * 查询某次检查的的checklist
	 * Method Description : ########
	 * @param batchId 检查批次ID
	 * @return 本次检查的检查项目表及结果
	 */
	public List queryChecklistPerformList(String batchId);
	
	
	//========================== 检查项目实施 ==========================//
	
	/**
	 * 查询检查批次列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return 
	 */
	public List queryChecklistImplBatch(Map<String,String> m , Page p);
	/**
	 * 保存检查批次
	 * @param obj 检查批次对象
	 */
	public void saveChecklistImplBatch(ChecklistImplBatch obj) ;
	/**
	 * 更新检查批次
	 * @param obj 检查批次对象
	 */
	public void updateChecklistImplBatch(ChecklistImplBatch obj);
	/**
	 * 根据主键查询检查批次对象
	 * @param pk 主键
	 */
	public ChecklistImplBatch queryChecklistImplBatchById(java.lang.String pk);
	/**
	 * 删除检查批次对象
	 * @param pk 主键
	 */
	public void deleteChecklistImplBatchById(java.lang.String pk);
	/**
	 * 批量删除检查批次对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteChecklistImplBatchByIds(String ids);
	
	/**
	 * 查询某检查批次对应检验项目结果
	 * Method Description : ########
	 * @param checklistId
	 * @param batchId
	 * @return
	 */
	public String queryCheckResult(String checklistId,String batchId);
	
	/**
	 * 保存某检查批次对应检验项目结果
	 * Method Description : ########
	 * @param checklistId
	 * @param batchId
	 * @param value
	 * @return
	 */
	public String saveCheckResult(String checklistId,String batchId,String value);
	
	/**
	 * 保存某检查批次对应的检查项目的备注
	 * Method Description : ########
	 * @param checklistId
	 * @param batchId
	 * @param desc
	 * @return
	 */
	public String saveCheckDesc(String checklistId,String batchId,String desc);
	
	/**
	 * 查询某检验批次对应检查项目的备注
	 * Method Description : ########
	 * @param checklistId
	 * @param batchId
	 * @return
	 */
	public String queryCheckDesc(String checklistId,String batchId);
	/**
	 * 导出某节点及子节点
	 * @param treeCode 检验项目ID
	 * @return
	 */
	public List exportChecklist(String checklistId);
	
	
}
