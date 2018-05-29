/** 
 * Class Description:########
 * Date : 2018年2月6日 上午9:38:17
 * Auth : ccse 
*/  

package cn.thd.service.pmp;

import java.util.List;
import java.util.Map;

import com.thd.core.service.PubService;
import com.thd.util.Page;

public interface PmpService  extends PubService {
	/**
	 * 查询过程组
	 * Method Description : ########
	 * @return
	 */
	public List queryProcessGroup();
	/**
	 * 查询知识领域
	 * Method Description : ########
	 * @return
	 */
	public List queryKnowledgeArea();
	/**
	 * 查询管理过程
	 * Method Description : ########
	 * @return
	 */
	public List queryProcess();
	/**
	 * 查询输入输出,工具与技术
	 * Method Description : ########
	 * @return
	 */
	public List queryItto();
	/**
	 * 查询管理过程 -  输入输出,工具与技术 的关系
	 * Method Description : ########
	 * @return
	 */
	public List queryProcessIttoRela();
	/**
	 * 查询管理过程
	 * Method Description : ########
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryProcessData(Map<String,String> m , Page p);
	/**
	 * 查询某个过程的输入输出或技术工具
	 * Method Description : ########
	 * @param processId 管理过程ID
	 * @param classify
	 * @param ittoName itto名称
	 * @return
	 */
	public List queryProcessIttoRela(String processId,String classify,String ittoName);
}
