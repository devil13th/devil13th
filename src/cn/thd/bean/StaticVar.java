/** 
 * Class Description:########
 * Date : 2017年1月24日 下午2:16:45
 * Auth : wanglei 
*/  

package cn.thd.bean;

public class StaticVar {
	//月,周
	public static String PLAN_WEEK = "WEEK" ;
	public static String PLAN_MONTH = "MONTH";
	//是否成功
	public static String STATUS_SUCCESS ="SUCCESS";
	public static String STATUS_FAILURE = "FAILURE";
	//是否删除
	public static String ISDELETE_DELETED = "0";
	public static String ISDELETE_UNDELETE = "1";
	//是否在岗
	public static String ISPOS_ONPOSITION = "1";
	public static String ISPOS_UNPOSITION = "0";
	//是否叶子节点
	public static String ISLEAF_LEAF = "1";
	public static String ISLEAF_FOLDER = "0";
	//是否有效
	public static String ISVALID_VALID="1";
	public static String ISVALID_INVALID = "0";
	//jwt秘钥
	public static String JWTSECURITYSTR = "devil13th123456";
	
	
	//休息日工作日
	public static String DAYSTATUS_WORK="WORK";//工作日
	public static String DAYSTATUS_REST = "REST";//休息日
	
	//角色分类
	public static String ROLECLASSIFY_SYSTEM = "SYSTEM";//系统角色
	public static String ROLECLASSIFY_PROJECT = "PROJECT";//项目角色
	
	//是否字典
	public static String Y = "Y";//有权限
	public static String N = "N";//没有权限
	
	//会议条目分类
	public static String MEETING_TODO = "TODO";//待落实项
	public static String MEETING_ITEM = "ITEM";//纪要要点
	
	//流程状态
	public static String PROCESSSTATUS_DELETE="0";//删除
	public static String PROCESSSTATUS_SUSPENSION="2";//挂起
	public static String PROCESSSTATUS_NORMAL="1";//正常
	public static String PROCESSSTATUS_FINISH="5";//完成
	
	//RTF模板生成类型
	public static String REPORTTYPE_RTF="RTF";//RTF
	public static String REPORTTYPE_PDF="PDF";//PDF
	
	//公共文件上传分类(表)
	public static String ATTACHKEY_SEMEETING = "SE_MEETING";//会议
	public static String ATTACHKEY_PLANSUMMARY = "PLAN_SUMMARY";//计划
	public static String ATTACHKEY_SEPUBMODULE = "SE_PUB_MODULE";//公共模块
	public static String ATTACHKEY_SETRACETASK = "SE_TRACE_TASK";//需求矩阵任务
	public static String ATTACHKEY_SEDAYNOTE = "SE_DAY_NOTE";//记事
	public static String ATTACHKEY_SERISK = "SE_RISK";//风险
	public static String ATTACHKEY_SEREQUIREMENTTRACE = "SE_REQUIREMENT_TRACE";//需求矩阵
	public static String ATTACHKEY_SETRACEDEFECT = "SE_TRACE_DEFECT";//需求矩阵缺陷
	public static String ATTACHKEY_SETRACENOTE = "SE_TRACE_NOTE";//需求矩阵记事
	
	
	//功能菜单分类
	public static String FUNCTIONCLASSIFY_SYSDICPROCESSSTEP = "sys_dic_process_step";
	public static String FUNCTIONCLASSIFY_SYSDICPROCESS = "sys_dic_process";
	
	//状态
	public static String STATUS_FINISHED = "FINISHED";
	public static String STATUS_UNFINISH = "UNFINISH";
	
	
}
