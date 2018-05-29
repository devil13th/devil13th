
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
})

function resetForm(){
	theForm.form("reset");
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
			<s:form action="seRequirementTrace!seRequirementTraceFormSubmit" namespace="/se" method="post" id="theForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					创建时间<input 
							class="easyui-datebox" 
							name="seRequirementTrace.createTime"
							id="createTime" 
							type="text"
							data-options=""
							value="${seRequirementTrace.createTime}" /><br/>
							更新时间<input 
							class="easyui-datebox" 
							name="seRequirementTrace.updateTime"
							id="updateTime" 
							type="text"
							data-options=""
							value="${seRequirementTrace.updateTime}" /><br/>
							是否叶子节点<input 
							class="easyui-textbox" 
							name="seRequirementTrace.isLeaf"
							id="isLeaf" 
							type="text"
							data-options="required:true"
							value="${seRequirementTrace.isLeaf}" /><br/>
							是否删除<input 
							class="easyui-textbox" 
							name="seRequirementTrace.isDelete"
							id="isDelete" 
							type="text"
							data-options="required:true"
							value="${seRequirementTrace.isDelete}" /><br/>
							矩阵ID<input
							class="easyui-textbox" 
							name="seRequirementTrace.traceId"
							id="traceId" 
							type="text"
							data-options="required:true"
							value="${seRequirementTrace.traceId}" /><br/>
							树形目录代码<input 
							class="easyui-textbox" 
							name="seRequirementTrace.treeCode"
							id="treeCode" 
							type="text"
							data-options="required:true"
							value="${seRequirementTrace.treeCode}" /><br/>
				</div>
				<table class="common submit" border="0" width="100%">
					<tr>
						<th>
							项目ID
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seRequirementTrace.projectId"
							id="projectId" 
							type="text"
							value="${seRequirementTrace.projectId}" />
						</td>
					</tr>
					<tr>
						<th>
							矩阵编号
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seRequirementTrace.traceNo"
							id="traceNo" 
							type="text"
							data-options="required:true"
							value="${seRequirementTrace.traceNo}" />
						</td>
					</tr>
					<tr>
						<th>
							矩阵名称
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seRequirementTrace.traceName"
							id="traceName" 
							type="text"
							data-options="required:true"
							value="${seRequirementTrace.traceName}" />
						</td>
					</tr>
					<tr>
						<th>
							排序号
						</th>
						<td>
							<input 
							class="easyui-numberbox" 
							name="seRequirementTrace.traceOrder"
							id="traceOrder" 
							type="text" 
							precision="1" max="100" min="0"
							style="width:50px;"
							value="${seRequirementTrace.traceOrder}" />
						</td>
					</tr>
					<tr>
						<th>
							是否有效
						</th>
						<td>
		                    <s:select id="validSelect" cssStyle="width:150px;" cssClass="easyui-combobox" name="seRequirementTrace.isValid" list="#{'1':'有效','0':'无效'}" headerKey="" headerValue="请选择"></s:select>  
						</td>
					</tr>
				</table>
				<br />
				<center>
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="submitForm()">提交</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetForm()">重置</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="parent.clw()">关闭</a>  
				</center>
			</s:form>
		</div>
	</body>
</html>
