
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
			项目需求矩阵
		</title>
<script>
//矩阵树
var t ;
//弹出窗口
var win ; 
var taskTable;
var taskTableWin;
var assignedUsersTab;
var userLogTab;
var userLogQueryObj;

var traceNoteDataTable;
var ue;
var ue1;
var traceNoteForm;
var traceId ="";
var projectId = "${seRequirementTrace.projectId}";

var theSeTraceDefectTab;
var theSeTraceDefectForm;


var user_list_setting ={
		url:'${ctx}/common/common!queryUserListJsonStr.do?projectId=${projectId}',
		valueField:'USER_ID',
		textField:'USER_NAME'
};

var input_user_list_setting ={
		url:'${ctx}/common/common!queryUserListJsonStr.do?projectId=${projectId}',
		valueField:'USER_ID',
		textField:'USER_NAME'
};
var dic_user_list = {}
$.ajax({
	  dataType: "json",
	  url:'${ctx}/common/common!queryUserListJsonStr.do?projectId=${projectId}',
	  success: function(data){
		  dic_user_list = data;
		  //console.log(dic_bl_sys)
	  },
	  async:false
});
function user_list_formatter(value,row,index){
	for(var i = 0 , j = dic_user_list.length ; i < j ; i++){
		if(row.userId == dic_user_list[i].USER_ID){
			return dic_user_list[i].USER_NAME;
		}
	}
}


var project_list_setting ={
		url:'${ctx}/common/common!queryProjectListJsonStr.do',
		valueField:'value',
		textField:'text'
};
var input_project_list_setting ={
		url:'${ctx}/common/common!queryProjectListJsonStr.do',
		valueField:'value',
		textField:'text',
		onChange:function(){loadData("reload")}
};

var dic_project_list = {}
$.ajax({
	  dataType: "json",
	  url:'${ctx}/common/common!queryProjectListJsonStr.do',
	  success: function(data){
		  dic_project_list = data;
		  //console.log(dic_bl_sys)
	  },
	  async:false
});



function project_list_formatter(value,row,index){
	for(var i = 0 , j = dic_project_list.length ; i < j ; i++){
		if(row.projectId == dic_project_list[i].value){
			return dic_project_list[i].text;
		}
	}
}




$(function(){
	
	$("#userId").combobox(input_user_list_setting);
	$("#traceNoteUserId").combobox(input_user_list_setting);
	$("#ISSUE_USER").combobox(input_user_list_setting);
	
	$("#DEVELOPER").combobox(input_user_list_setting);
	$("#TEST_USER").combobox(input_user_list_setting);
	
	$("#updateDefectUserId").combobox(input_user_list_setting);
	
	
	traceNoteForm = $('#traceNoteForm').form({
		ajax:false
	})
	
	
	
	
	$("#tt").tabs({
		onSelect : function(title,index){
			//如果点击遗留备忘选项卡则刷新  -- 防止datagrid锁定列与未锁定列行高不一致的问题
			if(index == 2){
				loadTraceNoteDg();
			}
			if(index == 3){
				loadSeTraceDefectDg();
			}
		}
	})
	
	
	
	//弹出窗口初始化
	win = $('#win').window({
	    width:900,
	    height:600,
	    modal:true,
	    border:false
	});
	$('#win').window('close');
	
	$("#traceName").textbox({
		buttonIcon:'icon-err',
		onClickButton:function(){
			clearTrace();
			queryLogData();
		}
	})
	
	$("#taskName").textbox({
		buttonIcon:'icon-err',
		onClickButton:function(){
			clearTask();
			queryLogData();
		}
	})
	
	$("#userName").textbox({
		buttonIcon:'icon-err',
		onClickButton:function(){
			clearUser();
			queryLogData();
		}
	})
	
	
	taskTableWin = $('#taskTableWin').window({
	    width:900,
	    height:600,
	    modal:false,
	    border:false
	});
	$('#taskTableWin').window('close');
	
	$("#logDateH").datebox({onChange:function(){queryLogData()}});
	$("#logDateL").datebox({onChange:function(){queryLogData()}});
	
	
	
	
	theSeTraceDefectForm = $('#theSeTraceDefectForm').form({
		ajax:false
	})
	
	
	theSeTraceDefectTab = $('#theSeTraceDefectdataTable').datagrid({
		//title:'数据列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seTraceDefectListGetDate.do?r=' + Math.random(),
		queryParams:{PROJECT_ID:projectId},
		//斑马纹
		striped : true,
		//主键字段
		idField : "DEFECT_ID",
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
		pageSize : 15,
		//每页显示条目下拉菜单
		pageList : [ 5, 10,15, 20, 50, 100 ],
		//排序的列
		sortName : 'CREATE_TIME',
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
					field : 'DEFECT_ID',
					title : 'fid',
					checkbox : true,
					align : 'center'
				},*/
				{
					field : 'DEFECT_ID',
					title : '记录id',
					checkbox : true,
					align : 'center'
				},
				/*{
					field : 'TRACE_NAME',
					title : '矩阵名称',
					width : 100,
					sortable : true
				},*/
				{
					field : 'DEFECT_DESC',
					title : '缺陷描述',
					width : 200,
					sortable : true
				}
				] ],
		columns : [ [
				
				/*{
					field : 'DEFECT_PIC',
					title : '截图',
					width : 100,
					sortable : true
				},*/
				
				{
					field : 'TRACE_NAME',
					title : '功能名称',
					width : 150,
					sortable : true
				},
				{
					field : 'DEFECT_CLASSIFY',
					title : '缺陷分类',
					width : 100,
					sortable : true
				},
				{
					field : 'DEFECT_STATUS',
					title : '缺陷状态',
					width : 100,
					sortable : true
				},
				{
					field : 'DEVELOPER',
					title : '开发人员',
					width : 100,
					sortable : true
				},
				{
					field : 'TEST_USER',
					title : '测试人员',
					width : 100,
					sortable : true
				},
				{
					field : 'CREATE_TIME',
					title : '创建时间',
					width : 130,
					sortable : true
				},
				{
					field : 'UPDATE_TIME',
					title : '更新时间',
					width : 130,
					sortable : true
				},
				{
					field : 'OPER',
					title : '操作',
					width : 80,
					align : 'center',
					formatter : function(value, row, index) {
						
						<c:if test="${authMap['REQUIRE-TRACE'] == staticVarObj.y }">
							var editStr =  '<a  href="#" title="编辑" onclick="editSeTraceDefectDate(\'' + row.DEFECT_ID + '\')" >编辑</a>'
							var deleteStr = '<a  href="#" title="删除" onclick="deleteDefectData(\'' + row.DEFECT_ID + '\')" >删除</a>';
							return editStr + " " + deleteStr;
						</c:if>
						<c:if test="${authMap['REQUIRE-TRACE'] != staticVarObj.y }">
							if(row.TEST_USER_ID == '${loginUserInfo.userId}'){
								var editStr =  '<a  href="#" title="编辑" onclick="editSeTraceDefectDate(\'' + row.DEFECT_ID + '\')" >编辑</a>'
								var deleteStr = '<a  href="#" title="删除" onclick="deleteDefectData(\'' + row.DEFECT_ID + '\')" >删除</a>';
								return editStr + " " + deleteStr;
							}else{
								return " - ";
							}
						</c:if>
						
						
						
						
					}
				} 
				] ]

		,
		toolbar :"#defectTabBar",
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
		,
		
		onDblClickRow : function(rowIndex, rowData) {
			//不能选中条件中的行
			//editSeTraceDefectDate(rowData.DEFECT_ID);
			
			repairSeTraceDefect();
		},
		onClickRow:function(rowIndex,rowData){
			$("#defectId").val(rowData.DEFECT_ID);
			$.ajax("${ctx}/se/se!queryContentOfTraceDefect.do",
				{
					type:"post",
					data:{id:rowData.DEFECT_ID},
					success:function(r){
						var str = $.trim(r);
						//alert(str);
						ue1.setContent(str, false);
					}
				}
			)
		}
		
	})

	
	traceNoteDataTable = $('#traceNoteDataTable').datagrid({
		//title:'数据列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seTraceNoteListGetDate.do?r=' + Math.random(),
		queryParams:{PROJECT_ID:projectId},
		//斑马纹
		striped : true,
		//主键字段
		idField : "NOTE_ID",
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
		sortName : 'NOTE_ID',
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
					field : 'NOTE_ID',
					title : '遗留备忘id',
					checkbox : true,
					align : 'center'
				},
				{
					field : 'NOTE_TYPE',
					title : '记事种类',
					width : 80,
					sortable : true
				},
				{
					field : 'NOTE_TITLE',
					title : '遗留备忘标题',
					width : 200,
					sortable : true
				}
				] ],
		columns : [ [
				
				/*{
					field : 'NOTE_CONTENT',
					title : '遗留备忘内容',
					width : 100,
					sortable : true
				},*/
				{
					field : 'NOTE_STATUS',
					title : '状态',
					width : 100,
					sortable : true
				},
				{
					field : 'ISSUE_USER',
					title : '签发人',
					width : 100,
					sortable : true
				},
				{
					field : 'USER_NAME',
					title : '执行人',
					width : 100,
					sortable : true
				},
				{
					field : 'TRACE_NAME',
					title : '矩阵名称',
					width : 150,
					sortable : true
				},
				
				{
					field : 'CREATE_TIME',
					title : '创建时间',
					width : 100,
					sortable : true
				}/*,
				{
					field : 'ALARM_DATE',
					title : '提醒日期',
					width : 100,
					sortable : true
				},
				{
					field : 'ALARM_DAYS',
					title : '预警天数',
					width : 100,
					sortable : true
				},
				{
					field : 'IS_VALID',
					title : '是否有效',
					width : 100,
					sortable : true
				},
				{
					field : 'IS_DELETE',
					title : '是否删除',
					width : 100,
					sortable : true
				},
				{
					field : 'CREATE_TIME',
					title : '创建时间',
					width : 100,
					sortable : true
				},
				{
					field : 'UPDATE_TIME',
					title : '修改时间',
					width : 100,
					sortable : true
				},
				{
					field : 'OPER',
					title : '操作',
					width : 80,
					align : 'center',
					formatter : function(value, row, index) {
						var editStr =  '<a  href="#" title="编辑" onclick="editTraceNoteData(\'' + row.NOTE_ID + '\')" >编辑</a>'
						var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.NOTE_ID + '\')" >删除</a>';
						return editStr +"&nbsp;"+ deleteStr;
					}
				} */
				] ]

		,
		toolbar :[{
			text:'Add',
			iconCls:'icon-add',
			handler:function(){addTraceNote()} 
		},{
			text:'Edit',
			iconCls:'icon-edit',
			handler:function(){editTraceNoteData2()}
		},'-',{
			text:'Delete',
			iconCls:'icon-remove',
			handler:function(){deleteTraceNoteDatas()}
		}],
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
		,
		
		onDblClickRow : function(rowIndex, rowData) {
			//不能选中条件中的行
			editTraceNoteData(rowData.NOTE_ID);
		},
		onClickRow:function(rowIndex,rowData){
			$("#noteId").val(rowData.NOTE_ID);
			$.ajax("${ctx}/se/se!queryContentOfTraceNote.do",
				{
					type:"post",
					data:{id:rowData.NOTE_ID},
					success:function(r){
						var str = $.trim(r);
						//alert(str);
						ue.setContent(str, false);
					}
				}
			)
		}
	})
			
			
	userLogTab = $('#userLogTab').datagrid({
		title:'工作日志列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!querySeUserLogGetData.do?r=' + Math.random(),
		queryParams:{projectId:projectId},
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
		pageList : [ 5, 10, 20, 50, 100 ,1000],
		//排序的列
		sortName : 'plogDate',
		//排序方式
		sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//是否不换行
		nowrap: true,
		//分页工具所在位置
		//pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		toolbar:"#userLogBar",
		//是否展示数据汇总行footer
		<c:if test="${authMap['FINANCE'] == staticVarObj.y }">
		showFooter: true,
		</c:if>
		//冻结的列
		frozenColumns : [ [
		                   
			{
				field : 'plogId',
				title : '项目ID',
				checkbox : true,
				align : 'center'
			},
			{
				field : 'projectId',
				title : '项目名称',
				width : 100,
				editor:{type:'combobox',options:project_list_setting},
				sortable : true,
				formatter:project_list_formatter
			},
			{
				field : 'userId',
				title : '人员',
				width : 100,
				editor:{type:'combobox',options:user_list_setting},
				sortable : true,
				formatter:user_list_formatter
			},
			{
				field : 'plogDate',
				title : '日期',
				width : 100,
				editor:'datetimebox',
				sortable : true
			},
			{
				field : 'plogWorkload',
				title : '时长',
				width : 50,
				editor:{type:'textbox',options:{required:true}},
				sortable : true
			},
			
			] ],
			columns : [ [
			{
				field : 'plogRemark',
				title : '工作内容',
				width : 300,
				editor:{type:'textbox',options:{required:true}},
				sortable : true
			},
			<c:if test="${authMap['FINANCE'] == staticVarObj.y }">
			{
				field : 'dailyCost',
				title : 'DC',
				width : 60,
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
			},
			{
				field : 'createDate',
				title : '创建时间',
				width : 75,
				sortable : true,
				editor:'datetimebox'
			}
			
			
				] ]

		,
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
	
	})
	
	//矩阵树初始化
	t = $('#tree').tree({
		//是否显示树节点前的竖线
		lines:true,
		//是否需要动画效果
		animate:true,
		//查询节点提交方式
		method:"post",
		//查询节点地址(异步查询)
	    //url:'${ctx}/se/seRequirementTrace!getNextData.do',
	    
	    //查询节点地址(同步查询)
	    url:'${ctx}/se/seRequirementTrace!queryTraceTreeData.do',
	    
	    //是否有checkbox
	    //checkbox:true, 
	    //是否只显示叶子节点前的checkbox
	    //onlyLeafCheck:true,
	    //默认查询参数
	    queryParams:{'seRequirementTrace.projectId':projectId},
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
		onContextMenu:function(e,node){
			e.preventDefault();
			$(this).tree("select",node.target);
			$("#mm").menu("show",{
				left:e.pageX,
				top:e.pageY
			})
		},
		onClick : function(node){
			document.getElementById("traceInputFrame").src = "${ctx}/se/se!traceValueInput.do?seRequirementTrace.traceId=" + node.id;
			taskTable.datagrid("clearChecked");
			console.log(node);
			$("#traceName").textbox("setValue",node.text);
			$("#traceId").textbox("setValue",node.id);
			document.getElementById("icl").checked="checked";
			
			
			traceId = node.id;
			loadTraceNoteDg();
			loadSeTraceDefectDg();
			loadTaskDgByTrace(node.id);
		}
	});
	
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
			toolbar:'#tb',
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
	
	//任务列表
	taskTable = $('#taskTable').datagrid(
		{
			//title:'数据列表',
			iconCls : 'icon-user',
			//数据来源
			url : '${ctx}/se/se!seTraceTaskListGetDate.do?r=' + Math.random(),
			queryParams: {
				'PROJECT_ID': projectId,
			},
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
			//分页工具所在位置
			pagePosition : "bottom",
			checkOnSelect:true,
			selectOnCheck:true,
			rowStyler: function(index,row){
				if (row.WORK_LOAD_H < row.ACT_WORKLOAD){
					return 'background-color:#bb8162;color:#fff;font-weight:bold;';
				}
				if (row.WORK_LOAD_H <= (row.ACT_WORKLOAD + (row.WORK_LOAD_H*0.2))){
					return 'background-color:#6293BB;color:#fff;font-weight:bold;';
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
			toolbar :[{
				text:'Add',
				iconCls:'icon-add',
				handler:function(){addTask()} 
			},{
				text:'Edit',
				iconCls:'icon-edit',
				handler:function(){editTask()}
			},'-'/*,{
				text:'--Delete',
				iconCls:'icon-remove',
				handler:function(){}
			},'-',{
				text:'Refresh',
				iconCls:'icon-refresh',
				handler:function(){reloadTaskDg()}
			}*/,{
				text:'Assign',
				iconCls:'icon-user',
				handler:function(){assignUser()}
			},{
				text:'Start Process',
				iconCls:'icon-338',
				handler:function(){startProcess()}
			},{
				text:'Add Plan',
				iconCls:'icon-339',
				handler:function(){addTaskToPlan()}
			}
			
			
			],
			//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
			onSortColumn : function(sort, order) {
				$('#sort').val(sort);
				$('#order').val(order);
			}
			,
			
			onDblClickRow : function(rowIndex, rowData) {
				//不能选中条件中的行
				//editData(rowData.TASK_ID);
			},
			onSelect : function(rowIndex, rowData) {
				assignedUsersTab.datagrid("clearChecked");
				loadAssignedUsers(rowData.TASK_ID);
				
				
				$("#taskName").textbox("setValue",rowData.TASK_TITLE);
				$("#taskId").textbox("setValue",rowData.TASK_ID);
				$("#userId").textbox("setValue","");
				
				
				//设置日志查询条件
				//userLogQueryObj = {taskId:rowData.TASK_ID};
				queryLogData();
			},
			onLoadSuccess : function(data){
				if(data.total > 0){
					taskTable.datagrid("selectRow",0);
				}
			}
			
			
		})
})


function createNewNode(){
	
	var node = t.tree("getSelected");
	//alert(node.id);
	if(!node){
		message("请选择父节点!");
		if(!node.id){
			message("未找到节点ID!");
		}
	}
	var url = "${ctx}/se/seRequirementTrace!createNewRequirementTrace.do?id=" + node.id
	
	opw({title:'矩阵信息',url:url,w:'95%',h:'95%'});
}
function openTaskWin(){
	$('#taskTableWin').window('open');
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

function assignUser(){
	var row = taskTable.datagrid("getSelected");
	if (row){
		var url = "${ctx}/common/common!userSelector.do?cb=parent.assignCb&projectId=${seRequirementTrace.projectId}&seMapUser.relaTab=TASK&seMapUser.tabKeyValue=" + row.TASK_ID;
		opw({title:'用户信息',url:url,w:'65%',h:'75%'});
	}else{
		alert("未选择任务");
	}
}

function startProcess(){
	var row = taskTable.datagrid("getSelected");
	if (row){
		var url = "${ctx}/seProcess/seProcess!startTraceTaskProcess.do?key=taskProcess&taskId=" + row.TASK_ID;
		opw({title:'开启流程',url:url,w:'65%',h:'75%'});
	}else{
		alert("未选择任务");
	}
}

function addTaskToPlan(){
	
	var row = taskTable.datagrid("getSelected");;
	console.log(row);
	if (row){
		$.ajax({
			  dataType: "text",
			  url: "${ctx}/plan/plan!addTaskToPlan.do",
			  data : {
				  	"planExecution.planCode":"${planCode}",
				  	"planExecution.taskId":row.TASK_ID
			  },
			  success: function(data){
				if($.trim(data) == "SUCCESS"){
					message("已将任务添加到本周计划");
				}else{
					alert(data);
				}
			  },
			  type:"post"
		});
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
function addNode(id,newNodeId){
	var node =  t.tree("find",id);
	t.tree("reload", node.target);
	
	var selected = t.tree('getSelected');
	t.tree('append', {
		parent: node.target,
		data: [{
			id: newNodeId,
			text: '新建矩阵节点'
		}]
	});
	focusNode(newNodeId);
}
//选择某节点
function focusNode(id){
	var node = t.tree('find',id);
	//alert(node.id);
	//alert(node.target.outerHTML);
	//alert(node.target.id);
	//alert(document.getElementById(node.target.id))
	t.tree('select',node.target);
}
//更新某节点
function updateNode(id,name){
	
	var node = t.tree('find',id);
	if (node){
		t.tree('update', {
			target: node.target,
			text: name
		});
	}
	
}
//修改某节点
function modiNode(){
	var node = t.tree('getSelected');
	if (node){
		var url = "${ctx}/se/seRequirementTrace!seRequirementTraceFormBootstrap.do?id=" + node.id;
		opw({title:'矩阵信息',url:url,w:'95%',h:'95%'});
	}
}
//刷新某节点
function refreshNode(){
	var node = t.tree('getSelected');
	if (node){
		t.tree("reload",node.target);
	}
}
//消息
function message(text){
	$.messager.show({
		title:'消息',
		msg:text,
		showType:'show'
	});
}
//添加属性
function addPro(){
	var node = t.tree('getSelected');
	if (node){
		var url = "${ctx}/se/se!seTraceKeyList.do?seTraceKey.traceId=" + node.id
		opw({title:'矩阵属性信息',url:url});
	}
	
}

//拷贝属性
function copyPro(direct){
	//alert(direct);
	var node = t.tree('getSelected');
	if (node){
		$.post(
			 "${ctx}/se/se!copyTracePro.do", 
			 {
				 "sourceTraceId":node.id,
				 "copyType":direct
			 },
			 function(data){
			    if($.trim(data)=="success"){
			    	$.messager.show({
						title:'提示',
						msg:'操作成功',
						showType:'show'
					});
			    }else{
			    	$.messager.alert('错误信息','保存失败! ' + data,'error');
			    }
			  }, 
			 "text"
		);
	}else{
		
		$.messager.alert('错误信息','操作失败，请选择矩阵节点! ','error');
	}
}
function addTask(){
	///
	var node = t.tree('getSelected');
	if (node){
		var url = "${ctx}/se/se!seTraceTaskForm.do?seTraceTask.traceId=" + node.id;
		opw({title:'任务信息',url:url,w:'95%',h:'95%'});
	}
}
function editTask(){
	var data = taskTable.datagrid("getSelected");
	if(data){
		var url = "${ctx}/se/se!seTraceTaskForm.do?seTraceTask.taskId=" + data.TASK_ID;
		opw({title:'任务信息',url:url,w:'95%',h:'95%'});
	}else{
		message("请选择数据");
	}
}

function editTaskData(id){
	var url = "${ctx}/se/se!seTraceTaskForm.do?seTraceTask.taskId=" + id;
	opw({title:'矩阵信息',url:url,w:'95%',h:'95%'});
}


function note(){
	///
	var node = t.tree('getSelected');
	if (node){
		var url = "${ctx}/se/se!seTraceNoteForm.do?seRequirementTrace.projectId=" + projectId + "&seTraceNote.traceId=" + node.id
		opw({title:'矩阵遗留备忘信息',url:url,w:'95%',h:'95%'});
	}
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
	params.PROJECT_ID = projectId;
	//showObj(params);
	taskTable.datagrid("load", params);
}
//重新查询待办
function loadTaskDgByTrace(id) {
	taskTable.datagrid("load", {TRACE_ID:id,PROJECT_ID:projectId});
}
//重置待办表单后查询
function resetTaskForm(){
	theForm.form("clear");
	loadTaskDg();
}
//查询待办人员
function loadAssignedUsers(key){
	var obj = {
		'seMapUser.relaTab': 'TASK',
		'seMapUser.tabKeyValue': key
	}
	assignedUsersTab.datagrid("load", obj);
}

//获取勾选的日志人员
function getLogUsersData(){
	var objs = assignedUsersTab.datagrid("getChecked"); 
	return objs;
}

//生成日志
function createLog(){
	
	
	var rows = getLogUsersData();
	var ids = "";
	var names = "";
	//console.log(rows);
	if (rows.length > 0){
		for(var i = 0 , j = rows.length ; i < j ; i++){
			//alert(rows[i].USER_ID);
			ids += (rows[i].USER_ID+",");
			names +=  (rows[i].USER_NAME+",");
		}
	}else{
		message("操作失败:请勾选人员");
		return false;
	}
	//alert(ids);
	
	var taskObj = taskTable.datagrid("getSelected");
	if(!taskObj){
		alert("请选择任务");
		return false;
	};
	var taskId = taskObj.TASK_ID;
	
	var date = $("#logDateInput").datebox("getValue");
	var wl =  $("#workLoad").textbox("getValue");
	
	if(!confirm("确定生成[" + names + "][" + date + "]的日志么")){
		return false;
	}
	$.ajax({
		type: "POST",
		url: "${ctx}/se/se!transformATaskToLog.do",
		data: {
			'userIds':ids,
			'taskId':taskId,
			'logDate':date,
			'workLoad':wl
		},
		success: function(msg){
			//alert(msg);
			if($.trim(msg)=="SUCCESS"){
				message("操作成功");
				assignedUsersTab.datagrid("clearChecked");
				queryLogData();
			}else{
				message("操作失败:" + msg);
				return false;
			}
		},
		failure : function(msg){
			message("操作失败");
			return false;
		}
	});
	
	
}
function clearTrace(){
	$("#traceName").textbox("setValue","");
	$("#traceId").textbox("setValue","");
}
function clearTask(){
	$("#taskName").textbox("setValue","");
	$("#taskId").textbox("setValue","");
}
function clearUser(){
	//$("#userName").textbox("setValue","");
	$("#userId").combobox("setValue","");
}

//查询日志
function queryLogData(){
	var paramsObj = $("#logSearchForm").serializeArray();
	var queryObj = {a:Math.random()};
	var str = "";
	for(var i = 0 , j = paramsObj.length ; i < j ; i++){
		queryObj[paramsObj[i].name] = paramsObj[i].value;
		str += (paramsObj[i].name+":" + paramsObj[i].value + "\n")
	}
	queryObj.projectId = projectId;
	//console.log(queryObj);
	userLogTab.datagrid("load",queryObj);
	
	/*if(tp!=null && tp=="reload"){
		tab.datagrid("reload",queryObj);
	}else{
		tab.datagrid("load",queryObj);
	}*/
}

function deleteSePersonLogDatas(){
	if(confirm("确定删除勾选的日志么?")){
		var checkedIds = getUserLogTabCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		$.ajax("${ctx}/se/se!deleteSePersonLogByIds.do?ids=" + checkedIds + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						alert('操作成功');
						userLogTab.datagrid("clearChecked");
						queryLogData("reload");
					}else{
						alert(str);
					};
				}
			}
		)
	}
}

//获取勾选的行
function getUserLogTabCheckedIds(){
	var data = userLogTab.datagrid("getChecked");
	var str = ""
	for(var i = 0 , j = data.length ; i < j ; i++){
		//alert(data[i].PLOG_ID);
		str += (data[i].plogId + ",");
	};
	if(str != ""){
		str = str.substring(0,str.length - 1);
		return str;
	}else{
		return "";
	}
	
} 


// ------------------------------------- 用户日志操作面板相关内容 ----------------------------------------------//

function menuEditUserLog(){
	var row = userLogTab.datagrid("getSelected");
	var index = userLogTab.datagrid('getRowIndex',row.plogId);
	userLogTab.datagrid('beginEdit', index);
}

function saveAllUserLog(){
	var datas = userLogTab.datagrid('getData');
	if(datas.rows.length > 0){
		for(var i = 0 , j = datas.rows.length ; i < j ; i++){
			var b = userLogTab.datagrid('validateRow',i);
			if(!b){
				showMsg("错误信息","数据有误,请修改!");
				return false;
			};
			userLogTab.datagrid('endEdit',i);
		}
	}

	var changes = userLogTab.datagrid('getChanges');
	//alert(changes.length);
	if(changes.length >= 1){
		var r = "";
		var ct = 0;
		var res = ""; 
		
		for(var i = 0 , j = changes.length ; i < j ; i++){
			console.log(JSON.stringify(changes[i]));
			
			$.ajax({
			  type: "POST",
			  url: "${ctx}/se/se!saveUserLogJsonData.do?_r= " + Math.random(),
			  data: { acceptJson: JSON.stringify(changes[i]), ids: changes[i].plogId},
			  success: function(data) {
					if(data.status != 'success'){
						res += (data.errMsg + ",");
					}
					ct++;
					//alert(ct+"|" + changes.length);
					if(ct == changes.length){
						if(res == ""){
							queryLogData("reload");
							//$.messager.alert('MESSAGE',' SAVE SUCCESS '  ,'info');
							showMsg("提示",'保存成功');
						}else{
							//$.messager.alert('ERR!','Err Info:[' + res + ']  NOT BE SAVED SUCCESS'  ,'error');
							showMsg("错误信息","Err Info:[" + res + "]  NOT BE SAVED SUCCESS");
						}
					}
					
				},
			  dataType: "json"
			});


			/*$.getJSON( "${ctx}/backlog/backlog!savePerBackInfo.do?acceptJson="+JSON.stringify(changes[i])+ "&blNo=" + changes[i].blId + "&_r= " + Math.random(), function(data) {
				if(data.status != 'success'){
					res += (data.errMsg + ",");
				}
				ct++;
				//alert(ct+"|" + changes.length);
				if(ct == changes.length){
					if(res == ""){
						$.messager.alert('MESSAGE',' SAVE SUCCESS '  ,'info');
					}else{
						$.messager.alert('ERR!','Err Info:[' + res + ']  NOT BE SAVED SUCCESS'  ,'error');
					}
				}
				
			});
			*/
	
		}
		//alert("changed date:"+r);
	}else{
		
		//$.messager.alert('MESSAGE',' SAVE SUCCESS '  ,'info');
		showMsg("提示","保存成功");
	}
}


function showMsg(tit,msg){
	$.messager.show({
		title:tit,
		msg:msg,
		timeout:2000,
		showType:'slide'
	});	
}

function createBlankLog(){
	$.getJSON( "${ctx}/se/se!createBlankUserLog.do?_r=" + Math.random(), function(data) {
		if(data.status == 'success'){
			var row = userLogTab.datagrid('appendRow',data.objJson);
			var index = userLogTab.datagrid('getRowIndex',data.objJson.plogId);
			//userLogTab.datagrid('endEdit', lastEditIndex);
			userLogTab.datagrid('beginEdit', index);
			userLogTab.datagrid('selectRow', index);
		}else{
			
			//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
			showMsg("错误信息",data.errMsg);
		}
	});
}




function deleteSePersonLogDatas(){
	if(confirm("确定删除勾选的日志么?")){
		var checkedIds = getUserLogCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		$.ajax("${ctx}/se/se!deleteSePersonLogByIds.do?ids=" + checkedIds + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						alert('操作成功');
						userLogTab.datagrid("clearChecked");
						queryLogData("reload");
					}else{
						alert(str);
					};
				}
			}
		)
	}
}
//获取勾选的行
function getUserLogCheckedIds(){
	var data = userLogTab.datagrid("getChecked");
	var str = ""
	for(var i = 0 , j = data.length ; i < j ; i++){
		//alert(data[i].PLOG_ID);
		str += (data[i].plogId + ",");
	};
	if(str != ""){
		str = str.substring(0,str.length - 1);
		return str;
	}else{
		return "";
	}
	
} 



function linkTask(){
	var row = userLogTab.datagrid("getSelected");
	if(row){
		//alert(row.projectId);
		showWin("${ctx}/se/seRequirementTrace!seRequirementTraceTaskSelect.do?cb=getParent().linkTaskCb&seRequirementTrace.projectId="+row.projectId);
	}else{
		alert("请选择数据");
	}
}

function linkTaskCb(data){
	console.log(data);
	var row = userLogTab.datagrid("getSelected");
	console.log(row);
	$.ajax("${ctx}/se/se!linkTaskForLog.do",
			{
				type:"POST",
				data:{
					'sePersonLog.plogId':row.plogId,
					'seTraceTask.taskId':data.TASK_ID
				},
				success:function(r){
					var str = $.trim(r);
					if(str == "SUCCESS"){
						alert('操作成功');
						//userLogTab.datagrid("clearChecked");
						queryLogData();
					}else{
						alert(str);
					};
				}
			}
		)
			
}


function rstUserLog(){
	$("#projectId").combobox("setValue","");
	$("#userId").combobox("setValue","");
	$("#logDateL").datebox("setValue","");
	$("#logDateH").datebox("setValue","");
	queryLogData();
}



//刷新表格
function reloadTraceNoteDg() {
	traceNoteDataTable.datagrid("reload");
}
//重新查询
function loadTraceNoteDg() {
	var jsonData = $("#traceNoteForm").serializeArray();
	var params = formToJson(jsonData);
	params.a = Math.random();
	//alert(traceId)
	params.TRACE_ID = traceId;
	params.PROJECT_ID = projectId;
	console.log("----" + params);
	traceNoteDataTable.datagrid("load", params);
}
//重置表单后查询
function resetTraceNoteForm(){
	traceNoteForm.form("clear");
	traceId="";
	loadTraceNoteDg();
}

//弹出保存页面方法
function addTraceNote(t) {
	var url = "${ctx}/se/se!seTraceNoteForm.do?seRequirementTrace.projectId=" + projectId + "&seTraceNote.traceId=" + traceId
	showWin(url, 1080, 600);
}
//弹出编辑页面
function editTraceNoteData(id) {
	var url = "${ctx}/se/se!seTraceNoteForm.do?seRequirementTrace.projectId=" + projectId + "&seTraceNote.noteId=" + id
	showWin(url,1080, 600);
	
}
//弹出编辑页面
function editTraceNoteData2() {
	var data = traceNoteDataTable.datagrid("getSelected");
	if(data){
		editTraceNoteData(data.NOTE_ID);
	}else{
		alert("请选择数据");
	}
}


function deleteTraceNoteDatas(){
	var checkedIds = getTraceNoteCheckedIds();
	if(checkedIds == ""){
		alert("请勾选数据后再进行删除");
		return ;
	}
	if(confirm("确定删除勾选的数据么?")){
		$.ajax("${ctx}/se/se!deleteSeTraceNoteByIds.do?ids=" + checkedIds + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						alert('操作成功');
						traceNoteDataTable.datagrid("clearChecked");
						loadTraceNoteDg();
					}else{
						alert(str);
					};
				}
			}
		)
	}
	
}
//获取勾选的行
function getTraceNoteCheckedIds(){
	var data = traceNoteDataTable.datagrid("getChecked");
	var str = ""
	for(var i = 0 , j = data.length ; i < j ; i++){
		//alert(data[i].NOTE_ID);
		str += (data[i].NOTE_ID + ",");
	};
	if(str != ""){
		str = str.substring(0,str.length - 1);
		return str;
	}else{
		return "";
	}
	
}
//删除操作
function deleteTraceNoteData(id){
	if(confirm("确定删除此条记录么?")){
		$.ajax("${ctx}/se/se!deleteSeTraceNoteById.do?seTraceNote.noteId=" + id + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						alert('操作成功');
						loadTraceNoteDg();
					}else{
						alert(str);
					};
				}
			}
		)
	}
}


//刷新表格
function reloadSeTraceDefectDg() {
	theSeTraceDefectTab.datagrid("reload");
}
//重新查询
function loadSeTraceDefectDg() {
	
	var jsonData = $("#theSeTraceDefectForm").serializeArray();
	var params = formToJson(jsonData);
	params.a = Math.random();
	//showObj(params);
	params.TRACE_ID = traceId;
	params.PROJECT_ID = projectId;
	//console.log("----" + params);
	theSeTraceDefectTab.datagrid("load", params);
}
//导出
function exportSeTraceDefectList(){
	var jsonData = $("#theSeTraceDefectForm").serializeArray();
	var params = formToJson(jsonData);
	params.a = Math.random();
	//showObj(params);
	params.TRACE_ID = traceId;
	params.PROJECT_ID = projectId;
	//console.log("----" + params);
	
	var data = $("#theSeTraceDefectForm").serialize();
	var url = "${ctx}/se/se!seTraceDefectListGetDate.do?export=1&" + data + "&TRACE_ID=" + traceId + "&PROJECT_ID=" + projectId + "&_r=" + Math.random();
	//alert(url);
	window.open(url);
	
	
	
}
//重置表单后查询
function resetSeTraceDefectForm(){
	theSeTraceDefectForm.form("clear");
	loadSeTraceDefectDg();
}

//弹出保存页面方法
function addSeTraceDefectObj(t) {
	var url = "${ctx}/se/se!seTraceDefectForm.do?seRequirementTrace.projectId=" + projectId + "&seTraceDefect.traceId=" + traceId;
	showWin(url, 1080, 600);
}
//弹出编辑页面
function editSeTraceDefectDate(id) {
	var url = "${ctx}/se/se!seTraceDefectForm.do?seRequirementTrace.projectId=" + projectId + "&seTraceDefect.defectId=" + id;
	showWin(url,1080, 600);
}
//弹出编辑页面
function editSeTraceDefectDate2() {
	var data = theSeTraceDefectTab.datagrid("getSelected");
	if(data){
		editSeTraceDefectDate(data.DEFECT_ID);
	}else{
		alert("请选择数据");
	}
}


function deleteSeTraceDefectDates(){
	var checkedIds = getDefectCheckedIds();
	if(checkedIds == ""){
		alert("请勾选数据后再进行删除");
		return ;
	}
	if(confirm("确定删除勾选的数据么?")){
		$.ajax("${ctx}/se/se!deleteSeTraceDefectByIds.do?ids=" + checkedIds + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						alert('操作成功');
						theSeTraceDefectTab.datagrid("clearChecked");
						loadSeTraceDefectDg();
					}else{
						alert(str);
					};
				}
			}
		)
	}
	
}
//获取勾选的行
function getDefectCheckedIds(){
	var data = theSeTraceDefectTab.datagrid("getChecked");
	var str = ""
	for(var i = 0 , j = data.length ; i < j ; i++){
		//alert(data[i].DEFECT_ID);
		str += (data[i].DEFECT_ID + ",");
	};
	if(str != ""){
		str = str.substring(0,str.length - 1);
		return str;
	}else{
		return "";
	}
	
}
//删除操作
function deleteDefectData(id){
	if(confirm("确定删除此条记录么?")){
		$.ajax("${ctx}/se/se!deleteSeTraceDefectById.do?seTraceDefect.defectId=" + id + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						alert('操作成功');
						loadSeTraceDefectDg();
					}else{
						alert(str);
					};
				}
			}
		)
	}
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

function repairSeTraceDefect(){
	var data = theSeTraceDefectTab.datagrid("getSelected");
	var url = "${ctx}/se/se!seTraceDefectStatusInfo.do?seTraceDefect.defectId=" + data.DEFECT_ID
	opw({title:'测试记录',url:url,w:'95%',h:'95%'});
	//console.log(data);
}



</script>
	</head>

<body class="easyui-layout">
	<div data-options="region:'west',split:true,title:'[${projectInfo.proName }]WBS'" style="width:350px;" >
		<!-- 
		<input type="button" value="矩阵待办信息" onclick="openTaskWin()"/>
		 -->
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
			<div title="任务信息" data-options="iconCls:'icon-list'">
				<!-- 矩阵任务 S -->
				<div class="easyui-layout" data-options="fit:true" >
					<div data-options="region:'center',iconCls:'icon-ok',border:false" style="padding:1px;">
						<table id="taskTable"></table>
					</div>
					<div data-options="region:'south',iconCls:'icon-ok',split:true,border:false" style="height:350px;padding:1px;">
						<div class="easyui-layout"  data-options="fit:true">
							<div data-options="region:'north',iconCls:'icon-ok',split:true,border:true" style="height:35px;padding:1px;">
								<form id="logSearchForm">
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td>包含子</td>
											<td><input type="checkbox" name="icl" id="icl" value="1"/></td>
											<td>需求：</td>
											<td><input type="text" class="easyui-textbox" id="traceName" name="traceName"  /></td>
											<td>任务：</td>
											<td><input type="text" class="easyui-textbox" id="taskName" name="taskName" /></td>
											<td>从</td>
											<td><input type="text"	class="easyui-datebox" name="logDateL" id="logDateL"  style="width:95px;" /></td>
											<td>至</td>
											<td><input type="text"	class="easyui-datebox" name="logDateH" id="logDateH"  style="width:95px;" /></td>
											<td>人员：</td>
											<td><input type="text" class="easyui-textbox" id="userId" name="userId" style="width:85px;"></td>
											<td><a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-search'" onclick="queryLogData();" >查询</a></td>
										</tr>
									</table>
									<div style="display:none;">
									<input type="text" class="easyui-textbox" name="traceId" id="traceId"/>
									<input type="text" class="easyui-textbox" name="taskId" id="taskId"/>
									<!--  <input type="text" class="easyui-textbox" name="userId" id="userId"/>-->
									</div>
								</form>
							</div>
							<div data-options="region:'center',iconCls:'icon-ok',border:false" >
								<table id="userLogTab"></table>
								<div id="userLogBar" >
									<a href="javascript:void(0)" class="easyui-linkbutton" title="新增项目" data-options="iconCls:'icon-add',plain:true" onclick="createBlankLog()">新增</a>
									<a href="javascript:void(0)" class="easyui-linkbutton" title="新增项目" data-options="iconCls:'icon-save',plain:true" onclick="saveAllUserLog()">保存</a>
									<a href="javascript:void(0)" class="easyui-linkbutton" title="编辑项目信息" data-options="iconCls:'icon-edit',plain:true" onclick="menuEditUserLog()">编辑</a>
									<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" data-options="iconCls:'icon-refresh',plain:true" onclick="rst()">重置</a>
									<a href="javascript:void(0)" class="easyui-linkbutton" title="删除" data-options="iconCls:'icon-err',plain:true" onclick="deleteSePersonLogDatas()">删除</a>
									<a href="javascript:void(0)" class="easyui-linkbutton" title="关联任务" data-options="iconCls:'icon-tag-purple',plain:true" onclick="linkTask()">关联任务</a>
								</div>
							</div>
							<!-- 
							<div data-options="region:'east',iconCls:'icon-ok',split:true,border:false" style="width:350px;padding:1px;">
							</div>
							 -->
						</div>
						
						
					</div>
					<div data-options="region:'east',iconCls:'icon-ok',border:false,split:true" style="width:350px;padding:1px;">
						<table id="assignedUsers"></table>
						<div id="tb" style="padding:2px 5px;">
				   				日期：
				   				<input type="text"	class="easyui-datebox" name="logDateInput" id="logDateInput" type="text" style="width:95px;" value="${currentDate}" />
								工作量： 
								<input type="text" class="easyui-numberbox"  name="workLoad" id="workLoad" type="text"  style="width:35px;" value="8" /> H
								<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-search'" onclick="createLog()">生成日志</a> 
							</form>
					    </div>
					</div>
				</div>
				<!-- 矩阵任务 E -->
			</div>
			<div title="矩阵属性" >
				<iframe  frameborder="0" width="100%" name="traceInputFrame" id="traceInputFrame" height="100%"></iframe>
			</div>
			
			<div title="遗留备忘" style="padding:1px;" data-options="iconCls:'icon-book'">
				<!-- 
				<iframe  frameborder="0" width="100%" name="noteFrame" id="noteFrame" height="100%" src="${ctx}/se/se!seTraceNoteList.do"></iframe>
				 -->
				 
				
				
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<form action="" id="traceNoteForm" method="post">
								<!-- 是否全部导出 -->
								<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
								<input type="hidden" id="sort" name="sort" value="status" />
								<input type="hidden" id="order" name="order" value="desc" />
								
								
									<div class="complex_search_area" id="search_all">
										<!-- 显示的查询条件 -->
										<table border="0" class="table_none_border">
											<tr>
												<!-- 记事种类  遗留 备忘 缺陷 -->
												<!--<td>
													<span class="Fieldname">种类：</span>
												</td>-->
												<td>
										
										 			 <s:select 
										 id="NOTE_TYPE" 
										 cssStyle="width:100px;"
										 cssClass="easyui-combobox" 
										 name="NOTE_TYPE" 
										  list="#{'遗留':'遗留','备忘':'备忘','缺陷':'缺陷','BUG':'BUG','变更':'变更','设计缺陷':'设计缺陷','开发疑问':'开发疑问'}" 
										 headerKey="" 
										 headerValue="请选择种类"></s:select>
												</td>
												<!-- 遗留备忘状态 -->
												<!-- <td>
													<span class="Fieldname">状态：</span>
												</td>-->
												<td>
														 
														 <s:select 
													 id="NOTE_STATUS" 
													 cssStyle="width:100px;"
													 cssClass="easyui-combobox" 
													 name="NOTE_STATUS" 
													 list="#{'未落实':'未落实','已落实':'已落实','已关闭':'已关闭'}" 
													 headerKey="" 
													 headerValue="请选择状态"></s:select>
												</td>
												<td>
													执行人：<input type="text"  id="traceNoteUserId"  name="userId" style="width:100px;"/>
												</td>
												<td>
													签发人：<input type="text"  id="ISSUE_USER"  name="ISSUE_USER" style="width:100px;"/>
												</td>
												<!-- 遗留备忘标题 -->
												<td>
													<span class="Fieldname">标题|内容：</span>
												</td>
												<td>
														<input 
														type="text"
														class="easyui-textbox" 
														name="NOTE_TITLE"
														id="NOTE_TITLE"
														type="text" 
														style="width:150px;"
														 />
												</td>
												<!-- 遗留备忘内容 -->
												<!--<td>
													<span class="Fieldname">内容：</span>
												</td>
												<td>
														<input 
														type="text"
														class="easyui-textbox" 
														name="NOTE_CONTENT"
														id="NOTE_CONTENT"
														type="text" 
														style="width:150px;"
														 />
												</td>-->
												
												
												<td>
													<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadTraceNoteDg()">查询</a>  
													<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetTraceNoteForm()">重置</a>  
												</td>
											</tr>
										</table>
									</div>
							</form>
					</div>
					<div data-options="region:'center'">
							<table id="traceNoteDataTable"></table>
					</div>
					<div data-options="region:'east',split:true,title:'内容'" style="width:460px;">
						<input type="hidden" id="noteId" name="noteId"/>
						<textarea id="content" name="content"></textarea>
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="saveContent(0)">保存</a> 
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="saveContent(1)">保存并落实</a>   
					</div>	
					
					
					
				</div>
			</div>
			
			
			<div title="测试记录" style="padding:1px;" data-options="iconCls:'icon-debug'">
				<div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north'" style="height:35px;">
						<form action="" id="theSeTraceDefectForm" method="post">
								<!-- 是否全部导出 -->
								<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
								<input type="hidden" id="sort" name="sort" value="CREATE_TIME" />
								<input type="hidden" id="order" name="order" value="desc" />
								
								
									<div class="complex_search_area" id="search_all">
										<!-- 显示的查询条件 -->
										<table border="0"  class="table_none_border">
											<tr>
												<!-- 缺陷描述 -->
												<td>
													<span class="Fieldname">描述：</span>
												</td>
												<td>
														<input 
														type="text"
														class="easyui-textbox" 
														name="DEFECT_DESC"
														id="DEFECT_DESC"
														type="text" 
														style="width:150px;"
														 />
												</td>
												<td>
														<s:select 
								 id="defectStatus" 
								 cssStyle="width:100px;"
								 cssClass="easyui-combobox" 
								 name="DEFECT_STATUS" 
								 list="#{'问题提出':'问题提出','已修改':'已修改','关闭':'关闭','重新打开':'重新打开','遗留问题':'遗留问题','非缺陷':'非缺陷'}" 
								 headerKey="" 
								 headerValue="缺陷状态"></s:select>
													
												</td>
												<!-- 开发人员 -->
												<td>
													<span class="Fieldname">开发人：</span>
												</td>
												<td>
														<input 
														type="text"
														name="DEVELOPER"
														id="DEVELOPER"
														type="text" 
														style="width:100px;"
														 />
												</td>
												<!-- 测试人员 -->
												<td>
													<span class="Fieldname">测试人：</span>
												</td>
												<td>
														<input 
														type="text"
														name="TEST_USER"
														id="TEST_USER"
														type="text" 
														style="width:100px;"
														 />
												</td>
												<td>
													<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeTraceDefectDg()">查询</a>  
													<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeTraceDefectForm()">重置</a>
													<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="exportSeTraceDefectList()">导出</a>    
												</td>
											</tr>
										</table>
									</div>
							</form>
					</div>
					<div data-options="region:'center'">
						
							<table id="theSeTraceDefectdataTable">
			
							</table>
							
							
		
							<div id="defectTabBar">
								
								<a href="javascript:void(0)" class="easyui-linkbutton" title="Add" onclick="addSeTraceDefectObj()" data-options="iconCls:'icon-add',plain:true" >Add</a>
								<a href="javascript:void(0)" class="easyui-linkbutton" title="Edit" onclick="editSeTraceDefectDate2()" data-options="iconCls:'icon-edit',plain:true" >Edit</a>
								<c:if test="${authMap['REQUIRE-TRACE'] == staticVarObj.y }">
									<a href="javascript:void(0)" class="easyui-linkbutton" title="Delete" onclick="deleteSeTraceDefectDates()" data-options="iconCls:'icon-remove',plain:true" >Delete</a>
									<a href="javascript:void(0)" class="easyui-linkbutton" title="Update Status" onclick="repairSeTraceDefect()" data-options="iconCls:'icon-edit-debug',plain:true" >更改状态</a>
								</c:if>
							</div>
					</div>
					<div data-options="region:'east',split:true,title:'内容'" style="width:460px;padding:1px;">
					
						<input type="hidden" id="defectId" name="defectId"/>
						<textarea id="defectContent" name="defectContent"></textarea>
					</div>	
							
							
					
				</div>
			</div>
		</div>  
	</div>
	
	<div id="mm" class="easyui-menu" style="width: 120px;">
		<c:if test="${authMap['REQUIRE-TRACE'] == staticVarObj.y }">
			<div data-options="iconCls:'icon-add'" onclick="createNewNode()">
				新增子节点
			</div>
			<div data-options="iconCls:'icon-edit'" onclick="modiNode()">
				编辑该节点
			</div>
			<div data-options="iconCls:'icon-reload'" onclick="refreshNode()">
				刷新
			</div>
			
			<div data-options="iconCls:'icon-remove'" id="canelTodayDeal" >
				删除该节点
			</div>
			<div class="menu-sep"></div>
		</c:if>
		
		
		<div data-options="iconCls:'icon-add'" onclick="addTask()">
			添加任务
		</div>
		<div data-options="iconCls:'icon-add'" onclick="note()">
			遗留备忘
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
		
	<div id="win" title="矩阵信息"><iframe id="winSrc" frameborder="0" width="100%" height="100%"></iframe></div>
	<div id="taskTableWin" title="任务列表" style="padding:2px;">
		
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
						loadTraceNoteDg();
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

ue1 = UE.getEditor('defectContent',{
	serverUrl: "${ctx}/se/se!uploadFile.do",
	
	toolbars: [[
	            'fullscreen'
	        ]],
	
	
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
