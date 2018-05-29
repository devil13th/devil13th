package cn.thd.service.vita;

import java.util.List;
import java.util.Map;

import cn.thd.pojo.vita.VitaEduHis;
import cn.thd.pojo.vita.VitaInfo;
import cn.thd.pojo.vita.VitaProjectDuty;
import cn.thd.pojo.vita.VitaProjectHis;
import cn.thd.pojo.vita.VitaProjectTec;
import cn.thd.pojo.vita.VitaTechnical;
import cn.thd.pojo.vita.VitaWorkHis;

import com.thd.core.service.PubService;
import com.thd.util.Page;
/**
 * file autogenerated by ThirdteenDevils's CodeGenUtil 
 */
public interface VitaService extends PubService {
	/**
	 * 查询简历信息列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryVitaInfo(Map<String,String> m , Page p);
	/**
	 * 保存简历信息
	 * @param obj 简历信息对象
	 */
	public void saveVitaInfo(VitaInfo obj) ;
	/**
	 * 更新简历信息
	 * @param obj 简历信息对象
	 */
	public void updateVitaInfo(VitaInfo obj);
	/**
	 * 根据主键查询简历信息对象
	 * @param pk 主键
	 */
	public VitaInfo queryVitaInfoById(java.lang.String pk);
	/**
	 * 删除简历信息对象
	 * @param pk 主键
	 */
	public void deleteVitaInfoById(java.lang.String pk);
	/**
	 * 批量删除简历信息对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteVitaInfoByIds(String ids);
	
	/**
	 * 查询教育经历列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryVitaEduHis(Map<String,String> m , Page p);
	/**
	 * 保存教育经历
	 * @param obj 教育经历对象
	 */
	public void saveVitaEduHis(VitaEduHis obj) ;
	/**
	 * 更新教育经历
	 * @param obj 教育经历对象
	 */
	public void updateVitaEduHis(VitaEduHis obj);
	/**
	 * 根据主键查询教育经历对象
	 * @param pk 主键
	 */
	public VitaEduHis queryVitaEduHisById(java.lang.String pk);
	/**
	 * 删除教育经历对象
	 * @param pk 主键
	 */
	public void deleteVitaEduHisById(java.lang.String pk);
	/**
	 * 批量删除教育经历对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteVitaEduHisByIds(String ids);
	/**
	 * 查询项目经历列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryVitaProjectDuty(Map<String,String> m , Page p);
	/**
	 * 保存项目经历
	 * @param obj 项目经历对象
	 */
	public void saveVitaProjectDuty(VitaProjectDuty obj) ;
	/**
	 * 更新项目经历
	 * @param obj 项目经历对象
	 */
	public void updateVitaProjectDuty(VitaProjectDuty obj);
	/**
	 * 根据主键查询项目经历对象
	 * @param pk 主键
	 */
	public VitaProjectDuty queryVitaProjectDutyById(java.lang.String pk);
	/**
	 * 删除项目经历对象
	 * @param pk 主键
	 */
	public void deleteVitaProjectDutyById(java.lang.String pk);
	/**
	 * 批量删除项目经历对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteVitaProjectDutyByIds(String ids);
	
	/**
	 * 查询项目经历列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryVitaProjectHis(Map<String,String> m , Page p);
	/**
	 * 保存项目经历
	 * @param obj 项目经历对象
	 */
	public void saveVitaProjectHis(VitaProjectHis obj) ;
	/**
	 * 更新项目经历
	 * @param obj 项目经历对象
	 */
	public void updateVitaProjectHis(VitaProjectHis obj);
	/**
	 * 根据主键查询项目经历对象
	 * @param pk 主键
	 */
	public VitaProjectHis queryVitaProjectHisById(java.lang.String pk);
	/**
	 * 删除项目经历对象
	 * @param pk 主键
	 */
	public void deleteVitaProjectHisById(java.lang.String pk);
	/**
	 * 批量删除项目经历对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteVitaProjectHisByIds(String ids);
	/**
	 * 查询项目包含技术列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryVitaProjectTec(Map<String,String> m , Page p);
	/**
	 * 保存项目包含技术
	 * @param obj 项目包含技术对象
	 */
	public void saveVitaProjectTec(VitaProjectTec obj) ;
	/**
	 * 更新项目包含技术
	 * @param obj 项目包含技术对象
	 */
	public void updateVitaProjectTec(VitaProjectTec obj);
	/**
	 * 根据主键查询项目包含技术对象
	 * @param pk 主键
	 */
	public VitaProjectTec queryVitaProjectTecById(java.lang.String pk);
	/**
	 * 删除项目包含技术对象
	 * @param pk 主键
	 */
	public void deleteVitaProjectTecById(java.lang.String pk);
	/**
	 * 批量删除项目包含技术对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteVitaProjectTecByIds(String ids);
	/**
	 * 查询技能熟练度列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryVitaTechnical(Map<String,String> m , Page p);
	/**
	 * 保存技能熟练度
	 * @param obj 技能熟练度对象
	 */
	public void saveVitaTechnical(VitaTechnical obj) ;
	/**
	 * 更新技能熟练度
	 * @param obj 技能熟练度对象
	 */
	public void updateVitaTechnical(VitaTechnical obj);
	/**
	 * 根据主键查询技能熟练度对象
	 * @param pk 主键
	 */
	public VitaTechnical queryVitaTechnicalById(java.lang.String pk);
	/**
	 * 删除技能熟练度对象
	 * @param pk 主键
	 */
	public void deleteVitaTechnicalById(java.lang.String pk);
	/**
	 * 批量删除技能熟练度对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteVitaTechnicalByIds(String ids);
	/**
	 * 查询工作经历列表
	 * @param m 查询条件
	 * @param p 分页信息
	 * @return
	 */
	public List queryVitaWorkHis(Map<String,String> m , Page p);
	/**
	 * 保存工作经历
	 * @param obj 工作经历对象
	 */
	public void saveVitaWorkHis(VitaWorkHis obj) ;
	/**
	 * 更新工作经历
	 * @param obj 工作经历对象
	 */
	public void updateVitaWorkHis(VitaWorkHis obj);
	/**
	 * 根据主键查询工作经历对象
	 * @param pk 主键
	 */
	public VitaWorkHis queryVitaWorkHisById(java.lang.String pk);
	/**
	 * 删除工作经历对象
	 * @param pk 主键
	 */
	public void deleteVitaWorkHisById(java.lang.String pk);
	/**
	 * 批量删除工作经历对象
	 * @param ids 主键,多个主键用","隔开
	 */
	public void deleteVitaWorkHisByIds(String ids);
}