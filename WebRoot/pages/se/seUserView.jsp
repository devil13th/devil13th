
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
			用户视图
		</title>
	
<style>

</style>

<script>

var taskTab ;
var noteTab;
var logTab;
var ue;
var input_project_list_setting ={
		url:'${ctx}/common/common!queryProjectListJsonStr.do',
		valueField:'value',
		textField:'text',
		onChange:function(){queryUserAllData("reload")}
};
var input_user_list_setting ={
		url:'${ctx}/common/common!queryUserListJsonStr.do',
		valueField:'USER_ID',
		textField:'USER_NAME',
		onChange:function(){queryUserAllData("reload")}
};
var taskStatus_user_list_setting ={
		url: "${ctx}/common/common!getDicJsonStr.do?sysDicPub.dicClassify=task_status",
		valueField:'dic_id',
		textField:'dic_name',
		onChange:function(){loadTaskData("reload")}
};





$(function(){
	$("#taskStatus").combobox(taskStatus_user_list_setting);
	$("#expireStatus").combobox({onChange:function(){loadTaskData("reload")}});
	$("#noteStatus").combobox({onChange:function(){loadNoteData("reload")}});
	$("#sysList").combobox(input_project_list_setting);
	$("#userList").combobox(input_user_list_setting);
	
	$("#logDateH").datebox({onChange:function(){loadLogData("reload")}});
	$("#logDateL").datebox({onChange:function(){loadLogData("reload")}});
	
	
	

	
	taskTab = $('#taskTab').datagrid({
		//title:'工作日志列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seUserViewGetTaskData.do?r=' + Math.random(),
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
		//不自动换行
		nowrap : true,
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
		sortName : 'plogDate',
		//排序方式
		sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		//pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		toolbar:"#taskTabBar",
		//是否展示数据汇总行footer
		showFooter: true,
		
		rowStyler: function(index,row){
			if (row.ableTime != null){
				if (row.planWorkLoad < row.actWorkLoad){
					return 'background-color:#bb8162;color:#fff;font-weight:bold;';
				}
				if (row.planWorkLoad <= (row.actWorkLoad + (row.planWorkLoad*0.2))){
					return 'background-color:#6293BB;color:#fff;font-weight:bold;';
				}
			}
		},
		
		
		//冻结的列
		frozenColumns : [ [
				{
					field : 'userName',
					title : '人员',
					width : 60,
					sortable : true
				},
				{
					field : 'taskTitle',
					title : '任务',
					width : 250,
					sortable : true
				}
				
				
				] ],
		columns : [ [
				{
					field : 'traceName',
					title : '需求名称',
					width : 250,
					sortable : true
				},
				{
					field : 'planWorkLoad',
					title : '计划(天)',
					width : 70,
					align:"right",
					sortable : true
				},
				{
					field : 'actWorkLoad',
					title : '实际(天)',
					width : 70,
					align:"right",
					sortable : true
				},
				{
					field : 'ableTime',
					title : '剩余(天)',
					width : 70,
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
			//alert(row.taskId);
			//alert(window.traceTreeFrame.open);
			window.traceTreeFrame.open(row.traceId);
		}
	
	})
	
	
	noteTab = $('#noteTab').datagrid({
		//title:'工作日志列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seUserViewGetNoteData.do?r=' + Math.random(),
		//斑马纹
		striped : true,
		//主键字段
		idField : "noteId",
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
		pagination : true,
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
		checkOnSelect:true,
		selectOnCheck:true,
		toolbar:"#noteTabBar",
		//是否展示数据汇总行footer
		showFooter: true,
		//冻结的列
		frozenColumns : [ [
				{
					field : 'noteId',
					title : 'NOTEID',
					checkbox : true,
					align : 'center'
				},
				{
					field : 'userName',
					title : '人员',
					width : 60,
					sortable : true
				},
				{
					field : 'noteTitle',
					title : '标题',
					width : 350,
					sortable : true
				}
				
				
				] ],
		columns : [ [

				{
					field : 'noteType',
					title : '类型',
					width : 60,
					sortable : true
				},
				{
					field : 'noteStatus',
					title : '状态',
					width : 60,
					sortable : true
				},
				{
					field : 'alarmDate',
					title : '最后期限',
					width : 70,
					sortable : true
				},
				{
					field : 'alarmDays',
					title : '预警期(天)',
					width : 70,
					sortable : true
				}
				] ]

		,
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		},
		onClickRow:function(rowIndex,rowData){
			$("#noteId").val(rowData.noteId);
			$.ajax("${ctx}/se/se!queryContentOfTraceNote.do",
				{
					type:"post",
					data:{id:rowData.noteId},
					success:function(r){
						var str = $.trim(r);
						//alert(str);
						ue.setContent(str, false);
					}
				}
			)
		}
	
	})
	
	
	logTab = $('#logTab').datagrid({
		//title:'工作日志列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seUserViewGetLogData.do?r=' + Math.random(),
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
		showFooter: true,
		//冻结的列
		frozenColumns : [ [
		
				{
					field : 'userName',
					title : '人员',
					width : 60,
					sortable : true
				},
				{
					field : 'plogRemark',
					title : '日志',
					width : 250,
					sortable : true
				}
				] ],
		columns : [ [
				{
					field : 'plogDate',
					title : '日期',
					width : 70,
					sortable : true
				},
				{
					field : 'plogWorkLoad',
					title : '工时(H)',
					width : 70,
					sortable : true
				},
				{
					field : 'traceName',
					title : '需求名称',
					width : 250,
					sortable : true
				},
				{
					field : 'taskTitle',
					title : '任务',
					width : 250,
					sortable : true
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

function getSelectedUser(){
	var uId = $("#userList").combobox("getValue");
	var projectId = $("#sysList").combobox("getValue");
	//alert(projectId);
}




function loadTaskData(tp){
	var params = getPubCondition();
	params.taskStatus = $("#taskStatus").combobox("getValue");
	params.expireStatus = $("#expireStatus").combobox("getValue");
	console.log(params);
	if(tp){
		taskTab.datagrid("reload", params);
	}else{
		taskTab.datagrid("load", params);
	}
}
function resetTaskData(){
	$("#taskStatus").combobox("setValue","");
	$("#expireStatus").combobox("setValue","");
	loadTaskData();
}
function loadNoteData(tp){
	var params = getPubCondition();
	params.noteStatus = $("#noteStatus").combobox("getValue");
	if(tp){
		noteTab.datagrid("reload", params);
	}else{
		noteTab.datagrid("load", params);
	}
}

function resetNoteData(){
	$("#noteStatus").combobox("setValue","");
	loadNoteData();
}
function loadLogData(tp){
	var params = getPubCondition();
	params.logDateH = $("#logDateH").datebox("getValue");
	params.logDateL = $("#logDateL").datebox("getValue");
	if(tp){
		logTab.datagrid("reload", params);
	}else{
		logTab.datagrid("load", params);
	}
}
function resetLogData(){
	var params = getPubCondition();
	$("#logDateH").datebox("setValue","");
	$("#logDateL").datebox("setValue","");
	loadLogData();
}

function queryUserAllData(){
	loadTaskData();
	loadNoteData();
	loadLogData();
}

function getPubCondition(){
	var userId = $("#userList").combobox("getValue");
	var projectId = $("#sysList").combobox("getValue");
	var params = {
		userId:userId,
		projectId:projectId
	}
	return params;
}
</script>
	</head>

<body class="easyui-layout">

	<div data-options="region:'north',split:true" style="text-align:right;height:33px;padding:2px;" >
		System：<input type="text"  id="sysList"  name="sysList" style="width:130px;"/>
		User：<input type="text"  id="userList"  name="userList" style="width:130px;"/>
	</div>
	

	<div data-options="region:'center',iconCls:'icon-ok',border:false" >
		<div id="tt" class="easyui-tabs"  data-options="fit:true" >   
			<div title="任务信息" data-options="iconCls:'icon-016'" style="padding:1px;">
			
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',iconCls:'icon-ok',border:false" >
						<table id="taskTab">
						</table>
						<div id="taskTabBar">
							<select id="taskStatus" style="width:100px;">
							</select>
							<select id="expireStatus">
								<option value="">全部</option>
								<option value="1">未超时</option>
								<option value="-1">超时</option>
							</select>
							
							
							<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" onclick="loadTaskData()" data-options="iconCls:'icon-search',plain:true" >查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="刷新" onclick="loadTaskData('refresh')" data-options="iconCls:'icon-refresh',plain:true" >刷新</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" onclick="resetTaskData()" data-options="iconCls:'icon-refresh1',plain:true" >重置</a>
						</div>
					</div>
					<div data-options="region:'east',split:true,title:'矩阵树1'" style="width:350px;" >
						<iframe src="${ctx }/se/se!traceTree.do?id=1" frameborder="0" width="100%" height="100%" name="traceTreeFrame" id="traceTreeFrame"></iframe>
					</div>
				</div>
	
			</div>
			<div title="遗留备忘信息" data-options="iconCls:'icon-016'"  style="padding:1px;">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',iconCls:'icon-ok',border:false" >
						<table id="noteTab">
						</table>
						<div id="noteTabBar">
							<select id="noteStatus"  style="width:100px;">
								<option value="">全部</option>
								<option value="已落实">已落实</option>
								<option value="未落实">未落实</option>
							</select>
							
							
							<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" onclick="loadNoteData()" data-options="iconCls:'icon-search',plain:true" >查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="刷新" onclick="loadNoteData('refresh')" data-options="iconCls:'icon-refresh',plain:true" >刷新</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" onclick="resetNoteData()" data-options="iconCls:'icon-refresh1',plain:true" >重置</a>
						</div>
					</div>
					<div data-options="region:'east',split:true,title:'矩阵树2'" style="width:650px;" >
						<input type="hidden" id="noteId"/>
						<textarea id="content" name="content"></textarea>
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="saveContent(0)">保存</a> 
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="saveContent(1)">保存并落实</a>   
					</div>
				</div>
			</div>
			<div title="日志信息" data-options="iconCls:'icon-016'"  style="padding:1px;">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',iconCls:'icon-ok',border:false" >
						<table id="logTab">
						</table>
						<div id="logTabBar">
							<input type="text"  id="logDateL"  name="logDateL" class="easyui-datebox" style="width:100px;"/>
							<input type="text"  id="logDateH"  name="logDateH" class="easyui-datebox" style="width:100px;"/>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" onclick="loadLogData()" data-options="iconCls:'icon-search',plain:true" >查询</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="刷新" onclick="loadLogData('refresh')" data-options="iconCls:'icon-refresh',plain:true" >刷新</a>
							<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" onclick="resetLogData()" data-options="iconCls:'icon-refresh1',plain:true" >重置</a>
						</div>
					</div>
					<div data-options="region:'east',split:true,title:'矩阵树3'" style="width:350px;" >
					</div>
				</div>
			</div>
		</div>
		
		
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
//消息
function message(text){
	$.messager.show({
		title:'消息',
		msg:text,
		showType:'show'
	});
}
function saveContent(s){
	//alert(ue.getContent());
	var noteId = $("#noteId").val();
	if(noteId){
		$.ajax("${ctx}/se/se!saveSeTraceNoteContent.do",
			{
				type:"post",
				data:{
					"seTraceNote.noteId":noteId,
					"seTraceNote.noteContent":ue.getContent(),
					"seTraceNote.noteStatus":s
				},
				success:function(r){
					if("success" == $.trim(r)){
						message("操作成功");
						loadNoteData("refresh");
					}
				}
			}
		)
	}else{
		alert("请选择一条记录");
	}
	
}
ue = UE.getEditor('content',{
	serverUrl: "${ctx}/se/se!uploadFile.do",
   	imageUrlPrefix:"",
   	imageActionName:'img',
   	imageFieldName:'imgFile',
   	imageAllowFiles:[".png", ".jpg", ".jpeg", ".gif", ".bmp"],
   	initialFrameWidth:'100%',   //初始化编辑器宽度,默认1000 
    initialFrameHeight:300,  //初始化编辑器高度,默认320
   	fileActionName: "uploadfile", /* controller里,执行上传视频的action名称 */
    fileFieldName: "imgFile", /* 提交的文件表单名称 */
    fileUrlPrefix: "", /* 文件访问路径前缀 */
    fileMaxSize: 51200000, /* 上传大小限制，单位B，默认50MB */
    fileAllowFiles: [
        ".png", ".jpg", ".jpeg", ".gif", ".bmp",
        ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
        ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid",
        ".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso",
        ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"
    ],
    videoActionName: "uploadvideo", /* 执行上传视频的action名称 */
    videoFieldName: "imgFile", /* 提交的视频表单名称 */
    videoMaxSize: 102400000, /* 上传大小限制，单位B，默认100MB */
    videoAllowFiles: [
        ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
        ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"], /* 上传视频格式显示 */
    enableAutoSave: false
});
</script>		
</body>
</html>
