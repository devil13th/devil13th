<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSeTraceDefectTab;

	var theSeTraceDefectForm;
	//刷新表格
	function reloadSeTraceDefectDg() {
		theSeTraceDefectTab.datagrid("reload");
	}
	//重新查询
	function loadSeTraceDefectDg() {
		var jsonData = $("#theSeTraceDefectForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSeTraceDefectTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSeTraceDefectForm(){
		theSeTraceDefectForm.form("clear");
		loadSeTraceDefectDg();
	}

	//弹出保存页面方法
	function addSeTraceDefectObj(t) {
		showWin("${ctx}/se/se!seTraceDefectForm.do", 1080, 600);
	}
	//弹出编辑页面
	function editSeTraceDefectDate(id) {
		showWin("${ctx}/se/se!seTraceDefectForm.do?seTraceDefect.defectId=" + id,1080, 600);
	}
	//弹出编辑页面
	function editSeTraceDefectDate2() {
		var data = theSeTraceDefectTab.datagrid("getSelected");
		if(data){
			editSeTraceDefectDate(data.DEFECT_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSeTraceDefectDates(){
		var checkedIds = getDefectCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeTraceDefectByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSeTraceDefectTab.datagrid("clearChecked");
							loadSeTraceDefectDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
		
	}
	//获取勾选的行
	function getDefectCheckedIds(){
		var data = theSeTraceDefectTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].DEFECT_ID);
			str += (data[i].DEFECT_ID + ",");
		};
		if(str != ""){
			str = str.substring(0,str.length - 1);
			return str;
		}else{
			return "";
		}
		
	}
	//删除操作
	function deleteDefectData(id){
		if(confirm("确定删除此条记录么?")){
			$.ajax("${ctx}/se/se!deleteSeTraceDefectById.do?seTraceDefect.defectId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSeTraceDefectDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theSeTraceDefectForm = $('#theSeTraceDefectForm').form({
			ajax:false
		})
		
		
		theSeTraceDefectTab = $('#theSeTraceDefectdataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seTraceDefectListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "DEFECT_ID",
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
							sortName : 'DEFECT_ID',
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
										field : 'DEFECT_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'DEFECT_ID',
										title : '记录id',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'TRACE_ID',
										title : '矩阵id',
										width : 100,
										sortable : true
									},
									{
										field : 'DEFECT_DESC',
										title : '缺陷描述',
										width : 100,
										sortable : true
									},
									{
										field : 'DEFECT_PIC',
										title : '截图',
										width : 100,
										sortable : true
									},
									{
										field : 'DEFECT_CLASSIFY',
										title : '缺陷分类',
										width : 100,
										sortable : true
									},
									{
										field : 'DEFECT_STATUS',
										title : '缺陷状态',
										width : 100,
										sortable : true
									},
									{
										field : 'DEVELOPER',
										title : '开发人员',
										width : 100,
										sortable : true
									},
									{
										field : 'TEST_USER',
										title : '测试人员',
										width : 100,
										sortable : true
									},
									{
										field : 'CREATE_TIME',
										title : '创建时间',
										width : 100,
										sortable : true
									},
									{
										field : 'UPDATE_TIME',
										title : '更新时间',
										width : 100,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width : 80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editSeTraceDefectDate(\'' + row.DEFECT_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteDefectData(\'' + row.DEFECT_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSeTraceDefectQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSeTraceDefectObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSeTraceDefectDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSeTraceDefectDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSeTraceDefectDate(rowData.DEFECT_ID);
							}
							
						})

	})

	

var querySeTraceDefectState = "open"
function hideSeTraceDefectQuery(){
	if("open" == querySeTraceDefectState){
		$('body').layout('collapse','north');
		querySeTraceDefectState = "close";
	}else{
		$('body').layout('expand','north');
		querySeTraceDefectState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSeTraceDefectForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 记录id -->
									<td>
										<span class="Fieldname">记录id：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DEFECT_ID"
											id="DEFECT_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>


									<!-- 矩阵id -->
									<td>
										<span class="Fieldname">矩阵id：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="TRACE_ID"
											id="TRACE_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 缺陷描述 -->
									<td>
										<span class="Fieldname">缺陷描述：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DEFECT_DESC"
											id="DEFECT_DESC"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 截图 -->
									<td>
										<span class="Fieldname">截图：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DEFECT_PIC"
											id="DEFECT_PIC"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 缺陷分类 -->
									<td>
										<span class="Fieldname">缺陷分类：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DEFECT_CLASSIFY"
											id="DEFECT_CLASSIFY"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 缺陷状态 -->
									<td>
										<span class="Fieldname">缺陷状态：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DEFECT_STATUS"
											id="DEFECT_STATUS"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 开发人员 -->
									<td>
										<span class="Fieldname">开发人员：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="DEVELOPER"
											id="DEVELOPER"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 测试人员 -->
									<td>
										<span class="Fieldname">测试人员：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="TEST_USER"
											id="TEST_USER"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 创建时间 -->
									<td>
										<span class="Fieldname">创建时间：</span>
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
									<!-- 更新时间 -->
									<td>
										<span class="Fieldname">更新时间：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-datebox" 
											name="UPDATE_TIME"
											id="UPDATE_TIME"
											type="text" 
											style="width:100px;"
											 />
									</td>
								</tr>
							</table>
						</div>
						<div class="btnArea">
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeTraceDefectDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeTraceDefectForm()">重置</a>  
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSeTraceDefectdataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
