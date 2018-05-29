<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="pub/TagLib.jsp"%>
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
	<div data-options="region:'north',split:true,title:'North'" style="height:60px;background:#fff;padding:10px">north region</div>
	<div data-options="region:'west',split:true,title:'West'" style="width:150px;padding:10px;overflow:auto;">
		<!-- 
		<a href="${ctx}/easyUi/easyUi!datagrid.do">easyui datagrid</a><br/>
		<a href="${ctx}/" onclick="showThis(this);return false">easyui datagrid in win</a><br/>
		<a href="${ctx}/easyUi/easyUi!datagridApi.do">easyui datagrid api</a><br/>
		<a href="${ctx}/easyUi/easyUi!propertyGrid.do">easyui propertygrid</a><br/>
		<a href="${ctx}/easyUi/easyUi!form.do">easyui form</a><br/>
		<a href="${ctx}/easyUi/easyUi!combobox.do">easyui combobox</a><br/>
		<a href="${ctx}/tree/tree_index.do">jquery ztree</a><br/> 
		<a href="${ctx}/tree/tree_select.do?ckType=checkbox&checkCodes=root.00001,root.00001.00001,root.00002,root.00003.00001.00001">jquery ztree(select)</a><br/>
		<a href="${ctx}/tree/tree_openCheckTree.do">选择树节点</a><br/>  
		 -->
		<a href="${ctx}/common/common!sysDicPubList.do">字典定义</a><br/>
		<a href ="${ctx}/backlog/backlog!backlog.do" onclick="showThis(this);return false">backlog</a><br/> 
		<a href ="${ctx}/backlog/backlog!fastCreateBacklog.do" onclick="showThis(this);return false">Fast Create Backlog</a><br/>
		<a href ="${ctx}/backlog/backlog!backlogForUser.do" onclick="showThis(this);return false">backlog for user</a><br/>  
		<a href ="${ctx}/checklist/checklist!index.do" onclick="showThis(this);return false">checklist</a><br/>  
		<a href ="${ctx}/checklist/checklist!checklistTree.do" onclick="showThis(this);return false">检查项目表实施</a><br/>  
		<a href ="${ctx}/plan/plan!planList.do" onclick="showThis(this);return false">计划列表</a><br/>  
		<a href ="${ctx}/se/se!seDayNoteList.do" onclick="showThis(this);return false">项目大事记</a><br/> 
		<a href ="${ctx}/se/se!seMeetingRecordList.do" onclick="showThis(this);return false">纪要记录</a><br/>  
		<a href ="${ctx}/se/seRequirementTrace!seRequirementTraceIndex.do?seRequirementTrace.projectId=SSMIS-A6" onclick="showThis(this);return false">需求矩阵</a><br/> 
		<a href ="${ctx}/se/se!seTraceNoteList.do" onclick="showThis(this);return false">遗留备忘</a><br/>  
		<a href ="${ctx}/se/se!seRiskList.do" onclick="showThis(this);return false">项目风险</a><br/>  
		<a href ="${ctx}/se/se!seUserList.do" onclick="showThis(this);return false">用户管理</a><br/>  
		<a href ="${ctx}/se/se!seProjectInfoList.do" onclick="showThis(this);return false">项目信息</a><br/>  
		<a href ="${ctx}/se/se!seUserLog.do" onclick="showThis(this);return false">日志</a><br/>  
		<a href ="${ctx}/se/se!sePubModuleList.do" onclick="showThis(this);return false">公共方法</a><br/>  
		<a href ="${ctx}/se/se!seTraceTaskList.do" onclick="showThis(this);return false">任务</a><br/>  
		<a href ="${ctx}/common/common!userSelector.do?seMapUser.relaTab=tab&seMapUser.tabKeyValue=1" onclick="showThis(this);return false">公共人员选择器</a><br/>  
		<a href ="${ctx}/se/se!seUserRewardAmerceList.do" onclick="showThis(this);return false">奖惩记录</a><br/>  
		<a href ="${ctx}/se/se!seUserView.do" onclick="showThis(this);return false">人员视图</a><br/>  
		<a href ="${ctx}/login/login!login.do" onclick="showThis(this);return false">系统登录</a><br/>  
		
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