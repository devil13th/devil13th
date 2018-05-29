<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>PMP Manage</title>
<meta charset="utf-8"/>
<%@ include file="../../../pub/pubCssJs.jsp"%>
</head>

<script>
var processTab;
var processIttoInTab;
var processIttoOutTab
var processIttoToolTab
$(function(){
	
	
	processTab = $('#processGrid').datagrid({
		//title:'数据列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/pmp/pmp!processGetDate.do?r=' + Math.random(),
		//斑马纹
		striped : true,
		queryParams: {
			//PROJECT_ID: '${sePubModule.projectId}'
		},
		//主键字段
		idField : "processId",
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
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		//冻结的列
		frozenColumns : [ [
		//选择框		
				
				{
					field : 'processName',
					title : '管理过程名称',
					width:200
				}
				] ],
		columns : [ [
				{
					field : 'knowledgeAreaName',
					title : '所属知识领域',
					width:150
				},
				{
					field : 'processGroupName',
					title : '所属过程组',
					width:150
				}
				] ]

		,
		toolbar:"#searchDiv",
		
		
		onClickRow : function(rowIndex, rowData) {
			queryItto(rowData.processId);
		}
		
	})
	
	
	
	
	processIttoInTab = $('#processIttoInGrid').datagrid({
		iconCls : 'icon-ok',
		url : '${ctx}/pmp/pmp!queryProcessIttoRelaData.do?r=' + Math.random(),
		striped : true,
		queryParams: {
			classify: 'in'
		},
		idField : "id",
		method : "post",
		singleSelect : true,
		nowrap : false,
		fit:true,
		border:false,
		pagination : false,
		pageSize : 10,
		pageList : [ 5, 10, 20, 50, 100 ],
		rownumbers : true,//行号 
		pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		frozenColumns : [ [
		//选择框		
				] ],
		columns : [ [
				{
					field : 'ittoName',
					title : 'ITTO名称',
					width:250
				},
				{
					field : 'processName',
					title : '管理过程名称',
					width:200
				},
				{
					field : 'knowledgeAreaName',
					title : '知识领域',
					width:200
				},
				{
					field : 'relaType',
					title : '种类',
					width:100
				}
				] ]

		,
		toolbar:"#ittoInBar"
	})
	
	
	
	processIttoToolTab = $('#processIttoToolGrid').datagrid({
		//title:'数据列表',
		iconCls : 'icon-ok',
		url : '${ctx}/pmp/pmp!queryProcessIttoRelaData.do?r=' + Math.random(),
		striped : true,
		queryParams: {
			classify: 'tool'
		},
		idField : "id",
		method : "post",
		singleSelect : true,
		nowrap : false,
		fit:true,
		border:false,
		pagination : false,
		pageSize : 10,
		pageList : [ 5, 10, 20, 50, 100 ],
		rownumbers : true,//行号 
		pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		frozenColumns : [ [
				] ],
		columns : [ [
				{
					field : 'ittoName',
					title : 'ITTO名称',
					width:250
				},
				{
					field : 'processName',
					title : '管理过程名称',
					width:200
				},
				{
					field : 'knowledgeAreaName',
					title : '知识领域',
					width:200
				},
				{
					field : 'relaType',
					title : '种类',
					width:100
				}
				] ]

		,
		toolbar:"#ittoToolBar"
	})
	
	
	
	
	processIttoOutTab = $('#processIttoOutGrid').datagrid({
		iconCls : 'icon-ok',
		url : '${ctx}/pmp/pmp!queryProcessIttoRelaData.do?r=' + Math.random(),
		striped : true,
		queryParams: {
			classify: 'out'
		},
		idField : "id",
		method : "post",
		singleSelect : true,
		nowrap : false,
		fit:true,
		border:false,
		pagination : false,
		pageSize : 10,
		pageList : [ 5, 10, 20, 50, 100 ],
		rownumbers : true,//行号 
		pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		frozenColumns : [ [
				] ],
		columns : [ [
				{
					field : 'ittoName',
					title : 'ITTO名称',
					width:250
				},
				{
					field : 'processName',
					title : '管理过程名称',
					width:200
				},
				{
					field : 'knowledgeAreaName',
					title : '知识领域',
					width:200
				},
				{
					field : 'relaType',
					title : '种类',
					width:100
				}
				] ]

		,
		toolbar:"#ittoOutBar"
	})
	

})

function queryProcess(){
	var jsonData = $("#processSearchForm").serializeArray();
	var params = formToJson(jsonData);
	params.a = Math.random();
	//showObj(params);
	processTab.datagrid("load", params);
}


function queryIttoForIttoName(ittoName){
	processIttoInTab.datagrid("load", {
		ittoName : $("#ittoName").textbox("getValue"),
		classify : "in"
	});
	processIttoOutTab.datagrid("load", {
		ittoName : $("#ittoName").textbox("getValue"),
		classify : "out"
	});
	processIttoToolTab.datagrid("load", {
		ittoName : $("#ittoName").textbox("getValue"),
		classify : "tool"
	});
}

function queryItto(processId){
	$("#ittoName").textbox("setValue","");
	queryIttoForClassify(processId,"in");
	queryIttoForClassify(processId,"out");
	queryIttoForClassify(processId,"tool");
}

function queryIttoForClassify(processId,classify,ittoName){
	var params = {
		processId : processId,
		classify : classify,
		ittoName : ittoName
	}
	if("in" == classify){
		processIttoInTab.datagrid("load", params);
	}else if("out" == classify){
		processIttoOutTab.datagrid("load", params);
	}else if("tool" == classify){
		processIttoToolTab.datagrid("load", params);
	}else{
		alert("错误的分类");
	}
	
}


function clearProcessQuery(){
	$("#processSearchForm").form("reset");
	queryProcess();
}
</script>
<body class="easyui-layout">
	<div data-options="region:'west',split:true,title:'Manage Process'" style="width:550px;" >
		<div id="searchDiv" style="text-align:right;">
			<form id="processSearchForm" style="padding:0px;margin:0px;">
				<select class="easyui-combobox" style="width:100px;" name="processGroupId">
					<option value="">所有过程组</option>
					<c:forEach items="${pgList}" var="opt">
						<option value="${opt.id }"> ${opt.name } </option>
					</c:forEach>
				</select>
				&nbsp;
				<select class="easyui-combobox" style="width:140px;" name="knowledgeAreaId">
					<option value="">所有知识领域</option>
					<c:forEach items="${kaList}" var="opt">
						<option value="${opt.id }"> ${opt.name } </option>
					</c:forEach>
				</select>
				&nbsp;
				<input type="text" class="easyui-textbox" placeholder="关键字" name="key" style="width:100px;"/>
				<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" title="搜索" onclick="queryProcess()"></a> 
				<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" title="清空" onclick="clearProcessQuery()"></a> 
			</form>
		</div>
		<table id="processGrid"></table>
	</div>

	<div data-options="region:'center',split:true,border:false"  >
		<div class="easyui-layout" data-options="fit:true,border:false">
			<div data-options="region:'north',split:true,title:'ITTO Search'" style="height:62px;padding:2px;overflow:hidden;" >
				<form id="ittoSearchForm">
					<input type="text" class="easyui-textbox" id="ittoName" name="ittoName" style="width:100px;"/>
					<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" title="搜索" onclick="queryIttoForIttoName()"></a> 
				
				</form>
			</div>
			<div data-options="region:'center',split:true,hideCollapsedContent:false,border:false"  >
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north',split:true,title:'Input',hideCollapsedContent:false" style="height:250px;" >
						<div id="ittoInBar"></div>
						<table id="processIttoInGrid"></table>
					</div>
					<div data-options="region:'center',split:true,title:'Tech & Tool',hideCollapsedContent:false"  >
						<div id="ittoToolBar"></div>
						<table id="processIttoToolGrid"></table>
					</div>
					<div data-options="region:'south',split:true,title:'Output',hideCollapsedContent:false" style="height:250px;" >
						<div id="ittoOutBar"></div>
						<table id="processIttoOutGrid"></table>
					</div>
				</div>
			</div>
		</div>
		
	</div>

</body>

</html>