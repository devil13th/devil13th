
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
			<s:form action="common!sysDicPubFormSubmit" namespace="/common" method="post" id="theForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					
				</div>
				<table class="common submit" border="1" width="100%">
					
					<tr>
						<th>
							字典标识
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicPub.dicId"
							id="dicId" 
							type="text"
							data-options="required:true"
							value="${sysDicPub.dicId}" />
						</td>
					</tr>



					<tr>
						<th>
							字典分类
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicPub.dicClassify"
							id="dicClassify" 
							type="text"
							data-options="required:true"
							value="${sysDicPub.dicClassify}" />
						</td>
					</tr>
					<tr>
						<th>
							字典名称
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicPub.dicName"
							id="dicName" 
							type="text"
							data-options="required:true"
							value="${sysDicPub.dicName}" />
						</td>
					</tr>
					<tr>
						<th>
							备注
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="sysDicPub.dicDesc"
							id="dicDesc" 
							type="text"
							data-options="required:true"
							value="${sysDicPub.dicDesc}" />
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
