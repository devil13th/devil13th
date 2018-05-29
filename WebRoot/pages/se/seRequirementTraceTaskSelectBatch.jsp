
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJs.jsp"%>
   
		<title>
			项目需求矩阵
		</title>
	
<style>

</style>

<script>
//矩阵树
var t ;
//弹出窗口
var win ; 
var taskTable;
var taskSelectedTable;
var assignedUsersTab;
function addTask(){
	///
	var node = t.tree('getSelected');
	if (node){
		var url = "${ctx}/se/se!seTraceTaskForm.do?seTraceTask.traceId=" + node.id;
		opw({title:'任务信息',url:url,w:'95%',h:'95%'});
	}
}


function assignUser(){
	var row = taskTable.datagrid("getSelected");
	if (row){
		var url = "${ctx}/common/common!userSelector.do?cb=parent.assignCb&projectId=${seRequirementTrace.projectId}&seMapUser.relaTab=TASK&seMapUser.tabKeyValue=" + row.TASK_ID;
		opw({title:'用户信息',url:url,w:'65%',h:'75%'});
	}else{
		alert("未选择任务");
	}
}

function assignCb(obj){
	//alert(obj);
	var row = taskTable.datagrid("getSelected");
	var ids = "";
	if (row){
		for(var i = 0 , j = obj.length ; i < j ; i++){
			//alert(obj[i].USER_ID);
			ids += (obj[i].USER_ID+",");
		}
		
		//alert(ids);
		$.ajax({
			type: "POST",
			//url: "${ctx}/common/common!saveUserMap.do",
			url:"${ctx}/se/se!assignTraceTaskOperators.do",
			data: {
				'seMapUser.relaTab':'TASK',
				'seMapUser.tabKeyValue':row.TASK_ID,
				'seMapUser.userId':ids
			},
			success: function(msg){
				//alert(msg);
				if($.trim(msg)=="SUCCESS"){
					message("操作成功");
					loadAssignedUsers(row.TASK_ID);
				}else{
					message("操作失败");
					return false;
				}
			},
			failure : function(msg){
				message("操作失败");
				return false;
			}
		});
	}
	clw();
}


//查询待办人员
function loadAssignedUsers(key){
	var obj = {
		'seMapUser.relaTab': 'TASK',
		'seMapUser.tabKeyValue': key
	}
	assignedUsersTab.datagrid("load", obj);
}

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

$(function(){
	//弹出窗口初始化
	win = $('#win').window({
	    width:900,
	    height:600,
	    modal:true,
	    border:false
	});
	$('#win').window('close');
	
	//矩阵树初始化
	t = $('#tree').tree({
		//是否显示树节点前的竖线
		lines:true,
		//是否需要动画效果
		animate:true,
		//查询节点提交方式
		method:"post",
		//查询节点地址
	   // url:'${ctx}/se/seRequirementTrace!getNextData.do',
	    
	  	//查询节点地址(异步查询)
	    //url:'${ctx}/se/seRequirementTrace!getNextData.do',
	    
	    //查询节点地址(同步查询)
	    url:'${ctx}/se/seRequirementTrace!queryTraceTreeData.do',
	    
	    //是否有checkbox
	    //checkbox:true, 
	    //是否只显示叶子节点前的checkbox
	    //onlyLeafCheck:true,
	    //默认查询参数
	    queryParams:{'seRequirementTrace.projectId':'${seRequirementTrace.projectId}'},
	    dnd:true,
	    //格式化节点
	    /*formatter:function(node){
			return node.text + "(" + node.id + ")";
		},*/
		onBeforeDrop:function(target,source,point){
			//alert(t.tree('getNode', target).id);
			//alert(source.id); 
			//alert(point);
			
			
			$.ajax({
				type: "POST",
				url: "${ctx}/se/seRequirementTrace!ajax.do",
				data: "ajaxMethod=moveNode&targetId=" + t.tree('getNode', target).id + "&sourceId=" + source.id + "&point=" + point,
				success: function(msg){
					//alert(msg);
					if($.trim(msg)=="success"){
						//alert( "操作成功");
						
						
						/*t.tree("reload",t.tree("getNode", target).id);
						t.tree("reload",t.tree(source.id));
						t.tree("reload",t.tree(source.id));*/
						//alert(t.tree("find",source.id).parentId);
						
						/*
						var sourceParentNode = t.tree("find", t.tree("find",source.id).parentId);
						t.tree("reload",sourceParentNode.target);
						var targetParentNode = t.tree("find",t.tree('getNode', target).parentId);
						t.tree("reload",targetParentNode.target);
						*/
					}else{
						message("操作失败");
						return false;
					}
				},
				failure : function(msg){
					message("操作失败");
					return false;
				}
			});
		},
		onClick : function(node){
			taskTable.datagrid("clearChecked");
			loadTaskDgByTrace(node.id);
		}
	});
	
	
	//任务列表
	taskTable = $('#taskTable').datagrid(
		{
			//title:'数据列表',
			iconCls : 'icon-user',
			//数据来源
			url : '${ctx}/se/se!seTraceTaskListGetDate.do?r=' + Math.random(),
			//斑马纹
			striped : true,
			
			queryParams:{PROJECT_ID:'${seRequirementTrace.projectId}'},
			//主键字段
			idField : "TASK_ID",
			//宽度自适应
			//fitColumns: true,
			//表单提交方式
			method : "post",
			//是否只能选择一行
			singleSelect : true,
			nowrap : false,
			fit:true,
			border:true,
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
			sortName : 'TASK_ID',
			//排序方式
			sortOrder : "desc",
			//pageNumber:5,s
			rownumbers : true,//行号 
			toolbar:"#tb",
			//分页工具所在位置
			pagePosition : "bottom",
			checkOnSelect:true,
			selectOnCheck:false,
			rowStyler: function(index,row){
				if (row.WORK_LOAD_H < row.ACT_WORKLOAD){
					return 'background-color:#6293BB;color:#fff;font-weight:bold;';
				}
				if (row.WORK_LOAD_H <= (row.ACT_WORKLOAD + (row.WORK_LOAD_H*0.2))){
					return 'background-color:#bb8162;color:#fff;font-weight:bold;';
				}
			},
			//冻结的列
			frozenColumns : [ [
			//选择框		
					/*{
						field : 'TASK_ID',
						title : 'fid',
						checkbox : true,
						align : 'center'
					},*/
					{
						field : 'TASK_ID',
						title : '任务ID',
						checkbox : true,
						align : 'center'
					},
					{
						field : 'TASK_TITLE',
						title : '任务标题',
						width : 200,
						sortable : true
					}
					
					] ],
			columns : [ [
					{
						field : 'TRACE_NAME',
						title : '所属矩阵',
						width : 150,
						sortable : true
					},
					{
						field : 'WORK_LOAD_D',
						title : '计划工作量(DAY)',
						width : 100,
						sortable : true
					},
					{
						field : 'WORK_LOAD_H',
						title : '计划工作量(H)',
						width : 100,
						sortable : true
					},
					{
						field : 'ACT_WORKLOAD',
						title : '实际工作量(H)',
						width : 100,
						sortable : true
					},
					{
						field : 'BEGIN_DATE',
						title : '开始日期',
						width : 100,
						sortable : true
					},
					{
						field : 'FINISH_DATE',
						title : '结束日期',
						width : 100,
						sortable : true
					},
					
					{
						field : 'TASK_STATUS',
						title : '状态',
						width : 100,
						sortable : true
					},
					
					{
						field : 'OPER',
						title : '操作',
						width : 80,
						align : 'center',
						formatter : function(value, row, index) {
							var editStr =  '<a  href="#" title="编辑" onclick="editTaskData(\'' + row.TASK_ID + '\')" >编辑</a>'
							return editStr;
							//var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.TASK_ID + '\')" >删除</a>';
							//return editStr +"&nbsp;"+ deleteStr;
						}
					} 
					] ]

			,
			
			toolbar :[
			    {
					text:'Add Task',
					iconCls:'icon-add',
					handler:function(){addTask()}
				},
				{
					text:'Assign',
					iconCls:'icon-user',
					handler:function(){assignUser()}
				}
			],
			
			//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
			onSortColumn : function(sort, order) {
				$('#sort').val(sort);
				$('#order').val(order);
			},//taskSelectedTable
			onCheck: function(index,row){
				
				var datas = taskSelectedTable.datagrid("getRows");
				var has = false;
				if(datas){
					for(var i = 0 , j = datas.length ;i < j ; i++){
						//alert(datas[i].PERSON_CODE);
						if(row.TASK_ID== datas[i].TASK_ID){
							has=true;
							break;
						}
					}
				}
				if(!has){
					taskSelectedTable.datagrid("insertRow",{
						index: 1,	// index start with 0
						row: row
					})
				}
			},
			onUncheck : function(index,row){
				var datas = taskSelectedTable.datagrid("getRows");
				if(datas){
					for(var i = 0 , j = datas.length ;i < j ; i++){
						//alert(datas[i].PERSON_CODE);
						if(row.TASK_ID == datas[i].TASK_ID){
							taskSelectedTable.datagrid("deleteRow",i);
							break;
						}
					}
				}
			},
			
			onSelect : function(rowIndex, rowData) {
				loadAssignedUsers(rowData.TASK_ID);
			}
			
			
		})
		
		
	assignedUsersTab =$('#assignedUsers').datagrid({
			//title:'数据列表',
			iconCls : 'icon-user',
			title:'执行人',
			//数据来源
			url : '${ctx}/common/common!userSelectorGetData.do?r=' + Math.random(),
			queryParams: {
				'seMapUser.relaTab': '${seMapUser.relaTab}',
				'seMapUser.tabKeyValue': '${seMapUser.tabKeyValue}'
			},
			//斑马纹
			striped : true,
			//主键字段
			idField : "USER_ID",
			//宽度自适应
			//fitColumns: true,
			//表单提交方式
			method : "post",
			//是否只能选择一行
			singleSelect : true,
			nowrap : false,
			fit:true,
			border:true,
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
			//sortName : 'TASK_ID',
			//排序方式
			//sortOrder : "desc",
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
						field : 'USER_ID',
						checkbox : true,
						align : 'center'
					},
					{
						field : 'USER_NAME',
						title : '姓名',
						width : 80,
						sortable : true
					}
					] ],
			columns : [ [
					{
						field : 'USER_ACCOUNT',
						title : '账号',
						width : 70,
						sortable : true
					},
					{
						field : 'USER_MAIL',
						title : '邮箱',
						width : 150,
						sortable : true
					}
					] ],
			onSelect : function(rowIndex, rowData) {
				//$("#userName").textbox("setValue",rowData.USER_NAME);
				$("#userId").combobox("setValue",rowData.USER_ID);
				queryLogData();
			}		
			
			
		})
		
		
	//选中的任务列表
	taskSelectedTable = $('#taskSelectedTable').datagrid(
		{
			//title:'数据列表',
			iconCls : 'icon-user',
			//数据来源
			//url : '${ctx}/se/se!seTraceTaskListGetDate.do?r=' + Math.random(),
			//斑马纹
			striped : true,
			//主键字段
			idField : "TASK_ID",
			//宽度自适应
			//fitColumns: true,
			//表单提交方式
			method : "post",
			//是否只能选择一行
			singleSelect : true,
			nowrap : false,
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
			//sortName : 'TASK_ID',
			//排序方式
			//sortOrder : "desc",
			//pageNumber:5,s
			rownumbers : true,//行号 
			//分页工具所在位置
			//pagePosition : "bottom",
			checkOnSelect:true,
			selectOnCheck:true,
			
			//冻结的列
			frozenColumns : [ [
			//选择框		
					/*{
						field : 'TASK_ID',
						title : 'fid',
						checkbox : true,
						align : 'center'
					},*/
					
					{
						field : 'TASK_TITLE',
						title : '任务标题',
						width : 200,
						sortable : true
					}
					
					] ],
			columns : [ [
					{
						field : 'TRACE_NAME',
						title : '所属矩阵',
						width : 150,
						sortable : true
					}
					] ]

			
			
		})
})


//消息
function message(text){
	$.messager.show({
		title:'消息',
		msg:text,
		showType:'show'
	});
}


//刷新待办表格
function reloadTaskDg() {
	taskTable.datagrid("reload");
}
//重新查询待办
function loadTaskDg() {
	var jsonData = $("#theForm").serializeArray();
	var params = formToJson(jsonData);
	params.a = Math.random();
	//showObj(params);
	taskTable.datagrid("load", params);
}
//重新查询待办
function loadTaskDgByTrace(id) {
	taskTable.datagrid("load", {TRACE_ID:id,PROJECT_ID:"${seRequirementTrace.projectId}"});
}

function loadTaskDgByTaskName(name) {
	taskTable.datagrid("load", {TASK_TITLE:name,PROJECT_ID:"${seRequirementTrace.projectId}"});
}

//重置待办表单后查询
function resetTaskForm(){
	theForm.form("clear");
	loadTaskDg();
}


function getSelectedDatas(){
	var rows = taskSelectedTable.datagrid("getRows");
	//alert(row.TASK_ID)
	${cb}(rows);
	window.close();
}

function reloadTraceTree(){
	t.tree('reload');
}
function filterTrace(){
	var k = $("#kw").textbox("getValue");
	//alert(k);
	//t.tree('expandTo', k);
	
	//前台过滤
	//t.tree('doFilter', '');
	t.tree('doFilter', k);
	t.tree('expandAll');
	
	//后台过滤
	/*
	$.ajax("${ctx}/se/se!traceFileter.do",
		{
			data:{msg:k},
			type:"POST",
			success:function(re){
				eval("var r = " + re);
				if(r.length > 0){
					for(var i = 0 , j = r.length ; i < j ; i++){
						var node =t.tree('find', r[i].traceId);
						if(node){
							//console.log(node)
							t.tree('update', {
								target:node.target,
								text: "<span style='color:red'>" + r[i].traceName + "</span>"  
							});
							t.tree('expandTo',  node.target);
						}
					}
				}
			}
		}
	)*/
	
	
	
	
	
			
	//var node =t.tree('find', '2c9a40dd5b1cb443015b1cde12550020');
	//t.tree('expandTo',  node.target);
	//t.tree('select', node.target);

	
}

function filterTraceAll(){
	var k = $("#kw").textbox("getValue");
	//alert(k);
	//t.tree('expandTo', k);
	
	$.ajax("${ctx}/se/se!traceFileter.do",
		{
			data:{msg:k},
			type:"POST",
			success:function(re){
				eval("var r = " + re);
				if(r.length > 0){
					for(var i = 0 , j = r.length ; i < j ; i++){
						var node =t.tree('find', r[i].traceId);
						if(node){
							//console.log(node)
							t.tree('update', {
								target:node.target,
								text: "<span style='color:red'>" + r[i].traceName + "</span>"  
							});
							t.tree('expandTo',  node.target);
						}
					}
				}
			}
		}
	)
	
	
	
	
	
			
	//var node =t.tree('find', '2c9a40dd5b1cb443015b1cde12550020');
	//t.tree('expandTo',  node.target);
	//t.tree('select', node.target);

	
}

function expendAllTree(){
	t.tree('expandAll');
}

function doSearch(val){
	loadTaskDgByTaskName(val);
}
</script>
	</head>

<body class="easyui-layout">
	<div data-options="region:'west',split:true,title:'矩阵树'" style="width:250px;" >
		<input type="text" class="easyui-textbox" style="width:100px;" id="kw"/>
		<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-filter'" onclick="filterTrace();" ></a>
		<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-search'" onclick="filterTraceAll();" ></a>
		<a href="#" class="easyui-linkbutton" title="清除搜索结果"  data-options="iconCls:'icon-clear'" onclick="reloadTraceTree();" ></a>
		<a href="#" class="easyui-linkbutton" title="全部展开"  data-options="iconCls:'icon-pin-red'" onclick="expendAllTree();" ></a>
		<ul id="tree" class="easyui-tree">
	    </ul>
	</div>
	

	<div data-options="region:'center',iconCls:'icon-ok',border:false" >
		<div id="tt" class="easyui-tabs"  data-options="fit:true">   
			<div title="任务信息" data-options="iconCls:'icon-016'">
			
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',iconCls:'icon-ok',border:false" >
						
						
						
						<!-- 矩阵任务 S -->
						<div class="easyui-layout" data-options="fit:true" >
							<div data-options="region:'center',iconCls:'icon-ok',border:false" style="padding:1px;">
								<table id="taskTable"></table>
							</div>
						</div>
						<!-- 矩阵任务 E -->
					
					</div>
				
					<div data-options="region:'north',iconCls:'icon-ok',border:false,height:27" style="text-align:right;padding:2px;overflow:hidden;">
						<input class="easyui-searchbox" data-options="prompt:'Please Input Value',searcher:doSearch" style="width:100%"/>
					</div>
					<div data-options="region:'south',iconCls:'icon-ok',border:false,height:200" >
						<table id="assignedUsers"></table>
					</div>
				</div>
				
			</div>
		</div>  
		
		
	</div>
	
	<div data-options="region:'east',title:'已选',split:true" style="padding:2px;width:400px;" >
		<table id="taskSelectedTable"></table>
	</div>	
	<div data-options="region:'south',split:false" style="padding:2px;height:30px;text-align:center;" >
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-right1'" onclick="getSelectedDatas()">确定</a> 
	</div>
	
	<div id="win" title="矩阵信息"><iframe id="winSrc" frameborder="0" width="100%" height="100%"></iframe></div>
	
</body>
</html>
