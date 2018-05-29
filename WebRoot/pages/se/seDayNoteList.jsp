<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var tab;

	var input_project_list_setting ={
			url:'${ctx}/common/common!queryProjectListJsonStr.do',
			valueField:'value',
			textField:'text',
			onChange:function(){loadDg()}
	};
	
	
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

	//弹出保存页面方法
	function addObj(t) {
		showWin("${ctx}/se/se!seDayNoteForm.do", 900, 600);
	}
	//弹出编辑页面
	function editData(id) {
		showWin("${ctx}/se/se!seDayNoteForm.do?seDayNote.noteId=" + id,900, 700);
	}
	//弹出编辑页面
	function editData2() {
		var data = tab.datagrid("getSelected");
		if(data){
			editData(data.NOTE_ID);
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
			$.ajax("${ctx}/se/se!deleteSeDayNoteByIds.do?ids=" + checkedIds + "&_r="+Math.random,
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
	function deleteData(id){
		if(confirm("确定删除此条记录么?")){
			$.ajax("${ctx}/se/se!deleteSeDayNoteById.do?seDayNote.noteId=" + id + "&_r="+Math.random,
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
							url : '${ctx}/se/se!seDayNoteListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							queryParams: {
								PROJECT_ID: '${seDayNote.projectId}'
							},
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
										title : '日记id',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'NOTE_TYPE',
										title : '记事类型',
										width : 100,
										sortable : true
									},
									{
										field : 'NOTE_DATE',
										title : '日记日期',
										width : 100,
										sortable : true
									},
									{
										field : 'NOTE_TITLE',
										title : '日记标题',
										width : 150,
										sortable : true
									},
									{
										field : 'PROJECTNAME',
										title : '所属系统',
										width : 150,
										sortable : true
									},
									
									
									/*{
										field : 'PROJECT_ID',
										title : '项目id',
										width : 100,
										sortable : true
									},
									{
										field : 'NOTE_CONTENT',
										title : '日记内容',
										width : 300,
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
									},*/ 
									{
										field : 'OPER',
										title : '操作',
										width : 100, 
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  ' <a  href="#" title="编辑" onclick="editData(\'' + row.NOTE_ID + '\')" >编辑</a> '
											var deleteStr = ' <a  href="#" title="删除" onclick="deleteData(\'' + row.NOTE_ID + '\')" >删除</a> ';
											return editStr + deleteStr;
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
								editData(rowData.NOTE_ID);
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
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 日记id 
									<td>
										<span class="Fieldname">日记id：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="NOTE_ID"
											id="NOTE_ID"
											type="text" 
											style="width:50px;"
											 />
									</td>
-->

									<!-- 项目id 
									<td>
										<span class="Fieldname">项目id：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="PROJECT_ID"
											id="PROJECT_ID"
											type="text" 
											style="width:50px;"
											 />
									</td>-->
									<!-- 日记日期 -->
									<td>
										<span class="Fieldname">日记日期：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="NOTE_DATE"
											id="NOTE_DATE"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<!-- 记事分类 -->
									<td>
										<span class="Fieldname">记事分类：</span>
									</td>
									<td>
										<s:select id="NOTE_TYPE" 
							 name="NOTE_TYPE"  
							 cssClass="easyui-combobox"  
							 list="#request.noteTypeList"  listKey="value" listValue="text" headerKey="" cssStyle="width:100px;" headerValue="请选择"></s:select>  
							 
							 		<!-- 所属项目 -->
									<td>
										<span class="Fieldname">所属项目：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-combobox" 
											name="PROJECT_ID"
											id="PROJECT_ID"
											value="${seMeeting.projectId}"
											type="text" 
											style="width:150px;"
											 />
									</td>
											
									</td>
									<!-- 日记标题 -->
									<td>
										<span class="Fieldname">日记标题：</span>
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
									<!-- 日记内容 
									<td>
										<span class="Fieldname">日记内容：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="NOTE_CONTENT"
											id="NOTE_CONTENT"
											type="text" 
											style="width:50px;"
											 />
									</td>-->
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
											style="width:50px;"
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
											style="width:50px;"
											 />
									</td>-->
									<!-- 创建时间 
									<td>
										<span class="Fieldname">创建时间：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="CREATE_TIME"
											id="CREATE_TIME"
											type="text" 
											style="width:100px;"
											 />
									</td>-->
									<!-- 修改时间
									<td>
										<span class="Fieldname">修改时间：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="UPDATE_TIME"
											id="UPDATE_TIME"
											type="text" 
											style="width:100px;"
											 />
									</td> -->
								
									<td>
									<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadDg()" title="查询"></a>  
									<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetForm()" title="重置"></a>  
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
