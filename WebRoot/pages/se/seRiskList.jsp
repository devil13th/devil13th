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
		showWin("${ctx}/se/se!seRiskForm.do?seRisk.projectId=${seRisk.projectId}", 1100, 600);
	}
	//弹出编辑页面
	function editData(id) {
		showWin("${ctx}/se/se!seRiskForm.do?seRisk.riskId=" + id,1100, 600);
	}
	//弹出编辑页面
	function editData2() {
		var data = tab.datagrid("getSelected");
		if(data){
			editData(data.RISK_ID);
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
			$.ajax("${ctx}/se/se!deleteSeRiskByIds.do?ids=" + checkedIds + "&_r="+Math.random,
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
			//alert(data[i].RISK_ID);
			str += (data[i].RISK_ID + ",");
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
			$.ajax("${ctx}/se/se!deleteSeRiskById.do?seRisk.riskId=" + id + "&_r="+Math.random,
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
		
		$("#PROJECT_ID").combobox("setValue","${seRisk.projectId}");
		
		tab = $('#dataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seRiskListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							queryParams: {
								PROJECT_ID: '${seRisk.projectId}'
							},
							//主键字段
							idField : "RISK_ID",
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
							sortName : 'RISK_ID',
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
										field : 'RISK_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'RISK_ID',
										title : '风险ID',
										checkbox : true,
										align : 'center'
									},
									{
										field : 'RISK_CONTENT',
										title : '风险描述',
										width : 550,
										sortable : true
									},
									{
										field : 'PROJECT_ID',
										title : '所属项目',
										width : 100,
										sortable : true
									},
									{
										field : 'RISK_CLASSIFY',
										title : '风险类别',
										width : 100,
										sortable : true
									}
									] ],
							columns : [ [
									
									{
										field : 'RISK_PROBABILITY',
										title : '概率',
										width : 100,
										sortable : true
									},
									{
										field : 'RISK_SWAY',
										title : '影响',
										width : 100,
										sortable : true
									},
									/*{
										field : 'RISK_VALUE',
										title : '风险值',
										width : 100,
										sortable : true
									},*/
									{
										field : 'RISK_LEVEL',
										title : '风险等级',
										width : 100,
										sortable : true
									},
									{
										field : 'RISK_PRIORITY',
										title : '优先级',
										width : 100,
										sortable : true
									},
									{
										field : 'DEAL_TYPE',
										title : '应对方式',
										width : 100,
										sortable : true
									},
									
									{
										field : 'PERSON_IN_CHARGE',
										title : '责任人',
										width : 100,
										sortable : true
									},
									{
										field : 'IDENT_DATE',
										title : '识别日期',
										width : 100,
										sortable : true
									},
									/*{
										field : 'EMERGENCY_PREPLAN',
										title : '应急预案',
										width : 100,
										sortable : true
									},{
										field : 'RISK_DEAL_CONTENT',
										title : '风险处理措施',
										width : 100,
										sortable : true
									},{
										field : 'MONITOR',
										title : '监控人',
										width : 100,
										sortable : true
									},*/
									{
										field : 'RISK_STATUS',
										title : '状态',
										width : 100,
										sortable : true
									},
									
									{
										field : 'IS_CLOSE',
										title : '是否关闭',
										width : 100,
										sortable : true
									},
									{
										field : 'CLOSE_DATE',
										title : '关闭日期',
										width : 100,
										sortable : true
									},
									{
										field : 'OPER',
										title : '操作',
										width :80,
										align : 'center',
										formatter : function(value, row, index) {
											var editStr =  '<a  href="#" title="编辑" onclick="editData(\'' + row.RISK_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.RISK_ID + '\')" >删除</a>';
											return editStr + "&nbsp;" + deleteStr;
										}
									} 
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
								editData(rowData.RISK_ID);
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
							<table border="0" class="table_none_border">
								<!-- <tr>
								 
									<td>
										<span class="Fieldname">风险类别：</span>
									</td>
									<td>
									  <s:select 
									 id="RISK_CLASSIFY" 
									 cssStyle="width:150px;"
									 cssClass="easyui-combobox" 
									 name="RISK_CLASSIFY" 
									 list="#{'需求风险':'需求风险','计划编制风险':'计划编制风险','设计和实现风险':'设计和实现风险','测试相关风险':'测试相关风险','组织和管理风险':'组织和管理风险数','人员风险':'人员风险','开发环境风险':'开发环境风险','管理过程风险':'管理过程风险','技术风险':'技术风险'}" 
									 headerKey="" 
									 headerValue="请选择">
									 </s:select>  
							 
									</td>
									
									
									
									
									
									
									<td>
										<span class="Fieldname">概率：</span>
									</td>
									<td>
											 
											 
											 <s:select 
							 id="RISK_PROBABILITY" 
							 cssStyle="width:150px;"
							 cssClass="easyui-combobox" 
							 name="RISK_PROBABILITY" 
							 list="#{'极高':'极高','比较低':'比较低','中等':'中等','比较低':'比较低','极低':'极低'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>  
									</td>
									<td>
										<span class="Fieldname">风险等级：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="RISK_LEVEL"
											id="RISK_LEVEL"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">优先级：</span>
									</td>
									<td>
											 
											 <s:select 
											 id="RISK_PRIORITY" 
											 cssStyle="width:150px;"
											 cssClass="easyui-combobox" 
											 name="RISK_PRIORITY" 
											 list="#{'高':'高','中':'中','低':'低'}" 
											 headerKey="" 
											 headerValue="请选择">
											 </s:select>
									</td>
									
									</tr>-->
									<tr>
									<!-- 
									<td>
										<span class="Fieldname">应对方式：</span>
									</td>
									<td>
											 
											 <s:select 
							 id="DEAL_TYPE" 
							 cssStyle="width:150px;"
							 cssClass="easyui-combobox" 
							 name="DEAL_TYPE" 
							 list="#{'规避':'规避','转移':'转移','接受':'接受','减缓':'减缓'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>
									</td>
									 -->
									<!-- 状态 -->
									<td>
										<span class="Fieldname">项目：</span>
									</td>
									<td>
									
										<s:select id="PROJECT_ID" 
name="PROJECT_ID"  
cssClass="easyui-combobox"  
list="#request.projectList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>

									</td>
									
									<td>
										<span class="Fieldname">状态：</span>
									</td>
									<td>
											  <s:select 
							 id="RISK_STATUS" 
							 cssStyle="width:150px;"
							 cssClass="easyui-combobox" 
							 name="RISK_STATUS" 
							 list="#{'跟踪':'跟踪','已发生':'已发生','未发生':'未发生','已关闭':'已关闭'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>
									</td>
									
									<td colspan="2">
									<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="dataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
