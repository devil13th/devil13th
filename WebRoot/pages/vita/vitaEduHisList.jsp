<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theVitaEduHisTab;

	var theVitaEduHisForm;
	//刷新表格
	function reloadVitaEduHisDg() {
		theVitaEduHisTab.datagrid("reload");
	}
	//重新查询
	function loadVitaEduHisDg() {
		var jsonData = $("#theVitaEduHisForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theVitaEduHisTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetVitaEduHisForm(){
		theVitaEduHisForm.form("clear");
		loadVitaEduHisDg();
	}

	//弹出保存页面方法
	function addVitaEduHisObj(t) {
		showWin("${ctx}/vita/vita!vitaEduHisForm.do", 900, 600);
	}
	//弹出编辑页面
	function editVitaEduHisDate(id) {
		showWin("${ctx}/vita/vita!vitaEduHisForm.do?vitaEduHis.eduHisId=" + id,900, 600);
	}
	//弹出编辑页面
	function editVitaEduHisDate2() {
		var data = theVitaEduHisTab.datagrid("getSelected");
		if(data){
			editVitaEduHisDate(data.EDU_HIS_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteVitaEduHisDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/vita/vita!deleteVitaEduHisByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theVitaEduHisTab.datagrid("clearChecked");
							loadVitaEduHisDg();
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
		var data = theVitaEduHisTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].EDU_HIS_ID);
			str += (data[i].EDU_HIS_ID + ",");
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
			$.ajax("${ctx}/vita/vita!deleteVitaEduHisById.do?vitaEduHis.eduHisId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadVitaEduHisDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theVitaEduHisForm = $('#theVitaEduHisForm').form({
			ajax:false
		})
		
		
		theVitaEduHisTab = $('#theVitaEduHisdataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/vita/vita!vitaEduHisListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "EDU_HIS_ID",
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
							sortName : 'EDU_HIS_ID',
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
										field : 'EDU_HIS_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'EDU_HIS_ID',
										title : '',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'VITA_ID',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'SCHOOL_NAME',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'BEGIN_DATE',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'FINISH_DATE',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'EDU_LEVEL',
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
											var editStr =  '<a  href="#" title="编辑" onclick="editVitaEduHisDate(\'' + row.EDU_HIS_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.EDU_HIS_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideVitaEduHisQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addVitaEduHisObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editVitaEduHisDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteVitaEduHisDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editVitaEduHisDate(rowData.EDU_HIS_ID);
							}
							
						})

	})

	

var queryVitaEduHisState = "open"
function hideVitaEduHisQuery(){
	if("open" == queryVitaEduHisState){
		$('body').layout('collapse','north');
		queryVitaEduHisState = "close";
	}else{
		$('body').layout('expand','north');
		queryVitaEduHisState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theVitaEduHisForm" method="post">
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
											name="EDU_HIS_ID"
											id="EDU_HIS_ID"
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
											name="VITA_ID"
											id="VITA_ID"
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
											name="SCHOOL_NAME"
											id="SCHOOL_NAME"
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
											name="BEGIN_DATE"
											id="BEGIN_DATE"
											type="text" 
											style="width:100px;"
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
											name="FINISH_DATE"
											id="FINISH_DATE"
											type="text" 
											style="width:100px;"
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
											name="EDU_LEVEL"
											id="EDU_LEVEL"
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
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadVitaEduHisDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetVitaEduHisForm()">重置</a>  
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theVitaEduHisdataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
