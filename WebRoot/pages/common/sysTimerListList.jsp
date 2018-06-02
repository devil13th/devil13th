<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSysTimerListTab;

	var theSysTimerListForm;
	//刷新表格
	function reloadSysTimerListDg() {
		theSysTimerListTab.datagrid("reload");
	}
	//重新查询
	function loadSysTimerListDg() {
		var jsonData = $("#theSysTimerListForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSysTimerListTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSysTimerListForm(){
		theSysTimerListForm.form("clear");
		loadSysTimerListDg();
	}

	//弹出保存页面方法
	function addSysTimerListObj(t) {
		showWin("${ctx}/common/common!sysTimerListForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSysTimerListDate(id) {
		showWin("${ctx}/common/common!sysTimerListForm.do?sysTimerList.timerId=" + id,900, 600);
	}
	//弹出编辑页面
	function editSysTimerListDate2() {
		var data = theSysTimerListTab.datagrid("getSelected");
		if(data){
			editSysTimerListDate(data.TIMER_ID);
		}else{
			message("请选择数据");
		}
	}
	
	
	function startTimer(){
		var data = theSysTimerListTab.datagrid("getSelected");
		if(data){
			//message(data.TIMER_ID)
			$.ajax("${ctx}/common/common!startTimer.do?id=" + data.TIMER_ID + "&_r="+Math.random(),
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "SUCCESS"){
							message('操作成功');
							loadSysTimerListDg();
						}else{
							message(str);
						};
					}
				}
			)
		}else{
			message("请选择数据");
		}
	}
	
	function pauseTimer(){
		var data = theSysTimerListTab.datagrid("getSelected");
		if(data){
			//message(data.TIMER_ID)
			$.ajax("${ctx}/common/common!pauseTimer.do?id=" + data.TIMER_ID + "&_r="+Math.random(),
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "SUCCESS"){
							message('操作成功');
							loadSysTimerListDg();
						}else{
							message(str);
						};
					}
				}
			)
		}else{
			message("请选择数据");
		}
	}
	
	function runATimeTimer(){
		var data = theSysTimerListTab.datagrid("getSelected");
		if(data){
			//message(data.TIMER_ID)
			$.ajax("${ctx}/common/common!runATimeTimer.do?id=" + data.TIMER_ID + "&_r="+Math.random(),
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "SUCCESS"){
							message('操作成功');
							//loadSysTimerListDg();
						}else{
							message(str);
						};
					}
				}
			)
		}else{
			message("请选择数据");
		}
	}
	
	function reloadTimer(){
		var data = theSysTimerListTab.datagrid("getSelected");
		if(data){
			//message(data.TIMER_ID)
			$.ajax("${ctx}/common/common!reloadTimer.do?id=" + data.TIMER_ID + "&_r="+Math.random(),
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "SUCCESS"){
							message('操作成功');
							//loadSysTimerListDg();
						}else{
							message(str);
						};
					}
				}
			)
		}else{
			message("请选择数据");
		}
	}
	
	
	
	
	function deleteSysTimerListDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			message("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/common/common!deleteSysTimerListByIds.do?ids=" + checkedIds + "&_r="+Math.random(),
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							message('操作成功');
							theSysTimerListTab.datagrid("clearChecked");
							loadSysTimerListDg();
						}else{
							message(str);
						};
					}
				}
			)
		}
		
	}
	//获取勾选的行
	function getCheckedIds(){
		var data = theSysTimerListTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//message(data[i].TIMER_ID);
			str += (data[i].TIMER_ID + ",");
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
			$.ajax("${ctx}/common/common!deleteSysTimerListById.do?sysTimerList.timerId=" + id + "&_r="+Math.random(),
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							message('操作成功');
							loadSysTimerListDg();
						}else{
							message(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theSysTimerListForm = $('#theSysTimerListForm').form({
			ajax:false
		})
		
		
		theSysTimerListTab = $('#theSysTimerListdataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/common/common!sysTimerListListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "TIMER_ID",
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
							sortName : 'TIMER_ID',
							//排序方式
							sortOrder : "desc",
							//pageNumber:5,s
							rownumbers : true,//行号 
							//分页工具所在位置
							pagePosition : "bottom",
							checkOnSelect:true,
							selectOnCheck:true,
							//冻结的列
							frozenColumns : [ [
							//选择框		
									/*{
										field : 'TIMER_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'TIMER_ID',
										title : '主键',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'TIMER_CODE',
										title : '标识',
										width : 100,
										sortable : true
									},
									{
										field : 'TIMER_GROUP',
										title : '所属组',
										width : 100,
										sortable : true
									},
									{
										field : 'TIMER_NAME',
										title : '名称',
										width : 100,
										sortable : true
									},
									{
										field : 'TIMER_DESC',
										title : '描述',
										width : 200,
										sortable : true
									},
									{
										field : 'TIMER_CLASS_NAME',
										title : '类全名',
										width : 200,
										sortable : true
									},
									{
										field : 'EXECUTION_PLAN',
										title : '执行计划',
										width : 100,
										sortable : true
									},
									{
										field : 'START_TYPE',
										title : '启动方式',
										width : 100,
										sortable : true
									},
									{
										field : 'RUN_STATE',
										title : '运行状态',
										width : 100,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editSysTimerListDate(\'' + row.TIMER_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.TIMER_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSysTimerListQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSysTimerListObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSysTimerListDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSysTimerListDates()}
							},{
								text:'启动',
								iconCls:'icon-edit',
								handler:function(){startTimer()}
							},{
								text:'暂停',
								iconCls:'icon-edit',
								handler:function(){pauseTimer()}
							},{
								text:'执行一次',
								iconCls:'icon-edit',
								handler:function(){runATimeTimer()}
							},{
								text:'重新加载定时器',
								iconCls:'icon-edit',
								handler:function(){reloadTimer()}
							}],
							
							
							
							
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSysTimerListDate(rowData.TIMER_ID);
							}
							
						})

	})

	

var querySysTimerListState = "open"
function hideSysTimerListQuery(){
	if("open" == querySysTimerListState){
		$('body').layout('collapse','north');
		querySysTimerListState = "close";
	}else{
		$('body').layout('expand','north');
		querySysTimerListState = "open";
	}
	
}
		

	function message(text){
		$.messager.show({
			title:'消息',
			msg:text,
			showType:'show'
		});
	}


</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSysTimerListForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 标识 -->
									<td>
										<span class="Fieldname">关键字：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="TIMER_CODE"
											id="TIMER_CODE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 所属组 -->
									<td>
										<span class="Fieldname">所属组：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="TIMER_GROUP"
											id="TIMER_GROUP"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">：状态</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="START_TYPE"
											id="START_TYPE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSysTimerListDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSysTimerListForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSysTimerListdataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
