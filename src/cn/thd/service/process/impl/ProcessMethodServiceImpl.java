/** 
 * Class Description:########
 * Date : 2018年1月4日 下午6:20:14
 * Auth : ccse 
*/  

package cn.thd.service.process.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.activiti.engine.task.IdentityLink;
import org.activiti.engine.task.Task;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import cn.thd.bean.ProcessMethodBean;
import cn.thd.bean.StaticVar;
import cn.thd.pojo.process.SeWorkList;
import cn.thd.service.process.ProcessMethodService;

import com.thd.core.dao.JdbcDao;
import com.thd.core.dao.PubDao;
import com.thd.util.MyActivitiUtil;
import com.thd.util.MyListUtils;
import com.thd.util.MyStringUtils;
@Service("processMethodService")
public class ProcessMethodServiceImpl implements ProcessMethodService {
	@Resource 
	private PubDao pubDao;
	@Resource
	private JdbcDao jdbcDao;
	@Resource
	private MyActivitiUtil myActivitiUtil;
	Logger log = Logger.getLogger(this.getClass());
	@Override
	public ProcessMethodBean afterStartProcess(
			ProcessMethodBean processMethodBean) {
		log.info(" processMethodServiceImpl.afterStartProcess()");
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		return processMethodBean;
	}

	@Override
	public ProcessMethodBean validate(ProcessMethodBean processMethodBean) {
		log.info(" processMethodServiceImpl.validate()");
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		return processMethodBean;
	}

	@Override
	public ProcessMethodBean setProcInstVar(ProcessMethodBean processMethodBean) {
		log.info(" processMethodServiceImpl.setProcInstVar()");
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		return processMethodBean;
	}

	@Override
	public ProcessMethodBean beforeCompleteTask(
			ProcessMethodBean processMethodBean) {
		log.info(" processMethodServiceImpl.beforeCompleteTask()");
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		return processMethodBean;
	}

	@Override
	public ProcessMethodBean afterCompleteTask(
			ProcessMethodBean processMethodBean) {
		log.info(" processMethodServiceImpl afterCompleteTask()");
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		return processMethodBean;
	}
	
	@Override
	public ProcessMethodBean beforeCloseProcess(
			ProcessMethodBean processMethodBean) {
		log.info(" processMethodServiceImpl beforeCloseProcess()");
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		return processMethodBean;
	}

	@Override
	public ProcessMethodBean afterCloseProcess(
			ProcessMethodBean processMethodBean) {
		log.info(" processMethodServiceImpl afterCloseProcess()");
		
		List<Task> tasks = myActivitiUtil.getTaskService().createTaskQuery().processInstanceId(processMethodBean.getProcessInstanceId()).list();
		
		if(MyListUtils.isNotEmpty(tasks)){
			throw new RuntimeException("存在尚未完成的待办不可关闭工作");
		}
		SeWorkList swl = (SeWorkList)this.pubDao.findById(SeWorkList.class, processMethodBean.getJobno());
		swl.setJobStatus(StaticVar.PROCESSSTATUS_FINISH);
		swl.setUpdateTime(new Date());
		this.pubDao.update(swl);
		processMethodBean.setStatus(StaticVar.STATUS_SUCCESS);
		return processMethodBean;
	}

	@Override
	public ProcessMethodBean hasTaskPerformAuth(ProcessMethodBean processMethodBean){
		List<IdentityLink> performers;
		if(MyStringUtils.isNotEmpty(processMethodBean.getTaskId())){
			performers = this.myActivitiUtil.queryCandidateForTask(processMethodBean.getTaskId());
		}else{
			performers = new ArrayList<IdentityLink>();
		}
		for(IdentityLink il : performers){
			if(processMethodBean.getOperator().equals(il.getUserId())){
				processMethodBean.setHasAuth(StaticVar.Y);
				return processMethodBean;
			}
		}
		processMethodBean.setHasAuth(StaticVar.N);
		return processMethodBean;
	};

	public PubDao getPubDao() {
		return pubDao;
	}

	public void setPubDao(PubDao pubDao) {
		this.pubDao = pubDao;
	}

	public JdbcDao getJdbcDao() {
		return jdbcDao;
	}

	public void setJdbcDao(JdbcDao jdbcDao) {
		this.jdbcDao = jdbcDao;
	}
	
}
