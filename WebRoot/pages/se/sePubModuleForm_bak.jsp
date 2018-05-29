
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
$(function(){
	theForm = $('#theForm').form({
		ajax:false
	});
	
	
	$('#moduleClassify').combobox({
	    url:'${ctx}/common/common!getDicJsonStr.do?sysDicPub.dicClassify=module_classify',
	    valueField:'dic_id',
	    textField:'dic_name',
	    editable: true,
	    method: 'post',
		mode: 'remote',
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






</script>
	</head>

	<body>
		<div id="pbody">
			<s:form action="se!sePubModuleFormSubmit" namespace="/se" method="post" id="theForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					组件ID<input 
							class="easyui-textbox" 
							name="sePubModule.moduleId"
							id="moduleId" 
							type="text"
							value="${sePubModule.moduleId}" />
				</div>
				<table class="common submit" border="1" width="100%">

					<tr>
						<th>
							组件标题
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.moduleTitle"
							id="moduleTitle" 
							type="text"
							data-options="required:true"
							value="${sePubModule.moduleTitle}" />
						</td>
					</tr>
					<tr>
						<th>
							组件分类
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.moduleClassify"
							id="moduleClassify" 
							type="text"
							data-options="required:true"
							value="${sePubModule.moduleClassify}" />
						</td>
					</tr>
					<tr>
						<th>
							组件方法名
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.moduleName"
							id="moduleName" 
							type="text"
							data-options="required:true"
							value="${sePubModule.moduleName}" />
						</td>
					</tr>
					<tr>
						<th>
							组件输入
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.moduleInput"
							id="moduleInput" 
							type="text"
							value="${sePubModule.moduleInput}" />
						</td>
					</tr>
					<tr>
						<th>
							组件输出
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.moduleOutput"
							id="moduleOutput" 
							type="text"
							value="${sePubModule.moduleOutput}" />
						</td>
					</tr>
					<tr>
						<th>
							组件描述
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.moduleDesc"
							id="moduleDesc" 
							type="text"
							value="${sePubModule.moduleDesc}" />
						</td>
					</tr>
					<tr>
						<th>
							组件所在文件
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.moduleFile"
							id="moduleFile" 
							type="text"
							value="${sePubModule.moduleFile}" />
						</td>
					</tr>
					<tr>
						<th>
							组件示例
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.moduleExample"
							id="moduleExample" 
							type="text"
							value="${sePubModule.moduleExample}" />
						</td>
					</tr>
					<tr>
						<th>
							组件发布日期
						</th>
						<td>
							<input 
							class="easyui-datebox" 
							name="sePubModule.moduleDate"
							id="moduleDate" 
							type="text"
							data-options="required:true"
							value="${sePubModule.moduleDate}" />
						</td>
					</tr>
					<tr>
						<th>
							组件负责人
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.moduleUser"
							id="moduleUser" 
							type="text"
							data-options="required:true"
							value="${sePubModule.moduleUser}" />
						</td>
					</tr>
					<tr>
						<th>
							所属项目
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sePubModule.projectId"
							id="projectId" 
							type="text"
							data-options="required:true"
							value="${sePubModule.projectId}" />
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
