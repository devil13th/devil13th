<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSysDicStandardDocTab;

	var theSysDicStandardDocForm;
	//刷新表格
	function reloadSysDicStandardDocDg() {
		theSysDicStandardDocTab.datagrid("reload");
	}
	//重新查询
	function loadSysDicStandardDocDg() {
		var jsonData = $("#theSysDicStandardDocForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSysDicStandardDocTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSysDicStandardDocForm(){
		theSysDicStandardDocForm.form("clear");
		loadSysDicStandardDocDg();
	}

	//弹出保存页面方法
	function addSysDicStandardDocObj(t) {
		showWin("${ctx}/common/common!sysDicStandardDocForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSysDicStandardDocDate(id) {
		showWin("${ctx}/common/common!sysDicStandardDocForm.do?sysDicStandardDoc.docCode=" + id,900, 600);
	}
	//弹出编辑页面
	function editSysDicStandardDocDate2() {
		var data = theSysDicStandardDocTab.datagrid("getSelected");
		if(data){
			editSysDicStandardDocDate(data.DOC_CODE);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSysDicStandardDocDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/common/common!deleteSysDicStandardDocByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSysDicStandardDocTab.datagrid("clearChecked");
							loadSysDicStandardDocDg();
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
		var data = theSysDicStandardDocTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].DOC_CODE);
			str += (data[i].DOC_CODE + ",");
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
			$.ajax("${ctx}/common/common!deleteSysDicStandardDocById.do?sysDicStandardDoc.docCode=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSysDicStandardDocDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theSysDicStandardDocForm = $('#theSysDicStandardDocForm').form({
			ajax:false
		})
		
		
		theSysDicStandardDocTab = $('#theSysDicStandardDocdataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/common/common!sysDicStandardDocListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "DOC_CODE",
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
							sortName : 'DOC_CODE',
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
										field : 'DOC_CODE',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'DOC_CODE',
										title : '文档CODE'
									}
									] ],
							columns : [ [
									{
										field : 'DOC_NAME',
										title : '标准文档名称',
										width : 100,
										sortable : true
									},
									{
										field : 'DOC_PHASES',
										title : '所属项目阶段',
										width : 100,
										sortable : true
									},
									{
										field : 'DOC_DESC',
										title : '标准文档说明',
										width : 100,
										sortable : true
									},
									{
										field : 'DOC_BLANK_TEMPLATE',
										title : '标准文档模板',
										width : 100,
										sortable : true
									},
									{
										field : 'DOC_EXAMPLE',
										title : '标准文档样例',
										width : 100,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editSysDicStandardDocDate(\'' + row.DOC_CODE + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.DOC_CODE + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSysDicStandardDocQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSysDicStandardDocObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSysDicStandardDocDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSysDicStandardDocDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSysDicStandardDocDate(rowData.DOC_CODE);
							}
							
						})

	})

	

var querySysDicStandardDocState = "open"
function hideSysDicStandardDocQuery(){
	if("open" == querySysDicStandardDocState){
		$('body').layout('collapse','north');
		querySysDicStandardDocState = "close";
	}else{
		$('body').layout('expand','north');
		querySysDicStandardDocState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSysDicStandardDocForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 文档CODE -->
									<td>
										<span class="Fieldname">文档CODE：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DOC_CODE"
											id="DOC_CODE"
											type="text" 
											style="width:150px;"
											 />
									</td>


									<!-- 标准文档名称 -->
									<td>
										<span class="Fieldname">标准文档名称：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DOC_NAME"
											id="DOC_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 所属项目阶段 -->
									<td>
										<span class="Fieldname">所属项目阶段：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DOC_PHASES"
											id="DOC_PHASES"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 标准文档说明 -->
									<td>
										<span class="Fieldname">标准文档说明：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DOC_DESC"
											id="DOC_DESC"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!--
									<td>
										<span class="Fieldname">标准文档模板：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DOC_BLANK_TEMPLATE"
											id="DOC_BLANK_TEMPLATE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">标准文档样例：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DOC_EXAMPLE"
											id="DOC_EXAMPLE"
											type="text" 
											style="width:150px;"
											 />
									</td>
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
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSysDicStandardDocDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSysDicStandardDocForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSysDicStandardDocdataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
