<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSysDicFunctionTab;

	var theSysDicFunctionForm;
	//刷新表格
	function reloadSysDicFunctionDg() {
		theSysDicFunctionTab.datagrid("reload");
	}
	//重新查询
	function loadSysDicFunctionDg() {
		var jsonData = $("#theSysDicFunctionForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSysDicFunctionTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSysDicFunctionForm(){
		theSysDicFunctionForm.form("clear");
		loadSysDicFunctionDg();
	}

	//弹出保存页面方法
	function addSysDicFunctionObj(t) {
		showWin("${ctx}/common/common!sysDicFunctionForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSysDicFunctionDate(id) {
		showWin("${ctx}/common/common!sysDicFunctionForm.do?sysDicFunction.funId=" + id,900, 600);
	}
	//弹出编辑页面
	function editSysDicFunctionDate2() {
		var data = theSysDicFunctionTab.datagrid("getSelected");
		if(data){
			editSysDicFunctionDate(data.FUN_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSysDicFunctionDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/common/common!deleteSysDicFunctionByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSysDicFunctionTab.datagrid("clearChecked");
							loadSysDicFunctionDg();
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
		var data = theSysDicFunctionTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].FUN_ID);
			str += (data[i].FUN_ID + ",");
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
			$.ajax("${ctx}/common/common!deleteSysDicFunctionById.do?sysDicFunction.funId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSysDicFunctionDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theSysDicFunctionForm = $('#theSysDicFunctionForm').form({
			ajax:false
		})
		
		
		theSysDicFunctionTab = $('#theSysDicFunctiondataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/common/common!sysDicFunctionListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "FUN_ID",
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
							sortName : 'FUN_ID',
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
										field : 'FUN_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'FUN_ID',
										title : '功能主键',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'FUN_NAME',
										title : '功能名称',
										width : 300,
										sortable : true
									},
									{
										field : 'FUN_URL',
										title : '功能URL',
										width : 500,
										sortable : true
									},
									{
										field : 'FUN_DESC',
										title : '功能描述',
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
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editSysDicFunctionDate(\'' + row.FUN_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.FUN_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSysDicFunctionQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSysDicFunctionObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSysDicFunctionDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSysDicFunctionDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSysDicFunctionDate(rowData.FUN_ID);
							}
							
						})

	})

	

var querySysDicFunctionState = "open"
function hideSysDicFunctionQuery(){
	if("open" == querySysDicFunctionState){
		$('body').layout('collapse','north');
		querySysDicFunctionState = "close";
	}else{
		$('body').layout('expand','north');
		querySysDicFunctionState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSysDicFunctionForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 功能主键
									<td>
										<span class="Fieldname">功能主键：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="FUN_ID"
											id="FUN_ID"
											type="text" 
											style="width:150px;"
											 />
									</td> -->


									<!-- 功能名称 -->
									<td>
										<span class="Fieldname">功能名称：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="FUN_NAME"
											id="FUN_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 功能URL 
									<td>
										<span class="Fieldname">功能URL：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="FUN_URL"
											id="FUN_URL"
											type="text" 
											style="width:150px;"
											 />
									</td>-->
									<!-- 功能描述 -->
									<td>
										<span class="Fieldname">功能描述：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="FUN_DESC"
											id="FUN_DESC"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 是否有效 
									<td>
										<span class="Fieldname">是否有效：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="IS_VALID"
											id="IS_VALID"
											type="text" 
											style="width:150px;"
											 />
									</td>-->
									<!-- 是否删除 
									<td>
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
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSysDicFunctionDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSysDicFunctionForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSysDicFunctiondataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
