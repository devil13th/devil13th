<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSeDayPlanTab;

	var theSeDayPlanForm;
	//刷新表格
	function reloadSeDayPlanDg() {
		theSeDayPlanTab.datagrid("reload");
	}
	//重新查询
	function loadSeDayPlanDg() {
		var jsonData = $("#theSeDayPlanForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSeDayPlanTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSeDayPlanForm(){
		theSeDayPlanForm.form("clear");
		loadSeDayPlanDg();
	}

	//弹出保存页面方法
	function addSeDayPlanObj(t) {
		showWin("${ctx}/se/se!seDayPlanForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSeDayPlanDate(id) {
		showWin("${ctx}/se/se!seDayPlanForm.do?seDayPlan.dayPlanId=" + id,900, 600);
	}
	//弹出编辑页面
	function editSeDayPlanDate2() {
		var data = theSeDayPlanTab.datagrid("getSelected");
		if(data){
			editSeDayPlanDate(data.DAY_PLAN_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSeDayPlanDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeDayPlanByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSeDayPlanTab.datagrid("clearChecked");
							loadSeDayPlanDg();
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
		var data = theSeDayPlanTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].DAY_PLAN_ID);
			str += (data[i].DAY_PLAN_ID + ",");
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
			$.ajax("${ctx}/se/se!deleteSeDayPlanById.do?seDayPlan.dayPlanId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSeDayPlanDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theSeDayPlanForm = $('#theSeDayPlanForm').form({
			ajax:false
		})
		
		
		theSeDayPlanTab = $('#theSeDayPlandataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seDayPlanListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "DAY_PLAN_ID",
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
							sortName : 'DAY_PLAN_ID',
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
										field : 'DAY_PLAN_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'DAY_PLAN_ID',
										title : '主键',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'PLAN_CONTENT',
										title : '日计划内容',
										width : 300,
										sortable : true
									},
									{
										field : 'USER_ID',
										title : '所属人员',
										width : 100,
										sortable : true
									},
									{
										field : 'PLAN_DATE',
										title : '所属日期',
										width : 100,
										sortable : true
									},
									/*{
										field : 'PLAN_REMARK',
										title : '备注',
										width : 100,
										sortable : true
									},*/
									{
										field : 'STATUS',
										title : '状态',
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
											var editStr =  '<a  href="#" title="编辑" onclick="editSeDayPlanDate(\'' + row.DAY_PLAN_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.DAY_PLAN_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSeDayPlanQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSeDayPlanObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSeDayPlanDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSeDayPlanDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSeDayPlanDate(rowData.DAY_PLAN_ID);
							}
							
						})

	})

	

var querySeDayPlanState = "open"
function hideSeDayPlanQuery(){
	if("open" == querySeDayPlanState){
		$('body').layout('collapse','north');
		querySeDayPlanState = "close";
	}else{
		$('body').layout('expand','north');
		querySeDayPlanState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSeDayPlanForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 主键 
									<td>
										<span class="Fieldname">主键：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DAY_PLAN_ID"
											id="DAY_PLAN_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>-->


									<!-- 日计划内容 -->
									<td>
										<span class="Fieldname">日计划内容：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="PLAN_CONTENT"
											id="PLAN_CONTENT"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 所属人员 -->
									<td>
										<span class="Fieldname">所属人员：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="USER_ID"
											id="USER_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 所属日期 -->
									<td>
										<span class="Fieldname">所属日期：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="PLAN_DATE"
											id="PLAN_DATE"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<!-- 备注
									<td>
										<span class="Fieldname">备注：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="PLAN_REMARK"
											id="PLAN_REMARK"
											type="text" 
											style="width:150px;"
											 />
									</td> -->
									<!-- 状态 -->
									<td>
										<span class="Fieldname">状态：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="STATUS"
											id="STATUS"
											type="text" 
											style="width:150px;"
											 />
									</td>
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
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeDayPlanDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeDayPlanForm()">重置</a>  
									</td>
								</tr>
								
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
				<table id="theSeDayPlandataTable">
				</table>
		</div>
		
				
				
		
	</body>

</html>
