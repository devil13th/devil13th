<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
var tab;
var projectUserTab;
var theForm;
var win;
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
	showWin("${ctx}/se/se!seProjectInfoForm.do", 900, 600);
}

function addProjectUser(){
	var data = tab.datagrid("getSelected");
	//alert(data.PROJECT_ID);
	if(data){
		showWin("${ctx}/se/se!seMapProjectUserForm.do?seMapProjectUser.projectId=" + data.PROJECT_ID, 900, 600);
	}else{
		showWin("${ctx}/se/se!seMapProjectUserForm.do" + data, 900, 600);
	}
}

//弹出编辑页面
function editData(id) {
	showWin("${ctx}/se/se!seProjectInfoForm.do?seProjectInfo.projectId=" + id,900, 600);
}
//弹出编辑页面
function editData2() {
	var data = tab.datagrid("getSelected");
	if(data){
		editData(data.PROJECT_ID);
	}else{
		alert("请选择数据");
	}
}

//编辑项目成员
function editProjectUser(){
	var data = projectUserTab.datagrid("getSelected");
	if(data){
		showWin("${ctx}/se/se!seMapProjectUserForm.do?seMapProjectUser.rid=" + data.RID,900, 700);
	}else{
		alert("请选择数据");
	}
}


function onpos_formatter(value,row,index){
	if(value == "1"){
		return "在岗";
	}else{
		return "离岗";
	}
}
function deleteProjectUserRela(){
	var data = projectUserTab.datagrid("getChecked");
	var str = ""
	for(var i = 0 , j = data.length ; i < j ; i++){
		//alert(data[i].PROJECT_ID);
		str += (data[i].RID + ",");
	};
	if(str != ""){
		str = str.substring(0,str.length - 1);
	}
	if(str == ""){
		alert("请勾选数据后再进行删除");
		return ;
	}
	if(confirm("确定删除勾选的数据么?")){
		$.ajax("${ctx}/se/se!deleteSeMapProjectUserById.do?seMapProjectUser.rid=" + str + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						alert('操作成功');
						projectUserTab.datagrid("clearChecked");
						loadProjectUserDg();
					}else{
						alert(str);
					};
				}
			}
		)
	}
	
	
	
}


function deleteDatas(){
	var checkedIds = getCheckedIds();
	if(checkedIds == ""){
		alert("请勾选数据后再进行删除");
		return ;
	}
	if(confirm("确定删除勾选的数据么?")){
		$.ajax("${ctx}/se/se!deleteSeProjectInfoByIds.do?ids=" + checkedIds + "&_r="+Math.random,
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
		//alert(data[i].PROJECT_ID);
		str += (data[i].PROJECT_ID + ",");
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
		$.ajax("${ctx}/se/se!deleteSeProjectInfoById.do?seProjectInfo.projectId=" + id + "&_r="+Math.random,
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
	
	
	
	//弹出窗口初始化
	win = $('#win').window({
	    width:900,
	    height:600,
	    modal:true,
	    border:false
	});
	$('#win').window('close');
	
	tab = $('#dataTable').datagrid({
		title:'项目列表',
		//title:'数据列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seProjectInfoListGetDate.do?r=' + Math.random(),
		//斑马纹
		striped : true,
		//主键字段
		idField : "PROJECT_ID",
		//宽度自适应
		//fitColumns: true,
		//表单提交方式
		method : "post",
		//是否只能选择一行
		singleSelect : true,
		nowrap : false,
		fit:true,
		border:true,
		//高度
		//height:450,
		//宽度
		//width:860,
		//是否分页
		//pagination : true,
		//分页信息
		//pageSize : 10,
		//每页显示条目下拉菜单
		//pageList : [ 5, 10, 20, 50, 100 ],
		//排序的列
		sortName : 'PROJECT_ID',
		//排序方式
		sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		//pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		//冻结的列
		frozenColumns : [ [
		//选择框		
				/*{
					field : 'PROJECT_ID',
					title : 'fid',
					checkbox : true,
					align : 'center'
				},*/
				{
					field : 'PROJECT_ID',
					title : '项目ID',
					checkbox : true,
					align : 'center'
				}
				] ],
		columns : [ [
				{
					field : 'PRO_NO',
					title : '项目标号',
					width : 100,
					sortable : true
				},
				{
					field : 'PRO_NAME',
					title : '项目名称',
					width : 100,
					sortable : true
				}/*,
				{
					field : 'PRO_DESCRIPTION',
					title : '项目描述',
					width : 100,
					sortable : true
				},
				{
					field : 'PRO_TARGET',
					title : '项目目标',
					width : 100,
					sortable : true
				},
				{
					field : 'PRO_BACKGROUND',
					title : '项目背景',
					width : 100,
					sortable : true
				},
				{
					field : 'FINAL_CONSIGN',
					title : '最终交付物',
					width : 100,
					sortable : true
				},
				{
					field : 'PRO_LEADER',
					title : '项目经理',
					width : 100,
					sortable : true
				},
				{
					field : 'PRO_MEMBER',
					title : '项目成员',
					width : 100,
					sortable : true
				},
				{
					field : 'OPER',
					title : '操作',
					width : 80,
					align : 'center',
					formatter : function(value, row, index) {
						var editStr =  '<a  href="#" title="编辑" onclick="editData(\'' + row.PROJECT_ID + '\')" >编辑</a>'
						var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.PROJECT_ID + '\')" >删除</a>';
						return editStr +"&nbsp;"+ deleteStr;
					}
				}*/ 
				] ]

		,
		toolbar:'#tb',
		/*
		toolbar :[{
			text:'收起搜索',
			iconCls:'icon-search',
			handler:function(){hideQuery()}
		},{
			text:'',
			iconCls:'icon-add',
			handler:function(){addObj()} 
		},{
			text:'',
			iconCls:'icon-edit',
			handler:function(){editData2()}
		},
		'-',
		{
			text:'编辑项目成员',
			iconCls:'icon-edit',
			handler:function(){editProjectUser()}
		},
		'-',
		{
			text:'',
			iconCls:'icon-remove',
			handler:function(){deleteDatas()}
		}],*/
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
		,
		onClickRow:function(){
			projectUserTab.datagrid("clearChecked");
			loadProjectUserDg();
			refreshTraceRoot();
		},
		onDblClickRow:function(index,data){
			//alert(data.PROJECT_ID);
			editData2();
			//showWin("${ctx}/se/seRequirementTrace!seRequirementTraceIndex.do?seRequirementTrace.projectId=" + data.PROJECT_ID, 900, 600);
		}
		
	})
					
	projectUserTab = $('#projectUserTab').datagrid({
		title:'项目用户信息',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/se/se!seMapProjectUserListGetDate.do?r=' + Math.random(),
		queryParams:{PROJECT_ID:"${seProjectInfo.projectId}"},
		//斑马纹
		striped : true,
		//主键字段
		idField : "RID",
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
		//pageSize : 10,
		//每页显示条目下拉菜单
		//pageList : [ 5, 10, 20, 50, 100 ],
		//排序的列
		sortName : 'RID',
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
					field : 'RID',
					title : 'fid',
					checkbox : true,
					align : 'center'
				},*/
				{
					field : 'RID',
					title : '',
					checkbox : true,
					align : 'center'
				},
				{
					field : 'USER_NAME',
					title : '用户姓名',
					width : 100,
					sortable : true
				}
				] ],
		columns : [ [
				{
					field : 'PROJECT_ID',
					title : '项目ID',
					width : 100,
					sortable : true
				},
				{
					field : 'USER_ID',
					title : '用户ID',
					width : 100,
					sortable : true
				},
				
				<c:if test="${authMap['FINANCE'] == staticVarObj.y }">
				
				{
					field : 'USER_COST',
					title : '成本(万/月)',
					width : 100,
					align:"right",
					sortable : true
				},
				{
					field : 'USER_POS',
					title : '岗位',
					width : 100,
					sortable : true
				},
				{
					field : 'USER_LEVEL',
					title : '用户级别',
					width : 100,
					sortable : true
				},
				</c:if>
				{
					field : 'ON_POSITION',
					title : '是否在岗',
					width : 50,
					sortable : true,
					formatter:onpos_formatter
				},
				{
					field : 'PLAN_DUTY',
					title : '计划到港日期',
					width : 100,
					sortable : true
				},
				{
					field : 'PLAN_UNDUTY',
					title : '计划离岗日期',
					width : 100,
					sortable : true
				},
				{
					field : 'ACT_DUTY',
					title : '实际到岗日期',
					width : 100,
					sortable : true
				},
				{
					field : 'ACT_UNDUTY',
					title : '实际离岗日期',
					width : 100,
					sortable : true
				}/*,
				{
					field : 'OPER',
					title : '操作',
					width : 80,
					align : 'center',
					formatter : function(value, row, index) {
						var editStr =  '<a  href="#" title="编辑" onclick="editData(\'' + row.RID + '\')" >编辑</a>'
						var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.RID + '\')" >删除</a>';
						return editStr +"&nbsp;"+ deleteStr;
					}
				} */
				] ]

		,
		toolbar :[{
			text:'Add User',
			iconCls:'icon-add',
			handler:function(){addProjectUser()} 
		},{
			text:'Edit',
			iconCls:'icon-edit',
			handler:function(){editProjectUser()}
		},{
			text:'设置角色',
			iconCls:'icon-add',
			handler:function(){setRole()} 
		},'-',{
			text:'Delete',
			iconCls:'icon-remove',
			handler:function(){deleteProjectUserRela()}
		}],
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
		,
		
		onDblClickRow : function(rowIndex, rowData) {
			//不能选中条件中的行
			//editData(rowData.RID);
			editProjectUser();
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
	function loadProjectUserDg() {
		var data = tab.datagrid("getSelected");
		if(data){
			projectUserTab.datagrid("load", {PROJECT_ID:data.PROJECT_ID});
		}else{
			projectUserTab.datagrid("load", {});
		}
		
	}


	function setRole(){
		
		var prjectData = tab.datagrid("getSelected");
		if(!prjectData){
			alert("请选择项目");
			return ;
		}
		//console.log(data);
		var projectId = prjectData.PROJECT_ID;

		
		var userData =  projectUserTab.datagrid("getSelected");
		if(!userData){
			alert("请选择人员");
			return ;
		}
		var userId = userData.USER_ID;
		
		
		var url = "${ctx}/se/se!seUserRoleSelector.do?cb=parent.saveUserRole&projectId=" + projectId + "&seUser.userId=" + userId;
		opw({title:'角色设置',url:url,w:'900',h:'500'});
	}
	
	
	
	function saveUserRole(obj){
		console.log(obj);
		
		
		var prjectData = tab.datagrid("getSelected");
		if(!prjectData){
			alert("请选择项目");
			return ;
		}
		//console.log(data);
		var projectId = prjectData.PROJECT_ID;
		
		var userData =  projectUserTab.datagrid("getSelected");
		if(!userData){
			alert("请选择人员");
			return ;
		}
		var userId = userData.USER_ID;
		
		
		var ids = "";
		for(var i = 0 , j = obj.length ; i < j ; i++){
			//alert(obj[i].ROLE_CODE);
			ids += (obj[i].ROLE_CODE+",");
		}
		
		
		//alert(ids);
		$.ajax({
			type: "POST",
			url: "${ctx}/se/se!saveUserRole.do",
			data: {
				'seMapUserRole.userId':userId,
				'seMapUserRole.roleCode':ids,
				'projectId':projectId
			},
			success: function(msg){
				//alert(msg);
				if($.trim(msg)=="SUCCESS"){
					message("操作成功");
				}else{
					message("操作失败");
					return false;
				}
			},
			failure : function(msg){
				message("操作失败");
				return false;
			}
		});
		
		
		
		clw();
	}
	
	
	
	
// --------------------------------  需求矩阵  ------------------------------------//


//矩阵树
var t ;
//弹出窗口
var win ; 
var traceId ="";




$(function(){
	
	//弹出窗口初始化
	win = $('#win').window({
	    width:900,
	    height:600,
	    modal:true,
	    border:false
	});
	$('#win').window('close');
	
	//矩阵树初始化
	t = $('#tree').tree({
		//是否显示树节点前的竖线
		lines:true,
		//是否需要动画效果
		animate:true,
		//查询节点提交方式
		method:"post",
		//查询节点地址(异步查询)
	    url:'${ctx}/se/seRequirementTrace!getNextData.do',
	    
	    //查询节点地址(同步查询)
	    //url:'${ctx}/se/seRequirementTrace!queryTraceTreeData.do',
	    
	    //是否有checkbox
	    //checkbox:true, 
	    //是否只显示叶子节点前的checkbox
	    //onlyLeafCheck:true,
	    //默认查询参数
	    queryParams:{'seRequirementTrace.projectId':'${seRequirementTrace.projectId}'},
	    dnd:true,
	    //格式化节点
	    /*formatter:function(node){
			return node.text + "(" + node.id + ")";
		},*/
		onBeforeDrop:function(target,source,point){
			//alert(t.tree('getNode', target).id);
			//alert(source.id); 
			//alert(point);
			
			$.ajax({
				type: "POST",
				url: "${ctx}/se/seRequirementTrace!ajax.do",
				data: "ajaxMethod=moveNode&targetId=" + t.tree('getNode', target).id + "&sourceId=" + source.id + "&point=" + point,
				success: function(msg){
					//alert(msg);
					if($.trim(msg)=="success"){
						//alert( "操作成功");
						
						
						/*t.tree("reload",t.tree("getNode", target).id);
						t.tree("reload",t.tree(source.id));
						t.tree("reload",t.tree(source.id));*/
						//alert(t.tree("find",source.id).parentId);
						
						/*
						var sourceParentNode = t.tree("find", t.tree("find",source.id).parentId);
						t.tree("reload",sourceParentNode.target);
						var targetParentNode = t.tree("find",t.tree('getNode', target).parentId);
						t.tree("reload",targetParentNode.target);
						*/
					}else{
						message("操作失败");
						return false;
					}
				},
				failure : function(msg){
					message("操作失败");
					return false;
				}
			});
		},
		onContextMenu:function(e,node){
			e.preventDefault();
			$(this).tree("select",node.target);
			$("#mm").menu("show",{
				left:e.pageX,
				top:e.pageY
			})
		},
		onClick : function(node){
			/*document.getElementById("traceInputFrame").src = "${ctx}/se/se!traceValueInput.do?seRequirementTrace.traceId=" + node.id;
			taskTable.datagrid("clearChecked");
			console.log(node);
			$("#traceName").textbox("setValue",node.text);
			$("#traceId").textbox("setValue",node.id);
			document.getElementById("icl").checked="checked";
			
			
			traceId = node.id;
			loadTraceNoteDg();
			loadSeTraceDefectDg();
			loadTaskDgByTrace(node.id);*/
		}
	});
	
})


function createNewNode(){
	
	var node = t.tree("getSelected");
	//alert(node.id);
	if(!node){
		message("请选择父节点!");
		if(!node.id){
			message("未找到节点ID!");
		}
	}
	var url = "${ctx}/se/seRequirementTrace!createNewRequirementTrace.do?id=" + node.id
	
	opw({title:'矩阵信息',url:url,w:'95%',h:'95%'});
}

function opw(obj){
	
	document.getElementById("winSrc").src = obj.url;
	$("#win").window("setTitle",obj.title);
	var w =  obj.w;
	if(!w){
		w = document.body.clientWidth * 0.95;
	}
	var h = obj.h;
	if(!h){
		h = document.body.clientHeight * 0.95;
	}
	$('#win').window('open');// open a window
	$('#win').window('resize',{
		width:w,
		height:h
	});
	$('#win').window('center');
	
}

function clw(){
	$('#win').window('close');
}
function addNode(id,newNodeId){
	var node =  t.tree("find",id);
	t.tree("reload", node.target);
	
	var selected = t.tree('getSelected');
	t.tree('append', {
		parent: node.target,
		data: [{
			id: newNodeId,
			text: '新建矩阵节点'
		}]
	});
	focusNode(newNodeId);
}
//选择某节点
function focusNode(id){
	var node = t.tree('find',id);
	//alert(node.id);
	//alert(node.target.outerHTML);
	//alert(node.target.id);
	//alert(document.getElementById(node.target.id))
	t.tree('select',node.target);
}
//切换项目刷新需求矩阵根节点
function refreshTraceRoot(){
	var sysObjData = tab.datagrid("getSelected");
	//console.log(sysObjData);
	
	if(sysObjData){
		var obj = {
			"seRequirementTrace.projectId":sysObjData.PROJECT_ID
		}
		
		
		
		$.ajax("${ctx}/se/seRequirementTrace!getNextData.do",{
				data:obj,
				type:"POST",
				dataType :"json",
				success:function(re){
					console.log(re);
					t.tree('loadData',re);
				},
				error:function(){
					alert("后台执行错误");
				}
			}
		)
			
			
		
	}else{
		alert("请选择数据");
	}
}
//更新某节点
function updateNode(id,name){
	
	var node = t.tree('find',id);
	if (node){
		t.tree('update', {
			target: node.target,
			text: name
		});
	}
	
}
//修改某节点
function modiNode(){
	var node = t.tree('getSelected');
	if (node){
		var url = "${ctx}/se/seRequirementTrace!seRequirementTraceFormBootstrap.do?id=" + node.id;
		opw({title:'矩阵信息',url:url,w:'95%',h:'95%'});
	}
}
//刷新某节点
function refreshNode(){
	var node = t.tree('getSelected');
	if (node){
		t.tree("reload",node.target);
	}
}
//消息
function message(text){
	$.messager.show({
		title:'消息',
		msg:text,
		showType:'show'
	});
}





function reloadTraceTree(){
	t.tree('reload');
}
function filterTrace(){
	var k = $("#kw").textbox("getValue");
	//alert(k);
	//t.tree('expandTo', k);
	
	//前台过滤
	//t.tree('doFilter', '');
	//t.tree('doFilter', k);
	//t.tree('expandAll');
	
	//后台过滤
	
	$.ajax("${ctx}/se/se!traceFileter.do",
		{
			data:{msg:k},
			type:"POST",
			success:function(re){
				eval("var r = " + re);
				if(r.length > 0){
					for(var i = 0 , j = r.length ; i < j ; i++){
						var node =t.tree('find', r[i].traceId);
						if(node){
							//console.log(node)
							t.tree('update', {
								target:node.target,
								text: "<span style='color:red'>" + r[i].traceName + "</span>"  
							});
							t.tree('expandTo',  node.target);
						}
					}
				}
			}
		}
	)
	
	
	
	
	
			
	//var node =t.tree('find', '2c9a40dd5b1cb443015b1cde12550020');
	//t.tree('expandTo',  node.target);
	//t.tree('select', node.target);

	
}

function filterTraceAll(){
	var k = $("#kw").textbox("getValue");
	//alert(k);
	//t.tree('expandTo', k);
	
	$.ajax("${ctx}/se/se!traceFileter.do",
		{
			data:{msg:k},
			type:"POST",
			success:function(re){
				eval("var r = " + re);
				if(r.length > 0){
					for(var i = 0 , j = r.length ; i < j ; i++){
						var node =t.tree('find', r[i].traceId);
						if(node){
							//console.log(node)
							t.tree('update', {
								target:node.target,
								text: "<span style='color:red'>" + r[i].traceName + "</span>"  
							});
							t.tree('expandTo',  node.target);
						}
					}
				}
			}
		}
	)
	
	
	
	
	
			
	//var node =t.tree('find', '2c9a40dd5b1cb443015b1cde12550020');
	//t.tree('expandTo',  node.target);
	//t.tree('select', node.target);

	
}

function expendAllTree(){
	t.tree('expandAll');
}


</script>
	</head>
	<body class="easyui-layout">
	
		<div data-options="region:'east',split:true" style="width:350px;">
			
		</div>
		<div data-options="region:'center',split:true">
			<table id="projectUserTab">
			</table>
		</div>
		
		<div data-options="region:'west',split:true,border:false" style="width:265px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'north',split:true,border:false" style="height:200px;">
					<table id="dataTable">
					</table>
				</div>
				<div data-options="region:'center',split:true,title:'需求矩阵树'">
					<input type="text" class="easyui-textbox" style="width:100px;" id="kw"/>
					<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-filter'" onclick="filterTrace();" ></a>
					<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-search'" onclick="filterTraceAll();" ></a>
					<a href="#" class="easyui-linkbutton" title="清除搜索结果"  data-options="iconCls:'icon-clear'" onclick="reloadTraceTree();" ></a>
					<a href="#" class="easyui-linkbutton" title="全部展开"  data-options="iconCls:'icon-pin-red'" onclick="expendAllTree();" ></a>
					<ul id="tree" class="easyui-tree">
				    </ul>
				</div>
			</div>
			
		</div>
		
		<div id="tb" style="padding:2px 5px;">
	        <form action="" id="theForm" method="post">
	        	<c:if test="${authMap['PROJECT-MANAGE'] == staticVarObj.y }">
			        <a href="javascript:void(0)" class="easyui-linkbutton" title="新增项目" data-options="iconCls:'icon-add',plain:true" onclick="addObj()"></a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" title="编辑项目信息" data-options="iconCls:'icon-edit',plain:true" onclick="editData2()"></a>
			        <a href="javascript:void(0)" class="easyui-linkbutton" title="删除项目" data-options="iconCls:'icon-remove',plain:true" onclick="deleteDatas()"></a>
    			</c:if>
				<!-- 是否全部导出 -->
				<input type="hidden" id="isExportAll" name="isExportAll" value="true" />
				<input type="hidden" id="sort" name="sort" value="status" />
				<input type="hidden" id="order" name="order" value="desc" />
   				<input 
				type="text"
				class="easyui-textbox" 
				name="PROJECT_ID"
				id="PROJECT_ID"
				type="text" 
				style="width:80px;"
				 />
				<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-search'" onclick="loadDg()"></a>
				<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-clear'" onclick="resetForm()"></a>
			</form>
    
	    </div>
				
		<div id="mm" class="easyui-menu" style="width: 120px;">
		<c:if test="${authMap['REQUIRE-TRACE'] == staticVarObj.y }">
			<div data-options="iconCls:'icon-add'" onclick="createNewNode()">
				新增子节点
			</div>
			<div class="menu-sep"></div>
			<div data-options="iconCls:'icon-edit'" onclick="modiNode()">
				编辑该节点
			</div>
			<div data-options="iconCls:'icon-remove'" id="canelTodayDeal" >
				删除该节点
			</div>
			<div class="menu-sep"></div>
		</c:if>
		<div data-options="iconCls:'icon-reload'" onclick="refreshNode()">
			刷新
		</div>
	</div>
	<div id="win" title="矩阵信息"><iframe id="winSrc" frameborder="0" width="100%" height="100%"></iframe></div>
	
	
	</body>

</html>
