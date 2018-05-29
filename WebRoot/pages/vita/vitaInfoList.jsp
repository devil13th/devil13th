<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theVitaInfoTab;

	var theVitaInfoForm;
	//刷新表格
	function reloadVitaInfoDg() {
		theVitaInfoTab.datagrid("reload");
	}
	//重新查询
	function loadVitaInfoDg() {
		var jsonData = $("#theVitaInfoForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theVitaInfoTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetVitaInfoForm(){
		theVitaInfoForm.form("clear");
		loadVitaInfoDg();
	}

	//弹出保存页面方法
	function addVitaInfoObj(t) {
		showWin("${ctx}/vita/vita!vitaInfoForm.do", 900, 600);
	}
	//弹出编辑页面
	function editVitaInfoDate(id) {
		showWin("${ctx}/vita/vita!vitaInfoForm.do?vitaInfo.vitaId=" + id,900, 600);
	}
	//弹出编辑页面
	function editVitaInfoDate2() {
		var data = theVitaInfoTab.datagrid("getSelected");
		if(data){
			editVitaInfoDate(data.VITA_ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteVitaInfoDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/vita/vita!deleteVitaInfoByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theVitaInfoTab.datagrid("clearChecked");
							loadVitaInfoDg();
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
		var data = theVitaInfoTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].VITA_ID);
			str += (data[i].VITA_ID + ",");
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
			$.ajax("${ctx}/vita/vita!deleteVitaInfoById.do?vitaInfo.vitaId=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadVitaInfoDg();
						}else{
							alert(str);
						};
					}
				}
			)
		}
	}
	
	
	

	$(function() {
		theVitaInfoForm = $('#theVitaInfoForm').form({
			ajax:false
		})
		
		
		theVitaInfoTab = $('#theVitaInfodataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/vita/vita!vitaInfoListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "VITA_ID",
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
							sortName : 'VITA_ID',
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
										field : 'VITA_ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'VITA_ID',
										title : '',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'USER_ID',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'VITA_NAME',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'SEX',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'BIRTHDAY',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'PHOTO',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'EDU',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'TEL',
										title : '',
										width : 100,
										sortable : true
									},
									{
										field : 'INTERDUCE',
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
										field : 'PRE_PAY',
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
											var editStr =  '<a  href="#" title="编辑" onclick="editVitaInfoDate(\'' + row.VITA_ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.VITA_ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideVitaInfoQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addVitaInfoObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editVitaInfoDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteVitaInfoDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editVitaInfoDate(rowData.VITA_ID);
							}
							
						})

	})

	

var queryVitaInfoState = "open"
function hideVitaInfoQuery(){
	if("open" == queryVitaInfoState){
		$('body').layout('collapse','north');
		queryVitaInfoState = "close";
	}else{
		$('body').layout('expand','north');
		queryVitaInfoState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theVitaInfoForm" method="post">
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
											name="USER_ID"
											id="USER_ID"
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
											name="VITA_NAME"
											id="VITA_NAME"
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
											name="SEX"
											id="SEX"
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
											name="BIRTHDAY"
											id="BIRTHDAY"
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
											name="PHOTO"
											id="PHOTO"
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
											name="EDU"
											id="EDU"
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
											name="TEL"
											id="TEL"
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
											name="INTERDUCE"
											id="INTERDUCE"
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
											class="easyui-textbox" 
											name="PRE_PAY"
											id="PRE_PAY"
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
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadVitaInfoDg()">查询</a>  
							<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetVitaInfoForm()">重置</a>  
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theVitaInfodataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
