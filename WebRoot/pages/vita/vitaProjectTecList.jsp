<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theVitaProjectTecTab;

	var theVitaProjectTecForm;
	//刷新表格
	function reloadVitaProjectTecDg() {
		theVitaProjectTecTab.datagrid("reload");
	}
	//重新查询
	function loadVitaProjectTecDg() {
		var jsonData = $("#theVitaProjectTecForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theVitaProjectTecTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetVitaProjectTecForm(){
		theVitaProjectTecForm.form("clear");
		loadVitaProjectTecDg();
	}

	//弹出保存页面方法
	function addVitaProjectTecObj(t) {
		showWin("${ctx}/vita/vita!vitaProjectTecForm.do", 900, 600);
	}
	//弹出编辑页面
	function editVitaProjectTecDate(id) {
		showWin("${ctx}/vita/vita!vitaProjectTecForm.do?vitaProjectTec.projectTecId=" + id,900, 600);
	}
	//弹出编辑页面
	function editVitaProjectTecDate2() {
		var data = theVitaProjectTecTab.datagrid("getSelected");
		if(data){
			editVitaProjectTecDate(data.PROJECT_TEC_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteVitaProjectTecDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/vita/vita!deleteVitaProjectTecByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theVitaProjectTecTab.datagrid("clearChecked");
							loadVitaProjectTecDg();
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
		var data = theVitaProjectTecTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].PROJECT_TEC_ID);
			str += (data[i].PROJECT_TEC_ID + ",");
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
			$.ajax("${ctx}/vita/vita!deleteVitaProjectTecById.do?vitaProjectTec.projectTecId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadVitaProjectTecDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theVitaProjectTecForm = $('#theVitaProjectTecForm').form({
			ajax:false
		})
		
		
		theVitaProjectTecTab = $('#theVitaProjectTecdataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/vita/vita!vitaProjectTecListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "PROJECT_TEC_ID",
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
							sortName : 'PROJECT_TEC_ID',
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
										field : 'PROJECT_TEC_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'PROJECT_TEC_ID',
										title : '',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'PROJECT_HIS_ID',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'TEC_NAME',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'TEC_CLASSIFY',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'IS_VALID',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'CREATE_TIME',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editVitaProjectTecDate(\'' + row.PROJECT_TEC_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.PROJECT_TEC_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideVitaProjectTecQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addVitaProjectTecObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editVitaProjectTecDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteVitaProjectTecDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editVitaProjectTecDate(rowData.PROJECT_TEC_ID);
							}
							
						})

	})

	

var queryVitaProjectTecState = "open"
function hideVitaProjectTecQuery(){
	if("open" == queryVitaProjectTecState){
		$('body').layout('collapse','north');
		queryVitaProjectTecState = "close";
	}else{
		$('body').layout('expand','north');
		queryVitaProjectTecState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theVitaProjectTecForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!--  -->
									<td>
										<span class="Fieldname">：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="PROJECT_TEC_ID"
											id="PROJECT_TEC_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>


									<!--  -->
									<td>
										<span class="Fieldname">：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="PROJECT_HIS_ID"
											id="PROJECT_HIS_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!--  -->
									<td>
										<span class="Fieldname">：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="TEC_NAME"
											id="TEC_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!--  -->
									<td>
										<span class="Fieldname">：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="TEC_CLASSIFY"
											id="TEC_CLASSIFY"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!--  -->
									<td>
										<span class="Fieldname">：</span>
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
									</td>
									<!--  -->
									<td>
										<span class="Fieldname">：</span>
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
									</td>
								</tr>
							</table>
						</div>
						<div class="btnArea">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadVitaProjectTecDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetVitaProjectTecForm()">重置</a>  
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theVitaProjectTecdataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
