
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

var theSysDicProcessForm;
$(function(){
	theSysDicProcessForm = $('#theSysDicProcessForm').form({
		ajax:false
	});
})

function resetSysDicProcessForm(){
	theSysDicProcessForm.form("clear");
	loadDg();
}

function submitForm(){
	var b = theSysDicProcessForm.form("validate");
	if(b){
		document.getElementById("theSysDicProcessForm").submit();
	}else{
		alert("请根据表单红色提示进行修改");
	};
	
}
function cw(){
	top.closeWin();
}


</script>
	</head>

	<body>
		<div id="pbody">
			<s:form action="common!sysDicProcessFormSubmit" namespace="/common" method="post" id="theSysDicProcessForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					流程ID<input 
							class="easyui-textbox" 
							name="sysDicProcess.processId"
							id="processId" 
							type="text"
							value="${sysDicProcess.processId}" />
				</div>
				<table class="common submit" border="1" width="100%">
					



					<tr>
						<th>
							流程KEY
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcess.processKey"
							id="processKey" 
							type="text"
							data-options="required:true"
							value="${sysDicProcess.processKey}" />
						</td>
					</tr>
					<tr>
						<th>
							流程名称
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcess.processName"
							id="processName" 
							type="text"
							data-options="required:true"
							value="${sysDicProcess.processName}" />
						</td>
					</tr>
					<tr>
						<th>
							流程定义ID
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcess.processDefId"
							id="processDefId" 
							type="text"
							data-options="required:true"
							value="${sysDicProcess.processDefId}" />
						</td>
					</tr>
					<tr>
						<th>
							Service名称
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcess.processService"
							id="processService" 
							type="text"
							data-options="required:true"
							value="${sysDicProcess.processService}" />
						</td>
					</tr>
					<tr>
						<th>
							是否删除
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcess.isDelete"
							id="isDelete" 
							type="text"
							data-options="required:true"
							value="${sysDicProcess.isDelete}" />
						</td>
					</tr>
					
				</table>
				<br />
				<center>
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="submitForm()">提交</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSysDicProcessForm()">重置</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="window.close()">关闭</a>  
					
				</center>
			</s:form>
		</div>
	</body>
</html>
