<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSeMeetingTab;

	var theSeMeetingForm;
	
	
	var input_project_list_setting ={
			url:'${ctx}/common/common!queryProjectListJsonStr.do',
			valueField:'value',
			textField:'text',
			onChange:function(){loadSeMeetingDg()}
	};
	
	
	//刷新表格
	function reloadSeMeetingDg() {
		theSeMeetingTab.datagrid("reload");
	}
	//重新查询
	function loadSeMeetingDg() {
		var jsonData = $("#theSeMeetingForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSeMeetingTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSeMeetingForm(){
		theSeMeetingForm.form("clear");
		loadSeMeetingDg();
	}

	//弹出保存页面方法
	function addSeMeetingObj(t) {
		showWin("${ctx}/se/se!seMeetingForm.do?seMeeting.projectId=${seMeeting.projectId}", 1200, 600);
	}
	//弹出编辑页面
	function editSeMeetingDate(id) {
		showWin("${ctx}/se/se!seMeetingForm.do?seMeeting.mettingCode=" + id,1200, 600);
	}
	//弹出编辑页面
	function editSeMeetingDate2() {
		var data = theSeMeetingTab.datagrid("getSelected");
		if(data){
			editSeMeetingDate(data.METTING_CODE);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSeMeetingDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeMeetingByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSeMeetingTab.datagrid("clearChecked");
							loadSeMeetingDg();
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
		var data = theSeMeetingTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].METTING_CODE);
			str += (data[i].METTING_CODE + ",");
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
			$.ajax("${ctx}/se/se!deleteSeMeetingById.do?seMeeting.mettingCode=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSeMeetingDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		
		
		
		$("#PROJECT_ID").combobox(input_project_list_setting);
		
		
		theSeMeetingForm = $('#theSeMeetingForm').form({
			ajax:false
		})
		
		
		theSeMeetingTab = $('#theSeMeetingdataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seMeetingListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							queryParams: {
								PROJECT_ID: '${seMeeting.projectId}'
							},
							//主键字段
							idField : "METTING_CODE",
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
							sortName : 'METTING_CODE',
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
										field : 'METTING_CODE',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'METTING_CODE',
										title : '会议CODE',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'METTING_NAME',
										title : '会议名称',
										width : 300,
										sortable : true
									},
									{
										field : 'METTING_TYPE',
										title : '会议类型',
										width : 100,
										sortable : true
									},
									{
										field : 'METTING_TIME',
										title : '会议时间',
										width : 100,
										sortable : true
									},
									{
										field : 'METTING_ADDR',
										title : '会议地点',
										width : 100,
										sortable : true
									},
									{
										field : 'METTING_EMCEE',
										title : '主持人',
										width : 100,
										sortable : true
									},
									{
										field : 'METTING_PARTICIPANT',
										title : '参会人员',
										width : 400,
										sortable : true
									},
									{
										field : 'PROJECT_ID',
										title : '所属项目',
										width : 100,
										sortable : true
									},
									/*{
										field : 'METTING_INTRO',
										title : '会议介绍',
										width : 100,
										sortable : true
									},{
										field : 'METTING_PROCESS',
										title : '会议议程',
										width : 100,
										sortable : true
									},
									{
										field : 'METTING_SUMMARY',
										title : '会议纪要',
										width : 100,
										sortable : true
									},
									{
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
											var editStr =  '<a  href="#" title="编辑" onclick="editSeMeetingDate(\'' + row.METTING_CODE + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.METTING_CODE + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSeMeetingQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSeMeetingObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSeMeetingDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSeMeetingDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSeMeetingDate(rowData.METTING_CODE);
							}
							
						})

	})

	

var querySeMeetingState = "open"
function hideSeMeetingQuery(){
	if("open" == querySeMeetingState){
		$('body').layout('collapse','north');
		querySeMeetingState = "close";
	}else{
		$('body').layout('expand','north');
		querySeMeetingState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSeMeetingForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>


									<!-- 会议名称 -->
									<td>
										<span class="Fieldname">会议名称：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="METTING_NAME"
											id="METTING_NAME"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<!-- 会议类型 -->
									<td>
										<span class="Fieldname">会议类型：</span>
									</td>
									<td>
											<s:select id="METTING_TYPE" 
					 name="METTING_TYPE"  
					 cssClass="easyui-combobox"  
					 list="#request.meetingTypeList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select> 
									</td>
									
					 
					 
									<!-- 所属项目 -->
									<td>
										<span class="Fieldname">所属项目：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-combobox" 
											name="PROJECT_ID"
											id="PROJECT_ID"
											value="${seMeeting.projectId}"
											type="text" 
											style="width:150px;"
											 />
									</td>
									
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeMeetingDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeMeetingForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSeMeetingdataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
