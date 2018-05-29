<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>用户日志</title>
<meta charset="utf-8" />
<%@ include file="../../pub/pubCssJs.jsp"%>
<script>
var tab;

var user_list_setting ={
		url:'${ctx}/common/common!queryUserListJsonStr.do',
		valueField:'USER_ID',
		textField:'USER_NAME'
};

var input_user_list_setting ={
		url:'${ctx}/common/common!queryUserListJsonStr.do',
		valueField:'USER_ID',
		textField:'USER_NAME',
		onChange:function(){loadData("reload")}
};

var dic_user_list = {}
$.ajax({
	  dataType: "json",
	  url:'${ctx}/common/common!queryUserListJsonStr.do',
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
		textField:'text'
};
var input_project_list_setting ={
		url:'${ctx}/common/common!queryProjectListJsonStr.do',
		valueField:'value',
		textField:'text',
		onChange:function(){loadData("reload")}
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
	
	
	$("#sysList").combobox(input_project_list_setting);
	$("#userList").combobox(input_user_list_setting);
	$("#logDateH").datebox({onChange:function(){loadData("reload")}});
	$("#logDateL").datebox({onChange:function(){loadData("reload")}});
	
	$('#calendar').calendar({
	    current:new Date(),
	    onSelect:function(date){
	    
	    	var dateStr = date.getFullYear()+"-"+((date.getMonth()+1) > 9 ? (date.getMonth()+1) : "0"+ (date.getMonth()+1))+"-"+(date.getDate() > 9 ? date.getDate() : "0"+ date.getDate());
	    	//alert(dateStr);
	    	$("#logDateL").textbox("setValue",dateStr);
	    	$("#logDateH").textbox("setValue",dateStr);
	    	loadData();
	    }
	});
	
	
	tab = $('#userLogs').datagrid({
				title:'工作日志列表',
				iconCls : 'icon-ok',
				//数据来源
				url : '${ctx}/se/se!seUserLogGetData.do?r=' + Math.random(),
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
				                   
				                   
				                   /*
				                   " v.plog_id as plogId, "+
				" v.user_name as userName, "+
				" v.pro_name as proName, "+
				" v.plog_remark as plogRemark, "+
				" v.plog_workload as  plogWorkload, "+
				" v.plog_date as plogDate, "+
				" v.trace_name as traceName, "+
				" v.task_title as taskTitle, "+
				" v.begin_date as beginDate, "+
				" v.finish_date as finishDate, "+
				" v.work_load as planWorkLoad, "+
				" v.task_require as taskRequire, "+
				" v.task_status as taskStatus, "+
				" v.user_id as userId, "+
				" v.project_id  as projectId, "+
				" v.trace_id  as traceId "+
				*/
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
							width : 100,
							editor:{type:'combobox',options:user_list_setting},
							sortable : true,
							formatter:user_list_formatter
						},
						{
							field : 'plogDate',
							title : '日期',
							width : 100,
							editor:'datebox',
							sortable : true
						},
						{
							field : 'plogWorkload',
							title : '时长',
							width : 50,
							editor:{type:'textbox',options:{required:true}},
							sortable : true
						},
						
						] ],
				columns : [ [
						{
							field : 'projectId',
							title : '项目名称',
							width : 100,
							editor:{type:'combobox',options:project_list_setting},
							sortable : true,
							formatter:project_list_formatter
						},
						
						{
							field : 'plogRemark',
							title : '工作内容',
							width : 200,
							editor:{type:'textbox',options:{required:true}},
							sortable : true
						},
						{
							field : 'traceName',
							title : '需求名称',
							width : 200,
							sortable : true
						},
						{
							field : 'taskTitle',
							title : '任务名称',
							width : 200,
							sortable : true
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
					tab.datagrid('selectRow',index);
					$('#mm').menu('show',{
						left: e.pageX-5,
						top: e.pageY-5
					});
				}
	})
})



function menuEdit(){
	var row = tab.datagrid("getSelected");
	var index = tab.datagrid('getRowIndex',row.plogId);
	tab.datagrid('beginEdit', index);
}

function saveAll(){
	var datas = tab.datagrid('getData');
	if(datas.rows.length > 0){
		for(var i = 0 , j = datas.rows.length ; i < j ; i++){
			var b = tab.datagrid('validateRow',i);
			if(!b){
				showMsg("错误信息","数据有误,请修改!");
				return false;
			};
			tab.datagrid('endEdit',i);
		}
	}

	var changes = tab.datagrid('getChanges');
	//alert(changes.length);
	if(changes.length >= 1){
		var r = "";
		var ct = 0;
		var res = ""; 
		
		for(var i = 0 , j = changes.length ; i < j ; i++){
			console.log(JSON.stringify(changes[i]));
			
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
							loadData("reload");
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


function loadData(tp){
	var paramsObj = $("#searchForm").serializeArray();
	
	var queryObj = {a:Math.random()};
	var str = "";
	for(var i = 0 , j = paramsObj.length ; i < j ; i++){
		queryObj[paramsObj[i].name] = paramsObj[i].value;
		str += (paramsObj[i].name+":" + paramsObj[i].value + "\n")
	}
	console.log(queryObj);
	
	if(tp!=null && tp=="reload"){
		tab.datagrid("reload",queryObj);
	}else{
		tab.datagrid("load",queryObj);
	}
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
			var row = tab.datagrid('appendRow',data.objJson);
			var index = tab.datagrid('getRowIndex',data.objJson.plogId);
			//tab.datagrid('endEdit', lastEditIndex);
			tab.datagrid('beginEdit', index);
			tab.datagrid('selectRow', index);
		}else{
			
			//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
			showMsg("错误信息",data.errMsg);
		}
	});
}

function rst(){
	$("#sysList").combobox("setValue","");
	$("#userList").combobox("setValue","");
	$("#logDateL").datebox("setValue","");
	$("#logDateH").datebox("setValue","");
	loadData();
}




function deleteSePersonLogDatas(){
	if(confirm("确定删除勾选的日志么?")){
		var checkedIds = getCheckedIds();
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
						tab.datagrid("clearChecked");
						loadData("reload");
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


function linkTrace(){
	var row = tab.datagrid("getSelected");
	if(row){
		//alert(row.projectId);
		showWin("${ctx}/se/seRequirementTrace!seRequirementTraceSelect.do?cb=getParent().linkTraceCb&seRequirementTrace.projectId="+row.projectId);
	}else{
		alert("请选择数据");
	}
}
function linkTraceCb(data){
	console.log(data);
	var row = tab.datagrid("getSelected");
	console.log(row);
	$.ajax("${ctx}/se/se!linkTraceForLog.do",
			{
				type:"POST",
				data:{
					'sePersonLog.plogId':row.plogId,
					'seRequirementTrace.traceId':data.id
				},
				success:function(r){
					var str = $.trim(r);
					if(str == "SUCCESS"){
						alert('操作成功');
						//tab.datagrid("clearChecked");
						loadData();
					}else{
						alert(str);
					};
				}
			}
		)
			
}


</script>
</head>
<body class="easyui-layout">


<div id="mm" class="easyui-menu" style="width: 120px;">
			<div data-options="iconCls:'icon-edit'" onclick="menuEdit()">
				编辑
			</div>
			<div class="menu-sep"></div>
</div>
<div id="tb" >
	<a href="javascript:void(0)" class="easyui-linkbutton" title="新增项目" data-options="iconCls:'icon-add',plain:true" onclick="createBlankLog()">新增</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" title="新增项目" data-options="iconCls:'icon-save',plain:true" onclick="saveAll()">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" title="编辑项目信息" data-options="iconCls:'icon-edit',plain:true" onclick="editData2()">编辑</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" title="查询" data-options="iconCls:'icon-search',plain:true" onclick="loadData()">查询</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" title="重置" data-options="iconCls:'icon-refresh',plain:true" onclick="rst()">重置</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" title="删除" data-options="iconCls:'icon-err',plain:true" onclick="deleteSePersonLogDatas()">删除</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" title="关联需求" data-options="iconCls:'icon-tag-purple',plain:true" onclick="linkTrace()">关联矩阵</a>
</div>

<div data-options="region:'east',title:'Search',split:true" style="width:222px;padding:2px;">
<form id="searchForm" method="post"/>
	<table border="0">
		<tr>
			<td>Project:</td>
			<td><input type="text"  id="sysList"  name="sysList" style="width:130px;"/></td>
		</tr>
		<tr>
			<td>User   :</td>
			<td><input type="text"  id="userList"  name="userList" style="width:130px;"/></td>
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
		<div class="easyui-calendar" id="calendar" style="width:212px;height:212px;"></div>
		</div>
	</div>
</form>

<div data-options="region:'center',border:false">
	<table id ="userLogs"></table>
</div>




</body>
</html>