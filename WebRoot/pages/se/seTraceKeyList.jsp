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
		var traceId = $("#TRACE_ID").val();
		showWin("${ctx}/se/se!seTraceKeyForm.do?seTraceKey.traceId=" + traceId, 900, 700);
	}
	//弹出编辑页面
	function editData(id) {
		showWin("${ctx}/se/se!seTraceKeyForm.do?seTraceKey.kid=" + id,900, 700);
	}
	//弹出编辑页面
	function editData2() {
		var data = tab.datagrid("getSelected");
		if(data){
			editData(data.KID);
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
			$.ajax("${ctx}/se/se!deleteSeTraceKeyByIds.do?ids=" + checkedIds + "&_r="+Math.random,
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
			//alert(data[i].KID);
			str += (data[i].KID + ",");
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
			$.ajax("${ctx}/se/se!deleteSeTraceKeyById.do?seTraceKey.kid=" + id + "&_r="+Math.random,
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
		
		
		tab = $('#dataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seTraceKeyListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "KID",
							//参数
							queryParams:{
								TRACE_ID:"${seTraceKey.traceId}"
							},
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
							sortName : 'KID',
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
										field : 'KID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'KID',
										title : '主键',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'TRACE_NAME',
										title : '矩阵名称',
										width : 100,
										sortable : true
									},
									{
										field : 'KNAME',
										title : '属性名称',
										width : 100,
										sortable : true
									},
									{
										field : 'KCODE',
										title : '属性代码',
										width : 100,
										sortable : true
									},
									{
										field : 'KTYPE',
										title : '属性类型',
										width : 100,
										sortable : true
									},
									{
										field : 'KDESC',
										title : '属性备注',
										width : 100,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width : 100,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editData(\'' + row.KID + '\')" >编辑</a>'
											var nbspStr = "&nbsp;";
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.KID + '\')" >删除</a>';
											return editStr + nbspStr + deleteStr;
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
								editData(rowData.KID);
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
					<input type="hidden" id="TRACE_ID" name="TRACE_ID" value="${seTraceKey.traceId}" />
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 属性名称 -->
									<td>
										<span class="Fieldname">属性名称：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="KNAME"
											id="KNAME"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<!-- 属性代码(小写英文字母) -->
									<td>
										<span class="Fieldname">属性代码(小写英文字母)：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="KCODE"
											id="KCODE"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<!-- 属性类型 STRING:字符串 CLOB:大文本 DIC:字典  INT:整数  FLOAT:小数  DATE:日期 -->
									<td>
										<span class="Fieldname">属性类型</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="KTYPE"
											id="KTYPE"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<!-- 属性备注 -->
									<td>
										<span class="Fieldname">属性备注：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="KDESC"
											id="KDESC"
											type="text" 
											style="width:100px;"
											 />
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
