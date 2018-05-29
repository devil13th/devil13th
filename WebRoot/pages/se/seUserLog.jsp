<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>用户日志</title>
<meta charset="utf-8" />
<%@ include file="../../pub/pubCssJs.jsp"%>
<script>
var userLogTab;
var projectUserTab;
var user_list_setting ={
		url:'${ctx}/common/common!queryUserListAllJsonStr.do',
		valueField:'USER_ID',
		textField:'USER_NAME'
};

var input_user_list_setting ={
		url:'${ctx}/common/common!queryUserListAllJsonStr.do',
		valueField:'USER_ID',
		textField:'USER_NAME',
		onChange:function(){queryLogData("reload");}
};

var dic_user_list = {}
$.ajax({
	  dataType: "json",
	  url:'${ctx}/common/common!queryUserListAllJsonStr.do',
	  success: function(data){
		  dic_user_list = data;
		  //console.log(dic_bl_sys)
	  },
	  async:false
});
function user_list_formatter(value,row,index){
	for(var i = 0 , j = dic_user_list.length ; i < j ; i++){
		if(row.userId == dic_user_list[i].USER_ID){
			return dic_user_list[i].USER_NAME;
		}
	}
}


var project_list_setting ={
		url:'${ctx}/common/common!queryProjectListJsonStr.do',
		valueField:'value',
		textField:'text',
		required:true
};
var input_project_list_setting ={
		url:'${ctx}/common/common!queryProjectListJsonStr.do',
		valueField:'value',
		textField:'text',
		onChange:function(){queryLogData("reload");queryProjectUserData()}
};

var dic_project_list = {}
$.ajax({
	  dataType: "json",
	  url:'${ctx}/common/common!queryProjectListJsonStr.do',
	  success: function(data){
		  dic_project_list = data;
		  //console.log(dic_bl_sys)
	  },
	  async:false
});



function project_list_formatter(value,row,index){
	for(var i = 0 , j = dic_project_list.length ; i < j ; i++){
		if(row.projectId == dic_project_list[i].value){
			return dic_project_list[i].text;
		}
	}
}
	
	
$(function(){
	
	
	$("#projectId").combobox(input_project_list_setting);
	$("#userId").combobox(input_user_list_setting);
	$("#logDateL").datebox({onChange:function(){/*$("#logDateH").datebox("setValue",$("#logDateL").datebox("getValue"));*/queryLogData("reload")}});
	$("#logDateH").datebox({onChange:function(){queryLogData("reload")}});
	
	
	$('#calendar').calendar({
	    current:new Date(),
	    onSelect:function(date){
	    
	    	var dateStr = date.getFullYear()+"-"+((date.getMonth()+1) > 9 ? (date.getMonth()+1) : "0"+ (date.getMonth()+1))+"-"+(date.getDate() > 9 ? date.getDate() : "0"+ date.getDate());
	    	//alert(dateStr);
	    	$("#logDateL").textbox("setValue",dateStr);
	    	$("#logDateH").textbox("setValue",dateStr);
	    	queryLogData();
	    	showUser();
	    }
	});
	
	
	userLogTab = $('#userLogs').datagrid({
				title:'工作日志列表',
				iconCls : 'icon-ok',
				//数据来源
				//url : '${ctx}/se/se!seUserLogGetData.do?r=' + Math.random(),
				url : '${ctx}/se/se!querySeUserLogGetData.do?r=' + Math.random(),
				//斑马纹
				striped : true,
				//主键字段
				idField : "plogId",
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
				pagination : true,
				//分页信息
				pageSize : 10,
				//每页显示条目下拉菜单
				pageList : [ 5, 10, 20, 50, 100 ],
				//排序的列
				sortName : 'plogDate',
				//是否不换行
				nowrap: true,
				//排序方式
				sortOrder : "desc",
				//pageNumber:5,s
				rownumbers : true,//行号 
				//分页工具所在位置
				//pagePosition : "bottom",
				checkOnSelect:false,
				selectOnCheck:false,
				<c:if test="${authMap['FINANCE'] == staticVarObj.y }">
				showFooter: true,
				</c:if>
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
							field : 'plogId',
							title : '项目ID',
							checkbox : true,
							align : 'center'
						},
						{
							field : 'userId',
							title : '人员',
							width : 60,
							editor:{type:'combobox',options:user_list_setting},
							sortable : true,
							formatter:user_list_formatter
						},
						{
							field : 'plogDate',
							title : '日期',
							width : 75,
							editor:'datetimebox',
							sortable : true
						},
						{
							field : 'plogWorkload',
							title : '时长',
							width : 50,
							editor:{type:'textbox',options:{required:true}},
							sortable : true
						}
						
						] ],
				columns : [ [
						{
							field : 'plogRemark',
							title : '工作内容',
							width : 200,
							editor:{type:'textbox',options:{required:true}},
							sortable : true
						},
						<c:if test="${authMap['FINANCE'] == staticVarObj.y }">
						{
							field : 'dailyCost',
							title : 'DC',
							width : 60,
							sortable : false
						},
						</c:if>
						{
							field : 'taskTitle',
							title : '任务',
							width : 150,
							sortable : false,
						},
						{
							field : 'traceName',
							title : '需求名称',
							width : 150,
							sortable : false
						},
						{
							field : 'projectId',
							title : '项目名称',
							width : 100,
							editor:{type:'combobox',options:project_list_setting},
							sortable : true,
							formatter:project_list_formatter
						},
						{
							field : 'createDate',
							title : '创建时间',
							width : 75,
							sortable : true,
							editor:'datetimebox'
						}
						
						
						
						] ]

				,
				toolbar:'#tb',
				//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
				onSortColumn : function(sort, order) {
					$('#sort').val(sort);
					$('#order').val(order);
				}
				,

				onRowContextMenu:function(e,index,data){
					e.preventDefault();
					userLogTab.datagrid('selectRow',index);
					$('#mm').menu('show',{
						left: e.pageX-5,
						top: e.pageY-5
					});
				},
				onLoadSuccess:function(){
					showUser();
				}
		})
		
		
		
		
		
		projectUserTab = $('#projectUserTab').datagrid(
				{
					title:'项目用户列表',
					iconCls : 'icon-ok',
					//数据来源
					url : '${ctx}/se/se!seProjectUserListGetData.do?r=' + Math.random(),
					queryParams:{PROJECT_ID:"${seProjectInfo.projectId}"},
					//斑马纹
					striped : true,
					//主键字段
					idField : "USER_ID",
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
					checkOnSelect:false,
					selectOnCheck:false,
					columns : [ [
							{
								field : 'USER_ID',
								title : '用户ID',
								width : 100,
								sortable : true
							},
							{
								field : 'USER_NAME',
								title : '用户姓名',
								width : 100,
								sortable : true
							}
							] ]
					})



		
		
		
		
		
	});
	
	
	



function menuEditUserLog(){
	var row = userLogTab.datagrid("getSelected");
	var index = userLogTab.datagrid('getRowIndex',row.plogId);
	userLogTab.datagrid('beginEdit', index);
}

function saveAllUserLog(){
	var datas = userLogTab.datagrid('getData');
	if(datas.rows.length > 0){
		for(var i = 0 , j = datas.rows.length ; i < j ; i++){
			var b = userLogTab.datagrid('validateRow',i);
			if(!b){
				showMsg("错误信息","数据有误,请修改!");
				return false;
			};
			userLogTab.datagrid('endEdit',i);
		}
	}

	var changes = userLogTab.datagrid('getChanges');
	//alert(changes.length);
	if(changes.length >= 1){
		var r = "";
		var ct = 0;
		var res = ""; 
		
		for(var i = 0 , j = changes.length ; i < j ; i++){
			//console.log(JSON.stringify(changes[i]));
			
			$.ajax({
			  type: "POST",
			  url: "${ctx}/se/se!saveUserLogJsonData.do?_r= " + Math.random(),
			  data: { acceptJson: JSON.stringify(changes[i]), ids: changes[i].plogId},
			  success: function(data) {
					if(data.status != 'success'){
						res += (data.errMsg + ",");
					}
					ct++;
					//alert(ct+"|" + changes.length);
					if(ct == changes.length){
						if(res == ""){
							queryLogData("reload");
							//$.messager.alert('MESSAGE',' SAVE SUCCESS '  ,'info');
							showMsg("提示",'保存成功');
						}else{
							//$.messager.alert('ERR!','Err Info:[' + res + ']  NOT BE SAVED SUCCESS'  ,'error');
							showMsg("错误信息","Err Info:[" + res + "]  NOT BE SAVED SUCCESS");
						}
					}
					
				},
			  dataType: "json"
			});


			/*$.getJSON( "${ctx}/backlog/backlog!savePerBackInfo.do?acceptJson="+JSON.stringify(changes[i])+ "&blNo=" + changes[i].blId + "&_r= " + Math.random(), function(data) {
				if(data.status != 'success'){
					res += (data.errMsg + ",");
				}
				ct++;
				//alert(ct+"|" + changes.length);
				if(ct == changes.length){
					if(res == ""){
						$.messager.alert('MESSAGE',' SAVE SUCCESS '  ,'info');
					}else{
						$.messager.alert('ERR!','Err Info:[' + res + ']  NOT BE SAVED SUCCESS'  ,'error');
					}
				}
				
			});
			*/
	
		}
		//alert("changed date:"+r);
	}else{
		
		//$.messager.alert('MESSAGE',' SAVE SUCCESS '  ,'info');
		showMsg("提示","保存成功");
	}
}


function queryLogData(tp){
	var paramsObj = $("#searchForm").serializeArray();
	
	var queryObj = {a:Math.random()};
	var str = "";
	for(var i = 0 , j = paramsObj.length ; i < j ; i++){
		queryObj[paramsObj[i].name] = paramsObj[i].value;
		str += (paramsObj[i].name+":" + paramsObj[i].value + "\n")
	}
	//console.log(queryObj);
	
	if(tp!=null && tp=="reload"){
		userLogTab.datagrid("reload",queryObj);
	}else{
		userLogTab.datagrid("load",queryObj);
	}
}

function queryProjectUserData(){
	var projectId  = $("#projectId").combobox("getValue");
	projectUserTab.datagrid("load",{id:$("#projectId").combobox("getValue")});
}
function showMsg(tit,msg){
	$.messager.show({
		title:tit,
		msg:msg,
		timeout:2000,
		showType:'slide'
	});	
}

function createBlankLog(){
	$.getJSON( "${ctx}/se/se!createBlankUserLog.do?_r=" + Math.random(), function(data) {
		if(data.status == 'success'){
			var row = userLogTab.datagrid('appendRow',data.objJson);
			var index = userLogTab.datagrid('getRowIndex',data.objJson.plogId);
			//userLogTab.datagrid('endEdit', lastEditIndex);
			userLogTab.datagrid('beginEdit', index);
			userLogTab.datagrid('selectRow', index);
		}else{
			
			//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
			showMsg("错误信息",data.errMsg);
		}
	});
}




function deleteSePersonLogDatas(){
	if(confirm("确定删除勾选的日志么?")){
		var checkedIds = getUserLogCheckedIds();
		if(checkedIds == ""){
			alert("请勾选数据后再进行删除");
			return ;
		}
		$.ajax("${ctx}/se/se!deleteSePersonLogByIds.do?ids=" + checkedIds + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						alert('操作成功');
						userLogTab.datagrid("clearChecked");
						queryLogData("reload");
					}else{
						alert(str);
					};
				}
			}
		)
	}
}
//获取勾选的行
function getUserLogCheckedIds(){
	var data = userLogTab.datagrid("getChecked");
	var str = ""
	for(var i = 0 , j = data.length ; i < j ; i++){
		//alert(data[i].PLOG_ID);
		str += (data[i].plogId + ",");
	};
	if(str != ""){
		str = str.substring(0,str.length - 1);
		return str;
	}else{
		return "";
	}
	
} 



function linkTask(){
	var row = userLogTab.datagrid("getSelected");
	var rows = userLogTab.datagrid("getChecked");
	if(rows && rows.length > 0){
		//alert(row.projectId);
		showWin("${ctx}/se/seRequirementTrace!seRequirementTraceTaskSelect.do?cb=getParent().linkTaskCb&seRequirementTrace.projectId="+row.projectId);
	}else{
		alert("请选择数据");
	}
}

function linkTaskCb(data){
	//var row = userLogTab.datagrid("getSelected");
	
	var rows = userLogTab.datagrid("getChecked");
	//console.log(rows);
	
	var plogIds = "";
	if(rows && rows.length > 0){
		for(var i = 0 , j = rows.length ; i < j ; i++){
			plogIds += (","+rows[i].plogId);
		}
	}
	if(plogIds){
		plogIds = plogIds.substring(1,plogIds.length);
		console.log(plogIds);
		
		$.ajax("${ctx}/se/se!linkTaskForLog.do",
				{
					type:"POST",
					data:{
						'sePersonLog.plogId':plogIds,
						'seTraceTask.taskId':data.TASK_ID
					},
					success:function(r){
						var str = $.trim(r);
						if(str == "SUCCESS"){
							alert('操作成功');
							//userLogTab.datagrid("clearChecked");
							userLogTab.datagrid("clearChecked");
							queryLogData();
						}else{
							alert(str);
						};
					}
				}
			)
			
	}else{
		alert("请勾选日志记录");
	}
	
}


function rstUserLog(){
	$("#projectId").combobox("setValue","");
	$("#userId").combobox("setValue","");
	$("#logDateL").datebox("setValue","");
	$("#logDateH").datebox("setValue","");
	queryLogData();
}

function showUser(){
	projectUserTab.datagrid("unselectAll");
	var logData = userLogTab.datagrid("getRows");
	var userData = projectUserTab.datagrid("getRows");
	//console.log(logData.length);
	//console.log(userData.length);
	for(var i = 0 , j = logData.length ; i < j  ; i++){
		var lgD = logData[i];
		/*for(var x= 0 , y = userData.length ; x < y  ; x++){
			
			var userD = userData[x];
			console.log(lgD.userId + "|"+ userD.USER_ID)
			if(lgD.userId == userD.USER_ID){
				var no = projectUserTab.datagrid("getRowIndex",userD);
				projectUserTab.datagrid("selectRow",no);
			}
		}*/
		projectUserTab.datagrid("selectRecord",lgD.userId);
		//console.log(lgD.userId);
	}
}


</script>
</head>
<body class="easyui-layout">


<div id="mm" class="easyui-menu" style="width: 120px;">
			<div data-options="iconCls:'icon-edit'" onclick="menuEditUserLog()">
				编辑
			</div>
			<div class="menu-sep"></div>
</div>




<div data-options="region:'west',split:true" style="width:228px;padding:1px;">
		<form id="searchForm" method="post"/>
			<input type="hidden" id="sort" name="sort" value="status" />
			<input type="hidden" id="order" name="order" value="desc" />
			<table border="0">
				<tr>
					<td>Project:</td>
					<td><input type="text"  id="projectId"  name="projectId" style="width:130px;"/></td>
				</tr>
				<tr>
					<td>User   :</td>
					<td><input type="text"  id="userId"  name="userId" style="width:130px;"/></td>
				</tr>
				<tr>
					<td>From   :</td>
					<td><input type="text"  id="logDateL"  name="logDateL" class="easyui-datebox" style="width:130px;"/></td>
				</tr>
				<tr>
					<td>To   :</td>
					<td><input type="text"  id="logDateH"  name="logDateH" class="easyui-datebox" style="width:130px;"/></td>
				</tr>
			</table>
			 
			
			<div style="padding-top:5px;">
				<div class="easyui-calendar" id="calendar" style="width:212px;height:212px;">
				</div>
			</div>
			
		</form>
</div>		
		
		
<div data-options="region:'east',split:true" style="width:228px;padding:1px;">
	<table id="projectUserTab">

	</table>
</div>
<div data-options="region:'center',border:false">
	<table id ="userLogs"></table>
	<div id="tb" >
		<a href="javascript:void(0)" class="easyui-linkbutton" title="新增" data-options="iconCls:'icon-add',plain:true" onclick="createBlankLog()">新增</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" title="保存" data-options="iconCls:'icon-save',plain:true" onclick="saveAllUserLog()">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" title="编辑" data-options="iconCls:'icon-edit',plain:true" onclick="menuEditUserLog()">编辑</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" data-options="iconCls:'icon-search',plain:true" onclick="queryLogData()">查询</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" data-options="iconCls:'icon-refresh',plain:true" onclick="rstUserLog()">重置</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" title="删除" data-options="iconCls:'icon-err',plain:true" onclick="deleteSePersonLogDatas()">删除</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" title="关联任务" data-options="iconCls:'icon-tag-purple',plain:true" onclick="linkTask()">关联任务</a>
		
	</div>
</div>

	
</div>



</body>
</html>