<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theVitaProjectDutyTab;

	var theVitaProjectDutyForm;
	//刷新表格
	function reloadVitaProjectDutyDg() {
		theVitaProjectDutyTab.datagrid("reload");
	}
	//重新查询
	function loadVitaProjectDutyDg() {
		var jsonData = $("#theVitaProjectDutyForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theVitaProjectDutyTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetVitaProjectDutyForm(){
		theVitaProjectDutyForm.form("clear");
		loadVitaProjectDutyDg();
	}

	//弹出保存页面方法
	function addVitaProjectDutyObj(t) {
		showWin("${ctx}/vita/vita!vitaProjectDutyForm.do", 900, 600);
	}
	//弹出编辑页面
	function editVitaProjectDutyDate(id) {
		showWin("${ctx}/vita/vita!vitaProjectDutyForm.do?vitaProjectDuty.dutyId=" + id,900, 600);
	}
	//弹出编辑页面
	function editVitaProjectDutyDate2() {
		var data = theVitaProjectDutyTab.datagrid("getSelected");
		if(data){
			editVitaProjectDutyDate(data.DUTY_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteVitaProjectDutyDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/vita/vita!deleteVitaProjectDutyByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theVitaProjectDutyTab.datagrid("clearChecked");
							loadVitaProjectDutyDg();
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
		var data = theVitaProjectDutyTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].DUTY_ID);
			str += (data[i].DUTY_ID + ",");
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
			$.ajax("${ctx}/vita/vita!deleteVitaProjectDutyById.do?vitaProjectDuty.dutyId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadVitaProjectDutyDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theVitaProjectDutyForm = $('#theVitaProjectDutyForm').form({
			ajax:false
		})
		
		
		theVitaProjectDutyTab = $('#theVitaProjectDutydataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/vita/vita!vitaProjectDutyListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "DUTY_ID",
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
							sortName : 'DUTY_ID',
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
										field : 'DUTY_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'DUTY_ID',
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
										field : 'DUTY_DESC',
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
											var editStr =  '<a  href="#" title="编辑" onclick="editVitaProjectDutyDate(\'' + row.DUTY_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.DUTY_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideVitaProjectDutyQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addVitaProjectDutyObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editVitaProjectDutyDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteVitaProjectDutyDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editVitaProjectDutyDate(rowData.DUTY_ID);
							}
							
						})

	})

	

var queryVitaProjectDutyState = "open"
function hideVitaProjectDutyQuery(){
	if("open" == queryVitaProjectDutyState){
		$('body').layout('collapse','north');
		queryVitaProjectDutyState = "close";
	}else{
		$('body').layout('expand','north');
		queryVitaProjectDutyState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theVitaProjectDutyForm" method="post">
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
											name="DUTY_ID"
											id="DUTY_ID"
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
											name="DUTY_DESC"
											id="DUTY_DESC"
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
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadVitaProjectDutyDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetVitaProjectDutyForm()">重置</a>  
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theVitaProjectDutydataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
