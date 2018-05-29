<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var tab;

	var theForm;
	
	var input_project_list_setting ={
			url:'${ctx}/common/common!queryProjectListJsonStr.do',
			valueField:'value',
			textField:'text'
	}
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

	//弹出保存页面方法
	function addObj(t) {
		showWin("${ctx}/se/se!sePubModuleForm.do?sePubModule.projectId=${sePubModule.projectId}",1000, 600);
	}
	//弹出编辑页面
	function editData(id) {
		showWin("${ctx}/se/se!sePubModuleForm.do?sePubModule.moduleId=" + id,1000, 600);
	}
	//弹出编辑页面
	function editData2() {
		var data = tab.datagrid("getSelected");
		if(data){
			editData(data.MODULE_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteDatas(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSePubModuleByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							tab.datagrid("clearChecked");
							loadDg();
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
		var data = tab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].MODULE_ID);
			str += (data[i].MODULE_ID + ",");
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
			$.ajax("${ctx}/se/se!deleteSePubModuleById.do?sePubModule.moduleId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theForm = $('#theForm').form({
			ajax:false
		})
		$("#PROJECT_ID").combobox(input_project_list_setting);
		
		tab = $('#dataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!sePubModuleListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							queryParams: {
								PROJECT_ID: '${sePubModule.projectId}'
							},
							//主键字段
							idField : "MODULE_ID",
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
							sortName : 'MODULE_ID',
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
										field : 'MODULE_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'MODULE_ID',
										title : '组件ID',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'MODULE_TITLE',
										title : '组件标题',
										sortable : true
									},
									{
										field : 'MODULE_NAME',
										title : '组件方法名',
										sortable : true
									},
									{
										field : 'DIC_NAME',
										title : '分类',
										sortable : true
									},
									/*{
										field : 'MODULE_CLASSIFY',
										title : '组件分类',
										width : 100,
										sortable : true
									},
									
									{
										field : 'MODULE_INPUT',
										title : '组件输入',
										width : 100,
										sortable : true
									},
									{
										field : 'MODULE_OUTPUT',
										title : '组件输出',
										width : 100,
										sortable : true
									},
									{
										field : 'MODULE_DESC',
										title : '组件描述',
										width : 100,
										sortable : true
									},
									{
										field : 'MODULE_FILE',
										title : '组件所在文件',
										width : 100,
										sortable : true
									},
									{
										field : 'MODULE_EXAMPLE',
										title : '组件示例',
										width : 100,
										sortable : true
									},
									{
										field : 'MODULE_DATE',
										title : '组件发布日期',
										width : 100,
										sortable : true
									},
									{
										field : 'MODULE_USER_NAME',
										title : '组件负责人',
										width : 100,
										sortable : true
									},*/
									{
										field : 'PROJECT_ID',
										title : '所属项目',
										width : 100,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editData(\'' + row.MODULE_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.MODULE_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editData2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteDatas()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editData(rowData.MODULE_ID);
							}
							
						})

	})

	

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
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
						<div style="display:none;">
						<!-- 没用的查询条件 -->
						<table>
						<tr>
						<!-- 组件描述 -->
									<td>
										<span class="Fieldname">组件描述：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MODULE_DESC"
											id="MODULE_DESC"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 组件所在文件 -->
									<td>
										<span class="Fieldname">组件所在文件：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MODULE_FILE"
											id="MODULE_FILE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 组件示例 -->
									<td>
										<span class="Fieldname">组件示例：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MODULE_EXAMPLE"
											id="MODULE_EXAMPLE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 组件发布日期 -->
									<td>
										<span class="Fieldname">组件发布日期：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="MODULE_DATE"
											id="MODULE_DATE"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<!-- 组件负责人 -->
									<td>
										<span class="Fieldname">组件负责人：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MODULE_USER"
											id="MODULE_USER"
											type="text" 
											style="width:150px;"
											 />
									</td>
									</tr>
						</table>
						</div>
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 组件标题 -->
									<td>
										<span class="Fieldname">组件标题：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MODULE_TITLE"
											id="MODULE_TITLE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 组件分类 -->
									<td>
										<span class="Fieldname">组件分类：</span>
									</td>
									<td>
									<s:select id="MODULE_CLASSIFY" 
					 name="MODULE_CLASSIFY"  
					 cssClass="easyui-combobox"  
					 list="#request.moduleClassifyList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select> 
					 
					 
									</td>
									<!-- 组件方法名 -->
									<td>
										<span class="Fieldname">组件方法名：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MODULE_NAME"
											id="MODULE_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									
									<!-- 所属项目 -->
									<td>
										<span class="Fieldname">所属项目：</span>
									</td>
									<td>
										<input type="text"    id="PROJECT_ID" value="${sePubModule.projectId}"  name="PROJECT_ID" style="width:130px;"/>
										
									</td>
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="dataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
