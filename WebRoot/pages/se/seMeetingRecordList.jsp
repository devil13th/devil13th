<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSeMeetingRecordTab;

	var theSeMeetingRecordForm;
	//刷新表格
	function reloadSeMeetingRecordDg() {
		theSeMeetingRecordTab.datagrid("reload");
	}
	//重新查询
	function loadSeMeetingRecordDg() {
		var jsonData = $("#theSeMeetingRecordForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSeMeetingRecordTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSeMeetingRecordForm(){
		theSeMeetingRecordForm.form("clear");
		loadSeMeetingRecordDg();
	}

	//弹出保存页面方法
	function addSeMeetingRecordObj(t) {
		showWin("${ctx}/se/se!seMeetingRecordForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSeMeetingRecordDate(id) {
		showWin("${ctx}/se/se!seMeetingRecordForm.do?seMeetingRecord.itemId=" + id,900, 600);
	}
	//弹出编辑页面
	function editSeMeetingRecordDate2() {
		var data = theSeMeetingRecordTab.datagrid("getSelected");
		if(data){
			editSeMeetingRecordDate(data.ITEM_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSeMeetingRecordDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeMeetingRecordByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSeMeetingRecordTab.datagrid("clearChecked");
							loadSeMeetingRecordDg();
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
		var data = theSeMeetingRecordTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].ITEM_ID);
			str += (data[i].ITEM_ID + ",");
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
			$.ajax("${ctx}/se/se!deleteSeMeetingRecordById.do?seMeetingRecord.itemId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSeMeetingRecordDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theSeMeetingRecordForm = $('#theSeMeetingRecordForm').form({
			ajax:false
		})
		
		
		theSeMeetingRecordTab = $('#theSeMeetingRecorddataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seMeetingRecordListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "ITEM_ID",
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
							sortName : 'ITEM_ID',
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
										field : 'ITEM_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'ITEM_ID',
										title : '条目ID',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'MEETING_CODE',
										title : '会议CODE',
										width : 100,
										sortable : true
									},
									{
										field : 'ITEM_ISSUER',
										title : '提出人',
										width : 100,
										sortable : true
									},
									{
										field : 'ITEM_CLASSIFY',
										title : '分类',
										width : 100,
										sortable : true
									},
									{
										field : 'ITEM_DESC',
										title : '描述',
										width : 100,
										sortable : true
									},
									{
										field : 'ITEM_PERFORMER',
										title : '执行人',
										width : 100,
										sortable : true
									},
									{
										field : 'ITEM_STATUS',
										title : '状态',
										width : 100,
										sortable : true
									},
									{
										field : 'IS_DELETE',
										title : '是否删除',
										width : 100,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editSeMeetingRecordDate(\'' + row.ITEM_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.ITEM_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSeMeetingRecordQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSeMeetingRecordObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSeMeetingRecordDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSeMeetingRecordDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSeMeetingRecordDate(rowData.ITEM_ID);
							}
							
						})

	})

	

var querySeMeetingRecordState = "open"
function hideSeMeetingRecordQuery(){
	if("open" == querySeMeetingRecordState){
		$('body').layout('collapse','north');
		querySeMeetingRecordState = "close";
	}else{
		$('body').layout('expand','north');
		querySeMeetingRecordState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSeMeetingRecordForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 条目ID -->
									<td>
										<span class="Fieldname">条目ID：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ITEM_ID"
											id="ITEM_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>


									<!-- 会议CODE -->
									<td>
										<span class="Fieldname">会议CODE：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="MEETING_CODE"
											id="MEETING_CODE"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 提出人 -->
									<td>
										<span class="Fieldname">提出人：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ITEM_ISSUER"
											id="ITEM_ISSUER"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 分类 -->
									<td>
										<span class="Fieldname">分类：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ITEM_CLASSIFY"
											id="ITEM_CLASSIFY"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 描述 -->
									<td>
										<span class="Fieldname">描述：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ITEM_DESC"
											id="ITEM_DESC"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 执行人 -->
									<td>
										<span class="Fieldname">执行人：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ITEM_PERFORMER"
											id="ITEM_PERFORMER"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 状态 -->
									<td>
										<span class="Fieldname">状态：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ITEM_STATUS"
											id="ITEM_STATUS"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 是否删除 -->
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
									</td>
								</tr>
							</table>
						</div>
						<div class="btnArea">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeMeetingRecordDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeMeetingRecordForm()">重置</a>  
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSeMeetingRecorddataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
