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
		showWin("${ctx}/se/se!seMapProjectUserForm.do", 900, 700);
	}
	//弹出编辑页面
	function editData(id) {
		showWin("${ctx}/se/se!seMapProjectUserForm.do?seMapProjectUser.rid=" + id,900, 700);
	}
	//弹出编辑页面
	function editData2() {
		var data = tab.datagrid("getSelected");
		if(data){
			editData(data.RID);
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
			$.ajax("${ctx}/se/se!deleteSeMapProjectUserByIds.do?ids=" + checkedIds + "&_r="+Math.random,
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
			//alert(data[i].RID);
			str += (data[i].RID + ",");
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
			$.ajax("${ctx}/se/se!deleteSeMapProjectUserById.do?seMapProjectUser.rid=" + id + "&_r="+Math.random,
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
							url : '${ctx}/se/se!seMapProjectUserListGetDate.do?r=' + Math.random(),
							queryParams:{PROJECT_ID:"${seProjectInfo.projectId}"},
							//斑马纹
							striped : true,
							//主键字段
							idField : "RID",
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
							sortName : 'RID',
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
										field : 'RID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'RID',
										title : '',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'PROJECT_ID',
										title : '项目ID',
										width : 100,
										sortable : true
									},
									{
										field : 'USER_ID',
										title : '用户ID',
										width : 100,
										sortable : true
									},
									{
										field : 'USER_NAME',
										title : '用户姓名',
										width : 100,
										sortable : true
									},
									{
										field : 'USER_COST',
										title : '个人成本',
										width : 100,
										sortable : true
									},
									{
										field : 'USER_POS',
										title : '岗位',
										width : 100,
										sortable : true
									},
									{
										field : 'USER_LEVEL',
										title : '用户级别',
										width : 100,
										sortable : true
									},
									{
										field : 'ON_POSITION',
										title : '是否在岗',
										width : 50,
										sortable : true
									},
									
									{
										field : 'PLAN_DUTY',
										title : '计划到港日期',
										width : 100,
										sortable : true
									},
									{
										field : 'PLAN_UNDUTY',
										title : '计划离岗日期',
										width : 100,
										sortable : true
									},
									{
										field : 'ACT_DUTY',
										title : '实际到岗日期',
										width : 100,
										sortable : true
									},
									{
										field : 'ACT_UNDUTY',
										title : '实际离岗日期',
										width : 100,
										sortable : true
									}/*,
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editData(\'' + row.RID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.RID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} */
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
								editData(rowData.RID);
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


									<!-- 用户ID -->
									<td>
										<span class="Fieldname">用户ID：</span>
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
									<!-- 用户姓名 -->
									<td>
										<span class="Fieldname">用户姓名：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="USER_NAME"
											id="USER_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 个人成本 -->
									<td>
										<span class="Fieldname">个人成本：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-numberbox" 
											name="USER_COST"
											id="USER_COST"
											type="text" 
											precision="1" max="100" min="0"
											style="width:150px;"
											 />
									</td>
									<!-- 岗位 -->
									<td>
										<span class="Fieldname">岗位：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="USER_POS"
											id="USER_POS"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 用户级别 -->
									<td>
										<span class="Fieldname">用户级别：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="USER_LEVEL"
											id="USER_LEVEL"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 计划到港日期 -->
									<td>
										<span class="Fieldname">计划到港日期：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="PLAN_DUTY"
											id="PLAN_DUTY"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<!-- 计划离岗日期 -->
									<td>
										<span class="Fieldname">计划离岗日期：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="PLAN_UNDUTY"
											id="PLAN_UNDUTY"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<!-- 实际到岗日期 -->
									<td>
										<span class="Fieldname">实际到岗日期：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="ACT_DUTY"
											id="ACT_DUTY"
											type="text" 
											style="width:100px;"
											 />
									</td>
									<!-- 实际离岗日期 -->
									<td>
										<span class="Fieldname">实际离岗日期：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="ACT_UNDUTY"
											id="ACT_UNDUTY"
											type="text" 
											style="width:100px;"
											 />
									</td>
								</tr>
							</table>
						</div>
						<div class="btnArea">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetForm()">重置</a>  
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="dataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
