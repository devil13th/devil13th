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
//刷新表格
function reloadDg() {
	tab.datagrid("reload");
}

//重新查询
function loadDg() {
	var jsonData = $("#theForm").serializeArray();
	var params = formToJson(jsonData);
	params.a = Math.random();
	//showObj(params);
	tab.datagrid("load", params);
}
//重置表单后查询
function resetForm(){
	theForm.form("clear");
	loadDg();
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
	
	tab = $('#dataTable')
			.datagrid(
					{
						//title:'数据列表',
						iconCls : 'icon-ok',
						//数据来源
						url : '${ctx}/seProcess/seProcess!todoListGetData.do?r=' + Math.random(),
						//斑马纹
						striped : true,
						//主键字段
						idField : "TASKID",
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
						sortName : 'TASKCREATETIME',
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
									field : 'TASKID',
									title : '日记id',
									checkbox : true,
									align : 'center'
								}
								] ],
						columns : [ [
								{
									field : 'BUSSINESSKEY',
									title : '工作编号',
									width : 100,
									sortable : true
								},
								{
									field : 'WORKNAME',
									title : '工作名称',
									width : 200,
									sortable : true
								},
								
								
								{
									field : 'TASKNAME',
									title : '待办名称',
									width : 100,
									sortable : true
								},
								/*
								{
									field : 'TASKUSERID',
									title : '待办人',
									width : 100,
									sortable : true
								},
								*/
								{
									field : 'USERNAME',
									title : '待办人',
									width : 100,
									sortable : true
								},
								{
									field : 'TASKCREATETIME',
									title : '任务创建时间',
									width : 140,
									sortable : true
								},
								{
									field : 'STARTTIME',
									title : '工作创建时间',
									width : 140,
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
							/*var taskUrl = rowData.FORMKEY + 
									"?jobno=" + rowData.BUSSINESSKEY +
									"&taskId=" + rowData.TASKID +
									"&procInsId=" + rowData.PROCINSID +
									"&_r=" + Math.random();*/
									var taskUrl = rowData.formKey + 
									"?jobno=" + rowData.bkey +
									"&stepCode=" + rowData.taskKey +
									"&_r=" + Math.random();		
									
							opw({title:'矩阵信息',url:taskUrl,w:'95%',h:'95%'});
						},
						onRowContextMenu:function(e,index,data){
							e.preventDefault();
							tab.datagrid('selectRow',index);
							$('#mm').menu('show',{
								left: e.pageX-5,
								top: e.pageY-5
							}); 
						}
						
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
	var rowData = tab.datagrid("getSelected");
	var url ="${ctx}/seProcess/seProcess!showProcessImage.do?taskId=" + rowData.TASKID;
	opw({title:'流程图',url:url,w:'95%',h:'95%'});
}

</script>
	</head>
	<body class="easyui-layout">
	
		<div id="mm" class="easyui-menu" style="width: 120px;">
			<div data-options="iconCls:'icon-edit'" onclick="dealTask()">
				进入待办
			</div>
			<div class="menu-sep"></div>
			<div data-options="iconCls:'icon-04'" id="todayDeal" onclick="processInfo()">
				查看任务信息
			</div>
			<div data-options="iconCls:'icon-038'" id="canelTodayDeal" onclick="showProcessImage()">
				查看流程图
			</div>
		</div>
		
		
		<div data-options="region:'north'" style="height:35px;"> 
			
		</div>
		<div data-options="region:'center'">
			
				<table id="dataTable">

				</table>
				
				<div id="tb">
				<form action="" id="theForm" method="post">
					关键字：<input 
							type="text"
							class="easyui-textbox" 
							name="bkey"
							id="bkey"
							type="text" 
							style="width:100px;"
							 />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" onclick="loadDg()" data-options="iconCls:'icon-search',plain:true" >查询</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" onclick="$('#bkey').textbox('setValue','');loadDg()" data-options="iconCls:'icon-refresh1',plain:true" >重置</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" title="待办处理" onclick="dealTask()" data-options="iconCls:'icon-tag-green',plain:true" >待办处理</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" title="流程总览" onclick="processInfo()" data-options="iconCls:'icon-tag-pink',plain:true" >流程总览</a>
					<a href="javascript:void(0)" class="easyui-linkbutton" title="查看流程图" onclick="showProcessImage()" data-options="iconCls:'icon-038',plain:true" >查看流程图</a>
					
				</form>
				</div>
		</div>
		
				
				
		<div id="win" title="待办" style="overflow:hidden;"><iframe id="winSrc" frameborder="0" width="100%" height="100%"></iframe></div>
	</body>

</html>
