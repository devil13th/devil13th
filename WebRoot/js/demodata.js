var projectlist={"total":200,"rows":[
	{"projectstep":"登记","belongdept":"审图部","finishdate":"2016-01-01","worktype":"审图","jobno":"SP16C001","projectname":"2015DL300225审图","projectleader":"张三","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"normal","has_suggest":"是"},
	{"projectstep":"评审","belongdept":"审图部","finishdate":"2016-01-01","worktype":"科研","jobno":"SP16C002","projectname":"XXX科研项目","projectleader":"李四","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"normal","has_suggest":"是"},
	{"projectstep":"审图","belongdept":"审图部","finishdate":"2016-01-01","worktype":"审图","jobno":"SP16C003","projectname":"2015DL300225审图","projectleader":"王五","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"normal","has_suggest":"否"},
	{"projectstep":"汇报","belongdept":"审图部","finishdate":"2016-01-01","worktype":"科研","jobno":"SP16C004","projectname":"XXX科研项目","projectleader":"赵六","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"closeto","has_suggest":"是"},
	{"projectstep":"已完成","belongdept":"审图部","finishdate":"2016-01-01","worktype":"审图","jobno":"SP16C005","projectname":"2015DL300225审图","projectleader":"张三","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"overdue","has_suggest":"是"},
	{"projectstep":"已完成","belongdept":"审图部","finishdate":"2016-01-01","registdate":"2016-01-01","worktype":"科研","jobno":"SP16C006","projectname":"XXX科研项目","projectleader":"李四","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"normal","has_suggest":"否"},
	{"projectstep":"登记","belongdept":"审图部","finishdate":"2016-01-01","worktype":"审图","jobno":"SP16C007","projectname":"2015DL300225审图","projectleader":"张三","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"normal","has_suggest":"是"},
	{"projectstep":"评审","belongdept":"审图部","finishdate":"2016-01-01","worktype":"科研","jobno":"SP16C008","projectname":"XXX科研项目","projectleader":"李四","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"normal","has_suggest":"否"},
	{"projectstep":"审图","belongdept":"审图部","finishdate":"2016-01-01","worktype":"审图","jobno":"SP16C009","projectname":"2015DL300225审图","projectleader":"王五","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"normal","has_suggest":"是"},
	{"projectstep":"汇报","belongdept":"审图部","finishdate":"2016-01-01","worktype":"科研","jobno":"SP16C010","projectname":"XXX科研项目","projectleader":"赵六","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"closeto","has_suggest":"否"},
	{"projectstep":"已完成","belongdept":"审图部","finishdate":"2016-01-01","worktype":"审图","jobno":"SP16C011","projectname":"2015DL300225审图","projectleader":"张三","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"overdue","has_suggest":"是"},
	{"projectstep":"已完成","belongdept":"审图部","finishdate":"2016-01-01","registdate":"2016-01-01","worktype":"科研","jobno":"SP16C012","projectname":"XXX科研项目","projectleader":"李四","projectprocess":"25%","workload":"50","workstatus":"进行中","alarmstatus":"normal","has_suggest":"是"}
]}

var projectlistTask={"total":200,"rows":[


var projectinfodata = {"total":7,"rows":[
	{"name":"工作控制号","value":"XX审图","group":"项目信息"},
	{"name":"项目名称","value":"XX审图","group":"项目信息"},
	{"name":"开始日期","value":"2016-01-01","group":"计划信息"},
	{"name":"结束日期","value":"2016-01-05","group":"计划信息"},
	{"name":"计划工期","value":"5天","group":"计划信息"},
	{"name":"计划工时","value":"100人/天","group":"计划信息"},
	{"name":"开始日期","value":"2016-01-01","group":"实际信息"},
	{"name":"结束日期","value":"2016-01-05","group":"实际信息"},
	{"name":"计划工期","value":"5天","group":"实际信息"},
	{"name":"计划工时","value":"100人/天","group":"实际信息"},
	{"name":"组长","value":"张三","group":"人员信息",},
	{"name":"参与人","value":"李四,王五,赵六","group":"人员信息"}
]}

var tasklist={"total":200,"rows":[
	{"tasktype":"审图登记","alarmstatus":"","taskno":"SP16C001_001","taskname":"XX审图登记","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50","has_suggest":"是"},
	{"tasktype":"审图任务","alarmstatus":"","taskno":"SP16C001_001","taskname":"XX图纸审图","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50","has_suggest":"否"},
	{"tasktype":"审图复核","alarmstatus":"","taskno":"SP16C001_001","taskname":"XX图纸复核","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50","has_suggest":"否"},
	{"tasktype":"审图归档","alarmstatus":"closeto","taskno":"SP16C001_001","taskname":"XX审图归档","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50","has_suggest":"是"},
	{"tasktype":"审图盖章","alarmstatus":"overdue","taskno":"SP16C001_001","taskname":"XX意见书盖章","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50","has_suggest":"否"},
	{"tasktype":"审图评审","alarmstatus":"closeto","taskno":"SP16C001_001","taskname":"XX审图评审","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50","has_suggest":"是"}
	
]}

var tasklistTask={"total":7,"rows":[
{"workload":"50","taskno":"2016SP001_007","tasktype":"项目跟踪","projectprocess":"25%","assigneddate":"2016/1/1","projectname":"XX项目","has_suggest":"是","taskname":"项目进度跟踪","alarmstatus":""}

var taskinfodata = {"total":7,"rows":[
	{"name":"任务控制号","value":"2016SP001_001","group":"任务信息"},
	{"name":"任务名称","value":"XX船体审图","group":"任务信息"},
	{"name":"工作控制号","value":"2016SP001","group":"任务信息"},
	{"name":"项目名称","value":"XX审图","group":"任务信息"},
	{"name":"开始日期","value":"2016-01-01","group":"任务计划"},
	{"name":"结束日期","value":"2016-01-05","group":"任务计划"},
	{"name":"计划工期","value":"5天","group":"任务计划"},
	{"name":"计划工时","value":"100人/天","group":"任务计划"},
	{"name":"开始日期","value":"2016-01-01","group":"任务实际"},
	{"name":"结束日期","value":"2016-01-05","group":"任务实际"},
	{"name":"计划工期","value":"5天","group":"任务实际"},
	{"name":"计划工时","value":"100人/天","group":"任务实际"}
	/*{"name":"开始日期","value":"2016-01-01","group":"项目计划信息"},
	{"name":"结束日期","value":"2016-01-05","group":"项目计划信息"},
	{"name":"计划工期","value":"5天","group":"项目计划信息"},
	{"name":"计划工时","value":"100人/天","group":"项目计划信息"},
	{"name":"开始日期","value":"2016-01-01","group":"项目实际信息"},
	{"name":"结束日期","value":"2016-01-05","group":"项目实际信息"},
	{"name":"计划工期","value":"5天","group":"项目实际信息"},
	{"name":"计划工时","value":"100人/天","group":"项目实际信息"},
	{"name":"组长","value":"张三","group":"人员信息",},
	{"name":"参与人","value":"李四,王五,赵六","group":"人员信息"}*/
]}





var data1={"total":7,"rows":[
	{"name":"需求代码","value":"0201","group":"需求分析","editor":"text"},
	{"name":"使用角色","value":"系统管理员","group":"需求分析","editor":"text"},
	{"name":"需求优先级","value":"重要且紧急","group":"需求分析","editor":"numberbox"},
	{"name":"需求来源","value":"程序文件","group":"需求分析","editor":"datebox"},
	{"name":"进度","value":"50%","group":"需求分析","editor":"text"},
	{"name":"进度","value":"50%","group":"详细设计","editor":"text"},
	{"name":"开发人员","value":"张三","group":"开发","editor":"text"},
	{"name":"进度","value":"50%","group":"开发","editor":"text"},
	{"name":"测试人员","value":"张三","group":"测试","editor":"text"},
	{"name":"进度","value":"50%","group":"测试","editor":"text"},
	
]}

//派工信息
var assigndata={"total":4,"rows":[
	{"name":"审核","value":"张三,李四"},
	{"name":"复核","value":"王五,赵六"},
	{"name":"盖章","value":"张三"},
	{"name":"归档","value":"张三"}
]}

//工作预警
var workalarmlist={"total":200,"rows":[
	{
		"alarmstatus":"closeto",
		"jobno":"2014SH300105",
		"alarm_content":"图纸审核即将到期",
		"base_date":"2015-01-01",
		"expire":"2015-02-01",
		"work_type":"审图",
		"ableday":5
			
	},
		{
		"alarmstatus":"overdue",
		"jobno":"2014SH3001065",
		"alarm_content":"图纸审核即将到期",
		"base_date":"2015-01-01",
		"expire":"2015-02-01",
		"work_type":"审图",
		"ableday":4
	},
		{
		"alarmstatus":"closeto",
		"jobno":"2014SH300105",
		"alarm_content":"图纸审核即将到期",
		"base_date":"2015-01-01",
		"expire":"2015-02-01",
		"work_type":"审图",
		"ableday":3
	},
		{
		"alarmstatus":"overdue",
		"jobno":"2014SH300105",
		"alarm_content":"图纸审核即将到期",
		"base_date":"2015-01-01",
		"expire":"2015-02-01",
		"work_type":"审图",
		"ableday":2
	},
		{
		"alarmstatus":"closeto",
		"jobno":"2014SH300105",
		"alarm_content":"图纸审核即将到期",
		"base_date":"2015-01-01",
		"expire":"2015-02-01",
		"work_type":"审图",
		"ableday":1
	},
		{
		"alarmstatus":"overdue",
		"jobno":"2014SH300105",
		"alarm_content":"图纸审核即将到期",
		"base_date":"2015-01-01",
		"expire":"2015-02-01",
		"work_type":"科研",
		"ableday":0
	},
		{
		"alarmstatus":"closeto",
		"jobno":"2014SH300105",
		"alarm_content":"图纸审核即将到期",
		"base_date":"2015-01-01",
		"expire":"2015-02-01",
		"work_type":"科研",
		"ableday":0
	},
		{
		"alarmstatus":"overdue",
		"jobno":"2014SH300105",
		"alarm_content":"图纸审核即将到期",
		"base_date":"2015-01-01",
		"expire":"2015-02-01",
		"work_type":"审图",
		"ableday":0
	}
]}

//系统消息
var messagelist={"total":200,"rows":[
	{
		"send_user":"张三",
		"jobno":"2014SH300105",
		"message_content":"请对XX工作的XX图纸进行复核",
		"send_time":"2014-02-05 14:21",
		"message_status":"已读"
	},
	{
		"send_user":"张三",
		"jobno":"2014SH300105",
		"message_content":"请对XX工作的XX图纸进行复核",
		"send_time":"2014-02-05 14:21",
		"message_status":"未读"
	},
		{
		"send_user":"张三",
		"jobno":"2014SH300105",
		"message_content":"请对XX工作的XX图纸进行复核",
		"send_time":"2014-02-05 14:21",
		"message_status":"已读"
	},
		"send_user":"张三",
		"jobno":"2014SH300105",
		"message_content":"请对XX工作的XX图纸进行复核",
		"send_time":"2014-02-05 14:21",
		"message_status":"已读"
	},
		{
		"send_user":"张三",
		"jobno":"2014SH300105",
		"message_content":"请对XX工作的XX图纸进行复核",
		"send_time":"2014-02-05 14:21",
		"message_status":"未读"
	},
		{
		"send_user":"张三",
		"jobno":"2014SH300105",
		"message_content":"请对XX工作的XX图纸进行复核",
		"send_time":"2014-02-05 14:21",
		"message_status":"未读"
	},
		{
		"send_user":"张三",
		"jobno":"2014SH300105",
		"message_content":"请对XX工作的XX图纸进行复核",
		"send_time":"2014-02-05 14:21",
		"message_status":"已读"
	},
		{
		"send_user":"张三",
		"jobno":"2014SH300105",
		"message_content":"请对XX工作的XX图纸进行复核",
		"send_time":"2014-02-05 14:21",
		"message_status":"已读"
	},
		{
		"send_user":"张三",
		"jobno":"2014SH300105",
		"message_content":"请对XX工作的XX图纸进行复核",
		"send_time":"2014-02-05 14:21",
		"message_status":"未读"
	}
]}

//送审图纸清单
var sendpaperlist={"total":200,"rows":[
	{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"A",
		"papername":"工作挺加强结构图",
		"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000004",
		"paperstatus":"审核中",
		"surveyor":"张三",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子",
		"assign_draw":"张三,李四",
		"assign_audit":"王五"
	},
		{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"B",
		"papername":"工作挺加强结构图",
			"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000003",
		"paperstatus":"审核中",
		"surveyor":"李四",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子",
			"assign_draw":"张三",
		"assign_audit":"王五"
	},
		{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"A",
		"papername":"工作挺加强结构图",
			"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000005",
		"paperstatus":"审核中",
		"surveyor":"张三",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子",
			"assign_draw":"李四",
		"assign_audit":"王五"
	},
		{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"A",
		"papername":"工作挺加强结构图",
			"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000006",
		"paperstatus":"审核中",
		"surveyor":"张三",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子",
			"assign_draw":"张三",
		"assign_audit":"王五"
	},
		{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"A",
		"papername":"工作挺加强结构图",
			"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000007",
		"paperstatus":"已退审",
		"surveyor":"张三",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子",
			"assign_draw":"李四",
		"assign_audit":"王五"
	},
		{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"A",
		"papername":"工作挺加强结构图",
			"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000008",
		"paperstatus":"审核中",
		"surveyor":"张三",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子",
		"assign_draw":"李四",
		"assign_audit":"王五"
	},
		{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"A",
		"papername":"工作挺加强结构图",
			"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000004",
		"paperstatus":"审核中",
		"surveyor":"张三",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子"
	},
		{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"A",
		"papername":"工作挺加强结构图",
			"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000004",
		"paperstatus":"审核中",
		"surveyor":"张三",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子"
	},
		{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"A",
		"papername":"工作挺加强结构图",
			"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000004",
		"paperstatus":"审核中",
		"surveyor":"张三",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子"
	},
		{
		"registdate":"2016-01-01",
		"paperno":"SC6110-054-02JS",
		"paperversion":"A",
		"papername":"工作挺加强结构图",
			"standardpapaer":"总布置图",
		"paperpageno":"5",
		"papercode":"20150000004",
		"paperstatus":"审核中",
		"surveyor":"张三",
		"expno":"H-1",
		"suggestno":"001H",
		"suggestno":"001H",
		"plandate":"2016-01-01",
		"overdate":"2016-02-01",
		"outmemo":"无",
		"inmemo":"无",
		"fileno":"归档卷号",
		"filetype":"电子"
	}
	
]}

//标准图纸清单
var standarpaperlist={"total":200,"rows":[
	{
		"exp":"船体",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"5"
	},
		{
		"exp":"轮机",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"6"
	},
		{
		"exp":"电气",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"7"
	},
		{
		"exp":"船体",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"8"
	},
		{
		"exp":"船体",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"9"
	},
		{
		"exp":"船体",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"5"
	},
		{
		"exp":"船体",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"5"
	},
		{
		"exp":"船体",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"5"
	},
		{
		"exp":"船体",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"5"
	},
		{
		"exp":"船体",
		"no":"400-002",
		"name_cn":"轮机送审图纸目录",
		"belongmodule":"船舶及动力管系审图",
		"valid":"有效",
		"memo":"无",
		"standworkload":"5"
	},
	
]}


//图纸缺陷信息
var paperdefectdata = {"total":200,"rows":[
	{
		"paper_no":"P116-100-001",
		"paper_name":"B总布置图",
		"defect_content":"缺陷内容缺陷内容",
		"submit_user":"张三",
		"submit_date":"2015-01-01"
	},
		{
		"paper_no":"P116-100-001",
		"paper_name":"B总布置图",
		"defect_content":"缺陷内容缺陷内容",
		"submit_user":"张三",
		"submit_date":"2015-01-01"
	},
		{
		"paper_no":"P116-100-001",
		"paper_name":"B总布置图",
		"defect_content":"缺陷内容缺陷内容",
		"submit_user":"张三",
		"submit_date":"2015-01-01"
	},
		{
		"paper_no":"P116-100-001",
		"paper_name":"B总布置图",
		"defect_content":"缺陷内容缺陷内容",
		"submit_user":"张三",
		"submit_date":"2015-01-01"
	},
		{
		"paper_no":"P116-100-001",
		"paper_name":"B总布置图",
		"defect_content":"缺陷内容缺陷内容",
		"submit_user":"张三",
		"submit_date":"2015-01-01"
	}
]}
//流程单

var flowlist = {"total":200,"rows":[
	{
		"batchno":"H-1",
		"acceptdate":"2016-01-01",
		"draw":"张三,王五",
		"audit":"李四"
	},
		{
		"batchno":"H-2",
		"acceptdate":"2016-01-02",
		"draw":"张三",
		"audit":"李四"
	},
		{
		"batchno":"H-3",
		"acceptdate":"2016-01-03",
		"draw":"张三",
		"audit":"李四"
	},
		{
		"batchno":"M-1",
		"acceptdate":"2016-01-04",
		"draw":"张三",
		"audit":"李四"
	},
		{
		"batchno":"M-2",
		"acceptdate":"2016-01-05",
		"draw":"张三",
		"audit":"李四"
	},
		{
		"batchno":"M-3",
		"acceptdate":"2016-01-06",
		"draw":"张三",
		"audit":"李四"
	}
]}

var data2 = [
	"id":1,
	"name":"C",
	"size":"",
	"date":"02/19/2010",
	"children":[
		"id":2,
		"name":"Program Files",
		"size":"120 MB",
		"date":"03/20/2010",
		"children":[
			"id":21,
			"name":"Java",
			"size":"",
			"date":"01/13/2010",
			"state":"closed",
			"children":[
				"id":211,
				"name":"java.exe",
				"size":"142 KB",
				"date":"01/13/2010"
			},
				"id":212,
				"name":"jawt.dll",
				"size":"5 KB",
				"date":"01/13/2010"
			}]
		},
			"id":22,
			"name":"MySQL",
			"size":"",
			"date":"01/13/2010",
			"state":"closed",
			"children":[
				"id":221,
				"name":"my.ini",
				"size":"10 KB",
				"date":"02/26/2009"
			},
				"id":222,
				"name":"my-huge.ini",
				"size":"5 KB",
				"date":"02/26/2009"
			},
				"id":223,
				"name":"my-large.ini",
				"size":"5 KB",
				"date":"02/26/2009"
			}]
		}]
	},
		"id":3,
		"name":"eclipse",
		"size":"",
		"date":"01/20/2010",
		"children":[
			"id":31,
			"name":"eclipse.exe",
			"size":"56 KB",
			"date":"05/19/2009"
		},
			"id":32,
			"name":"eclipse.ini",
			"size":"1 KB",
			"date":"04/20/2010"
		},
			"id":33,
			"name":"notice.html",
			"size":"7 KB",
			"date":"03/17/2005"
		}]
	}]
}]

var data3={"total":28,"rows":[
	{"productid":"FI-SW-01","productname":"Koi","unitcost":10.00,"status":"P","listprice":36.50,"attr1":"Large","itemid":"EST-1"},
	{"productid":"K9-DL-01","productname":"Dalmation","unitcost":12.00,"status":"P","listprice":18.50,"attr1":"Spotted Adult Female","itemid":"EST-10"},
	{"productid":"RP-SN-01","productname":"Rattlesnake","unitcost":12.00,"status":"P","listprice":38.50,"attr1":"Venomless","itemid":"EST-11"},
	{"productid":"RP-SN-01","productname":"Rattlesnake","unitcost":12.00,"status":"P","listprice":26.50,"attr1":"Rattleless","itemid":"EST-12"},
	{"productid":"RP-LI-02","productname":"Iguana","unitcost":12.00,"status":"P","listprice":35.50,"attr1":"Green Adult","itemid":"EST-13"},
	{"productid":"FL-DSH-01","productname":"Manx","unitcost":12.00,"status":"P","listprice":158.50,"attr1":"Tailless","itemid":"EST-14"},
	{"productid":"FL-DSH-01","productname":"Manx","unitcost":12.00,"status":"P","listprice":83.50,"attr1":"With tail","itemid":"EST-15"},
	{"productid":"FL-DLH-02","productname":"Persian","unitcost":12.00,"status":"P","listprice":23.50,"attr1":"Adult Female","itemid":"EST-16"},
	{"productid":"FL-DLH-02","productname":"Persian","unitcost":12.00,"status":"P","listprice":89.50,"attr1":"Adult Male","itemid":"EST-17"},
	{"productid":"AV-CB-01","productname":"Amazon Parrot","unitcost":92.00,"status":"P","listprice":63.50,"attr1":"Adult Male","itemid":"EST-18"}
]}



//计费项目
var itempricedata={"total":28,"rows":[
	{"jobno":"2016SP001","bill_item":"审图条目1","bill_plan_pay":220.00,"bill_act_pay":200.00,"bill_content":"备注信息"},
	{"jobno":"2016SP001","bill_item":"审图条目1","bill_plan_pay":220.00,"bill_act_pay":200.00,"bill_content":"备注信息"},
	{"jobno":"2016SP001","bill_item":"审图条目1","bill_plan_pay":220.00,"bill_act_pay":200.00,"bill_content":"备注信息"},
	{"jobno":"2016SP001","bill_item":"审图条目1","bill_plan_pay":220.00,"bill_act_pay":200.00,"bill_content":"备注信息"},
	{"jobno":"2016SP001","bill_item":"审图条目1","bill_plan_pay":220.00,"bill_act_pay":200.00,"bill_content":"备注信息"},
	{"jobno":"2016SP001","bill_item":"审图条目1","bill_plan_pay":220.00,"bill_act_pay":200.00,"bill_content":"备注信息"},
	{"jobno":"2016SP001","bill_item":"审图条目1","bill_plan_pay":220.00,"bill_act_pay":200.00,"bill_content":"备注信息"},
	{"jobno":"2016SP001","bill_item":"审图条目1","bill_plan_pay":220.00,"bill_act_pay":200.00,"bill_content":"备注信息"}
	
],"footer":[
	{"bill_item":"总计：","bill_plan_pay":200.26,"bill_act_pay":100.26}
]}


//计费通知单
var billlistdata={"total":28,"rows":[
	{"billno":"2016SP001","billdate":"2016-01-01","billpay":220.00,"billuser":"张三"},
	{"billno":"2016SP002","billdate":"2016-01-01","billpay":220.00,"billuser":"张三"},
	{"billno":"2016SP003","billdate":"2016-01-01","billpay":220.00,"billuser":"张三"}
	
],"footer":[
	{"billno":"总计：","billpay":660}
]}




//项目归档信息
var pigedata={"total":28,"rows":[
	{"tgbh":"01-01","dept":"电气室","paper_no":"2016SP001","paper_name":"XXX审图项目","zy":"船体","sl":"5","dw":"袋","zlr":"张三","jcr":"李四","jhrq":"2016-01-01","jcyj":"无","gdr":"王五","bz":"无"},
	{"tgbh":"01-02,01-03","dept":"轮机室","paper_no":"2016SP001","paper_name":"XXX审图项目","zy":"轮机","sl":"3","dw":"套","zlr":"张三","jcr":"李四","jhrq":"2016-01-01","jcyj":"无","gdr":"王五","bz":"无"},
	{"tgbh":"01-04","dept":"船体法定室","paper_no":"2016SP001","paper_name":"XXX审图项目","zy":"电气","sl":"2","dw":"袋","zlr":"张三","jcr":"李四","jhrq":"2016-01-01","jcyj":"无","gdr":"王五","bz":"无"}
]}

//图纸归档信息
var paperpigedata={"total":28,"rows":[
	{"hh":"10133-10135","dh":"SP13C153","ajtm":"250,000DWT矿砂船（OC25.0-5/6）","zy":"船体","ys":"3盒","bzdw":"结构一室","bzsj":"2016-01-01","bgqx":"50年","mj":"内控B","bz":"船体1H-375H（电子审图）工作卷两盒纸质送审图纸一盒（01H\12H\137H）","zhs":"3","cfdd":"上海规范研究所"},
	{"hh":"10132","dh":"SP13C153","ajtm":"250,000DWT矿砂船（OC25.0-5/6）","zy":"船体","ys":"3盒","bzdw":"结构一室","bzsj":"2016-01-01","bgqx":"50年","mj":"内控B","bz":"船体1H-375H（电子审图）工作卷两盒纸质送审图纸一盒（01H\12H\137H）","zhs":"3","cfdd":"上海规范研究所"},
	{"hh":"10133","dh":"SP13C153","ajtm":"250,000DWT矿砂船（OC25.0-5/6）","zy":"船体","ys":"3盒","bzdw":"结构一室","bzsj":"2016-01-01","bgqx":"50年","mj":"内控B","bz":"轮机1M-375M","zhs":"3","cfdd":"上海规范研究所"},
	
]}

//客户信息
var customerbilldata={"total":28,"rows":[
	{"customer":"中华人民共和国安庆海事局","sum_pay":"600","act_pay":"300","arrear_pay":"200"},
	{"customer":"海南哈飞游艇驾驶培训有限公司","sum_pay":"600","act_pay":"300","arrear_pay":"200"},
	{"customer":"中华人民共和国长江海事局","sum_pay":"600","act_pay":"300","arrear_pay":"200"},
	{"customer":"重庆市涪陵交通旅游建设投资集团有限公司","sum_pay":"600","act_pay":"300","arrear_pay":"200"},
	{"customer":"南京港（集团）有限公司","sum_pay":"600","act_pay":"300","arrear_pay":"200"},
	{"customer":"葛洲坝集团第五工程公司","sum_pay":"600","act_pay":"300","arrear_pay":"200"},
	{"customer":"中海发展股份有限公司货轮公司","sum_pay":"600","act_pay":"300","arrear_pay":"200"},
	{"customer":"中海客轮有限公司","sum_pay":"600","act_pay":"300","arrear_pay":"200"},
	{"customer":"启东吕宋轮船运输有限公司","sum_pay":"600","act_pay":"300","arrear_pay":"200"},
	{"customer":"张家港石油化工供销公司","sum_pay":"600","act_pay":"300","arrear_pay":"200"}
]}

//客户付费信息
var customerpaydata={"total":28,"rows":[
	{"customer":"中华人民共和国安庆海事局","jflist":"jf001","jobno":"2016SP001","billno":"SHST1600001","pay":200,"pay_date":"2016-01-01"},
	{"customer":"中华人民共和国安庆海事局","jflist":"jf002","jobno":"2016SP001","billno":"SHST1600002","pay":200,"pay_date":"2016-01-01"},
	{"customer":"中华人民共和国安庆海事局","jflist":"jf003","jobno":"2016SP001","billno":"SHST1600003","pay":200,"pay_date":"2016-01-01"},
	{"customer":"中华人民共和国安庆海事局","jflist":"jf004","jobno":"2016SP001","billno":"SHST1600004","pay":200,"pay_date":"2016-01-01"},
	{"customer":"中华人民共和国安庆海事局","jflist":"jf005","jobno":"2016SP001","billno":"SHST1600005","pay":200,"pay_date":"2016-01-01"},
	{"customer":"中华人民共和国安庆海事局","jflist":"jf006","jobno":"2016SP001","billno":"SHST1600006","pay":200,"pay_date":"2016-01-01"}
]}

//催款信息
var urgedata={"total":28,"rows":[
	{"customer":"中华人民共和国安庆海事局","jflist":"jf001","jobno":"2016SP001","billno":"SHST1601001","urge_date":"2016-01-01","urge_remark":"已督促xxxx付款，其回应在xxx之前结清剩余款项","urge_user":"张三"},
	{"customer":"张家港石油化工供销公司","jflist":"jf011","jobno":"2016SP005","billno":"SHST1600201","urge_date":"2016-01-01","urge_remark":"已督促xxxx付款，其回应在xxx之前结清剩余款项","urge_user":"李四"},
	{"customer":"中海客轮有限公司","jflist":"jf021","jobno":"2016SP121","billno":"SHST1600521","urge_date":"2016-01-01","urge_remark":"已督促xxxx付款，其回应在xxx之前结清剩余款项","urge_user":"王五"},
	{"customer":"中海发展股份有限公司货轮公司","jflist":"jf031","jobno":"2016SP301","billno":"SHST1601002","urge_date":"2016-01-01","urge_remark":"已督促xxxx付款，其回应在xxx之前结清剩余款项","urge_user":"张三"},
	{"customer":"南京港（集团）有限公司","jflist":"jf041","jobno":"2016SP041","billno":"SHST1602001","urge_date":"2016-01-01","urge_remark":"已督促xxxx付款，其回应在xxx之前结清剩余款项","urge_user":"李四"},
	{"customer":"中华人民共和国长江海事局","jflist":"jf051","jobno":"2016SP024","billno":"SHST1603007","urge_date":"2016-01-01","urge_remark":"已督促xxxx付款，其回应在xxx之前结清剩余款项","urge_user":"王五"},
	{"customer":"海南哈飞游艇驾驶培训有限公司","jflist":"jf061","jobno":"2016SP022","billno":"SHST1604005","urge_date":"2016-01-01","urge_remark":"已督促xxxx付款，其回应在xxx之前结清剩余款项","urge_user":"张三"}
	
]}




//意见书信息
var approvaldata = {"total":28,"rows":[
	{"approvalstatus":"已批准","no":"47H","mainorg":"张家港石油化工供销公司","copyorg":"CCS温州办事处","credate":"2016-01-01","projectid":""},
	{"approvalstatus":"待提交","no":"40H","mainorg":"张家港石油化工供销公司","copyorg":"CCS温州办事处","credate":"2016-01-01","projectid":""},
	{"approvalstatus":"已批准","no":"50H","mainorg":"张家港石油化工供销公司","copyorg":"CCS温州办事处","credate":"2016-01-01","projectid":""},
	{"approvalstatus":"待提交","no":"24H","mainorg":"张家港石油化工供销公司","copyorg":"CCS温州办事处","credate":"2016-01-01","projectid":""},
	{"approvalstatus":"已批准","no":"25H","mainorg":"张家港石油化工供销公司","copyorg":"CCS温州办事处","credate":"2016-01-01","projectid":""},
	{"approvalstatus":"已批准","no":"26H","mainorg":"张家港石油化工供销公司","copyorg":"CCS温州办事处","credate":"2016-01-01","projectid":""},
	{"approvalstatus":"待提交","no":"27H","mainorg":"张家港石油化工供销公司","copyorg":"CCS温州办事处","credate":"2016-01-01","projectid":""}
	
]}

//审图意见
var suggestdata = {"total":28,"rows":[
	{"jobno":"SP16C001","approvalno":"04H","paperno":"HS6007-020-007","version":"01","paper_name":"总布置图","suggest":"本审图意见请尽快予以回复。在全部图纸审查完之前，本审图部保留对已审批图纸继续提意见的权利。","projectid":"2014DL350001","classify":"S","closedate":"2016-02-01","alarmstatus":"normal"},
	{"jobno":"SP16C002","approvalno":"04H","paperno":"HS6007-020-007","version":"01","paper_name":"总布置图","suggest":"本审图意见请尽快予以回复。在全部图纸审查完之前，本审图部保留对已审批图纸继续提意见的权利。","projectid":"2014DL350001","classify":"P","closedate":"2016-02-01","alarmstatus":"closeto"},
	{"jobno":"SP16C003","approvalno":"04H","paperno":"HS6007-020-007","version":"01","paper_name":"总布置图","suggest":"本审图意见请尽快予以回复。在全部图纸审查完之前，本审图部保留对已审批图纸继续提意见的权利。","projectid":"2014DL350001","classify":"S","closedate":"2016-02-01","alarmstatus":"overdue"},
	{"jobno":"SP16C004","approvalno":"04H","paperno":"HS6007-020-007","version":"01","paper_name":"总布置图","suggest":"本审图意见请尽快予以回复。在全部图纸审查完之前，本审图部保留对已审批图纸继续提意见的权利。","projectid":"2014DL350001","classify":"P","closedate":"2016-02-01","alarmstatus":"normal"},
	{"jobno":"SP16C005","approvalno":"04H","paperno":"HS6007-020-007","version":"01","paper_name":"总布置图","suggest":"本审图意见请尽快予以回复。在全部图纸审查完之前，本审图部保留对已审批图纸继续提意见的权利。","projectid":"2014DL350001","classify":"S","closedate":"2016-02-01","alarmstatus":"closeto"},
	{"jobno":"SP16C006","approvalno":"04H","paperno":"HS6007-020-007","version":"01","paper_name":"总布置图","suggest":"本审图意见请尽快予以回复。在全部图纸审查完之前，本审图部保留对已审批图纸继续提意见的权利。","projectid":"2014DL350001","classify":"P","closedate":"2016-02-01","alarmstatus":"overdue"},
	{"jobno":"SP16C007","approvalno":"04H","paperno":"HS6007-020-007","version":"01","paper_name":"总布置图","suggest":"本审图意见请尽快予以回复。在全部图纸审查完之前，本审图部保留对已审批图纸继续提意见的权利。","projectid":"2014DL350001","classify":"S","closedate":"2016-02-01","alarmstatus":"normal"}
]}



//适用标准
var standarddata = {"total":28,"rows":[
	{"standard_classify":"海船适用标准","standard_name_cn":"75届海安徽通过的决议及部分通函","standard_name_en":""},
	{"standard_classify":"海船适用标准","standard_name_cn":"2008修改案（以MSC.271(85)决议通过，2010年1月1日","standard_name_en":"2008 Amendments(by Msc.271(85),effective "},
	{"standard_classify":"海船适用标准","standard_name_cn":"附则VI 防止船舶造成空气污染规则","standard_name_en":"Annex VI Regulations for the prevention of air pollution from ships"},
	{"standard_classify":"海船适用标准","standard_name_cn":"CCS 钢质海船建造和入级规范(1983)","standard_name_en":"The rules and regulations for the "}
]}



//标准图纸字典
var standarddicdata = {"total":28,"rows":[
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","module":"船舶及动力管系审图","valid":"有效","remark":"","p1":"客船","p2":"CSDA","p3":"海口--海安,近海航区调遣","p4":"100-200","p5":"20150101-20160101"},
	{"export":"轮机","no":"400-002","name_cn":"轮机说明书","module":"船舶及动力管系审图","valid":"有效","remark":"","p1":"客船","p2":"CSDA","p3":"海口--海安,近海航区调遣","p4":"100-200","p5":"20150101-20160101"},
	{"export":"电气","no":"400-003","name_cn":"机械设备估算书","module":"船舶及动力管系审图","valid":"有效","remark":"","p1":"客船","p2":"CSDA","p3":"海口--海安,近海航区调遣","p4":"100-200","p5":"20150101-20160101"},
	{"export":"船体","no":"400-004","name_cn":"轮机送审图纸目录","module":"船舶及动力管系审图","valid":"有效","remark":"","p1":"客船","p2":"CSDA","p3":"海口--海安,近海航区调遣","p4":"100-200","p5":"20150101-20160101"},
	{"export":"船体","no":"400-005","name_cn":"轮机送审图纸目录","module":"船舶及动力管系审图","valid":"有效","remark":"","p1":"客船","p2":"CSDA","p3":"海口--海安,近海航区调遣","p4":"100-200","p5":"20150101-20160101"},
	{"export":"船体","no":"400-006","name_cn":"轮机送审图纸目录","module":"船舶及动力管系审图","valid":"有效","remark":"","p1":"客船","p2":"CSDA","p3":"海口--海安,近海航区调遣","p4":"100-200","p5":"20150101-20160101"},
	{"export":"船体","no":"400-007","name_cn":"轮机送审图纸目录","module":"船舶及动力管系审图","valid":"有效","remark":"","p1":"客船","p2":"CSDA","p3":"海口--海安,近海航区调遣","p4":"100-200","p5":"20150101-20160101"}
]}

//标准图纸工时
var standardloaddata = {"total":28,"rows":[
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"},
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"},
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"},
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"},
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"},
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"},
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"},
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"},
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"},
	{"export":"船体","no":"400-001","name_cn":"轮机送审图纸目录","t1":"2.0","t2":"2.0","t3":"2.0","t4":"2.0","t5":"2.0","t6":"2.0","t7":"2.0"}
]}




//审图意见书列表
var sendbacklist = 
{"total":28,"rows":[
	{"zy":"船体","yjslsh":"SP16C001-001H","tsrq":"2016-01-01","zbr":"张三","sx":"李四","sh":"王五","fh":"赵六","qf":"张三","ztfbrq":"2016-01-01","bz":"","scrq":"2016-01-01"},
	{"zy":"船体","yjslsh":"SP16C001-002H","tsrq":"2016-01-02","zbr":"张三","sx":"李四","sh":"王五","fh":"赵六","qf":"张三","ztfbrq":"2016-01-01","bz":"","scrq":"2016-01-01"},
	{"zy":"轮机","yjslsh":"SP16C001-001M","tsrq":"2016-01-03","zbr":"张三","sx":"李四","sh":"王五","fh":"赵六","qf":"张三","ztfbrq":"2016-01-01","bz":"","scrq":"2016-01-01"},
	{"zy":"轮机","yjslsh":"SP16C001-002M","tsrq":"2016-01-04","zbr":"张三","sx":"李四","sh":"王五","fh":"赵六","qf":"张三","ztfbrq":"2016-01-01","bz":"","scrq":"2016-01-01"},
	{"zy":"轮机","yjslsh":"SP16C001-003M","tsrq":"2016-01-05","zbr":"张三","sx":"李四","sh":"王五","fh":"赵六","qf":"张三","ztfbrq":"2016-01-01","bz":"","scrq":"2016-01-01"}
]}



//拟持证书
var certdata = {"total":28,"rows":[
	{"cert_classify":"非国际拟持证书","cert_name_cn":"装载手册","cert_name_en":""},
	{"cert_classify":"国际拟持证书","cert_name_cn":"入级证书","cert_name_en":"Classification cert. For hull "},
	{"cert_classify":"国际拟持证书","cert_name_cn":"国际载重线证书","cert_name_en":"International Load line certificate"},
	{"cert_classify":"海船适用标准","cert_name_cn":"货船构造安全证书","cert_name_en":"Cargo ship safety construction certificate"}
]}


//审图派工分类
var assigndrawdata = {"total":1,"rows":[
	{
		"s1":"张三",
		"s2":"李四",
		"s3":"王五",
		"s4":"李四",
		"s5":"张三",
		"s6":"李四",
		"s7":"张三",
		"s8":"李四",
		"s9":"张三",
		"s10":"李四",
		"s11":"张三",
		"s12":"李四"
	}
	
]}

var taskList={"total":4,"rows":[
	{"taskId":"1","taskName":"任务一","staff":"张三","status":"暂停","timeProgress":"100%","exeProgress":"80%"},
]}

var taskDetail={"total":1,"rows":[
	{"taskId":"1","taskName":"任务一","staff":"张三","status":"暂停","timeProgress":"100%","exeProgress":"80%"}
]}


var staffList={"total":15,"rows":[

	
	
	{"center":"广州","pauseProjectNum":"2","depart":"轮机","pauseTaskWork":"15","taskWork":"40","staffName":"张三","staffType":"轮机","staffTitle":"工程师","projectNum":"3","export":"船体"},
	{"center":"武汉","pauseProjectNum":"0","depart":"轮机","pauseTaskWork":"0","taskWork":"12","staffName":"李四","staffType":"轮机","staffTitle":"工程师","projectNum":"2","export":"轮机"},
	
	
	
	
	
]}

var epasreviewassigndata={"total":15,"rows":[

{"center":"广州","pauseProjectNum":"2","depart":"轮机","pauseTaskWork":"15","taskWork":"40","staffName":"张三","staffType":"审图验船师","staffTitle":"工程师","projectNum":"3","export":"船体"},	
{"center":"武汉","pauseProjectNum":"0","depart":"轮机","pauseTaskWork":"0","taskWork":"12","staffName":"李四","staffType":"审图验船师","staffTitle":"工程师","projectNum":"2","export":"轮机"},	
{"center":"武汉","pauseProjectNum":"0","depart":"轮机","pauseTaskWork":"0","taskWork":"5","staffName":"王五","staffType":"审图验船师","staffTitle":"工程师","projectNum":"1","export":"电气"},
{"center":"广州","pauseProjectNum":"2","depart":"轮机","pauseTaskWork":"15","taskWork":"40","staffName":"张三","staffType":"审图验船师","staffTitle":"工程师","projectNum":"3","export":"船体"},
{"center":"武汉","pauseProjectNum":"0","depart":"轮机","pauseTaskWork":"0","taskWork":"12","staffName":"李四","staffType":"审图验船师","staffTitle":"工程师","projectNum":"2","export":"轮机"},	
{"center":"武汉","pauseProjectNum":"0","depart":"轮机","pauseTaskWork":"0","taskWork":"5","staffName":"王五","staffType":"审图验船师","staffTitle":"工程师","projectNum":"1","export":"电气"},	
{"center":"广州","pauseProjectNum":"2","depart":"轮机","pauseTaskWork":"15","taskWork":"40","staffName":"张三","staffType":"审图验船师","staffTitle":"工程师","projectNum":"3","export":"船体"},	
{"center":"武汉","pauseProjectNum":"0","depart":"轮机","pauseTaskWork":"0","taskWork":"12","staffName":"李四","staffType":"审图验船师","staffTitle":"工程师","projectNum":"2","export":"轮机"},	
{"center":"武汉","pauseProjectNum":"0","depart":"轮机","pauseTaskWork":"0","taskWork":"5","staffName":"王五","staffType":"审图验船师","staffTitle":"工程师","projectNum":"1","export":"电气"},	
{"center":"广州","pauseProjectNum":"2","depart":"轮机","pauseTaskWork":"15","taskWork":"40","staffName":"张三","staffType":"审图验船师","staffTitle":"工程师","projectNum":"3","export":"船体"}
]}



var staffTaskList={"total":15,"rows":[

var dailyRecordList={"total":8,"rows":[

var taskSList={"total":7,"rows":[


var reviewassigndata = {"total":4,"rows":[
	{"name":"船体-规范审核","value":"张三,李四"},
	{"name":"船体-规范复核","value":"王五,赵六"},
	{"name":"船体-有限元审核","value":"张三"},
	{"name":"船体-有限元复核","value":"李四"},
	{"name":"船体-性能审核","value":"王五"},
	{"name":"船体-性能复核","value":"赵六"},
	{"name":"船体-法定审核","value":"王五"},
	{"name":"船体-法定复核","value":"赵六"},
	{"name":"轮机-轮机审核","value":"张三"},
	{"name":"轮机-轮机复核","value":"李四"},
	{"name":"轮机-扭振审核","value":"王五"},
	{"name":"轮机-扭振复核","value":"李四"},
	{"name":"电气-电气审核","value":"张三"},
	{"name":"电气-电气复核","value":"李四"}
]}


var epaslogdata = {"total":15,"rows":[

{"log_date":"2016-01-01","paper_no":"HS6007-020-001","paper_name":"总布置图","work_load":"5","log_user":"张三","log_content":"XXXX图纸审图"},	
{"log_date":"2016-01-02","paper_no":"HS6007-020-002","paper_name":"总布置图","work_load":"6","log_user":"李四","log_content":"XXXX图纸复核"},	
{"log_date":"2016-01-03","paper_no":"HS6007-020-003","paper_name":"总布置图","work_load":"3","log_user":"张三","log_content":"XXXX图纸审图"},	
{"log_date":"2016-01-04","paper_no":"HS6007-020-004","paper_name":"总布置图","work_load":"4","log_user":"李四","log_content":"XXXX图纸复核"},	
{"log_date":"2016-01-05","paper_no":"HS6007-020-005","paper_name":"总布置图","work_load":"2","log_user":"张三","log_content":"XXXX图纸审图"}	
]
}

//首页待办
var indextasklist={"total":200,"rows":[
	{"projectclassify":"审图","tasktype":"审图登记","alarmstatus":"","taskno":"2016SP001_001","taskname":"SP16C001审图工作登记","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"审图","tasktype":"审图评审","alarmstatus":"closeto","taskno":"2016SP001_001","taskname":"SP16C001审图工作评审","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"审图","tasktype":"审图图纸派工","alarmstatus":"closeto","taskno":"2016SP001_001","taskname":"XX审图图纸派工","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"审图","tasktype":"审图任务","alarmstatus":"","taskno":"2016SP001_001","taskname":"XX图纸审图","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"审图","tasktype":"审图任务2","alarmstatus":"","taskno":"2016SP001_001","taskname":"XX图纸审图","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"审图","tasktype":"审图复核","alarmstatus":"","taskno":"2016SP001_001","taskname":"XX图纸复核","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"审图","tasktype":"审图盖章","alarmstatus":"overdue","taskno":"2016SP001_001","taskname":"SP16C001审图工作意见书盖章","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"审图","tasktype":"审图归档","alarmstatus":"closeto","taskno":"2016SP001_001","taskname":"SP16C001审图工作归档","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	

	{"projectclassify":"计划任务","tasktype":"计划任务登记","alarmstatus":"","taskno":"2016SP001_001","taskname":"XX审图评审","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"计划任务","tasktype":"计划任务评审","alarmstatus":"","taskno":"2016SP001_001","taskname":"XX审图评审","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"计划任务","tasktype":"计划任务执行","alarmstatus":"overdue","taskno":"2016SP001_001","taskname":"XX审图评审","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	{"projectclassify":"计划任务","tasktype":"计划任务汇报","alarmstatus":"closeto","taskno":"2016SP001_001","taskname":"XX审图评审","projectname":"XX审图项目","assigneddate":"2016-01-01","projectprocess":"25%","workload":"50"},
	
	{"projectclassify":"规范科研","tasktype":"项目信息补填","alarmstatus":"","taskno":"2016XXX_001","taskname":"完善项目内容","projectname":"XX科研项目","assigneddate":"2016-02-22","projectprocess":"25%","workload":"50"},
	{"projectclassify":"规范科研","tasktype":"阶段计划/任务编制","alarmstatus":"","taskno":"2016XXX_001","taskname":"制定项目计划任务","projectname":"XX科研项目","assigneddate":"2016-02-22","projectprocess":"25%","workload":"50"},
	{"projectclassify":"规范科研","tasktype":"评审意见分配","alarmstatus":"overdue","taskno":"2016XXX_001","taskname":"评审意见分配","projectname":"XX科研项目","assigneddate":"2016-02-22","projectprocess":"25%","workload":"50"},
	{"projectclassify":"规范科研","tasktype":"任务处理","alarmstatus":"closeto","taskno":"2016XXX_001","taskname":"对XX进行研究","projectname":"XX科研项目","assigneddate":"2016-02-22","projectprocess":"25%","workload":"50"},
	{"projectclassify":"规范科研","tasktype":"任务处理","alarmstatus":"","taskno":"2016XXX_001","taskname":"编写XX规范初稿","projectname":"XX科研项目","assigneddate":"2016-02-22","projectprocess":"25%","workload":"50"},
	{"projectclassify":"规范科研","tasktype":"评审意见任务","alarmstatus":"overdue","taskno":"2016XXX_001","taskname":"对XX意见进行处理","projectname":"XX科研项目","assigneddate":"2016-02-22","projectprocess":"25%","workload":"50"},
	{"projectclassify":"规范科研","tasktype":"评审任务","alarmstatus":"closeto","taskno":"2016XXX_001","taskname":"参加XX评审","projectname":"XX科研项目","assigneddate":"2016-02-22","projectprocess":"25%","workload":"50"}
	
]}

var fileList = {"total":200,"rows":[

//帮助文件
var tipdata = {
		importEpasInfo : "请导入SSMIS导出的审图工作文件",
		taskHelp:"全部待办列表,点击右键进行日志填报",
		projectTaskHelp:"被选择项目的待办列表,点击右键进行日志填报"
}


//附件类别树形目录

var attachtreedata = [{
    "id":1,
    "text":"全部类别",
    "children":[
		{
			"text":"审图",
			"children":[
				{
					"text":"图纸(10)"
				},
					"text":"图片(5)"
				},
					"text":"流程单(5)"
				},
					"text":"意见书(3)"
				},
					"text":"评审表(3)"
				},
					"text":"经验分享(10)",
				}
			]
		},
			"text":"科研规范",
			"children":[
				{
					"text":"规范(5)"
				},
					"text":"标准(2)"
				},
					"text":"报告(3)"
				},
					"text":"图片(5)"
				},
					"text":"经验分享(10)",
				}
			]
		},
			"text":"一般项目",
			"children":[
				{
					"text":"传真(3)",
				},
					"text":"客户提供资料(0)",
				},
					"text":"流程附件(4)",
				},
					"text":"规范(2)",
				},
					"text":"标准(3)",
				},
					"text":"经验分享(10)",
				},
					"text":"图纸(10)",
				},
					"text":"图片(5)"
				}	
			]
		}
     ]
}]

//附件类型
var attachlist = {"total":200,"rows":[
	{"id":1,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":2,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":3,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":4,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":5,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":6,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":7,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":8,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":9,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":10,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"},
	{"id":11,"jobno":"2016DL00003","name":"总布置图","type":"pdf","size":"1022","classify":"图纸","remark":"xxxx审图项目总布置图","uploader":"张三"}
]}
 
//图柜列表


var cupboardlist = {"total":200,"rows":[
	{"tgbh":"01-01","jobnos":"SP16C001,SP16C002","remark":"寄送总部","last_date":"2016-01-01"},
	{"tgbh":"01-02","jobnos":"SP16C003,SP16C004","remark":"寄送总部","last_date":"2016-01-02"},
	{"tgbh":"01-03","jobnos":"SP16C004,SP16C005","remark":"寄送总部","last_date":"2016-01-03"},
	{"tgbh":"02-01","jobnos":"SP16C006,SP16C007","remark":"寄送总部","last_date":"2016-01-04"},
	{"tgbh":"02-02","jobnos":"SP16C008,SP16C009","remark":"寄送总部","last_date":"2016-01-05"}
]}



var qualist = {"total":200,"rows":[
	{"attach":"","getdate":"2016-01-01","certno":"","classify":"转化","remark":""},
	{"attach":"","getdate":"2016-01-01","certno":"","classify":"新增","remark":""},
	{"attach":"","getdate":"2016-01-01","certno":"","classify":"更新","remark":""},
	{"attach":"","getdate":"2016-01-01","certno":"","classify":"转化","remark":""},
	{"attach":"","getdate":"2016-01-01","certno":"","classify":"转化","remark":""},
	{"attach":"","getdate":"2016-01-01","certno":"","classify":"转化","remark":""}
]}



var centerList = [

var deptList = [

var planTypeList = [

var planStatus = [

var centerPlan = {"total":200,"rows":[

var planList = {"total":200,"rows":[
{"startTime":"2016-1-1","center":"中国船级社审图中心","workload":"10","staff":"李四、王五","complete":"30%","status":"草稿","leader":"张三","dept":"业务管理部","endTime":"2016-1-31","taskName":"XXX","taskGoal":"1、XXX；2、XXXXXXXX","week":"31"},

var staffDailyList = {"total":200,"rows":[
{"staff":"张三","exeWorkload":"60%","projectname":"项目A","efficiency":"120%","fillWorkload":"15","taskname":"任务A","planWorkload":"30"},

var taskTree = {"total":15,"rows":[
{"id":"0","taskNo":"XXXX-01","taskName":"项目A","_parentId":""},
{"id":"001003","workload":"50","status":"执行中","timeProcess":"30%","tasktype":"项目跟踪","extProcess":"40%","checkDate":"2016-1-1","taskNo":"XXXX-04","projectName":"项目A","taskName":"项目进度跟踪","_parentId":"001"},