<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>INDEX</title>

<!-- easyui css -->
<link rel="stylesheet" href="${ctx}/js/easyui/themes/default/easyui.css" />
<link rel="stylesheet" href="${ctx}/js/easyui/themes/icon.css" />

<!-- jquery js -->
<script src="${ctx}/js/jquery/jquery-1.8.0.min.js"></script>

<!--  easyui js -->
<script src="${ctx}/js/easyui/jquery.easyui.min.js"></script>
<script src="${ctx}/js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script>
var win;
$(function(){
	win = $('#win').window({
	    width:900,
	    height:600,
	    modal:true,
	    border:false
	});
	$('#win').window('close');
	
	
	//$("body").layout("collapse","north");
})
function showThis(o){
	
	window.open(o.href);
	
	//当前窗口打开弹出层的方式
	/*document.getElementById("winSrc").src = o.href;
	var w =  document.body.clientWidth * 0.95;
	var h = document.body.clientHeight * 0.95;
	$('#win').window('open');// open a window
	$('#win').window('resize',{
		width:w,
		height:h
	});
	$('#win').window('center');*/
	
}
</script>
</head>

<body class="easyui-layout">
	<div data-options="region:'north',split:true" style="height:60px;background:#fff;padding:10px">
		<div style="text-align:right;">
			<c:if test="${loginUserInfo == null }">
			<a href ="${ctx}/login/login!login.do" >系统登录</a><br/>  
			</c:if>
			<c:if test="${loginUserInfo != null }">
			登录用户：${loginUserInfo.seUser.userName }
			<a href="${ctx}/login/login!logout.do">退出</a>
			<a href="${ctx}/login/login!logout.do">修改密码</a>
			</c:if>
		</div>
	</div>
	
	
	<div data-options="region:'west',split:true,title:'West'" style="width:150px;padding:1px;overflow:auto;">
		<div class="easyui-accordion" data-options="fit:true,border:false" >
			<div title="常用" style="padding:5px;">
				<a href ="${ctx}/backlog/backlog!backlog.do" onclick="showThis(this);return false">backlog</a><br/> 
				<a href ="${ctx}/checklist/checklist!checklistTree.do" onclick="showThis(this);return false">检查项目表实施</a><br/>   
				<a href ="${ctx}/se/seRequirementTrace!seRequirementTraceIndex.do?seRequirementTrace.projectId=SSMIS-A6" onclick="showThis(this);return false">需求矩阵</a><br/> 
				<a href ="${ctx}/se/se!seUserLog.do" onclick="showThis(this);return false">日志</a><br/>  
				<a href ="${ctx}/se/se!sePubModuleList.do" onclick="showThis(this);return false">公共方法</a><br/>  
				<a href ="${ctx}/seProcess/seProcess!startProcess.do" onclick="showThis(this);return false">流程(开发中)</a><br/>  
				<a href ="${ctx}/seProcess/seProcess!todoList.do" onclick="showThis(this);return false">待办(开发中)</a><br/>  
			
			</div>
			<div title="VIEW" style="padding:5px;">
				<a href ="${ctx}/se/se!seUserView.do" onclick="showThis(this);return false">人员视图</a><br/>  
				<a href ="${ctx}/se/se!seCountView.do" onclick="showThis(this);return false">统计视图</a><br/>  
				<a href ="${ctx}/login/login!login.do" onclick="showThis(this);return false">系统登录</a><br/>  
			</div>
			<div title="其他" style="padding:5px;">
				
				<a href ="${ctx}/checklist/checklist!index.do" onclick="showThis(this);return false">checklist</a><br/> 
				<a href="${ctx}/common/common!sysDicPubList.do">字典定义</a><br/>
				<a href ="${ctx}/se/se!seMeetingRecordList.do" onclick="showThis(this);return false">纪要记录</a><br/>  
				<a href ="${ctx}/plan/plan!planList.do" onclick="showThis(this);return false">计划列表</a><br/>
				<a href ="${ctx}/se/se!seDayNoteList.do" onclick="showThis(this);return false">项目大事记</a><br/> 
				<a href ="${ctx}/backlog/backlog!backlogForUser.do" onclick="showThis(this);return false">backlog for user</a><br/> 
				<a href ="${ctx}/backlog/backlog!fastCreateBacklog.do" onclick="showThis(this);return false">Fast Create Backlog</a><br/>
				<a href ="${ctx}/se/se!seRiskList.do" onclick="showThis(this);return false">项目风险</a><br/>  
				<a href ="${ctx}/se/se!seUserList.do" onclick="showThis(this);return false">用户管理</a><br/>  
				<a href ="${ctx}/common/common!userSelector.do?seMapUser.relaTab=tab&seMapUser.tabKeyValue=1" onclick="showThis(this);return false">公共人员选择器</a><br/>  
				<a href ="${ctx}/se/se!seUserRewardAmerceList.do" onclick="showThis(this);return false">奖惩记录</a><br/> 
				<c:if test="${ session.loginUserInfo.canReadCost == '1' }">
					<a href ="${ctx}/se/se!seProjectInfoList.do" onclick="showThis(this);return false">项目信息</a><br/>  
				</c:if>
				[${session.user }]
			</div>
		</div>
		
		
		
		<!-- 
		<a href ="${ctx}/common/common!xxjthzsg.do" onclick="showThis(this);return false">小小军团</a><br/>  
		 -->
		
	</div>
	<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;">east region</div>
	<div data-options="region:'south',split:true,border:false" style="height:50px;background:#fff;padding:10px;">south region</div>
	<div data-options="region:'center',title:'Center'">
		
	</div>
	
	<div id="win"><iframe id="winSrc" frameborder="0" width="100%" height="100%"></iframe></div>
</body>


</html>