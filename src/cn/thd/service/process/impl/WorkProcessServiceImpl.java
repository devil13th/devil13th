/** 
 * Class Description:########
 * Date : 2018年1月4日 下午6:21:33
 * Auth : ccse 
*/  

package cn.thd.service.process.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import cn.thd.bean.ProcessMethodBean;
import cn.thd.bean.ProcessStaticVar;
import cn.thd.bean.StaticVar;
import cn.thd.pojo.process.SeProcTask;
import cn.thd.pojo.process.SeWorkList;
import cn.thd.service.process.ProcessMethodService;
import cn.thd.service.process.SeProcessService;
import cn.thd.service.se.SeService;

import com.thd.util.MyActivitiUtil;
import com.thd.util.MyStringUtils;
@Service("workProcessService")
public class WorkProcessServiceImpl extends ProcessMethodServiceImpl implements
		ProcessMethodService {
	Logger log = Logger.getLogger(this.getClass());
	@Resource
	private MyActivitiUtil myActivitiUtil;
	@Resource
	private SeProcessService seProcessService;
	@Resource
	private SeService seService;
	
	@Override
	public ProcessMethodBean validate(ProcessMethodBean processMethodBean) {
		log.info(this.getClass() + " validate()");
//		processMethodBean.setoMessage("错误啦");
//		processMethodBean.setoStatus(StaticVar.STATUS_FAILURE);
//		return processMethodBean;
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		
		Map m = this.myActivitiUtil.getVariableForProcessInstance(processMethodBean.getProcessInstanceId());
		//派工
		if(ProcessStaticVar.WORKPROCESS_ASSIGN.equals(processMethodBean.getStepCode())){
			if(m == null){
				processMethodBean.setMessage("未找到环境变量");
				processMethodBean.setStatus(StaticVar.STATUS_FAILURE);
			}
			//System.out.println(m.get("WORKPROCESS_EXECUTE").toString());
			
			processMethodBean.setMessage("");
			if(m.get("WORKPROCESS_EXECUTE") == null || MyStringUtils.isEmpty(m.get("WORKPROCESS_EXECUTE").toString())){
				processMethodBean.setMessage(" 未设置执行人");
				processMethodBean.setStatus(StaticVar.STATUS_FAILURE);
			}
			
			if(m.get("WORKPROCESS_INSPECT") == null || MyStringUtils.isEmpty(m.get("WORKPROCESS_INSPECT").toString())){
				processMethodBean.setMessage(processMethodBean.getMessage() + " 未设置执审核人");
				processMethodBean.setStatus(StaticVar.STATUS_FAILURE);
			}
		}
		return processMethodBean;
	}

	@Override
	public ProcessMethodBean setProcInstVar(ProcessMethodBean processMethodBean) {
		log.info(this.getClass() + " setProcInstVar()  ... ...   STEP CODE : " +  processMethodBean.getStepCode());
		//派工
		if(ProcessStaticVar.WORKPROCESS_ASSIGN.equals(processMethodBean.getStepCode())){
			//设置流程变量
			Map m = new HashMap();
			Map<String,String> performer = seProcessService.queryPerformersByJobnoAndMark(processMethodBean.getJobno(), "performer");
			Map<String,String> auditers = seProcessService.queryPerformersByJobnoAndMark(processMethodBean.getJobno(), "auditer");
			if(MyStringUtils.isNotEmpty(performer.get("userIds"))){
				m.put("WORKPROCESS_EXECUTE",performer.get("userIds"));
			}else{
				this.myActivitiUtil.getRuntimeService().removeVariable(processMethodBean.getProcessInstanceId(), "WORKPROCESS_EXECUTE");
			}
			if(MyStringUtils.isNotEmpty(auditers.get("userIds"))){
				m.put("WORKPROCESS_INSPECT",auditers.get("userIds"));
			}else{
				this.myActivitiUtil.getRuntimeService().removeVariable(processMethodBean.getProcessInstanceId(), "WORKPROCESS_INSPECT");
			}
			this.myActivitiUtil.addVarableToProcessInstance(m, processMethodBean.getProcessInstanceId());
		}
		
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		return processMethodBean;
	}
	
	
	@Override
	public ProcessMethodBean afterStartProcess(ProcessMethodBean processMethodBean) {
		log.info(this.getClass() + " afterStartProcess()");
		SeProcTask spt = new SeProcTask();
		spt.setJobno(processMethodBean.getJobno());
		spt.setAssigner(processMethodBean.getOperator());
		this.getPubDao().save(spt);
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		
		Map m = new HashMap();
		if(MyStringUtils.isEmpty(processMethodBean.getOperator())){
			processMethodBean.setStatus(StaticVar.STATUS_FAILURE);
			processMethodBean.setMessage("未设置流程开启人");
			return processMethodBean;
		}
		m.put("WORKPROCESS_DECIDE", processMethodBean.getOperator());
		myActivitiUtil.addVarableToProcessInstance(m, processMethodBean.getProcessInstanceId());
		return processMethodBean;
	}
	@Override
	public ProcessMethodBean hasTaskPerformAuth(ProcessMethodBean processMethodBean){
		System.out.println(" -------------- 权限查询 -------------");
		//如果没有taskId则为浏览流程历史,不可进行编辑,无当前步骤
		if(MyStringUtils.isEmpty(processMethodBean.getTaskId())){
			processMethodBean.setHasAuth(StaticVar.N);
			return processMethodBean;
		}
		if(MyStringUtils.isNotEmpty(processMethodBean.getJobno())){
			SeWorkList swl = this.seProcessService.querySeWorkListByJobno(processMethodBean.getJobno());
			if(swl != null){
				Map authMap = this.seService.queryAuth(processMethodBean.getOperator(),swl.getProjectId());
				if(authMap.get("PROCESS") != null){
					processMethodBean.setHasAuth(StaticVar.Y);
					return processMethodBean;
				}
			}
		}
		return super.hasTaskPerformAuth(processMethodBean);
		
	};
}
