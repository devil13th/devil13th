<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
	var theSeUserRewardAmerceTab;

	var theSeUserRewardAmerceForm;
	
	var input_user_list_setting ={
			url:'${ctx}/common/common!queryUserListJsonStr.do',
			valueField:'USER_ID',
			textField:'USER_NAME'
	};
	
	var input_project_list_setting ={
			url:'${ctx}/common/common!queryProjectListJsonStr.do',
			valueField:'value',
			textField:'text'
	};
	
	
	
	
	
	//刷新表格
	function reloadSeUserRewardAmerceDg() {
		theSeUserRewardAmerceTab.datagrid("reload");
	}
	//重新查询
	function loadSeUserRewardAmerceDg() {
		var jsonData = $("#theSeUserRewardAmerceForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		//showObj(params);
		theSeUserRewardAmerceTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetSeUserRewardAmerceForm(){
		theSeUserRewardAmerceForm.form("clear");
		loadSeUserRewardAmerceDg();
	}

	//弹出保存页面方法
	function addSeUserRewardAmerceObj(t) {
		showWin("${ctx}/se/se!seUserRewardAmerceForm.do", 900, 600);
	}
	//弹出编辑页面
	function editSeUserRewardAmerceDate(id) {
		showWin("${ctx}/se/se!seUserRewardAmerceForm.do?seUserRewardAmerce.id=" + id,900, 600);
	}
	//弹出编辑页面
	function editSeUserRewardAmerceDate2() {
		var data = theSeUserRewardAmerceTab.datagrid("getSelected");
		if(data){
			editSeUserRewardAmerceDate(data.ID);
		}else{
			alert("请选择数据");
		}
	}
	
	
	function deleteSeUserRewardAmerceDates(){
		var checkedIds = getCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		if(confirm("确定删除勾选的数据么?")){
			$.ajax("${ctx}/se/se!deleteSeUserRewardAmerceByIds.do?ids=" + checkedIds + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							theSeUserRewardAmerceTab.datagrid("clearChecked");
							loadSeUserRewardAmerceDg();
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
		var data = theSeUserRewardAmerceTab.datagrid("getChecked");
		var str = ""
		for(var i = 0 , j = data.length ; i < j ; i++){
			//alert(data[i].ID);
			str += (data[i].ID + ",");
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
			$.ajax("${ctx}/se/se!deleteSeUserRewardAmerceById.do?seUserRewardAmerce.id=" + id + "&_r="+Math.random,
				{
					type:"GET",
					success:function(r){
						var str = $.trim(r);
						if(str == "success"){
							alert('操作成功');
							loadSeUserRewardAmerceDg();
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
		$("#USER_ID").combobox(input_user_list_setting);
		
		theSeUserRewardAmerceForm = $('#theSeUserRewardAmerceForm').form({
			ajax:false
		})
		
		
		theSeUserRewardAmerceTab = $('#theSeUserRewardAmercedataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seUserRewardAmerceListGetDate.do?r=' + Math.random(),
							//斑马纹
							striped : true,
							//主键字段
							idField : "ID",
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
							sortName : 'ID',
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
										field : 'ID',
										title : 'fid',
										checkbox : true,
										align : 'center'
									},*/
									{
										field : 'ID',
										title : '主键',
										checkbox : true,
										align : 'center'
									}
									] ],
							columns : [ [
									{
										field : 'PROJECT_ID',
										title : '所属系统',
										width : 100,
										sortable : true
									},
									{
										field : 'USER_NAME',
										title : '用户',
										width : 100,
										sortable : true
									},
									{
										field : 'RA_LEVEL',
										title : '等级',
										width : 100,
										sortable : true
									},
									{
										field : 'REMARK',
										title : '备注',
										width : 500,
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
											var editStr =  '<a  href="#" title="编辑" onclick="editSeUserRewardAmerceDate(\'' + row.ID + '\')" >编辑</a>'
											var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.ID + '\')" >删除</a>';
											return editStr +"&nbsp;"+ deleteStr;
										}
									} 
									] ]

							,
							toolbar :[{
								text:'收起搜索',
								iconCls:'icon-search',
								handler:function(){hideSeUserRewardAmerceQuery()}
							},{
								text:'Add',
								iconCls:'icon-add',
								handler:function(){addSeUserRewardAmerceObj()} 
							},{
								text:'Edit',
								iconCls:'icon-edit',
								handler:function(){editSeUserRewardAmerceDate2()}
							},'-',{
								text:'Delete',
								iconCls:'icon-remove',
								handler:function(){deleteSeUserRewardAmerceDates()}
							}],
							//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
							onSortColumn : function(sort, order) {
								$('#sort').val(sort);
								$('#order').val(order);
							}
							,
							
							onDblClickRow : function(rowIndex, rowData) {
								//不能选中条件中的行
								editSeUserRewardAmerceDate(rowData.ID);
							}
							
						})

	})

	

var querySeUserRewardAmerceState = "open"
function hideSeUserRewardAmerceQuery(){
	if("open" == querySeUserRewardAmerceState){
		$('body').layout('collapse','north');
		querySeUserRewardAmerceState = "close";
	}else{
		$('body').layout('expand','north');
		querySeUserRewardAmerceState = "open";
	}
	
}
		




</script>
	</head>
	<body class="easyui-layout">
		<div data-options="region:'north'" style="height:35px;">
			<form action="" id="theSeUserRewardAmerceForm" method="post">
					<!-- 是否全部导出 -->
					<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
					<input type="hidden" id="sort" name="sort" value="status" />
					<input type="hidden" id="order" name="order" value="desc" />
					
					
						<div class="complex_search_area" id="search_all">
							<!-- 显示的查询条件 -->
							<table border="0"  class="table_none_border">
								<tr>
									<!-- 
									<td>
										<span class="Fieldname">主键：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="ID"
											id="ID"
											type="text" 
											style="width:150px;"
											 />
									</td>


									
									
									
									-->
									<td>
										<span class="Fieldname">用户：</span>
									</td>
									<td>
											<input 
											type="text"
											name="USER_ID"
											id="USER_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">所属系统：</span>
									</td>
									<td>
											<input 
											type="text"
											name="PROJECT_ID"
											id="PROJECT_ID"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<span class="Fieldname">等级：</span>
									</td>
									<td>
										 <select class="easyui-combobox" name="RA_LEVEL" id="RA_LEVEL" style="width:150px;">
											<option value="">请选择</option>
							                <option value="1">好</option>
							                <option value="2">很好</option>
							                <option value="3">非常好</option>
							                <option value="-1">轻微错误</option>
							                <option value="-2">一般错误</option>
							                <option value="-3">严重错误</option>
										 </select>
									</td>
									<td>
										<span class="Fieldname">备注：</span>
									</td>
									<td>
											<input 
											type="text"
											class="easyui-textbox" 
											name="REMARK"
											id="REMARK"
											type="text" 
											style="width:150px;"
											 />
									</td>
									<td>
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="loadSeUserRewardAmerceDg()">查询</a>  
										<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSeUserRewardAmerceForm()">重置</a>  
									</td>
								</tr>
							</table>
						</div>
				</form>
		</div>
		<div data-options="region:'center'">
			
				<table id="theSeUserRewardAmercedataTable">

				</table>
		</div>
		
				
				
		
	</body>

</html>
