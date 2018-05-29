
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
			<s:form action="se!seTraceKeyFormSubmit" namespace="/se" method="post" id="theForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					主键<input 
							class="easyui-textbox" 
							name="seTraceKey.kid"
							id="kid" 
							type="text"
							data-options=""
							value="${seTraceKey.kid}" /><br/>
				</div>
				<table class="common submit" border="0" width="100%">
					<tr>
						<th>
							矩阵id
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seTraceKey.traceId"
							id="traceId" 
							type="text"
							data-options=""
							value="${seTraceKey.traceId}" />
						</td>
					</tr>
					<tr>
						<th>
							属性名称
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seTraceKey.kname"
							id="kname" 
							type="text"
							data-options="required:true"
							value="${seTraceKey.kname}" />
						</td>
					</tr>
					<tr>
						<th>
							属性代码(小写英文字母)
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seTraceKey.kcode"
							id="kcode" 
							type="text"
							data-options="required:true"
							value="${seTraceKey.kcode}" />
						</td>
					</tr>
					<tr>
						<th>
							属性类型
						</th>
						<td>
							
							 <s:select 
							 id="ktype" 
							 cssStyle="width:150px;"
							 cssClass="easyui-combobox" 
							 name="seTraceKey.ktype" 
							 list="#{'STRING':'字符串','CLOB':'大文本','DIC':'字典','INT':'整数','FLOAT':'小数','DATE':'日期'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>
						</td>
					</tr>
					<tr>
						<th>
							属性备注
						</th>
						<td>
							<input 
							class="easyui-textbox" 
							name="seTraceKey.kdesc"
							id="kdesc" 
							type="text"
							data-options="required:true"
							value="${seTraceKey.kdesc}" />
							注：如果是字典，字典值以";"隔开。例如：已完成;未完成
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
