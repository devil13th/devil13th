package cn.thd.service.se;

import java.util.List;
import java.util.Map;

import cn.thd.bean.EasyUiTreeBean;
import cn.thd.pojo.se.SeRequirementTrace;

import com.thd.core.service.PubService;
import com.thd.util.Page;

public interface SeRequirementTraceService extends PubService {
	/**
	 * 根据矩阵ID查询矩阵对象
	 * @param nodeId 矩阵ID
	 * @return 矩阵对象
	 */
	public SeRequirementTrace queryNodeById(String nodeId);
	/**
	 * 根据矩阵ID查询树形代码
	 * @param noteId 矩阵ID
	 * @return 树形代码
	 */
	public String queryTreeCodeById(String nodeId);
	/**
	 * 根据矩阵树码查询矩阵对象
	 * @param treeCode 树码
	 * @return 矩阵对象
	 */
	public SeRequirementTrace queryNodeByTreeCode(String treeCode);
	/**
	 * 查询矩阵根节点对象
	 * @param projectId 系统ID
	 * @return 矩阵对象
	 */
	public SeRequirementTrace queryRoot(String projectId);
	/**
	 * 查询矩阵根节点json
	 * @param projectId 系统ID
	 * @return 根节点json
	 */
	public String queryRootJson(String projectId);
	/**
	 * 根据树形代码查询下级矩阵列表
	 * @param projectId 系统ID
	 * @param code 树形代码
	 * @return 矩阵列表
	 */
	public List queryNextNodeByCode(String code,String projectId);
	/**
	 * 根据树形代码查询子孙矩阵列表
	 * @param code 树形代码
	 * @return 矩阵列表
	 */
	public List queryChildNodeByCode(String code);
	/**
	 * 根据矩阵节点ID查询父节点
	 * @param id 矩阵节点ID
	 * @return SeRequirementTrace对象
	 */
	public SeRequirementTrace queryParentNode(String id);
	/**
	 * 根据矩阵ID查询下级矩阵列表
	 * @param id 矩阵ID
	 * @return 矩阵列表
	 */
	public List queryNextNodeById(String id);
	
	/**
	 * 根据矩阵ID查询下级矩阵列表的JSON数据
	 * @param id 矩阵ID
	 * @return 矩阵列表的JSON数据
	 */
	public String queryNextNodeJsonById(String id);
	
	/**
	 * 将矩阵节点转为easyui所用类型
	 * @param trace 矩阵对象
	 * @return  easyui所用对象
	 */
	public Map<String,String> converterSeRequirementTractToNode(SeRequirementTrace trace);
	/**
	 * 创建新矩阵节点
	 * @param parentNodeId 父节点ID
	 * @return 新矩阵节点对象
	 */
	public SeRequirementTrace createNewNode(String parentNodeId);
	/**
	 * 新增矩阵节点
	 * @param parentNodeId 父节点ID
	 * @param trace 新增对象
	 * @return 成功返回success 失败返回错误原因
	 */
	public String saveNode(String parentNodeId,SeRequirementTrace trace);
	/**
	 * 编辑矩阵节点
	 * @param trace 矩阵节点对象
	 * @return 成功返回success 失败返回错误原因
	 */
	public String updateNode(SeRequirementTrace trace);
	
	/**
	 * 删除矩阵节点
	 * @param nodeId 矩阵节点ID
	 * @return 成功返回success 失败返回错误原因
	 */
	public String deleteNode(String nodeId);
	
	/**
	 * 移动节点
	 * @param targetId 目标矩阵对象ID
	 * @param sourceId 被移动的矩阵对象ID
	 * @param point 移动类型  top:移动到某节点上方  bottom:移动到某节点下方  append:移动到某节点内部
	 * @return 成功返回success 失败返回错误原因
	 */
	public String moveNode(String targetId,String sourceId,String point);
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
	 * 查询跟踪矩阵树列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List querySeRequirementTrace(Map<String,String> m , Page p);
	/**
	 * 保存跟踪矩阵树
	 * @param obj 跟踪矩阵树对象
	 */
	public void saveSeRequirementTrace(SeRequirementTrace obj) ;
	/**
	 * 更新跟踪矩阵树
	 * @param obj 跟踪矩阵树对象
	 */
	public void updateSeRequirementTrace(SeRequirementTrace obj);
	/**
	 * 根据主键查询跟踪矩阵树对象
	 * @param pk 主键
	 */
	public SeRequirementTrace querySeRequirementTraceById(java.lang.String pk);
	/**
	 * 删除跟踪矩阵树对象
	 * @param pk 主键
	 */
	public void deleteSeRequirementTraceById(java.lang.String pk);
	/**
	 * 批量删除跟踪矩阵树对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteSeRequirementTraceByIds(String ids);
	
	/**
	 * 获取某项目的需求矩阵所有节点
	 * @param projectId 项目ID
	 * @param treeCode 属性目录节点treecode 如果是null则为根节点
	 * @return
	 */
	public List<EasyUiTreeBean> queryTraceTreeData(String projectId,String treeCode);
	/**
	 * 查询跟踪矩阵任务联合列表
	 * @param projectId 项目ID
	 * @return
	 */
	public List querySeRequirementTraceTaskUnion(String projectId);
	/**
	 * 查询矩阵及任务
	 * Method Description : ########
	 * @param keyWord 关键字
	 * @param projectId 项目ID
	 * @return
	 */
	public List seRequirementTraceTaskUnionSearch(String keyWord,String projectId);
	
}
