
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

var theSysDicProcessStepForm;
$(function(){
	theSysDicProcessStepForm = $('#theSysDicProcessStepForm').form({
		ajax:false
	});
})

function resetSysDicProcessStepForm(){
	theSysDicProcessStepForm.form("clear");
	loadDg();
}

function submitForm(){
	var b = theSysDicProcessStepForm.form("validate");
	if(b){
		document.getElementById("theSysDicProcessStepForm").submit();
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
			<s:form action="common!sysDicProcessStepFormSubmit" namespace="/common" method="post" id="theSysDicProcessStepForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					步骤ID<input 
							class="easyui-textbox" 
							name="sysDicProcessStep.stepId"
							id="stepId" 
							type="text"
							value="${sysDicProcessStep.stepId}" />
				</div>
				<table class="common submit" border="1" width="100%">



					<tr>
						<th>
							所属流程ID
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcessStep.processId"
							id="processId" 
							type="text"
							data-options="required:true"
							value="${sysDicProcessStep.processId}" />
						</td>
					</tr>
					<tr>
						<th>
							步骤CODE
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcessStep.stepCode"
							id="stepCode" 
							type="text"
							data-options="required:true"
							value="${sysDicProcessStep.stepCode}" />
						</td>
					</tr>
					<tr>
						<th>
							步骤名称
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcessStep.stepName"
							id="stepName" 
							type="text"
							data-options="required:true"
							value="${sysDicProcessStep.stepName}" />
						</td>
					</tr>
					<tr>
						<th>
							步骤序号
						</th>
						<td>
							<input 
							class="easyui-numberbox" 
							name="sysDicProcessStep.stepOrder"
							id="stepOrder" 
							type="text" 
							precision="0" max="100" min="0"
							style="width:50px;"
							value="${sysDicProcessStep.stepOrder}" />
						</td>
					</tr>
					<tr>
						<th>
							是否第一步骤
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcessStep.isFirstStep"
							id="isFirstStep" 
							type="text"
							data-options="required:true"
							value="${sysDicProcessStep.isFirstStep}" />
						</td>
					</tr>
					<tr>
						<th>
							是否最后一个步骤
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcessStep.isLastStep"
							id="isLastStep" 
							type="text"
							data-options="required:true"
							value="${sysDicProcessStep.isLastStep}" />
						</td>
					</tr>
					<tr>
						<th>
							是否删除
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicProcessStep.isDelete"
							id="isDelete" 
							type="text"
							data-options="required:true"
							value="${sysDicProcessStep.isDelete}" />
						</td>
					</tr>
					
				</table>
				<br />
				<center>
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="submitForm()">提交</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSysDicProcessStepForm()">重置</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="window.close()">关闭</a>  
					
				</center>
			</s:form>
		</div>
	</body>
</html>
