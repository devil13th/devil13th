
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
			<s:form action="se!seUserFormSubmit" namespace="/se" method="post" id="theForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					
				</div>
				<table class="common submit" border="1" width="100%">
					<tr>
					
					
							
						<th>
							用户ID
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seUser.userId"
							id="userId" 
							type="text"
							<c:if test="${operate == 'update'}">readonly="readonly"</c:if>
							value="${seUser.userId}" />
						</td>
						</tr>
						<tr>
						<th>
							用户姓名
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seUser.userName"
							id="userName" 
							type="text"
							data-options="required:true"
							value="${seUser.userName}" />
						</td>
					</tr>
					<tr>
						<th>
							用户名
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seUser.userAccount"
							id=".userAccount" 
							type="text"
							data-options="required:true"
							value="${seUser.userAccount}" />
						</td>
					</tr>
					<tr>
						<th>
							用户密码
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seUser.userPassword"
							id="userPassword" 
							type="text"
							data-options="required:true"
							value="${seUser.userPassword}" />
						</td>
					</tr>
					
					
					
					
					<tr>
						<th>
							所在公司
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seUser.companyName"
							id="companyName" 
							type="text"
							data-options="required:true"
							value="${seUser.companyName}" />
						</td>
					</tr>
					<tr>
						<th>
							邮箱
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seUser.userMail"
							id="userMail" 
							type="text"
							data-options="required:true"
							value="${seUser.userMail}" />
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
