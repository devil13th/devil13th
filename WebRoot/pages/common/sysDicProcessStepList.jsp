<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSysDicProcessStepTab;

	var theSysDicProcessStepForm;
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
		theSysDicProcessStepForm = $('#theSysDicProcessStepForm').form({
			ajax:false
		})
		
		
		theSysDicProcessStepTab = $('#theSysDicProcessStepdataTable')
				.datagrid(
						{
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
							queryParams : {PROCESS_ID:"${id}"},
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
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSysDicProcessStepQuery()}
							},{
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

	})

	

var querySysDicProcessStepState = "open"
function hideSysDicProcessStepQuery(){
	if("open" == querySysDicProcessStepState){
		$('body').layout('collapse','north');
		querySysDicProcessStepState = "close";
	}else{
		$('body').layout('expand','north');
		querySysDicProcessStepState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSysDicProcessStepForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 步骤ID -->
									<!--<td>
										<span class="Fieldname">步骤ID：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="STEP_ID"
											id="STEP_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>-->


									<!-- 所属流程ID -->
									<td>
										<span class="Fieldname">所属流程ID：</span>
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
									<!-- 步骤CODE -->
									<td>
										<span class="Fieldname">步骤CODE：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="STEP_CODE"
											id="STEP_CODE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 步骤名称 -->
									<td>
										<span class="Fieldname">步骤名称：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="STEP_NAME"
											id="STEP_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 步骤序号 -->
									<!--<td>
										<span class="Fieldname">步骤序号：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-numberbox" 
											name="STEP_ORDER"
											id="STEP_ORDER"
											type="text" 
											precision="0" max="100" min="0"
											style="width:150px;"
											 />
									</td>-->
									<!-- 是否第一步骤 -->
									<!--<td>
										<span class="Fieldname">是否第一步骤：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="IS_FIRST_STEP"
											id="IS_FIRST_STEP"
											type="text" 
											style="width:150px;"
											 />
									</td> -->
									<!-- 是否最后一个步骤 -->
									<!--<td>
										<span class="Fieldname">是否最后一个步骤：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="IS_LAST_STEP"
											id="IS_LAST_STEP"
											type="text" 
											style="width:150px;"
											 />
									</td>-->
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
									</td>-->
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSysDicProcessStepDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSysDicProcessStepForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSysDicProcessStepdataTable">

				</table>
		</div>
	</body>
</html>
