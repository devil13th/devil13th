/** 
 * Class Description:########
 * Date : 2018年1月4日 下午6:21:33
 * Auth : ccse 
*/  

package cn.thd.service.process.impl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import cn.thd.bean.ProcessMethodBean;
import cn.thd.bean.StaticVar;
import cn.thd.pojo.process.SeProcTask;
import cn.thd.service.process.ProcessMethodService;
import cn.thd.service.process.SeProcessService;
import cn.thd.service.se.SeService;
@Service("taskProcessService")
public class TaskProcessServiceImpl extends ProcessMethodServiceImpl implements
		ProcessMethodService {
	Logger log = Logger.getLogger(this.getClass());
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
		return super.validate(processMethodBean);
	}

	@Override
	public ProcessMethodBean setProcInstVar(ProcessMethodBean processMethodBean) {
		log.info(this.getClass() + " setProcInstVar()");
		return super.setProcInstVar(processMethodBean);
	}
	
	
	@Override
	public ProcessMethodBean afterStartProcess(ProcessMethodBean processMethodBean) {
		log.info(this.getClass() + " afterStartProcess()");
		try{
			SeProcTask spt = new SeProcTask();
			spt.setJobno(processMethodBean.getJobno());
			spt.setAssigner(processMethodBean.getOperator());
			this.getPubDao().save(spt);
			processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		}catch(Exception e){
			processMethodBean.setStatus(StaticVar.STATUS_FAILURE);
			processMethodBean.setMessage(e.getMessage());
		}
		return processMethodBean;
	}
	
	
}
