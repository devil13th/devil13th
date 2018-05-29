
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<title><s:text name="title.applyName"></s:text>
		</title>
	
<style type="text/css">
</style>
<script>

var theForm;



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
$(function(){
	$("#checkUser,#checkedUser").combobox(input_user_list_setting);
	$("#projectId").combobox(input_project_list_setting);
	theForm = $('#theForm').form({
		ajax:false
	});
})

function resetForm(){
	theForm.form("clear");
	loadDg();
}

function submitForm(){
	var b = theForm.form("validate");
	if(b){
		document.getElementById("theForm").submit();
	}else{
		alert("请根据表单红色提示进行修改");
	};
	
}
function cw(){
	top.closeWin();
}

function selectChecklist(){
	showWin("${ctx}/checklist/checklist!checklistSelector.do");
}

function selectProjectModule(){
	var projectId = $("#projectId").combobox("getValue");
	if(projectId){
		showWin("${ctx}/se/seRequirementTrace!seRequirementTraceSelect.do?cb=getParent().selectProjectModuleCb&seRequirementTrace.projectId="+projectId);
	}else{
		alert("请选择所属系统");
	}
}

function selectChecklistCb(obj){
	//console.log(obj);
	//alert(obj.id);
	//alert(obj.name);
	$('#checklistId').textbox("setValue",obj.id);
	$("#cklistName").html(obj.name);
}


function selectProjectModuleCb(obj){
	$("#checkModule").textbox("setValue",obj.text);
	$("#traceId").val(obj.id);
	$("#traceName").html(obj.text);
	//alert(obj);
}

</script>
	</head>

	<body>
		<div id="pbody">
			<s:form action="checklist!checklistImplBatchFormSubmit" namespace="/checklist" method="post" id="theForm">
				<input 
							name="checklistImplBatch.id"
							id="id" 
							type="hidden"
							data-options="required:true"
							value="${checklistImplBatch.id}" />
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					
				</div>
				<table class="common submit" border="1" width="100%">

					<tr>
						<th>
							批次
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="checklistImplBatch.checkBatch"
							id="checkBatch" 
							type="text"
							data-options="required:true"
							value="${checklistImplBatch.checkBatch}" />
						</td>
					</tr>
					<tr>
						<th>
							检查人
						</th>
						<td>
							<input 
							name="checklistImplBatch.checkUser"
							id="checkUser" 
							type="text"
							data-options="required:true"
							value="${checklistImplBatch.checkUser}" />
							
							
						</td>
					</tr>
					
					<tr>
						<th>
							所属项目
						</th>
						<td>
							<input 
							name="checklistImplBatch.projectId"
							id="projectId" 
							value="${checklistImplBatch.projectId}" />
						</td>
					</tr>
					
					<tr>
						<th>
							功能模块
						</th>
						<td>
							<span id="traceName">${trace.traceName }</span>
							<input 
							name="checklistImplBatch.traceId"
							id="traceId" 
							type="hidden"
							value="${checklistImplBatch.traceId}" />
							<input type="button" onclick="selectProjectModule()" value="选择"/>
						</td>
					</tr>
					<tr>
						<th>
							功能模块描述
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="checklistImplBatch.checkModule"
							id="checkModule" 
							type="text"
							data-options="required:true"
							value="${checklistImplBatch.checkModule}" />
						</td>
					</tr>
					<tr>
						<th>
							检验项目目录
						</th>
						<td>
						<span id="cklistName">${ckl.cklistName}</span>
							<input 
							class="easyui-textbox" 
							name="checklistImplBatch.checklistId"
							id="checklistId" 
							type="hidden"
							data-options="required:true"
							value="${checklistImplBatch.checklistId}" /><input type="button" onclick="selectChecklist()" value="选择"/>
						</td>
					</tr>
					<tr>
						<th>
							开发人员
						</th>
						<td>
							<input 
							name="checklistImplBatch.checkedUser"
							id="checkedUser" 
							type="text"
							data-options="required:true"
							value="${checklistImplBatch.checkedUser}" />
						</td>
					</tr>
					<tr>
						<th>
							检查时间
						</th>
						<td>
							<input 
							class="easyui-datetimebox" 
							name="checklistImplBatch.checkTime"
							id="checkTime" 
							type="text"
							data-options="required:true"
							value="<fmt:formatDate value="${checklistImplBatch.checkTime}" pattern="yyyy-MM-dd HH:mm:ss"/>  " />
						</td>
					</tr>
					<tr>
						<th>
							是否删除
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="checklistImplBatch.isDelete"
							id="isDelete" 
							type="text"
							data-options="required:true"
							value="${checklistImplBatch.isDelete}" />
						</td>
					</tr>
					<tr>
						<th>
							备注
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="checklistImplBatch.checkDesc"
							id="checkDesc" 
							type="text"
							value="${checklistImplBatch.checkDesc}" />
						</td>
					</tr>
					
				</table>
				<br />
				<center>
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="submitForm()">提交</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetForm()">重置</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="window.close()">关闭</a>  
					
				</center>
			</s:form>
		</div>
	</body>
</html>
