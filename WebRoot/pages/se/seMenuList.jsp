<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSeMenuTab;

	var theSeMenuForm;
	
	
	function reloadSeMenuTreeNode(id){
		theSeMenuTab.treegrid('reload', id);
	}
	//刷新表格
	function reloadSeMenuDg() {
		theSeMenuTab.treegrid("reload");
	}
	//重新查询
	function loadSeMenuDg() {
		var jsonData = $("#theSeMenuForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSeMenuTab.treegrid("load", params);
	}
	//重置表单后查询
	function resetSeMenuForm(){
		theSeMenuForm.form("clear");
		loadSeMenuDg();
	}

	//弹出保存页面方法
	function addSeMenuObj(t) {
		var data = theSeMenuTab.treegrid("getSelected");
		var parentId = "";
		if(data){
			parentId = data.MENU_ID;
			
			
			
			theSeMenuTab.treegrid('append',{
				parent: data.MENU_ID,  // the node has a 'id' value that defined through 'idField' property
				data: [{
					MENU_ID: Math.random(),
					MENU_NAME: '新建节点'
				}]
			});
			
			
		}
		showWin("${ctx}/se/se!seMenuForm.do?id=" + parentId , 900, 600);
	}
	//弹出编辑页面
	function editSeMenuDate(id) {
		showWin("${ctx}/se/se!seMenuForm.do?seMenu.menuId=" + id,900, 600);
	}
	//弹出编辑页面
	function editSeMenuDate2() {
		var data = theSeMenuTab.treegrid("getSelected");
		if(data){
			editSeMenuDate(data.MENU_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSeMenuDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeMenuByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSeMenuTab.treegrid("clearChecked");
							loadSeMenuDg();
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
		var data = theSeMenuTab.treegrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].MENU_ID);
			str += (data[i].MENU_ID + ",");
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
			$.ajax("${ctx}/se/se!deleteSeMenuById.do?seMenu.menuId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSeMenuDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	function formatterIsLeaf(value,row,index){
		if (value == '1'){
			return '是'; 
		} else {
			return '否';
		}
	}
	
	function formatterIsValid(value,row,index){
		if (value == '1'){
			return '有效'; 
		} else {
			return '无效';
		}
	}
	
	
	$(function() {
		theSeMenuForm = $('#theSeMenuForm').form({
			ajax:false
		})
		
		
		theSeMenuTab = $('#theSeMenudataTable')
				.treegrid(
						{
							title:'菜单管理',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seMenuListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "MENU_ID",
							//宽度自适应
							//fitColumns: true,
							//表单提交方式
							method : "post",
							//是否只能选择一行
							singleSelect : true,
							nowrap : true,
							fit:true,
							border:false,
							//高度
							//height:450,
							//宽度
							//width:860,
							treeField:'MENU_NAME',
							//是否分页
							pagination : true,
							//分页信息
							pageSize : 10,
							//每页显示条目下拉菜单
							pageList : [ 5, 10, 20, 50, 100 ],
							//排序的列
							sortName : 'MENU_ID',
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
										field : 'MENU_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'MENU_ID',
										title : '菜单ID',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'MENU_NAME',
										title : '菜单名称',
										width : 200,
										sortable : true
									},
									{
										field : 'MENU_NAME_EN',
										title : '菜单英文名称',
										width : 200,
										sortable : true
									},
									{
										field : 'MENU_URL',
										title : '菜单URL',
										width : 200,
										sortable : true
									},
									{
										field : 'MENU_ORDER',
										title : '排序号',
										width : 60,
										sortable : true
									},
									/*{
										field : 'MENU_DESC',
										title : '功能描述',
										width : 100,
										sortable : true
									},*/
									{
										field : 'MENU_ICO',
										title : '图标样式',
										width : 200,
										sortable : true
									},
									{
										field : 'OPEN_TYPE',
										title : '打开方式',
										width : 100,
										sortable : true
									},
									{
										field : 'TREE_CODE',
										title : '树形代码',
										width : 200,
										sortable : true
									},
									{
										field : 'IS_LEAF',
										title : '是否叶子节点',
										width : 100,
										sortable : true,
										formatter:formatterIsLeaf,
										align:'center'
									},
									
									{
										field : 'IS_VALID',
										title : '是否有效',
										width : 100,
										sortable : true,
										formatter:formatterIsValid,
										align:'center'
									},
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editSeMenuDate(\'' + row.MENU_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.MENU_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSeMenuObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSeMenuDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSeMenuDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSeMenuDate(rowData.MENU_ID);
							},
							onContextMenu:function(e,row){
								e.preventDefault();
								theSeMenuTab.datagrid('selectRow',row.MENU_ID);
								$("#mm").menu("show",{
									left:e.pageX,
									top:e.pageY
								})
							}
						})

	})

	

var querySeMenuState = "open"
function hideSeMenuQuery(){
	if("open" == querySeMenuState){
		$('body').layout('collapse','north');
		querySeMenuState = "close";
	}else{
		$('body').layout('expand','north');
		querySeMenuState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
	<%-- 
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSeMenuForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 菜单ID -->
									<td>
										<span class="Fieldname">菜单ID：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MENU_ID"
											id="MENU_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>


									<!-- 菜单名称 -->
									<td>
										<span class="Fieldname">菜单名称：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MENU_NAME"
											id="MENU_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 树形代码 -->
									<td>
										<span class="Fieldname">树形代码：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="TREE_CODE"
											id="TREE_CODE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 是否叶子节点 -->
									<td>
										<span class="Fieldname">是否叶子节点：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="IS_LEAF"
											id="IS_LEAF"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 菜单URL -->
									<td>
										<span class="Fieldname">菜单URL：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MENU_URL"
											id="MENU_URL"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 功能描述 -->
									<td>
										<span class="Fieldname">功能描述：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MENU_DESC"
											id="MENU_DESC"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 是否有效 -->
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
											style="width:150px;"
											 />
									</td>
									<!-- 图标样式 -->
									<td>
										<span class="Fieldname">图标样式：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MENU_ICO"
											id="MENU_ICO"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 打开方式 -->
									<td>
										<span class="Fieldname">打开方式：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="OPEN_TYPE"
											id="OPEN_TYPE"
											type="text" 
											style="width:150px;"
											 />
									</td>
								</tr>
							</table>
						</div>
						<div class="btnArea">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeMenuDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeMenuForm()">重置</a>  
						</div>
				</form>
		</div>
		
		 --%>
		<div data-options="region:'center'">
			
				<table id="theSeMenudataTable">

				</table>
		</div>
		
				
				
		<div id="mm" class="easyui-menu" style="width: 120px;">
			<div data-options="iconCls:'icon-add'" onclick="addSeMenuObj('root')">
				新增根菜单
			</div>
			<div data-options="iconCls:'icon-add'" onclick="addSeMenuObj()">
				新增子菜单
			</div>
			<div class="menu-sep"></div>
			<div data-options="iconCls:'icon-edit'" onclick="editSeMenuDate2()">
				编辑菜单
			</div>
			<div data-options="iconCls:'icon-01'" onclick="deleteSeMenuDates()">
				删除菜单
			</div>
			
			
		</div>
	</body>

</html>
