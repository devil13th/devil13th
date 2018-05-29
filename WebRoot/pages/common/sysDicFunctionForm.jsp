
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

var theSysDicFunctionForm;
$(function(){
	theSysDicFunctionForm = $('#theSysDicFunctionForm').form({
		ajax:false
	});
})

function resetSysDicFunctionForm(){
	theSysDicFunctionForm.form("clear");
	loadDg();
}

function submitForm(){
	var b = theSysDicFunctionForm.form("validate");
	if(b){
		document.getElementById("theSysDicFunctionForm").submit();
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
			<s:form action="common!sysDicFunctionFormSubmit" namespace="/common" method="post" id="theSysDicFunctionForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					功能主键<input 
							class="easyui-textbox" 
							name="sysDicFunction.funId"
							id="funId" 
							type="text"
							value="${sysDicFunction.funId}" />
				</div>
				<table class="common submit" border="1" width="100%">
					



					<tr>
						<th>
							功能名称
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicFunction.funName"
							id="funName" 
							type="text"
							data-options="required:true"
							value="${sysDicFunction.funName}" />
						</td>
					</tr>
					<tr>
						<th>
							功能URL
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicFunction.funUrl"
							id="funUrl" 
							type="text"
							data-options="required:true"
							value="${sysDicFunction.funUrl}" />
						</td>
					</tr>
					<tr>
						<th>
							功能描述
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicFunction.funDesc"
							id="funDesc" 
							type="text"
							data-options="required:true"
							value="${sysDicFunction.funDesc}" />
						</td>
					</tr>
					<tr>
						<th>
							是否有效
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicFunction.isValid"
							id="isValid" 
							type="text"
							data-options="required:true"
							value="${sysDicFunction.isValid}" />
						</td>
					</tr>
					<tr>
						<th>
							是否删除
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicFunction.isDelete"
							id="isDelete" 
							type="text"
							data-options="required:true"
							value="${sysDicFunction.isDelete}" />
						</td>
					</tr>
					
				</table>
				<br />
				<center>
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="submitForm()">提交</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetSysDicFunctionForm()">重置</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="window.close()">关闭</a>  
					
				</center>
			</s:form>
		</div>
	</body>
</html>
