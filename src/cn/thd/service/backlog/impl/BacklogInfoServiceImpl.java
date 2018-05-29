package cn.thd.service.backlog.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import cn.thd.dto.DataTableBean;
import cn.thd.pojo.backlog.BacklogDeal;
import cn.thd.pojo.backlog.BacklogInfo;
import cn.thd.pojo.backlog.BacklogNote;
import cn.thd.pojo.plan.PlanItem;
import cn.thd.service.backlog.BacklogInfoService;

import com.thd.core.dao.JdbcDao;
import com.thd.core.dao.PubDao;
import com.thd.core.service.PubServiceImpl;
import com.thd.util.DateFormart;
import com.thd.util.ListUtil;
import com.thd.util.MyListUtils;
import com.thd.util.Page;
import com.thd.util.StringUtil;
@Service("backlogInfoService")
public class BacklogInfoServiceImpl extends PubServiceImpl implements BacklogInfoService {
	@Resource 
	private PubDao pubDaoImpl;
	@Resource
	private JdbcDao jdbcDao;
	public void updateBacklog(BacklogInfo bli){
		pubDaoImpl.update(bli);
	};
	
	
	public BacklogInfo queryBacklogById(String id){
		return (BacklogInfo)this.pubDaoImpl.findById(BacklogInfo.class, id);
	};
	
	/**
	 * 保存backlog(自动取号)
	 * @param bli
	 */
	public void saveBacklogInfo(BacklogInfo bli) throws Exception{
		BacklogInfo nBli = createBlankBacklog();
		//String blNo = nBli.getBlId();
		
		String[] ignoreProperties = new String[]{"blId","createDate","blStatus"};
		BeanUtils.copyProperties(bli, nBli, ignoreProperties);
		//BeanUtils.copyProperties(bli, nBli);
		//nBli.setBlId(blNo);
		this.updateBacklog(nBli);
	};
	/**
	 * 更新backlog
	 * @param bli
	 */
	public void updateBacklogInfo(BacklogInfo bli){
		this.pubDaoImpl.update(bli);
	};
	
	public BacklogInfo createBlankBacklog(){
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH) + 1;
		int day = c.get(Calendar.DAY_OF_MONTH);
		
		String blNo = "BL" + year+(month<10 ? ("0" + month) : month)+(day<10 ? ("0" + day) : day);
		String createDateStr =  (year+"-"+(month<10 ? ("0" + month) : month)+"-"+(day<10 ? ("0" + day) : day));
		String sql = "select count(1) as ct from backlog_info where create_date = '"+ createDateStr +"'";
		List l  = this.pubDaoImpl.findBySql(sql);
		String baseCode= "000";
		int i = 1;
		if(ListUtil.isNotEmpty(l)){
			Object obj = ListUtil.getOne(l);
			i = Integer.parseInt(obj.toString());
			i++;
		}
		
		blNo += (baseCode + i).substring((baseCode + i).length() - baseCode.length() , (baseCode + i).length() );
		//System.out.println("--" + createDateStr);
		BacklogInfo bli = new BacklogInfo();
		bli.setBlId(blNo);
		bli.setCreateDate(DateFormart.toDate(createDateStr));
		bli.setBlStatus("1");
		bli.setBlLevel(3);
		bli.setAlarmDays(1);
		bli.setBlClassify("todo");
		bli.setFnshDate(new Date());
		bli.setStartDate(new Date());
		bli.setExpireDate(new Date());
		this.getPubDaoImpl().save(bli);
		return bli;
	}
	
	public BacklogInfo createBacklog(BacklogInfo bli){
		BacklogInfo blankBli = createBlankBacklog();
		String no = blankBli.getBlId();
		String[] ignoreProperties = new String[]{"blId","createDate","blStatus"};
		BeanUtils.copyProperties(bli, blankBli, ignoreProperties);
		this.getPubDaoImpl().update(blankBli);
		return bli;
	};
	
	public List queryBacklog(Map<String,String> m,Page p){
		/*
		String sql = "select " +
				" a.bl_id as blId," +//0 id
				" a.bl_content as blContent," +//1 内容
				" a.bl_level as blLevel," +//2 等级
				" a.start_date as startDate," +//3 开始日期
				" a.fnsh_date as fnshDate," +//4 结束日期
				" a.expire_date as expireDate," +//5 最终期限
				" a.bl_status as blStatus," +//6 状态
				" a.bl_mes as blMes," +//7 备注
				" a.bl_des as blDes," +//8描述
				" a.bl_issue_user as blIssueUser," +//9提出人
				" a.bl_exe_user as blExeUser," +//10 执行人
				" a.alarm_days as alarmDays," + //11 报警时期
				" a.create_date as createDate," + //12 创建日期
				" DATE_SUB(a.expire_date,INTERVAL a.alarm_days DAY) as alarmDate,"+ //13开始预警日期
				" case WHEN bl_status = '-1' THEN '删除' WHEN bl_status = '0' THEN '完成'  WHEN TIMESTAMPDIFF(DAY,a.expire_date,NOW()) > 0 THEN '过期' WHEN  TIMESTAMPDIFF(DAY,a.expire_date,NOW())  > (0-alarm_days) THEN '预警' ELSE '正常' end as expireStatus , " + //14 期限状态
				" TIMESTAMPDIFF(DAY,NOW(),a.expire_date) as expireDays, " + //15到期天数
				" a.bl_classify as blClassify " + //16 分类
				" from backlog_info a where 1=1 ";
			
		StringBuffer sb = new StringBuffer("");
		if(StringUtil.isNotEmpty(m.get("blId"))){
			sb.append(" and a.bl_id like '%" + m.get("blId") + "%'");
		}
		if(StringUtil.isNotEmpty(m.get("blContent"))){
			sb.append(" and a.bl_content like '%" + m.get("blContent") + "%'");
		}
		if(StringUtil.isNotEmpty(m.get("blLevel"))){
			sb.append(" and a.bl_level like '" + m.get("blLevel") + "'");
		}
		
		if(StringUtil.isNotEmpty(m.get("blClassify"))){
			sb.append(" and a.bl_classify like '" + m.get("blClassify") + "'");
		}
		if(StringUtil.isNotEmpty(m.get("blStatus"))){
			sb.append(" and a.bl_status like '" + m.get("blStatus") + "'");
		}
		if(StringUtil.isNotEmpty(m.get("issuer"))){
			sb.append(" and a.bl_issue_user like '%" + m.get("issuer") + "%'");
		}
		if(StringUtil.isNotEmpty(m.get("executer"))){
			sb.append(" and a.bl_exe_user like '%" + m.get("executer") + "%'");
		}
		if(StringUtil.isNotEmpty(m.get("blExpireMin"))){
			sb.append(" and a.expire_date >= '" + m.get("blExpireMin") + " 00:00:00'");
		}
		if(StringUtil.isNotEmpty(m.get("blExpireMax"))){
			sb.append(" and a.expire_date <= '" + m.get("blExpireMax") + " 23:59:59'");
		}
		if(StringUtil.isNotEmpty(m.get("blStartMin"))){
			sb.append(" and a.start_date >= '" + m.get("blStartMin") + " 00:00:00'");
		}
		if(StringUtil.isNotEmpty(m.get("blStartMax"))){
			sb.append(" and a.start_date <= '" + m.get("blStartMax") + " 23:59:59'");
		}
		if(StringUtil.isNotEmpty(m.get("blFnshMin"))){
			sb.append(" and a.fnsh_date >= '" + m.get("blFnshMin") + " 00:00:00'");
		}
		if(StringUtil.isNotEmpty(m.get("blFnshMax"))){
			sb.append(" and a.fnsh_date <= '" + m.get("blFnshMax") + " 23:59:59'");
		}
		if(StringUtil.isNotEmpty(m.get("createMin"))){
			sb.append(" and a.create_date >= '" + m.get("createMin") + " 00:00:00'");
		}
		if(StringUtil.isNotEmpty(m.get("createMax"))){
			sb.append(" and a.create_date <= '" + m.get("createMax") + " 23:59:59'");
		}
		if(StringUtil.isNotEmpty(m.get("dealMax"))){
			sb.append(" and a.bl_id in (select d.bl_id from backlog_deal d where d.deal_date <= '" + m.get("dealMax") + " 23:59:59')");
		}
		if(StringUtil.isNotEmpty(m.get("dealMin"))){
			sb.append(" and a.bl_id in (select d.bl_id from backlog_deal d where d.deal_date >= '" + m.get("dealMin") + " 00:00:00')");
		}
		if(StringUtil.isNotEmpty(m.get("blAlarmStatus"))){
			if("1".equals(m.get("blAlarmStatus"))){
				sb.append(" and (bl_status = '1' and (TIMESTAMPDIFF(DAY,a.expire_date,NOW())>(0-alarm_days)>0) and  (TIMESTAMPDIFF(DAY,a.expire_date,NOW()) <= 0)  )");
			}
			if("2".equals(m.get("blAlarmStatus"))){
				sb.append(" and (bl_status = '1' and (TIMESTAMPDIFF(DAY,a.expire_date,NOW()) > 0)) ");
			}
		}
		
		
		
		sql += sb.toString();
		String sql_order = "a.bl_status desc, a.bl_level desc,TIMESTAMPDIFF(DAY,a.expire_date,NOW()) desc,a.fnsh_date desc,a.create_date desc";
		
		
		
		String order = m.get("order");
		String ascdesc = m.get("asc");
		
		if(StringUtil.isNotEmpty(order)){
			sql_order = " a." + order ;
			if(StringUtil.isNotEmpty(ascdesc)){
				sql_order += " " + ascdesc;
			}
		}
		
		sql += " order by " + sql_order;
		*/
		
		
		String sql = "select " +
				" a.blId as blId," +//0 id
				" a.blContent as blContent," +//1 内容
				" a.blLevel as blLevel," +//2 等级
				" a.startDate as startDate," +//3 开始日期
				" a.fnshDate as fnshDate," +//4 结束日期
				" a.expireDate as expireDate," +//5 最终期限
				" a.blStatus as blStatus," +//6 状态
				" a.blMes as blMes," +//7 备注
				" a.blDes as blDes," +//8描述
				" a.blIssueUser as blIssueUser," +//9提出人
				" a.blExeUser as blExeUser," +//10 执行人
				" a.alarmDays as alarmDays," + //11 报警时期
				" a.createDate as createDate," + //12 创建日期
				" a.alarmDate as alarmDate,"+ //13开始预警日期
				" a.expireStatus as expireStatus , " + //14 期限状态
				" a.expireDays as expireDays, " + //15到期天数
				" a.blClassify as blClassify, " + //16 分类
				" a.blClassifyName as blClassifyName, " + //17 分类名称
				" a.blSys as blSys, " + //18所属系统
				" ass.user_name as blIssueUserName, " + //签发人姓名
				" exeu.user_name as blExeUserName  " + //执行人姓名
				" from view_backlog a " + 
				" left join se_user ass on a.blIssueUser = ass.user_id" + 
				" left join se_user exeu on a.blExeUser = exeu.user_id where 1=1 ";
			
		StringBuffer sb = new StringBuffer("");
		if(StringUtil.isNotEmpty(m.get("blId"))){
			sb.append(" and a.blId like '%" + m.get("blId") + "%'");
		}
		if(StringUtil.isNotEmpty(m.get("blContent"))){
			sb.append(" and a.blContent like '%" + m.get("blContent") + "%'");
		}
		if(StringUtil.isNotEmpty(m.get("blLevel"))){
			sb.append(" and a.blLevel like '" + m.get("blLevel") + "'");
		}
		
		if(StringUtil.isNotEmpty(m.get("blClassify"))){
			sb.append(" and a.blClassify like '" + m.get("blClassify") + "'");
		}
		if(StringUtil.isNotEmpty(m.get("blStatus"))){
			sb.append(" and a.blStatus like '" + m.get("blStatus") + "'");
		}
		if(StringUtil.isNotEmpty(m.get("blSys"))){
			sb.append(" and a.blSys like '" + m.get("blSys") + "'");
		}
		if(StringUtil.isNotEmpty(m.get("issuer"))){
			sb.append(" and a.blIssueUser like '%" + m.get("issuer") + "%'");
		}
		if(StringUtil.isNotEmpty(m.get("executer"))){
			sb.append(" and a.blExeUser like '%" + m.get("executer") + "%'");
		}
		if(StringUtil.isNotEmpty(m.get("blExpireMin"))){
			sb.append(" and a.expireDate >= '" + m.get("blExpireMin") + " 00:00:00'");
		}
		if(StringUtil.isNotEmpty(m.get("blExpireMax"))){
			sb.append(" and a.expireDate <= '" + m.get("blExpireMax") + " 23:59:59'");
		}
		if(StringUtil.isNotEmpty(m.get("blStartMin"))){
			sb.append(" and a.startDate >= '" + m.get("blStartMin") + " 00:00:00'");
		}
		if(StringUtil.isNotEmpty(m.get("blStartMax"))){
			sb.append(" and a.startDate <= '" + m.get("blStartMax") + " 23:59:59'");
		}
		if(StringUtil.isNotEmpty(m.get("blFnshMin"))){
			sb.append(" and a.fnshDate >= '" + m.get("blFnshMin") + " 00:00:00'");
		}
		if(StringUtil.isNotEmpty(m.get("blFnshMax"))){
			sb.append(" and a.fnshDate <= '" + m.get("blFnshMax") + " 23:59:59'");
		}
		if(StringUtil.isNotEmpty(m.get("createMin"))){
			sb.append(" and a.createDate >= '" + m.get("createMin") + " 00:00:00'");
		}
		if(StringUtil.isNotEmpty(m.get("createMax"))){
			sb.append(" and a.createDate <= '" + m.get("createMax") + " 23:59:59'");
		}
		if(StringUtil.isNotEmpty(m.get("dealMax"))){
			sb.append(" and a.blId in (select d.bl_id from backlog_deal d where d.deal_date <= '" + m.get("dealMax") + " 23:59:59')");
		}
		if(StringUtil.isNotEmpty(m.get("dealMin"))){
			sb.append(" and a.blId in (select d.bl_id from backlog_deal d where d.deal_date >= '" + m.get("dealMin") + " 00:00:00')");
		}
		if(StringUtil.isNotEmpty(m.get("blAlarmStatus"))){
			if("1".equals(m.get("blAlarmStatus"))){
				sb.append(" and (a.blStatus = '1' and a.expireStatus = '预警')");
			}
			if("2".equals(m.get("blAlarmStatus"))){
				sb.append(" and (a.blStatus = '1' and a.expireStatus = '过期') ");
			}
		}
		
		sql += sb.toString();
		String sql_order = "a.blStatus desc, a.blLevel desc,a.expireDays desc,a.fnshDate desc,a.createDate desc";
		
		
		
		String order = m.get("order");
		String ascdesc = m.get("asc");
		
		if(StringUtil.isNotEmpty(order)){
			sql_order = " a." + order ;
			if(StringUtil.isNotEmpty(ascdesc)){
				sql_order += " " + ascdesc;
			}
		}
		sql += " order by " + sql_order;
		
		this.getLog().info(sql);
		
		return this.jdbcDao.query(sql, null, p);
	};
	
	
	
	public String deleteAll(){
		try{
			String sql = "delete from backlog_info";
			this.getPubDaoImpl().executeSql(sql);
			return "success";
		}catch(Exception e){
			return e.getMessage();
		}
		
	};
	
	public void deleteBacklog(String blId){
		BacklogInfo bli = (BacklogInfo)this.getPubDaoImpl().findById(BacklogInfo.class, blId);
		bli.setBlStatus("-1");
		this.getPubDaoImpl().update(bli);
	};
	
	public void fnshOver(String blId){
		BacklogInfo bli = (BacklogInfo)this.getPubDaoImpl().findById(BacklogInfo.class, blId);
		bli.setBlStatus("0");
		bli.setFnshDate(new Date());
		this.getPubDaoImpl().update(bli);
		this.dealToday(blId);
	};
	
	public String fnshDate(String blId,String datetime){
		BacklogInfo bli = (BacklogInfo)this.getPubDaoImpl().findById(BacklogInfo.class, blId);
		if(StringUtil.isEmpty(blId)){
			return "请指定待办";
		}
		if(bli == null){
			return "未找到该待办" + blId;
		}
		try{
			if("0".equals(bli.getBlStatus())){
				return "该待办已完成,不可操作";
			}
			Date d = DateFormart.toDateTime(datetime);
			bli.setFnshDate(d);
			bli.setBlStatus("0");
			this.getPubDaoImpl().save(bli);
			dealDate(blId,datetime);
			return "success";
		}catch(Exception e){
			return "操作失败";
		}
	};
	public void delayOneDay(String blId){
		BacklogInfo bli = (BacklogInfo)this.getPubDaoImpl().findById(BacklogInfo.class, blId);
		Calendar c = Calendar.getInstance();
		c.setTime(bli.getExpireDate());
		c.add(Calendar.DAY_OF_MONTH, 1);
		Date date=c.getTime();
		bli.setExpireDate(date);
		this.getPubDaoImpl().update(bli);
	};
	public void saveOrUpdateNote(String blId,String note){
		BacklogNote bli = (BacklogNote)this.getPubDaoImpl().findById(BacklogNote.class, blId);
		if(bli == null){
			bli = new BacklogNote();
			bli.setBlId(blId);
		}
		bli.setBlNote(note);
		this.getPubDaoImpl().saveOrUpdate(bli);
	};
	public String queryNote(String blId){
		BacklogNote bli = (BacklogNote)this.getPubDaoImpl().findById(BacklogNote.class, blId);
		if(bli == null){
			return "";
		}else{
			return bli.getBlNote();
		}
	};
	
	public String dealDate(String blId,String date){
		BacklogInfo bli = (BacklogInfo)this.getPubDaoImpl().findById(BacklogInfo.class, blId);
		if(StringUtil.isEmpty(blId)){
			return "请指定待办";
		}
		if(bli == null){
			return "未找到该待办" + blId;
		}
		try{
			String queryRes = isDealDate(blId,date);
			if("false".equals(queryRes)){
				Date d = DateFormart.toDate(date);
				BacklogDeal bld = new BacklogDeal();
				bld.setBlId(blId);
				bld.setDealDate(d);
				this.getPubDaoImpl().save(bld);
				return "success";
			}else if("true".equals(queryRes)){
				return "success";
			}else{
				return queryRes;
			}
		}catch(Exception e){
			return "操作失败";
		}
	};
	
	public String dealToday(String blId){
		String date = DateFormart.toString(new Date());
		return dealDate(blId,date);
	};
	
	public String isDealDate(String blId,String date){
		if(StringUtil.isEmpty(blId)){
			return "请指定待办";
		}
		if(StringUtil.isEmpty(date)){
			return "请指定日期";
		}
		Date d = DateFormart.toDate(date);
		String dStr = DateFormart.toString(d);
		try{
			String sql = "select count(1) from backlog_deal where deal_date = '" + date + "' and bl_id = '" + blId + "'";
			List l = this.getPubDaoImpl().findBySql(sql);
			Object obj = ListUtil.getOne(l);
			Integer ct = Integer.parseInt(obj.toString());
			if(ct.compareTo(0) > 0){
				return "true";
			}else{
				return "false";
			}
		}catch(Exception e){
			return "查询某天待办失败";
		}
	};
	
	public String deleteDealDate(String blId,String date){
		try {
			String sql = "delete from backlog_deal  where deal_date = '" + date + "' and bl_id = '" + blId + "'";
			this.getPubDaoImpl().executeSql(sql);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "操作失败";
		}
	};
	
	public DataTableBean queryBacklogForUser(String userName,String todoStatus,Page p ){
		String sql = "select " +
				" a.blId as blId," +//0 id
				" a.blContent as blContent," +//1 内容
				" a.blLevel as blLevel," +//2 等级
				" a.startDate as startDate," +//3 开始日期
				" a.fnshDate as fnshDate," +//4 结束日期
				" a.expireDate as expireDate," +//5 最终期限
				" a.blStatus as blStatus," +//6 状态
				" a.blMes as blMes," +//7 备注
				" a.blDes as blDes," +//8描述
				" a.blIssueUser as blIssueUser," +//9提出人
				" a.blExeUser as blExeUser," +//10 执行人
				" u.user_name as blExeUserName,"+//执行人姓名
				" a.alarmDays as alarmDays," + //11 报警时期
				" a.createDate as createDate," + //12 创建日期
				" a.alarmDate as alarmDate,"+ //13开始预警日期
				" a.expireStatus as expireStatus , " + //14 期限状态
				" a.expireDays as expireDays, " + //15到期天数
				" a.blClassify as blClassify, " + //16 分类
				" a.blClassifyName as blClassifyName, " + //17 分类名称
				" a.blSys as blSys " + //18所属系统
				" from view_backlog a left join se_user u on a.blExeUser = u.user_id where 1=1 ";
		List params = new ArrayList();
		
		if(StringUtil.isNotEmpty(userName)){
			sql += " and upper(a.blExeUser) like ? ";
			params.add(userName.trim().toUpperCase());
		}
		
		if(StringUtil.isNotEmpty(todoStatus)){
			sql += " and a.blStatus = ? ";
			params.add(todoStatus);
		}
		sql += " order by a.blExeUser,a.blStatus desc, a.blLevel desc,a.expireDays desc,a.fnshDate desc,a.createDate desc";
//		Page p = new Page();
//		p.setCurrentPage(1);
//		p.setPageSize(10); 
		List r = this.jdbcDao.query(sql, params.toArray(), p);
		DataTableBean dtb = new DataTableBean();
		dtb.setCurrentPage(p.getCurrentPage());
		dtb.setData(r);
		dtb.setPageSize(p.getPageSize());
		dtb.setRecordsTotal(p.getListSize());
		dtb.setRecordsFiltered(p.getListSize());
		return dtb;
		
	};
	
	
	public DataTableBean queryBacklogForIndexPlugin(DataTableBean dtb){
		
		Page p = new Page();
		p.setCurrentPage(dtb.getCurrentPage());
		p.setPageSize(dtb.getPageSize());
		
		List r = this.queryBacklog(dtb.getConditions(), p);
		if(MyListUtils.isEmpty(r)){
			r = new ArrayList();
		}
		dtb.setData(r);
		dtb.setRecordsTotal(p.getListSize());
		dtb.setRecordsFiltered(p.getListSize());
		return dtb;
	};
	
	public Map queryBacklogDetail(String blId){
		String sql = "select " +
				" a.blId as blId," +//0 id
				" a.blContent as blContent," +//1 内容
				" a.blLevel as blLevel," +//2 等级
				" a.startDate as startDate," +//3 开始日期
				" a.fnshDate as fnshDate," +//4 结束日期
				" a.expireDate as expireDate," +//5 最终期限
				" a.blStatus as blStatus," +//6 状态
				" a.blMes as blMes," +//7 备注
				" a.blDes as blDes," +//8描述
				" a.blIssueUser as blIssueUser," +//9提出人
				" a.blExeUser as blExeUser," +//10 执行人
				" a.alarmDays as alarmDays," + //11 报警时期
				" a.createDate as createDate," + //12 创建日期
				" a.alarmDate as alarmDate,"+ //13开始预警日期
				" a.expireStatus as expireStatus , " + //14 期限状态
				" a.expireDays as expireDays, " + //15到期天数
				" a.blClassify as blClassify, " + //16 分类
				" a.blClassifyName as blClassifyName, " + //17 分类名称
				" a.blSys as blSys " + //18所属系统
				" from view_backlog a where blId = ? ";
		List params = new ArrayList();
		params.add(blId);
		List l = this.jdbcDao.query(sql, params.toArray(), null);
		if(ListUtil.isNotEmpty(l)){
			return (Map)l.get(0);
		}else{
			return new HashMap();
		}
		
	};
	
	
	public List queryBacklogForPeriod(String startDate,String endDate){
		String sql = "select " +
				" a.blId as blId," +//0 id
				" a.blContent as blContent," +//1 内容
				" a.blLevel as blLevel," +//2 等级
				" a.startDate as startDate," +//3 开始日期
				" a.fnshDate as fnshDate," +//4 结束日期
				" a.expireDate as expireDate," +//5 最终期限
				" a.blStatus as blStatus," +//6 状态
				" a.blMes as blMes," +//7 备注
				" a.blDes as blDes," +//8描述
				" a.blIssueUser as blIssueUser," +//9提出人
				" a.blExeUser as blExeUser," +//10 执行人
				" a.alarmDays as alarmDays," + //11 报警时期
				" a.createDate as createDate," + //12 创建日期
				" a.alarmDate as alarmDate,"+ //13开始预警日期
				" a.expireStatus as expireStatus , " + //14 期限状态
				" a.expireDays as expireDays, " + //15到期天数
				" a.blClassify as blClassify, " + //16 分类
				" a.blClassifyName as blClassifyName, " + //17 分类名称
				" a.blSys as blSys " + //18所属系统
				" from view_backlog a where " + 
				" (startDate >= ? and startDate <= ?) or " +
				" (fnshDate >= ? and fnshDate <= ?) or " +
				" (createDate >= ? and createDate <= ?) or " + 
				"  blId in (select distinct deal.bl_id from backlog_deal deal where deal_date  >= ? and deal_date <= ?) " ;
				
		List params = new ArrayList();
		params.add(startDate);
		params.add(endDate);
		params.add(startDate);
		params.add(endDate);
		params.add(startDate);
		params.add(endDate);
		params.add(startDate);
		params.add(endDate);
		List l = this.jdbcDao.query(sql, params.toArray(), null);
		return l;
	};
	
	
	public String transferPlanItemToBacklog(String id){
		PlanItem pi = (PlanItem)this.pubDaoImpl.findById(PlanItem.class, id);
		if(pi == null){
			throw new RuntimeException(" Plan Item Not Be Found , ID: " + id);
		}
		BacklogInfo bli = this.createBlankBacklog();
		bli.setBlContent(pi.getPlanItemTitle());
		bli.setBlExeUser(pi.getExeUser());
		bli.setExpireDate(pi.getPlanFinishDate());
		this.pubDaoImpl.update(bli);
		return bli.getBlId();
	};
	
	
	
}
