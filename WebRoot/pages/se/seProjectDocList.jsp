<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSeProjectDocTab;

	var theSeProjectDocForm;
	//刷新表格
	function reloadSeProjectDocDg() {
		theSeProjectDocTab.datagrid("reload");
	}
	//重新查询
	function loadSeProjectDocDg() {
		var jsonData = $("#theSeProjectDocForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSeProjectDocTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSeProjectDocForm(){
		theSeProjectDocForm.form("clear");
		loadSeProjectDocDg();
	}

	//弹出保存页面方法
	function addSeProjectDocObj(t) {
		showWin("${ctx}/se/se!seProjectDocForm.do?seProjectDoc.projectId=${seProjectDoc.projectId}", 900, 600);
	}
	//弹出编辑页面
	function editSeProjectDocDate(id) {
		showWin("${ctx}/se/se!seProjectDocForm.do?seProjectDoc.docId=" + id,900, 600);
	}
	//弹出编辑页面
	function editSeProjectDocDate2() {
		var data = theSeProjectDocTab.datagrid("getSelected");
		if(data){
			editSeProjectDocDate(data.DOC_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSeProjectDocDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeProjectDocByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSeProjectDocTab.datagrid("clearChecked");
							loadSeProjectDocDg();
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
		var data = theSeProjectDocTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].DOC_ID);
			str += (data[i].DOC_ID + ",");
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
			$.ajax("${ctx}/se/se!deleteSeProjectDocById.do?seProjectDoc.docId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSeProjectDocDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theSeProjectDocForm = $('#theSeProjectDocForm').form({
			ajax:false
		})
		
		$("#PROJECT_ID").combobox("setValue","${seProjectDoc.projectId}");
		theSeProjectDocTab = $('#theSeProjectDocdataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seProjectDocListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							queryParams: {
								PROJECT_ID: '${seProjectDoc.projectId}'
							},
							//主键字段
							idField : "DOC_ID",
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
							sortName : 'DOC_ID',
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
										field : 'DOC_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'DOC_ID',
										title : '文档ID',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'PROJECT_ID',
										title : '项目',
										width : 100,
										sortable : true
									},
									{
										field : 'DOC_NAME',
										title : '文档名称',
										width : 300,
										sortable : true
									},
									{
										field : 'DOC_CODE',
										title : '标准文档CODE',
										width : 100,
										sortable : true
									},
									{
										field : 'DOC_VERSOIN',
										title : '版本',
										width : 100,
										sortable : true
									},
									{
										field : 'DOC_DESC',
										title : '文档说明',
										width : 100,
										sortable : true
									},
									{
										field : 'UPLOADER',
										title : '上传人',
										width : 100,
										sortable : true
									},
									{
										field : 'UPLOAD_TIME',
										title : '上传时间',
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
											var editStr =  '<a  href="#" title="编辑" onclick="editSeProjectDocDate(\'' + row.DOC_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.DOC_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSeProjectDocQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSeProjectDocObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSeProjectDocDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSeProjectDocDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSeProjectDocDate(rowData.DOC_ID);
							}
							
						})

	})

	

var querySeProjectDocState = "open"
function hideSeProjectDocQuery(){
	if("open" == querySeProjectDocState){
		$('body').layout('collapse','north');
		querySeProjectDocState = "close";
	}else{
		$('body').layout('expand','north');
		querySeProjectDocState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSeProjectDocForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 文档ID -->
									<td>
										<span class="Fieldname">文档ID：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DOC_ID"
											id="DOC_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>


									<!-- 项目ID -->
									<td>
										<span class="Fieldname">项目：</span>
									</td>
									<td>
									
										<s:select id="PROJECT_ID" 
name="PROJECT_ID"  
cssClass="easyui-combobox"  
list="#request.projectList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>

									</td>
									<!-- 文档名称 -->
									<td>
										<span class="Fieldname">文档名称：</span>
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
									<!-- 标准文档CODE -->
									<td>
										<span class="Fieldname">标准文档CODE：</span>
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
									<!-- 
									<td>
										<span class="Fieldname">版本：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DOC_VERSOIN"
											id="DOC_VERSOIN"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">文档说明：</span>
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
									<td>
										<span class="Fieldname">上传人：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="UPLOADER"
											id="UPLOADER"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">上传时间：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="UPLOAD_TIME"
											id="UPLOAD_TIME"
											type="text" 
											style="width:100px;"
											 />
									</td>
									-->
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeProjectDocDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeProjectDocForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSeProjectDocdataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
