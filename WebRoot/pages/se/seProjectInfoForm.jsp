
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
			<s:form action="se!seProjectInfoFormSubmit" namespace="/se" method="post" id="theForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
				</div>
				<table class="common submit" border="1" width="100%">
					
					

					
					<tr>
						<th>
							项目ID
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seProjectInfo.projectId"
							id="projectId" 
							type="text"
							value="${seProjectInfo.projectId}" <c:if test="${operate=='update'}">readonly="readonly"</c:if>/>
						</td>
					</tr>
					
					<tr>
						<th>
							项目标号
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seProjectInfo.proNo"
							id="proNo" 
							type="text"
							data-options="required:true"
							value="${seProjectInfo.proNo}" />
						</td>
					</tr>
					<tr>
						<th>
							项目名称
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seProjectInfo.proName"
							id="proName" 
							type="text"
							data-options="required:true"
							value="${seProjectInfo.proName}" />
						</td>
					</tr>
					<tr>
						<th>
							项目描述
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seProjectInfo.proDescription"
							id="proDescription" 
							type="text"
							data-options="required:true"
							value="${seProjectInfo.proDescription}" />
						</td>
					</tr>
					<tr>
						<th>
							项目目标
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seProjectInfo.proTarget"
							id="proTarget" 
							type="text"
							data-options="required:true"
							value="${seProjectInfo.proTarget}" />
						</td>
					</tr>
					<tr>
						<th>
							项目背景
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seProjectInfo.proBackground"
							id="proBackground" 
							type="text"
							data-options="required:true"
							value="${seProjectInfo.proBackground}" />
						</td>
					</tr>
					<tr>
						<th>
							最终交付物
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seProjectInfo.finalConsign"
							id="finalConsign" 
							type="text"
							data-options="required:true"
							value="${seProjectInfo.finalConsign}" />
						</td>
					</tr>
					<tr>
						<th>
							项目经理
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seProjectInfo.proLeader"
							id="proLeader" 
							type="text"
							data-options="required:true"
							value="${seProjectInfo.proLeader}" />
						</td>
					</tr>
					<tr>
						<th>
							项目成员
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seProjectInfo.proMember"
							id="proMember" 
							type="text"
							data-options="required:true"
							value="${seProjectInfo.proMember}" />
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
