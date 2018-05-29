<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSysDicProcessTab;
	var theSysDicProcessForm;
	var syncProcessWin;
	var theSysDicProcessStepTab;
	var theSysDicProcessStepForm;
	function openSyncProcessWin(){
		syncProcessWin.dialog('open');
	}
	
	//刷新表格
	function reloadSysDicProcessDg() {
		theSysDicProcessTab.datagrid("reload");
	}
	//重新查询
	function loadSysDicProcessDg() {
		var jsonData = $("#theSysDicProcessForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSysDicProcessTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSysDicProcessForm(){
		theSysDicProcessForm.form("clear");
		loadSysDicProcessDg();
	}

	//弹出保存页面方法
	function addSysDicProcessObj(t) {
		showWin("${ctx}/common/common!sysDicProcessForm.do", 900, 600);
	}
	
	function stepList(id){
		showWin("${ctx}/common/common!sysDicProcessStepList.do?id=" + id, 900, 600);
	}

	
	
	//弹出编辑页面
	function editSysDicProcessDate(id) {
		showWin("${ctx}/common/common!sysDicProcessForm.do?sysDicProcess.processId=" + id,900, 600);
	}
	//弹出编辑页面
	function editSysDicProcessDate2() {
		var data = theSysDicProcessTab.datagrid("getSelected");
		if(data){
			editSysDicProcessDate(data.PROCESS_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSysDicProcessDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/common/common!deleteSysDicProcessByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSysDicProcessTab.datagrid("clearChecked");
							loadSysDicProcessDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
		
	}
	//获取勾选的行
	function getCheckedIds(){
		var data = theSysDicProcessTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].PROCESS_ID);
			str += (data[i].PROCESS_ID + ",");
		};
		if(str != ""){
			str = str.substring(0,str.length - 1);
			return str;
		}else{
			return "";
		}
		
	}
	//删除操作
	function deleteData(id){
		if(confirm("确定删除此条记录么?")){
			$.ajax("${ctx}/common/common!deleteSysDicProcessById.do?sysDicProcess.processId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSysDicProcessDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	
	
	
	
	
	//刷新表格
	function reloadSysDicProcessStepDg() {
		theSysDicProcessStepTab.datagrid("reload");
	}
	//重新查询
	function loadSysDicProcessStepDg() {
		var jsonData = $("#theSysDicProcessStepForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSysDicProcessStepTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSysDicProcessStepForm(){
		theSysDicProcessStepForm.form("clear");
		loadSysDicProcessStepDg();
	}

	//弹出保存页面方法
	function addSysDicProcessStepObj(t) {
		showWin("${ctx}/common/common!sysDicProcessStepForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSysDicProcessStepDate(id) {
		showWin("${ctx}/common/common!sysDicProcessStepForm.do?sysDicProcessStep.stepId=" + id,900, 600);
	}
	//弹出编辑页面
	function editSysDicProcessStepDate2() {
		var data = theSysDicProcessStepTab.datagrid("getSelected");
		if(data){
			editSysDicProcessStepDate(data.STEP_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSysDicProcessStepDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/common/common!deleteSysDicProcessStepByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSysDicProcessStepTab.datagrid("clearChecked");
							loadSysDicProcessStepDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
		
	}
	//获取勾选的行
	function getCheckedIds(){
		var data = theSysDicProcessStepTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].STEP_ID);
			str += (data[i].STEP_ID + ",");
		};
		if(str != ""){
			str = str.substring(0,str.length - 1);
			return str;
		}else{
			return "";
		}
		
	}
	//删除操作
	function deleteData(id){
		if(confirm("确定删除此条记录么?")){
			$.ajax("${ctx}/common/common!deleteSysDicProcessStepById.do?sysDicProcessStep.stepId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSysDicProcessStepDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

$(function() {
	theSysDicProcessForm = $('#theSysDicProcessForm').form({
		ajax:false
	})
		
		
	theSysDicProcessTab = $('#theSysDicProcessdataTable').datagrid({
		//title:'数据列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/common/common!sysDicProcessListGetDate.do?r=' + Math.random(),
		//斑马纹
		striped : true,
		//主键字段
		idField : "PROCESS_ID",
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
		sortName : 'PROCESS_ID',
		//排序方式
		sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		pagePosition : "bottom",
		checkOnSelect:true,
		selectOnCheck:true,
		//冻结的列
		frozenColumns : [ [
		//选择框		
				/*{
					field : 'PROCESS_ID',
					title : 'fid',
					checkbox : true,
					align : 'center'
				},*/
				{
					field : 'PROCESS_ID',
					title : '流程ID',
					checkbox : true,
					align : 'center'
				}
				] ],
		columns : [ [
				{
					field : 'PROCESS_KEY',
					title : '流程KEY',
					width : 100,
					sortable : true
				},
				{
					field : 'PROCESS_NAME',
					title : '流程名称',
					width : 100,
					sortable : true
				},
				{
					field : 'PROCESS_DEF_ID',
					title : '流程定义ID',
					width : 100,
					sortable : true
				},
				/*{
					field : 'IS_DELETE',
					title : '是否删除',
					width : 100,
					sortable : true
				},*/
				{
					field : 'OPER',
					title : '操作',
					width : 120,
					align : 'center',
					formatter : function(value, row, index) {
						var editStr =  '<a  href="#" title="编辑" onclick="editSysDicProcessDate(\'' + row.PROCESS_ID + '\')" >编辑</a>'
						var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.PROCESS_ID + '\')" >删除</a>';
						var stepStr = '<a  href="#" title="步骤信息" onclick="stepList(\'' + row.PROCESS_ID + '\')" >步骤信息</a>';
						return editStr +"&nbsp;"+ deleteStr+"&nbsp;"+ stepStr;
					}
				} 
				] ]
		,
		toolbar :[{
			text:'Add',
			iconCls:'icon-add',
			handler:function(){addSysDicProcessObj()} 
		},{
			text:'Edit',
			iconCls:'icon-edit',
			handler:function(){editSysDicProcessDate2()}
		},'-',{
			text:'Delete',
			iconCls:'icon-remove',
			handler:function(){deleteSysDicProcessDates()}
		},'-',{
			text:'同步流程',
			iconCls:'icon-06',
			handler:function(){openSyncProcessWin()}
		},'-',{
			text:'流程功能',
			iconCls:'icon-04',
			handler:function(){funProcessSetting()}
		}],
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
		,
		
		onDblClickRow : function(rowIndex, rowData) {
			//不能选中条件中的行
			editSysDicProcessDate(rowData.PROCESS_ID);
		},
		
		onSelect: function(rowIndex, rowData) {
			theSysDicProcessStepTab.datagrid("load", {PROCESS_ID:rowData.PROCESS_ID});
		},
		onLoadSuccess : function(){
			theSysDicProcessTab.datagrid("selectRow",0);
		}
		
		
		
	})
						
	theSysDicProcessStepTab = $('#theSysDicProcessStepdataTable').datagrid({
		//title:'数据列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/common/common!sysDicProcessStepListGetDate.do?r=' + Math.random(),
		//斑马纹
		striped : true,
		//主键字段
		idField : "STEP_ID",
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
		sortName : 'STEP_ID',
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
					field : 'STEP_ID',
					title : 'fid',
					checkbox : true,
					align : 'center'
				},
				{
					field : 'STEP_ID',
					title : '步骤ID',
					checkbox : true,
					align : 'center'
				}
				{
					field : 'PROCESS_ID',
					title : '所属流程ID',
					width : 100,
					sortable : true
				},*/
				] ],
		columns : [ [
				
				{
					field : 'STEP_CODE',
					title : '步骤CODE',
					width : 100,
					sortable : true
				},
				{
					field : 'STEP_NAME',
					title : '步骤名称',
					width : 100,
					sortable : true
				},
				{
					field : 'STEP_ORDER',
					title : '步骤序号',
					width : 100,
					sortable : true
				},
				{
					field : 'IS_FIRST_STEP',
					title : '是否第一步骤',
					width : 100,
					sortable : true
				},
				{
					field : 'IS_LAST_STEP',
					title : '是否最后一个步骤',
					width : 100,
					sortable : true
				},
				/*{
					field : 'IS_DELETE',
					title : '是否删除',
					width : 100,
					sortable : true
				},*/
				{
					field : 'OPER',
					title : '操作',
					width : 80,
					align : 'center',
					formatter : function(value, row, index) {
						var editStr =  '<a  href="#" title="编辑" onclick="editSysDicProcessStepDate(\'' + row.STEP_ID + '\')" >编辑</a>'
						var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.STEP_ID + '\')" >删除</a>';
						return editStr +"&nbsp;"+ deleteStr;
					}
				} 
				] ]

		,
		toolbar :[{
			text:'Add',
			iconCls:'icon-add',
			handler:function(){addSysDicProcessStepObj()} 
		},{
			text:'Edit',
			iconCls:'icon-edit',
			handler:function(){editSysDicProcessStepDate2()}
		},'-',{
			text:'Delete',
			iconCls:'icon-remove',
			handler:function(){deleteSysDicProcessStepDates()}
		},'-',{
			text:'步骤功能',
			iconCls:'icon-04',
			handler:function(){funStepSetting()}
		}],
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
		,
		
		onDblClickRow : function(rowIndex, rowData) {
			//不能选中条件中的行
			editSysDicProcessStepDate(rowData.STEP_ID);
		}
		
		
		
		
	})

						
	syncProcessWin=$('#syncProcessWin').dialog({
	    title: '请填写需要添加的流程步骤ID',
	    width: 320,
	    height: 150,
	    closed: true,
	    modal: true ,
	    buttons:[{
			text:'确定',
			handler:function(){
				var procDefId = $("#processDefId").textbox("getValue");
				if($.trim(procDefId) != ""){
					$.ajax({
						type: "POST",
						dataType:"text",
						url: "${ctx}/common/common!syncProcess.do?_r=" + Math.random(),
						data: {"id":procDefId},
						success:function(data){
							if($.trim(data) != 'SUCCESS'){
								syncProcessWin.dialog('close');
								showMsg("提示",$.trim(data));  
							}else{
								syncProcessWin.dialog('close');
								showMsg("提示",'操作成功');  
								loadSysDicProcessDg();
							}
						}
					}); 
				}else{
					showMsg("提示",'请填写流程定义ID');
				}
				
			}
		},{
			text:'取消',
			handler:function(){
				syncProcessWin.dialog('close');
		  	}
		}]
	});

})

	

var querySysDicProcessState = "open"

function funStepSetting(){
	var data = theSysDicProcessStepTab.datagrid("getSelected");
	var id = "";
	if(data){
		id = data.STEP_ID;
	}else{
		alert("请选择数据");
		return false;
	}
	showWin("${ctx}/common/common/common!sysDicFunctionSetting.do?classify=sys_dic_process_step&id=" +  id,900, 600);
}
function funProcessSetting(){
	
	var data = theSysDicProcessTab.datagrid("getSelected");
	var id = "";
	if(data){
		id = data.PROCESS_ID;
	}else{
		alert("请选择数据");
		return false;
	}
	
	showWin("${ctx}/common/common/common!sysDicFunctionSetting.do?classify=sys_dic_process&id=" +  id,900, 600);
}




function hideSysDicProcessQuery(){
	if("open" == querySysDicProcessState){
		$('body').layout('collapse','north');
		querySysDicProcessState = "close";
	}else{
		$('body').layout('expand','north');
		querySysDicProcessState = "open";
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



</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSysDicProcessForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 流程ID -->
									<!-- <td>
										<span class="Fieldname">流程ID：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="PROCESS_ID"
											id="PROCESS_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>
 -->

									<!-- 流程KEY -->
									<td>
										<span class="Fieldname">流程KEY：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="PROCESS_KEY"
											id="PROCESS_KEY"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 流程名称 -->
									<td>
										<span class="Fieldname">流程名称：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="PROCESS_NAME"
											id="PROCESS_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 部署ID -->
									<td>
										<span class="Fieldname">部署ID：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="PROCESS_DEPLOY_ID"
											id="PROCESS_DEPLOY_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 是否删除 -->
									<!-- <td>
										<span class="Fieldname">是否删除：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="IS_DELETE"
											id="IS_DELETE"
											type="text" 
											style="width:150px;"
											 />
									</td> -->
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSysDicProcessDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSysDicProcessForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center',title:'流程列表',split:true,hideCollapsedContent:false">
			<table id="theSysDicProcessdataTable"></table>
		</div>
		
		<div data-options="region:'east',title:'步骤列表',split:true,hideCollapsedContent:false,collapsed:false" style="width:435px;">
			<table id="theSysDicProcessStepdataTable"></table>
		</div>
		
		
		<div id="syncProcessWin" style="padding:10px;">
			[act_re_procdef]表的id_字段值<br/><br/>
			<input type="text" class="easyui-textbox" style="width:100%" id="processDefId" />
		</div>
		
	</body>

</html>
