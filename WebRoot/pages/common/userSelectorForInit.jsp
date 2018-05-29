<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>
		用户选择器
		</title>
		<script type="text/javascript">
	var tab;
	var userListTab;
	var theForm;
	
	var tab1_load = false;
	var tab2_load = false;
	
	function initSelectData(){
		//alert(tab1_load + "|" + tab2_load);
		if(tab1_load && tab2_load){
			var selected="";	//已选中用户
			var datasTab2 = tab.datagrid('getRows');
			//alert(datasTab2.length);
			for ( var i = 0; i < datasTab2.length; i++) {
				selected+=datasTab2[i].USER_ID+",";
			}
			//alert(selected)
			
			
			if(selected){
				var rows = userListTab.datagrid("getRows");
				for(var i=0;i<rows.length;i++){
					if(selected.indexOf(rows[i].USER_ID)>-1){
						userListTab.datagrid('selectRow',i);
					}
				}
			}
		}
		
	}

	
	
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
		showWin("${ctx}/se/se!seRiskForm.do", 900, 700);
	}
	//弹出编辑页面
	function editData(id) {
		showWin("${ctx}/se/se!seRiskForm.do?seRisk.riskId=" + id,900, 700);
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
		
		userListTab = $('#userListTab').datagrid({
			//title:'数据列表',
			iconCls : 'icon-ok',
			//数据来源
			url : '${ctx}/se/se!seUserListGetDate.do?r=' + Math.random(),
			
			//斑马纹
			striped : true,
			//主键字段
			idField : "USER_ID",
			
			queryParams:{PROJECT_ID:"${projectId}"},
			//宽度自适应
			//fitColumns: true,
			//表单提交方式
			method : "post",
			//是否只能选择一行
			singleSelect : false,
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
			//sortName : 'USER_NAME',
			//排序方式
			//sortOrder : "desc",
			//pageNumber:5,s
			rownumbers : true,//行号 
			//分页工具所在位置
			pagePosition : "bottom",
			//冻结的列
			//冻结的列
			frozenColumns : [ [
			//选择框		
					/*{
						field : 'USER_ID',
						title : 'fid',
						checkbox : true,
						align : 'center'
					},*/
					{
						field : 'USER_ID',
						title : '用户ID',
						checkbox : true,
						align : 'center'
					}
					] ],
			columns : [ [
					{
						field : 'USER_NAME',
						title : '用户姓名',
						width : 100,
						sortable : true
					},
					{
						field : 'USER_ACCOUNT',
						title : '账号',
						width : 70,
						sortable : true
					},
					{
						field : 'COMPANY_NAME',
						title : '所在公司',
						width : 100,
						sortable : true
					},
					{
						field : 'USER_MAIL',
						title : '邮箱',
						width : 100,
						sortable : true
					}
					] ],
			toolbar:'#tb',
			onLoadSuccess:function(data){
				tab2_load = true;
				initSelectData();
			},
			onSelect : function(index,row){
				var datas = tab.datagrid("getRows");
				var has = false;
				if(datas){
					for(var i = 0 , j = datas.length ;i < j ; i++){
						//alert(datas[i].PERSON_CODE);
						if(row.USER_ID== datas[i].USER_ID){
							has=true;
							break;
						}
					}
				}
				if(!has){
					tab.datagrid("insertRow",{
						index: 1,	// index start with 0
						row: row
					})
				}

			},
			onUnselect : function(index,row){
				var datas = tab.datagrid("getRows");
				if(datas){
					for(var i = 0 , j = datas.length ;i < j ; i++){
						//alert(datas[i].PERSON_CODE);
						if(row.USER_ID == datas[i].USER_ID){
							tab.datagrid("deleteRow",i);
							break;
						}
					}
				}
			},
			onSelectAll : function(rows){
				if(rows){
					for(var x = 0 , y = rows.length ; x < y ; x++){
						var row = rows[x];
						var datas = tab.datagrid("getRows");
						var has = false;
						if(datas){
							for(var i = 0 , j = datas.length ;i < j ; i++){
								//alert(datas[i].PERSON_CODE);
								if(row.USER_ID == datas[i].USER_ID){
									has=true;
									break;
								}
							}
						}
						if(!has){
							tab.datagrid("insertRow",{
								index: 1,	// index start with 0
								row: row
							})
						}
					}
				}
			},
			onUnselectAll : function(rows){
				if(rows){
					for(var x = 0 , y = rows.length ; x < y ; x++){
						var row = rows[x];
						var datas = tab.datagrid("getRows");
						if(datas){
							for(var i = 0 , j = datas.length ;i < j ; i++){
								if(row.USER_ID == datas[i].USER_ID){
									tab.datagrid("deleteRow",i);
									break;
								}
							}
						}
					} 
				}
			}
			
		})


		tab = $('#dataTable')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/se/se!seUserListGetDate.do?r=' + Math.random(),
							queryParams: {
								'USER_IDS': '${ids}',
							},
							//斑马纹
							striped : true,
							//主键字段
							idField : "USER_ID",
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
							pagination : false,
							//分页信息
							pageSize : 10,
							//每页显示条目下拉菜单
							pageList : [ 5, 10, 20, 50, 100 ],
							//排序的列
							//sortName : 'USER_NAME',
							//排序方式
							//sortOrder : "desc",
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
										field : 'USER_NAME',
										title : '姓名',
										width : 80,
										sortable : true
									}
									] ],
							columns : [ [
									{
										field : 'USER_ACCOUNT',
										title : '账号',
										width : 70,
										sortable : true
									},
									{
										field : 'USER_MAIL',
										title : '邮箱',
										width : 150,
										sortable : true
									}
									] ]

							,
							toolbar :[{
								text:'清空',
								iconCls:'icon-clear',
								handler:function(){alert('尚未开发')}
							}],
							
						
							onDblClickRow : function(index,row){
								
								var datas = userListTab.datagrid("getRows");
								if(datas){
									for(var i = 0 , j = datas.length ; i < j ; i++){
										//alert(i);
										if(datas[i].USER_ID == row.USER_ID){
											userListTab.datagrid("unselectRow",i); 
											return false;
										}
									}
								}
								tab.datagrid("deleteRow",index);
							},
							onLoadSuccess:function(data){
								tab1_load = true;
								initSelectData();
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
		

	//重新查询
	function loadUserListDg() {
		var jsonData = $("#theForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		params.PROJECT_ID = "${projectId}";
		//showObj(params);
		userListTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetUserListForm(){
		$("#theForm").form("clear");
		loadUserListDg();
	}
	
	function getSelected(){
		var datas = tab.datagrid("getData");
		var objs = [];
		for( var i = 0 , j = datas.rows.length ; i < j ; i++){
			var tmp = datas.rows[i];
			objs.push(tmp);
		}
		//alert(JSON.stringify(objs));
		${cb}(objs);
		//return objs;
	}

</script>
	</head>
	<body class="easyui-layout">
		
		<div data-options="region:'east',split:true" style="width:400px;">
				<table id="dataTable">

				</table>
		</div>
		<div data-options="region:'center',split:true" >
			<div id="tb" style="padding:2px 5px;">
	        <form action="" id="theForm" method="post">
   				姓名 <input 
				type="text"
				class="easyui-textbox" 
				name="USER_NAME"
				id="USER_NAME"
				type="text" 
				style="width:80px;"
				 />
				<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-search'" onclick="loadUserListDg()"></a>
				<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-clear'" onclick="resetUserListForm()"></a>
			</form>
			</div>
				<table id="userListTab">

				</table>
		</div>
		<div data-options="region:'south',split:true" style="height:60px;padding:10px;text-align:center">
			<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-search'" onclick="getSelected()"> 确定</a>
		</div>
				
				
		
	</body>

</html>
