<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
var tab;
var win;
var theForm;
var currentTaskTab;
var hisTaskTab;


var input_user_list_setting ={
		url:'${ctx}/common/common!queryUserListAllJsonStr.do',
		valueField:'USER_ID',
		textField:'USER_NAME'
};


//刷新表格
function reloadDg() {
	tab.datagrid("reload");
}
//重新查询
function loadCurrentTaskTab(processInstanceId){
	currentTaskTab.datagrid("load", {id:processInstanceId});
}
//重新查询
function loadhisTaskTab(processInstanceId){
	hisTaskTab.datagrid("load", {id:processInstanceId});
}


//重新查询
function loadDg() {
	var jsonData = $("#theForm").serializeArray();
	var params = formToJson(jsonData);
	console.log(params);
	params.a = Math.random();
	//showObj(params);
	tab.datagrid("load", params);
}
//重置表单后查询
function resetForm(){
	theForm.form("clear");
	loadDg();
}

function showTaskInfo(){
	var rowData = tab.datagrid("getSelected");
	if(rowData){
		var url = "seProcess/seProcess!taskProcessInfo.do?jobno="+rowData.jobno;
		opw({url:url});
	}else{
		alert("请选择流程实例数据");
	}
}


function deleteProcess(){
	if(confirm("删除后不可恢复,确定删除流程吗?")){
		var rowData = tab.datagrid("getSelected");
		if(rowData){
			$.ajax({
			    url:"${ctx}/seProcess/seProcess!cancelProcessInstance.do",//请求地址
			    method:"post",//提交方式
			    async:false,//是否异步
			    cache:false,//是否缓存
			    data:{jobno:rowData.jobno},//可以是字符串也可以是json对象，字符串类似本例子中的内容
			    dataType:"text",//返回数据的格式 xml, json, script, or html
			    success:function(r){//回调函数
			      var str = $.trim(r);
			      if(str == "SUCCESS"){
			        alert("操作成功");
			        reloadDg();
			      }else{
			        alert("操作失败");
			      };
			    }
			  })
		}else{
			alert("请选择流程实例数据");
		}
	}
}

function activeProcess(){
	var rowData = tab.datagrid("getSelected");
	if(rowData){
		$.ajax({
		    url:"${ctx}/seProcess/seProcess!activateProcessInstance.do",//请求地址
		    method:"post",//提交方式
		    async:false,//是否异步
		    cache:false,//是否缓存
		    data:{jobno:rowData.jobno},//可以是字符串也可以是json对象，字符串类似本例子中的内容
		    dataType:"text",//返回数据的格式 xml, json, script, or html
		    success:function(r){//回调函数
		      var str = $.trim(r);
		      if(str == "SUCCESS"){
		        alert("操作成功");
		        reloadDg();
		      }else{
		        alert("操作失败");
		      };
		    }
		  })
	}else{
		alert("请选择流程实例数据");
	}
}


function gotoTodo(){
	var rowData = currentTaskTab.datagrid("getSelected"); 
	if(rowData){
		/*var taskUrl = rowData.formKey + 
		"?jobno=" + rowData.businessKey +
		"&taskId=" + rowData.taskId +
		"&procInsId=" + rowData.procInstId +
		"&_r=" + Math.random();*/
		var taskUrl = rowData.formKey + 
		"?jobno=" + rowData.businessKey +
		"&stepCode=" + rowData.taskKey +
		"&_r=" + Math.random();
		opw({title:'矩阵信息',url:taskUrl,w:'95%',h:'95%'});
	}else{
		alert("请选择当前步骤");
	}
}

function gotoHis(){
	var rowData = hisTaskTab.datagrid("getSelected"); 
	if(rowData){
		/*var taskUrl = rowData.formKey + 
		"?jobno=" + rowData.businessKey +
		"&taskId=" + rowData.taskId +
		"&procInsId=" + rowData.procInstId +
		"&_r=" + Math.random();*/
		var taskUrl = rowData.formKey + 
		"?jobno=" + rowData.businessKey +
		"&stepCode=" + rowData.taskKey +
		"&_r=" + Math.random();
		opw({title:'矩阵信息',url:taskUrl,w:'95%',h:'95%'});
	}else{
		alert("请选择当前步骤");
	}
}
function suspenProcess(){
	var rowData = tab.datagrid("getSelected");
	if(rowData){
		$.ajax({
		    url:"${ctx}/seProcess/seProcess!suspendsProcessInstance.do",//请求地址
		    method:"post",//提交方式
		    async:false,//是否异步
		    cache:false,//是否缓存
		    data:{jobno:rowData.jobno},//可以是字符串也可以是json对象，字符串类似本例子中的内容
		    dataType:"text",//返回数据的格式 xml, json, script, or html
		    success:function(r){//回调函数
		      var str = $.trim(r);
		      if(str == "SUCCESS"){
		        alert("操作成功");
		        reloadDg();
		      }else{
		        alert("操作失败");
		      };
		    }
		  })
	}else{
		alert("请选择流程实例数据");
	}
}


function jobStatusFormatter(value,row,index){
	if("<%=StaticVar.PROCESSSTATUS_DELETE%>" == row.jobStatus){
		return "已删除";
	}
	if("<%=StaticVar.PROCESSSTATUS_NORMAL%>" == row.jobStatus){
		return "正常";
	}
	if("<%=StaticVar.PROCESSSTATUS_SUSPENSION%>" == row.jobStatus){
		return "挂起";
	}
	if("<%=StaticVar.PROCESSSTATUS_FINISH%>" == row.jobStatus){
		return "结束";
	}
}


function shBton(jobStatus){
	if(jobStatus == '<%=StaticVar.PROCESSSTATUS_NORMAL%>'){//流程正常
		$('#susBton').linkbutton('enable');
		$('#delBton').linkbutton('enable');
		$('#actBton').linkbutton('disable');
	}
	if(jobStatus == '<%=StaticVar.PROCESSSTATUS_SUSPENSION%>'){//挂起的流程
		$('#susBton').linkbutton('disable');
		$('#delBton').linkbutton('enable');
		$('#actBton').linkbutton('enable');
	}
	if(jobStatus == '<%=StaticVar.PROCESSSTATUS_FINISH%>'){//结束
		$('#susBton').linkbutton('disable');
		$('#delBton').linkbutton('disable');
		$('#actBton').linkbutton('disable');
	}
	if(jobStatus == '<%=StaticVar.PROCESSSTATUS_DELETE%>'){//删除
		$('#susBton').linkbutton('disable');
		$('#delBton').linkbutton('disable');
		$('#actBton').linkbutton('disable');
	}
}

function reAssign(){
	
	
	
	var rowData = currentTaskTab.datagrid("getSelected");
	if(!rowData){
		alert("请选择当前步骤记录");
		return;
	}
	
	var taskId = rowData.taskId;
	//alert(taskId);
	$.ajax({
		url:"${ctx}/seProcess/seProcess!queryTaskCandidate.do",//请求地址
	    method:"post",//提交方式
	    async:false,//是否异步
	    cache:false,//是否缓存
	    data:{taskId:taskId},//可以是字符串也可以是json对象，字符串类似本例子中的内容
	    dataType:"text",//返回数据的格式 xml, json, script, or html
	    success:function(r){//回调函数
			var str = $.trim(r);
			//alert(str);
			var url = "${ctx}/common/common!userSelectorForInit.do?ids=" + str + "&cb=parent.saveAssign";
			opw({url:url});
	    }
	  })
}
function saveAssign(usersJson){
	var userIds  = "";
	for(var i = 0 , j = usersJson.length ; i < j ; i++){
		var u = usersJson[i];
		userIds+=(","+u.USER_ID);
	}
	if(userIds != ""){
		userIds = userIds.substring(1,userIds.length);
	}
	var rowData = currentTaskTab.datagrid("getSelected");
	if(!rowData){
		alert("请选择当前步骤记录");
		return;
	}
	
	var taskId = rowData.taskId;
	
	$.ajax({
		url:"${ctx}/seProcess/seProcess!saveTaskCandidate.do",//请求地址
	    method:"post",//提交方式
	    async:false,//是否异步
	    cache:false,//是否缓存
	    data:{
	    	taskId:taskId,
	    	ids:userIds
	    },//可以是字符串也可以是json对象，字符串类似本例子中的内容
	    dataType:"text",//返回数据的格式 xml, json, script, or html
	    success:function(r){//回调函数
	    	var str = $.trim(r);
			if(str == "<%=StaticVar.STATUS_SUCCESS%>"){
		        alert("保存成功");
		        clw();
		        currentTaskTab.datagrid("reload");
		    }else{
		        alert("保存失败");
		        clw();
		    };
	    }
	  })
	 
}

$(function() { 
	theForm = $('#theForm').form({
		ajax:false
	})
	
	win = $('#win').window({
	    width:900,
	    height:600,
	    modal:true,
	    border:false
	});
	$('#win').window('close');
	
	
	$("#assigner").combobox(input_user_list_setting);
	$("#performer").combobox(input_user_list_setting);
	
	
	tab = $('#dataTable')
			.datagrid(
					{
						//title:'数据列表',
						iconCls : 'icon-ok',
						//数据来源
						url : '${ctx}/seProcess/seProcess!processListGetData.do?r=' + Math.random(),
						//斑马纹
						striped : true,
						//主键字段
						idField : "jobno",
						//宽度自适应
						//fitColumns: true,
						//表单提交方式
						method : "post",
						//是否只能选择一行
						singleSelect : true,
						nowrap : false,
						fit:true,
						border:false,
						//高度
						//height:450,
						//宽度
						//width:860,
						//是否分页
						pagination : true,
						//分页信息
						pageSize : 10,
						//每页显示条目下拉菜单
						pageList : [ 5, 10, 20, 50, 100 ],
						//排序的列
						sortName : 'startTime',
						//排序方式
						sortOrder : "desc",
						//pageNumber:5,s
						rownumbers : true,//行号 
						//分页工具所在位置
						pagePosition : "bottom",
						checkOnSelect:false,
						selectOnCheck:false,
						//冻结的列
						frozenColumns : [ [
						//选择框		
								/*{
									field : 'NOTE_ID',
									title : 'fid',
									checkbox : true,
									align : 'center'
								},*/
								{
									field : 'jobno',
									title : '工作编号',
									//checkbox : true,
									align : 'center',
									sortable : true
								},
								{
									field : 'workName',
									title : '工作名称',
									align : 'left',
									width:200,
									sortable : true
								}
								] ],
						columns : [ [
								{
									field : 'workType',
									title : '工作种类',
									//checkbox : true,
									align : 'left',
									width:100,
									sortable : true
								},
								{
									field : 'performer',
									title : '当前执行人',
									width : 120,
									sortable : true
								},
								{
									field : 'jobStatus',
									title : '流程状态',
									//checkbox : true,
									formatter:jobStatusFormatter,
									align : 'left',
									width:100,
									sortable : true
								},
								{
									field : 'currentStepName',
									title : '当前步骤',
									width:100,
									sortable : true
								},
								{
									field : 'projectId',
									title : '所属项目',
									width:90,
									sortable : true
								},
								{
									field : 'startTime',
									title : '开始日期',
									width:150,
									sortable : true
								},
								{
									field : 'startUser',
									title : '开启人',
									width : 60,
									sortable : true
								},
								
								
								{
									field : 'endTime',
									title : '结束日期',
									width:150,
									sortable : true
								}
								] ]

						,
						toolbar :"#tb",
						//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
						onSortColumn : function(sort, order) {
							$('#sort').val(sort);
							$('#order').val(order);
						}
						,
						
						onDblClickRow : function(rowIndex, rowData) {
							showTaskInfo();
						},
						onRowContextMenu:function(e,index,data){
							e.preventDefault();
							tab.datagrid('selectRow',index);
							$('#mm').menu('show',{
								left: e.pageX-5,
								top: e.pageY-5
							}); 
						},
						onSelect:function(rowIndex,rowData){
							currentTaskTab.datagrid("clearSelections");
							//currentTaskTab.datagrid("clearSelections");
							loadCurrentTaskTab(rowData.processInstanceId);
							loadhisTaskTab(rowData.processInstanceId);
							shBton(rowData.jobStatus);
							
						},
						onLoadSuccess:function(){
							//tab.datagrid("selectRow",0);
						}
					})
					
	currentTaskTab = $('#currentTaskTab')
			.datagrid(
					{
						title:'当前步骤',
						iconCls : 'icon-ok',
						//数据来源
						url : '${ctx}/seProcess/seProcess!queryCurrentTask.do?r=' + Math.random(),
						//斑马纹
						striped : true,
						//主键字段
						idField : "taskId",
						//宽度自适应
						//fitColumns: true,
						//表单提交方式
						method : "post",
						//是否只能选择一行
						singleSelect : true,
						nowrap : false,
						fit:true,
						border:false,
						//高度
						//height:450,
						//宽度
						//width:860,
						//是否分页
						pagination : false,
						//分页信息
						pageSize : 10,
						//每页显示条目下拉菜单
						pageList : [ 5, 10, 20, 50, 100 ],
						//排序的列
						sortName : 'startTime',
						//排序方式
						sortOrder : "desc",
						//pageNumber:5,s
						rownumbers : true,//行号 
						//分页工具所在位置
						pagePosition : "bottom",
						checkOnSelect:false,
						selectOnCheck:false,
						//冻结的列
						frozenColumns : [ [
						//选择框		
								/*{
									field : 'NOTE_ID',
									title : 'fid',
									checkbox : true,
									align : 'center'
								},*/
								{
									field : 'taskName',
									title : '步骤名称',
									width:100,
									//checkbox : true,
									sortable : true
								},
								{
									field : 'taskKey',
									title : '步骤KEY',
									//checkbox : true,
									align : 'left',
									width:100,
									sortable : true
								}
								] ],
						columns : [ [
								{
									field : 'groupUser',
									title : '代办人',
									width:150,
									sortable : true
								},
								{
									field : 'startTime',
									title : '开始时间',
									width:130,
									sortable : true
								}
								] ]
						,
						toolbar :"#tb1",
						//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
						onSortColumn : function(sort, order) {
							$('#sort').val(sort);
							$('#order').val(order);
						},
						onDblClickRow : function(rowIndex, rowData) {
							//showProcessImage();
							gotoTodo();
						},
						onLoadSuccess:function(){
							currentTaskTab.datagrid("selectRow",0);
						}
					
						
					
					})
					
	
	hisTaskTab = $('#hisTaskTab')
			.datagrid(
					{
						title:'历史步骤',
						iconCls : 'icon-ok',
						//数据来源
						url : '${ctx}/seProcess/seProcess!queryHistoryTask.do?r=' + Math.random(),
						//斑马纹
						striped : true,
						//主键字段
						idField : "taskHisId",
						//宽度自适应
						//fitColumns: true,
						//表单提交方式
						method : "post",
						//是否只能选择一行
						singleSelect : true,
						nowrap : false,
						fit:true,
						border:false,
						//高度
						//height:450,
						//宽度
						//width:860,
						//是否分页
						pagination : false,
						//分页信息
						pageSize : 10,
						//每页显示条目下拉菜单
						pageList : [ 5, 10, 20, 50, 100 ],
						//排序的列
						sortName : 'startTime',
						//排序方式
						sortOrder : "desc",
						//pageNumber:5,s
						rownumbers : true,//行号 
						//分页工具所在位置
						pagePosition : "bottom",
						checkOnSelect:false,
						selectOnCheck:false,
						//冻结的列
						frozenColumns : [ [
						//选择框		
								/*{
									field : 'NOTE_ID',
									title : 'fid',
									checkbox : true,
									align : 'center'
								},*/
								{
									field : 'taskName',
									title : '步骤名称',
									width:100,
									//checkbox : true,
									sortable : true
								},
								{
									field : 'taskKey',
									title : '步骤KEY',
									//checkbox : true,
									align : 'left',
									width:100,
									sortable : true
								}
								] ],
						columns : [ [
								{
									field : 'assigneeName',
									title : '办理人',
									width:150,
									sortable : true
								},
								{
									field : 'startTime',
									title : '开始时间',
									width:130,
									sortable : true
								},
								{
									field : 'endTime',
									title : '结束时间',
									width:130,
									sortable : true
								}
								] ]

						,
						//toolbar :"#tb",
						//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
						onSortColumn : function(sort, order) {
							$('#sort').val(sort);
							$('#order').val(order);
						},
						onDblClickRow : function(rowIndex, rowData) {
							//showProcessImage();
							gotoHis();
						},
						
					
					})

})

function opw(obj){
	
	document.getElementById("winSrc").src = obj.url;
	$("#win").window("setTitle",obj.title);
	var w =  obj.w;
	if(!w){
		w = document.body.clientWidth * 0.95;
	}
	var h = obj.h;
	if(!h){
		h = document.body.clientHeight * 0.95;
	}
	$('#win').window('open');// open a window
	$('#win').window('resize',{
		width:w,
		height:h
	});
	$('#win').window('center');
	
}

function clw(){
	$('#win').window('close');
}
	

var queryState = "open"
function hideQuery(){
	if("open" == queryState){
		$('body').layout('collapse','north');
		queryState = "close";
	}else{
		$('body').layout('expand','north');
		queryState = "open";
	}
	
}
		
function dealTask(){
	var rowData = tab.datagrid("getSelected");
	//alert(rowData.BUSSINESSKEY);
	var taskUrl = rowData.FORMKEY + 
	"?jobno=" + rowData.BUSSINESSKEY +
	"&taskId=" + rowData.TASKID +
	"&procInsId=" + rowData.PROCINSID +
	"&_r=" + Math.random();
	opw({title:'矩阵信息',url:taskUrl,w:'95%',h:'95%'});
}

function processInfo(){
	var rowData = tab.datagrid("getSelected");
	//alert(rowData.BUSSINESSKEY);
	var url = "${ctx}/seProcess/seProcess!taskProcessInfo.do?jobno=" + rowData.BUSSINESSKEY; 
	opw({title:'矩阵信息',url:url,w:'95%',h:'95%'});
}

function showProcessImage(){
	var rowData = currentTaskTab.datagrid("getSelected");
	if(rowData){
		var url ="${ctx}/seProcess/seProcess!showProcessImage.do?taskId=" + rowData.taskId;
		opw({title:'流程图',url:url,w:'95%',h:'95%'});
	}else{
		alert("请选择当前步骤记录");
	}
}

</script>
	</head>
	<body class="easyui-layout">
	
		<div id="mm" class="easyui-menu" style="width: 120px;">
			<div data-options="iconCls:'icon-edit'" onclick="gotoTodo()">
				进入待办
			</div>
			<div class="menu-sep"></div>
			<div data-options="iconCls:'icon-04'" id="todayDeal" onclick="showTaskInfo()">
				查看任务信息
			</div>
			<div data-options="iconCls:'icon-038'" id="canelTodayDeal" onclick="showProcessImage()">
				查看流程图
			</div>
		</div>
		
		
		<div data-options="region:'north',title:'流程实例管理',hideCollapsedContent:false,split:true" style="height:64px;padding:2px;"> 
			<form action="" id="theForm" method="post">
				关键字：<input 
							type="text"
							class="easyui-textbox" 
							name="bkey"
							id="bkey"
							type="text" 
							style="width:150px;"
							 />
							 &nbsp;&nbsp;
					派工人:
					<input 
							type="text"
							name="assigner"
							id="assigner"
							type="text" 
							style="width:100px;"
							 />
							  &nbsp;&nbsp;
					待办人:
					<input 
							type="text"
							name="performer"
							id="performer"
							type="text" 
							style="width:100px;"
							 />
							  &nbsp;&nbsp;
					流程状态：
							<select name="jobStatus" class="easyui-combobox">
								<option value="">请选择</option>
								<option value="<%=StaticVar.PROCESSSTATUS_NORMAL%>">正常</option>
								<option value="<%=StaticVar.PROCESSSTATUS_DELETE%>">删除</option>
								<option value="<%=StaticVar.PROCESSSTATUS_FINISH%>">结束</option>
								<option value="<%=StaticVar.PROCESSSTATUS_SUSPENSION%>">挂起</option>
							</select>
							 &nbsp;&nbsp;
					<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" onclick="loadDg()" data-options="iconCls:'icon-search'" >查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" onclick="$('#bkey').textbox('setValue','');loadDg()" data-options="iconCls:'icon-refresh1'" >重置</a>
			</form>
		</div>			
					
		<div data-options="region:'east',title:'步骤信息',split:true,hideCollapsedContent:false" style="width:450px;"> 
			<div  class="easyui-layout" data-options="fit:true">
				<div data-options="region:'north',split:true,border:false" style="height:150px;">
					<table id="currentTaskTab"></table>
					<div id="tb1">
						<c:if test="${authMap['PROCESS'] == staticVarObj.y}">
							<a href="javascript:void(0)" class="easyui-linkbutton" title="进入待办" onclick="gotoTodo()" data-options="plain:true,iconCls:'icon-336'" >进入待办</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="流程图" onclick="showProcessImage()" data-options="plain:true,iconCls:'icon-search'" >流程图</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="重新指派" onclick="reAssign()" data-options="plain:true,iconCls:'icon-332'" >重新指派</a>
						</c:if>
						
						<!-- 
						<a href="javascript:void(0)" class="easyui-linkbutton" title="待办处理" onclick="dealTask()" data-options="iconCls:'icon-tag-green',plain:true" >待办处理</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" title="流程总览" onclick="processInfo()" data-options="iconCls:'icon-tag-pink',plain:true" >流程总览</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" title="查看流程图" onclick="showProcessImage()" data-options="iconCls:'icon-038',plain:true" >查看流程图</a>
						 -->
					</div>
				
				</div> 
				<div data-options="region:'center',split:true,border:false">
					<table id="hisTaskTab"></table>
				</div>
			</div>
		</div>
		<div data-options="region:'center',split:true">
			
				<table id="dataTable">

				</table>
				
				<div id="tb">
					<c:if test="${authMap['PROCESS'] == staticVarObj.y}">
						<a href="javascript:void(0)" class="easyui-linkbutton" title="工作信息" onclick="showTaskInfo()" data-options="plain:true,iconCls:'icon-336'" >工作信息</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" title="删除流程" onclick="deleteProcess()" data-options="plain:true,iconCls:'icon-close'" id="delBton">删除</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" title="挂起流程" onclick="suspenProcess()" data-options="plain:true,iconCls:'icon-pin-red'" id="susBton">挂起</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" title="激活流程" onclick="activeProcess()" data-options="plain:true,iconCls:'icon-pin-blue'" id="actBton">激活</a>
						<!-- 
						<a href="javascript:void(0)" class="easyui-linkbutton" title="待办处理" onclick="dealTask()" data-options="iconCls:'icon-tag-green',plain:true" >待办处理</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" title="流程总览" onclick="processInfo()" data-options="iconCls:'icon-tag-pink',plain:true" >流程总览</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" title="查看流程图" onclick="showProcessImage()" data-options="iconCls:'icon-038',plain:true" >查看流程图</a>
						 -->
					 </c:if>
				</div>
		</div>
		
				
				
		<div id="win" title="待办" style="overflow:hidden;"><iframe id="winSrc" frameborder="0" width="100%" height="100%"></iframe></div>
	</body>

</html>
