<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSeAuthTab;

	var theSeAuthForm;
	//刷新表格
	function reloadSeAuthDg() {
		theSeAuthTab.datagrid("reload");
	}
	//重新查询
	function loadSeAuthDg() {
		var jsonData = $("#theSeAuthForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSeAuthTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSeAuthForm(){
		theSeAuthForm.form("clear");
		loadSeAuthDg();
	}

	//弹出保存页面方法
	function addSeAuthObj(t) {
		showWin("${ctx}/se/se!seAuthForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSeAuthDate(id) {
		showWin("${ctx}/se/se!seAuthForm.do?seAuth.authCode=" + id,900, 600);
	}
	//弹出编辑页面
	function editSeAuthDate2() {
		var data = theSeAuthTab.datagrid("getSelected");
		if(data){
			editSeAuthDate(data.AUTH_CODE);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSeAuthDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeAuthByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSeAuthTab.datagrid("clearChecked");
							loadSeAuthDg();
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
		var data = theSeAuthTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].AUTH_CODE);
			str += (data[i].AUTH_CODE + ",");
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
			$.ajax("${ctx}/se/se!deleteSeAuthById.do?seAuth.authCode=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSeAuthDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theSeAuthForm = $('#theSeAuthForm').form({
			ajax:false
		})
		
		
		theSeAuthTab = $('#theSeAuthdataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seAuthListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "AUTH_CODE",
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
							sortName : 'AUTH_CODE',
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
										field : 'AUTH_CODE',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'AUTH_CODE',
										title : '标记',
										width:250
									}
									] ],
							columns : [ [
									{
										field : 'AUTH_DESC',
										title : '说明',
										width : 300,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editSeAuthDate(\'' + row.AUTH_CODE + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.AUTH_CODE + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSeAuthQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSeAuthObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSeAuthDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSeAuthDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSeAuthDate(rowData.AUTH_CODE);
							}
							
						})

	})

	

var querySeAuthState = "open"
function hideSeAuthQuery(){
	if("open" == querySeAuthState){
		$('body').layout('collapse','north');
		querySeAuthState = "close";
	}else{
		$('body').layout('expand','north');
		querySeAuthState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSeAuthForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 标记 -->
									<td>
										<span class="Fieldname">标记：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="AUTH_CODE"
											id="AUTH_CODE"
											type="text" 
											style="width:150px;"
											 />
									</td>


									<!-- 说明 -->
									<td>
										<span class="Fieldname">说明：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="AUTH_DESC"
											id="AUTH_DESC"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeAuthDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeAuthForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSeAuthdataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
