
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


<%@ include file="../../pub/pubCssJs.jsp"%>

<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>


		<title>
			统计视图
		</title>
	
<style>

</style>

<script>
var workLoadTab;
var taskTab;
var traceTab;
var dayWorkLoadTab;
var logTab;

var input_user_list_setting ={
		url:'${ctx}/common/common!queryUserListJsonStr.do?projectId=SSMIS-A6',
		valueField:'USER_ID',
		textField:'USER_NAME',
		onChange:function(){loadDayworkLoadData()}
};

var input_project_list_setting ={
		url:'${ctx}/common/common!queryProjectListJsonStr.do',
		valueField:'value',
		textField:'text',
		onChange:function(){queryUserAllData()}
};


function getPubCondition(){
	//var userId = $("#userList").combobox("getValue");
	var projectId = $("#sysList").combobox("getValue");
	var params = {
		//userId:userId,
		projectId:projectId
	}
	return params;
}

//-- 工时
function loadDayworkLoadData(tp){
	var params = getPubCondition();
	
	params.userId = $("#dWLUserId").combobox("getValue");
	params.logDateH = $("#logDateH").datebox("getValue");
	params.logDateL = $("#logDateL").datebox("getValue");
	params.projectId = $("#sysList").combobox("getValue");
	//console.log(params);
	
	
	if(tp){
		dayWorkLoadTab.datagrid("reload", params);
	}else{
		dayWorkLoadTab.datagrid("load", params);
	}
}

//-- 工时
function loadworkLoadData(tp){
	var params = getPubCondition();
	params.logDateH = $("#logDateH").datebox("getValue");
	params.logDateL = $("#logDateL").datebox("getValue");
	params.projectId = $("#sysList").combobox("getValue");
	//console.log(params);
	if(tp){
		workLoadTab.datagrid("reload", params);
	}else{
		workLoadTab.datagrid("load", params);
	}
}
function resetWorkLoadData(){
	$("#logDateH").datebox("setValue","");
	$("#logDateL").datebox("setValue","");
	loadworkLoadData();
}
//-- 需求
function loadTaskData(tp){
	var params = getPubCondition();
	params.logDateH = $("#logDateH").datebox("getValue");
	params.logDateL = $("#logDateL").datebox("getValue");
	params.projectId = $("#sysList").combobox("getValue");
	//console.log(params);
	if(tp){
		taskTab.datagrid("reload", params);
	}else{
		taskTab.datagrid("load", params);
	}
}
function resetTaskData(){
	$("#logDateH").datebox("setValue","");
	$("#logDateL").datebox("setValue","");
	loadTaskData();
}
// -- 矩阵
function loadTraceData(tp){
	var params = getPubCondition();
	params.logDateH = $("#logDateH").datebox("getValue");
	params.logDateL = $("#logDateL").datebox("getValue");
	params.projectId = $("#sysList").combobox("getValue");
	//console.log(params);
	if(tp){
		traceTab.datagrid("reload", params);
	}else{
		traceTab.datagrid("load", params);
	}
}
function resetTraceData(){
	$("#logDateH").datebox("setValue","");
	$("#logDateL").datebox("setValue","");
	loadTraceData();
}


function resetDayWorkLoadData(){
	$("#logDateH").datebox("setValue","");
	$("#logDateL").datebox("setValue","");
	loadDayworkLoadData();
}



// -- 日志
function loadLogData(obj){
	var userId = "";
	var projectId = $("#sysList").combobox("getValue");
	var traceId = "";
	var taskId = "";
	
	var logDateH = $("#logDateH").datebox("getValue");
	var logDateL = $("#logDateL").datebox("getValue");
	
	if(obj){
		if(obj.userId){
			userId = obj.userId;
		}
		if(obj.projectId){
			projectId = obj.projectId;
		}
		if(obj.taskId){
			taskId=obj.taskId;
		}
		if(obj.traceId){
			traceId=obj.traceId;
		}
		if(obj.day){
			logDateH = obj.day;
			logDateL = obj.day;
		}
	}
	var params = {
		userId:userId,
		projectId:projectId,
		logDateH:logDateH,
		logDateL:logDateL,
		taskId:taskId,
		traceId:traceId
	}
	//params.logDateH = $("#logDateH").datebox("getValue");
	//params.logDateL = $("#logDateL").datebox("getValue");
	logTab.datagrid("load", params);
}
function queryUserAllData(){
	loadTaskData();
	loadworkLoadData();
	loadTraceData();
	loadLogData();
	loadDayworkLoadData();
}

$(function(){
	
	$("#dWLUserId").combobox(input_user_list_setting);
	
	$("#sysList").combobox(input_project_list_setting);
	
	$("#logDateH").datebox({onChange:function(){queryUserAllData()}});
	$("#logDateL").datebox({onChange:function(){queryUserAllData()}});
	
	var queryParams = {
		logDateH:"${logDateH}",
		logDateL:"${logDateL}"
	}
	
	dayWorkLoadTab = $('#dayWorkLoadTab').datagrid({
		//title:'工作日志列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seCountDayWorkLoadGetData.do?r=' + Math.random(),
		//斑马纹
		striped : true,
		//主键字段
		idField : "projectName",
		//宽度自适应
		//fitColumns: true,
		//表单提交方式
		method : "post",
		queryParams: queryParams,
		//是否只能选择一行
		singleSelect : true,
		//不自动换行
		nowrap : true,
		fit:true,
		border:true,
		//高度
		//height:450,
		//宽度
		//width:860,
		//是否分页
		pagination : false,
		//分页信息
		//pageSize : 10,
		//每页显示条目下拉菜单
		//pageList : [ 5, 10, 20, 50, 100 ],
		//排序的列
		//sortName : 'plogDate',
		//排序方式
		//sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		//pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		toolbar:"#dayWorkLoadBar",
		//是否展示数据汇总行footer
		//showFooter: true,
		
		
		columns : [ [
				{
					field : 'projectId',
					title : '项目',
					width : 150,
					sortable : true
				},
				{
					field : 'userName',
					title : '人员',
					align:"center",
					width : 50,
					sortable : true
				},
				{
					field : 'day',
					title : '日期',
					width : 80,
					align:"right",
					sortable : true
				},
				{
					field : 'work_load',
					title : '工时',
					width : 50,
					align:"right",
					sortable : true
				},
				
				{
					field : 'status',
					title : '状态',
					width : 50,
					align:"right",
					sortable : true
				}
				
				
				] ]

		,
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		},
		onClickRow:function(index,row){
			//alert(row.projectId + "|" + row.userId);
			//alert(window.traceTreeFrame.open);
			//window.traceTreeFrame.open(row.traceId);
			
			loadLogData(row);
			
			
		}
	
	})
	
	
	workLoadTab = $('#workLoadTab').datagrid({
		//title:'工作日志列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seCountWorkLoadGetData.do?r=' + Math.random(),
		queryParams: queryParams,
		//斑马纹
		striped : true,
		//主键字段
		idField : "projectName",
		//宽度自适应
		//fitColumns: true,
		//表单提交方式
		method : "post",
		//是否只能选择一行
		singleSelect : true,
		//不自动换行
		nowrap : true,
		fit:true,
		border:true,
		//高度
		//height:450,
		//宽度
		//width:860,
		//是否分页
		pagination : false,
		//分页信息
		//pageSize : 10,
		//每页显示条目下拉菜单
		//pageList : [ 5, 10, 20, 50, 100 ],
		//排序的列
		//sortName : 'plogDate',
		//排序方式
		//sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		//pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		toolbar:"#workLoadBar",
		//是否展示数据汇总行footer
		//showFooter: true,
		
		
		columns : [ [
				{
					field : 'projectName',
					title : '项目',
					width : 150,
					sortable : true
				},
				{
					field : 'userName',
					title : '人员',
					align:"center",
					width : 150,
					sortable : true
				},
				{
					field : 'workLoad',
					title : '工时',
					width : 150,
					align:"right",
					sortable : true
				}
				
				] ]

		,
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		},
		onClickRow:function(index,row){
			//alert(row.projectId + "|" + row.userId);
			//alert(window.traceTreeFrame.open);
			//window.traceTreeFrame.open(row.traceId);
			
			loadLogData(row);
			
			
		}
	
	})
	
	
	
	
	taskTab = $('#taskTab').datagrid({
		//title:'工作日志列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seCountTaskGetData.do?r=' + Math.random(),
		queryParams: queryParams,
		//斑马纹
		striped : true,
		//主键字段
		idField : "projectName",
		//宽度自适应
		//fitColumns: true,
		//表单提交方式
		method : "post",
		//是否只能选择一行
		singleSelect : true,
		//不自动换行
		nowrap : true,
		fit:true,
		border:true,
		//高度
		//height:450,
		//宽度
		//width:860,
		//是否分页
		pagination : false,
		//分页信息
		//pageSize : 10,
		//每页显示条目下拉菜单
		//pageList : [ 5, 10, 20, 50, 100 ],
		//排序的列
		//sortName : 'plogDate',
		//排序方式
		//sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		//pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		toolbar:"#taskBar",
		//是否展示数据汇总行footer
		//showFooter: true,
		
		
		columns : [ [
				{
					field : 'proName',
					title : '项目',
					width : 150,
					sortable : true
				},
				{
					field : 'traceName',
					title : '矩阵名称',
					width : 150,
					sortable : true
				},
				{
					field : 'taskTitle',
					title : '任务',
					width : 150,
					sortable : true
				}
				
				] ]

		,
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		},
		onClickRow:function(index,row){
			//alert(row.projectId + "|" + row.userId);
			//alert(window.traceTreeFrame.open);
			//window.traceTreeFrame.open(row.traceId);
			loadLogData(row);
		}
	
	})
	
	
	
	traceTab = $('#traceTab').datagrid({
		//title:'工作日志列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seCountTraceGetData.do?r=' + Math.random(),
		queryParams: queryParams,
		//斑马纹
		striped : true,
		//主键字段
		idField : "projectName",
		//宽度自适应
		//fitColumns: true,
		//表单提交方式
		method : "post",
		//是否只能选择一行
		singleSelect : true,
		//不自动换行
		nowrap : true,
		fit:true,
		border:true,
		//高度
		//height:450,
		//宽度
		//width:860,
		//是否分页
		pagination : false,
		//分页信息
		//pageSize : 10,
		//每页显示条目下拉菜单
		//pageList : [ 5, 10, 20, 50, 100 ],
		//排序的列
		//sortName : 'plogDate',
		//排序方式
		//sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		//pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		toolbar:"#traceBar",
		//是否展示数据汇总行footer
		//showFooter: true,
		
		
		columns : [ [
				{
					field : 'proName',
					title : '项目',
					width : 150,
					sortable : true
				},
				{
					field : 'traceName',
					title : '矩阵名称',
					width : 150,
					sortable : true
				}
				
				] ]

		,
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		},
		onClickRow:function(index,row){
			//alert(row.projectId + "|" + row.userId);
			//alert(window.traceTreeFrame.open);
			//window.traceTreeFrame.open(row.traceId);
			loadLogData(row);
		}
	
	})
	
	
	
	logTab = $('#logTab').datagrid({
		title:'工作日志详情',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!querySeUserLogGetData.do?r=' + Math.random(),
		queryParams: queryParams,
		//斑马纹
		striped : true,
		//主键字段
		idField : "plogId",
		//宽度自适应
		//fitColumns: true,
		//表单提交方式
		method : "post",
		//是否只能选择一行
		singleSelect : true,
		//不自动换行
		nowrap : true,
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
		sortName : 'plogDate',
		//排序方式
		sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		//pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		toolbar:"#logTabBar",
		//是否展示数据汇总行footer
		<c:if test="${authMap['FINANCE'] == staticVarObj.y }">
		showFooter: true,
		</c:if>
		//冻结的列
		frozenColumns : [ [
		                   
			{
				field : 'projectId',
				title : '项目名称',
				width : 70,
				sortable : true
			},
			{
				field : 'userName',
				title : '人员',
				width : 50,
				sortable : true
			},
			{
				field : 'plogDate',
				title : '日期',
				width : 70,
				sortable : true
			},
			{
				field : 'plogWorkload',
				title : '时长',
				width : 40,
				sortable : true
			},
			
			] ],
			columns : [ [
			{
				field : 'plogRemark',
				title : '工作内容',
				width : 300,
				sortable : true
			},
			<c:if test="${authMap['FINANCE'] == staticVarObj.y }">
			{
				field : 'dailyCost',
				title : 'DC',
				width : 80,
				sortable : false
			},
			</c:if>
			{
				field : 'taskTitle',
				title : '任务',
				width : 200,
				sortable : false,
			},
			{
				field : 'traceName',
				title : '需求名称',
				width : 200,
				sortable : false
			}
			
			
				] ]

		,
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
	
	})
})
</script>
	</head>

<body class="easyui-layout">
	<div data-options="region:'north',split:true" style="text-align:right;height:33px;padding:2px;" >
		
		System：<input type="text"  id="sysList"  name="sysList" style="width:130px;"/>
		Date:<input type="text"  id="logDateL" value="${logDateL}" name="logDateL" class="easyui-datebox" style="width:100px;"/> -
		<input type="text"  id="logDateH" value="${logDateH}"  name="logDateH" class="easyui-datebox" style="width:100px;"/>
	</div>

	<div data-options="region:'center',iconCls:'icon-ok',border:false" >
		<div id="tt" class="easyui-tabs"  data-options="fit:true" >   
		
			
			<div title="工作日工时统计" data-options="iconCls:'icon-016'" style="padding:1px;">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',iconCls:'icon-ok',border:false" >
						<table id="dayWorkLoadTab">
						</table>
						<div id="dayWorkLoadBar">
							User：<input type="text"  id="dWLUserId"  name="dWLUserId" style="width:130px;"/>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" onclick="loadDayworkLoadData()" data-options="iconCls:'icon-search',plain:true" >查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="刷新" onclick="loadDayworkLoadData('refresh')" data-options="iconCls:'icon-refresh',plain:true" >刷新</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" onclick="resetDayWorkLoadData()" data-options="iconCls:'icon-refresh1',plain:true" >重置</a>
						</div>
					</div>
				</div>
			</div>
			
			
			<div title="工时统计" data-options="iconCls:'icon-016'" style="padding:1px;">
			
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',iconCls:'icon-ok',border:false" >
						<table id="workLoadTab">
						</table>
						<div id="workLoadBar">
							<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" onclick="loadworkLoadData()" data-options="iconCls:'icon-search',plain:true" >查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="刷新" onclick="loadworkLoadData('refresh')" data-options="iconCls:'icon-refresh',plain:true" >刷新</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" onclick="resetWorkLoadData()" data-options="iconCls:'icon-refresh1',plain:true" >重置</a>
						</div>
					</div>
				</div>
	
			</div>
			<div title="任务统计" data-options="iconCls:'icon-016'"  style="padding:1px;">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',iconCls:'icon-ok',border:false" >
						<table id="taskTab">
						</table>
						<div id="taskBar">
							<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" onclick="loadTaskData()" data-options="iconCls:'icon-search',plain:true" >查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="刷新" onclick="loadTaskData('refresh')" data-options="iconCls:'icon-refresh',plain:true" >刷新</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" onclick="resetTaskData()" data-options="iconCls:'icon-refresh1',plain:true" >重置</a>
						</div>
					</div>
				</div>
			</div>
			<div title="需求信息" data-options="iconCls:'icon-016'"  style="padding:1px;">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',iconCls:'icon-ok',border:false" >
						<table id="traceTab">
						</table>
						<div id="traceBar">
							
							<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" onclick="loadTaskData()" data-options="iconCls:'icon-search',plain:true" >查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="刷新" onclick="loadTaskData('refresh')" data-options="iconCls:'icon-refresh',plain:true" >刷新</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" onclick="resetTaskData()" data-options="iconCls:'icon-refresh1',plain:true" >重置</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
	</div>
	<div data-options="region:'east',split:true" style="width:770px;" >
		<table id="logTab"></table>
	</div>
	
	
	<div id="mm" class="easyui-menu" style="width: 120px;">
		<div data-options="iconCls:'icon-add'" onclick="createNewNode()">
			新增子节点
		</div>
		<div data-options="iconCls:'icon-add'" onclick="addTask()">
			添加任务
		</div>
		<div data-options="iconCls:'icon-add'" onclick="note()">
			遗留备忘
		</div>
		<div class="menu-sep"></div>
		<div data-options="iconCls:'icon-edit'" onclick="modiNode()">
			编辑该节点
		</div>
		<div data-options="iconCls:'icon-remove'" id="canelTodayDeal" >
			删除该节点
		</div>
		<div class="menu-sep"></div>
		<div data-options="iconCls:'icon-reload'" onclick="refreshNode()">
			刷新
		</div>
		<div class="menu-sep"></div>
		<div data-options="iconCls:'icon-033'" onclick="addPro()">
			属性管理
		</div>
		<div data-options="iconCls:'icon-024'" onclick="copyPro('D')">
			属性覆盖下级
		</div>
		<div data-options="iconCls:'icon-017'" onclick="copyPro('U')">
			属性继承上级
		</div>
	</div>
	
	
<script>

</script>		
</body>
</html>
