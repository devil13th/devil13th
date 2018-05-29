<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>
		功能设置
		</title>
		<script type="text/javascript">
	var tab;
	var functionListTab;
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
				//alert(datasTab2[i].FUN_NAME)
				selected+=datasTab2[i].FUN_ID+",";
			}
			//alert(selected)
			
			
			if(selected){
				var rows = functionListTab.datagrid("getRows");
				for(var i=0;i<rows.length;i++){
					if(selected.indexOf(rows[i].FUN_ID)>-1){
						functionListTab.datagrid('selectRow',i);
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
		
		functionListTab = $('#functionListTab').datagrid({
			//title:'数据列表',
			iconCls : 'icon-ok',
			//数据来源
			url : '${ctx}/common/common!sysDicFunctionListGetDate.do?r=' + Math.random(),
			
			//斑马纹
			striped : true,
			//主键字段
			idField : "FUN_ID",
			
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
							field : 'FUN_ID',
							title : 'fid',
							checkbox : true,
							align : 'center'
						},*/
						{
							field : 'FUN_ID',
							title : '功能主键',
							checkbox : true,
							align : 'center'
						}
						] ],
				columns : [ [
						{
							field : 'FUN_NAME',
							title : '功能名称',
							width : 100,
							sortable : true
						},
						{
							field : 'FUN_URL',
							title : '功能URL',
							width : 300,
							sortable : true
						},
						{
							field : 'FUN_DESC',
							title : '功能描述',
							width : 100,
							sortable : true
						}
						] ]
			,
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
						if(row.FUN_ID== datas[i].FUN_ID){
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
						if(row.FUN_ID == datas[i].FUN_ID){
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
								if(row.FUN_ID == datas[i].FUN_ID){
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
								if(row.FUN_ID == datas[i].FUN_ID){
									tab.datagrid("deleteRow",i);
									break;
								}
							}
						}
					} 
				}
			}
			
		})


		tab = $('#selectedFunTab')
				.datagrid(
						{
							//title:'数据列表',
							iconCls : 'icon-ok',
							//数据来源
							url : '${ctx}/common/common!querySelectedFunGetData.do?r=' + Math.random(),
							queryParams: {
								'id': '${id}',
								'classify': '${classify}'
							},
							//斑马纹
							striped : true,
							//主键字段
							idField : "relaId",
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
										field : 'FUN_NAME',
										title : '功能名称',
										width : 150,
										sortable : true
									}
									] ],
							columns : [ [
									{
										field : 'RELA_SORT',
										title : '序号',
										editor:{type:'textbox',options:{required:true}},
										width : 70,
										sortable : true
									}
									
									] ]

							,
							toolbar :[{
								text:'清空',
								iconCls:'icon-clear',
								handler:function(){clearSelected()}
							},{
								text:'编辑',
								iconCls:'icon-edit',
								handler:function(){
									beginEditSelected();
								}
							},{
								text:'保存',
								iconCls:'icon-edit',
								handler:function(){
									//endEditSelected();
									selectedOk();
								}
							}
							
							
							
							],
							
						
							onDblClickRow : function(index,row){
								
								var datas = functionListTab.datagrid("getRows");
								if(datas){
									for(var i = 0 , j = datas.length ; i < j ; i++){
										//alert(i);
										if(datas[i].FUN_ID == row.FUN_ID){
											functionListTab.datagrid("unselectRow",i); 
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

	function clearSelected(){
		functionListTab.datagrid("clearChecked");
		
		var datas = tab.datagrid("getData");
		for( var i = 0 , j = datas.rows.length ; i < j ; j--){
			tab.datagrid("deleteRow",j);
		}
	}
	
	function beginEditSelected(){
		var datas = tab.datagrid("getData");
		for( var i = 0 , j = datas.rows.length ; i < j ; i++){
			tab.datagrid("beginEdit",i);
		}
	}
	
	function endEditSelected(){
		var datas = tab.datagrid("getData");
		for( var i = 0 , j = datas.rows.length ; i < j ; i++){
			tab.datagrid("endEdit",i);
		}
	}

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
	function loadFunctionDg() {
		var jsonData = $("#theForm").serializeArray();
		var params = formToJson(jsonData);
		params.a = Math.random();
		params.PROJECT_ID = "${projectId}";
		//showObj(params);
		functionListTab.datagrid("load", params);
	}
	//重置表单后查询
	function resetUserListForm(){
		$("#theForm").form("clear");
		loadFunctionDg();
	}
	
	function selectedOk(){
		endEditSelected();
		
		var datas = tab.datagrid("getData");
		var objs = [];
		for( var i = 0 , j = datas.rows.length ; i < j ; i++){
			var tmp = datas.rows[i];
			objs.push(tmp);
		}
		//${cb}(objs);
		
		
		var tabId = "${id}";
		var classify = "${classify}"
		var json = JSON.stringify(objs);
		//alert(json);
		//alert(tabId + classify);
		
		$.ajax({
			url:"${ctx}/common/common!saveSelectedFun.do",//请求地址
			method:"post",//提交方式
			async:false,//是否异步
			cache:false,//是否缓存
			data:{
				id : tabId,
				classify : classify,
				json : json
			},//可以是字符串也可以是json对象，字符串类似本例子中的内容
			dataType:"text",//返回数据的格式 xml, json, script, or html
			success:function(r){//回调函数
				var str = $.trim(r);
				if(str == "SUCCESS"){
				  alert("保存成功");
				  window.close();
				}else{
				  alert("保存失败");
				};
			}
		})
		//alert(JSON.stringify(objs));
		//return objs;
	}

</script>
	</head>
	<body class="easyui-layout">
		
		<div data-options="region:'east',split:true" style="width:400px;">
				<table id="selectedFunTab">

				</table>
		</div>
		<div data-options="region:'center',split:true" >
			<div id="tb" style="padding:2px 5px;">
	        <form action="" id="theForm" method="post">
   				<td>
					<span class="Fieldname">功能名称：</span>
				</td>
				<td>
						<input 
						type="text"
						class="easyui-textbox" 
						name="FUN_NAME"
						id="FUN_NAME"
						type="text" 
						style="width:150px;"
						 />
				</td>
				<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-search'" onclick="loadFunctionDg()"></a>
				<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-clear'" onclick="resetUserListForm()"></a>
			</form>
			</div>
				<table id="functionListTab">

				</table>
		</div>
		<div data-options="region:'south',split:true" style="height:60px;padding:10px;text-align:center">
			<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-save'" onclick="selectedOk()"> 保存</a>
			<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-clear'" onclick="window.close()"> 关闭</a>
		</div>
				
				
		
	</body>

</html>
