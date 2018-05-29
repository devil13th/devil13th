
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
   		<!-- 编辑器源码文件 -->
   		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
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
	 var obj = $("#theForm").serializeArray() ;
	 //alert(obj);
	/* var params = {};
	 
	 for(var i = 0 , j = obj.length ; i < j ; i++){
		 if(obj[i].name.substring(0,2) != "V_"){
		 	params[obj[i].name] = obj[i].value;
		 }
	 }
	 alert(params);
	 alert(JSON.stringify(params));
	*/
	
	 var params = [];
	 
	 for(var i = 0 , j = obj.length ; i < j ; i++){
		 if(obj[i].name.substring(0,2) == "V_"){
			 params.push(obj[i]);
		 }
	 }
	 //alert(params);
	 //alert(JSON.stringify(params));
	 
	 
	 $.post(
			 "${ctx}/se/se!traceValueInputSubmit.do", 
			 //{param:JSON.stringify(params)},
			 {
				 "seRequirementTrace.traceId":$("#traceId").val(),
				 "v":JSON.stringify(params)
			 },
			 //params,
			 function(data){
			    if($.trim(data)=="success"){
			    	message("保存成功");
			    }else{
			    	$.messager.alert('错误信息','保存失败! ' + data,'error');
			    }
			  }, 
			 "text");
	
	 
	/*
	var b = theForm.form("validate");
	if(b){
		document.getElementById("theForm").submit();
	}else{
		alert("请根据表单红色提示进行修改");
	};*/
	
}
function cw(){
	top.closeWin();
}
//消息
function message(text){
	$.messager.show({
		title:'消息',
		msg:text,
		showType:'show'
	});
}

</script>
	</head>

	<body style="margin:0px; padding:0px;">
			<s:form action="se!traceValueInputSubmit" namespace="/se" method="post" id="theForm">
				<div style="display:none;">
					<s:textfield name="seRequirementTrace.traceId" id="traceId"></s:textfield><br/>
				</div>
				
				
				
				<div id="tt" class="easyui-tabs" data-options="border:false" > 
				<div title="基础属性" data-options="iconCls:'icon-016'" style="padding:2px;">   
						<table width="100%" border="0" cellspacing="2" cellpadding="0" class="devil_form_tab"> 
								<thead>
								 <tr>
								 	<th colspan="2">矩阵属性信息</th>
								 </tr>
								 </thead>
								 <tbody>
				
								<c:forEach items="${stringProList}" var="p" varStatus="index">
									<c:if test="${index.index % 2 ==0}">
									<tr class="eve">
									</c:if>
									<c:if test="${index.index % 2 !=0}">
									<tr class="odd">
									</c:if>
									
									<c:if test="${p.KTYPE == 'STRING'}" >
										<td width="30%" class="t_rt">${p.KNAME}:</td>
										<td width="70%"><input type="text" id="V_${p.KCODE}" name="V_${p.KCODE}" value="${p.V}"  class="easyui-textbox" style="width:150px;"/></td>
									</c:if>
									<c:if test="${p.KTYPE == 'DIC'}" >
										
										
										</select>
										<td width="30%" class="t_rt">${p.KNAME}:</td>
										<td width="70%">
										<c:set var="dicValue" value="${fn:split(p.KDESC, ';')}" />
										
										<select class="easyui-combobox" style="width:150px;" id="V_${p.KCODE}" name="V_${p.KCODE}">
											<option value="" >请选择</option>
											<c:forEach items="${dicValue}" var="ov">
											<option value="${ov }" <c:if test="${p.V == ov}">selected="selected"</c:if>>${ov }</option>
											</c:forEach>
										</select>
										<!-- 
										<input type="text" id="V_${p.KCODE}" name="V_${p.KCODE}" value="${p.V}"  class="easyui-textbox" style="width:150px;"/>
										 -->
										</td>
									</c:if>
									<c:if test="${p.KTYPE == 'DATE'}" >
										<td width="30%" class="t_rt">${p.KNAME}:</td>
										<td width="70%">
										<input type="text" id="V_${p.KCODE}" name="V_${p.KCODE}" value="${p.V}"  class="easyui-datebox" style="width:150px;"/>
										</td>
									</c:if>
									<c:if test="${p.KTYPE == 'INT'}" >
										<td width="30%" class="t_rt">${p.KNAME}:</td>
										<td width="70%"><input type="text" id="V_${p.KCODE}" name="V_${p.KCODE}" value="${p.V}"  class="easyui-numberbox" style="width:150px;"  data-options="min:0,precision:0"/></td>
									</c:if>
									<c:if test="${p.KTYPE == 'FLOAT'}" >
										<td width="30%" class="t_rt">${p.KNAME}:</td>
										<td width="70%"><input type="text" id="V_${p.KCODE}" name="V_${p.KCODE}" value="${p.V}"  class="easyui-numberbox" style="width:150px;"  data-options="min:0,precision:2"/></td>
									</c:if>
									
									 </tr>
								</c:forEach>
								
								</tbody>
						</table>				
				</div>   
				
				
				
				<c:forEach items="${clobProList}" var="p" varStatus="index">
						<div title="${p.KNAME}"  style="padding:2px;">   
							<!-- 
							<input type="text" id="V_${p.KCODE}" name="V_${p.KCODE}" value="${p.V}"  class="easyui-textbox" style="width:500px;height:300px;"  data-options="multiline:true"/>	
							 -->
							 
							<textarea name="V_${p.KCODE}" id="V_${p.KCODE}">${p.V}</textarea>
							
							
							<script>
							var ue_${p.KCODE};
							ue_${p.KCODE} = UE.getEditor('V_${p.KCODE}',{
						    	serverUrl: "${ctx}/se/se!uploadFile.do",
						       	imageUrlPrefix:"",
						       	imageActionName:'img',
						       	imageFieldName:'imgFile',
						       	imageAllowFiles:[".png", ".jpg", ".jpeg", ".gif", ".bmp"],
						    	
						       	fileActionName: "uploadfile", /* controller里,执行上传视频的action名称 */
						        fileFieldName: "imgFile", /* 提交的文件表单名称 */
						        fileUrlPrefix: "", /* 文件访问路径前缀 */
						        fileMaxSize: 51200000, /* 上传大小限制，单位B，默认50MB */
						        fileAllowFiles: [
						            ".png", ".jpg", ".jpeg", ".gif", ".bmp",
						            ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
						            ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid",
						            ".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso",
						            ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"
						        ],
						        videoActionName: "uploadvideo", /* 执行上传视频的action名称 */
						        videoFieldName: "imgFile", /* 提交的视频表单名称 */
						        videoMaxSize: 102400000, /* 上传大小限制，单位B，默认100MB */
						        videoAllowFiles: [
						            ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
						            ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"], /* 上传视频格式显示 */

						    });
							</script>
							
						</div> 
				</c:forEach>
				
				</div>
				
				
				
				<center>
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="submitForm()">保存</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="resetForm()">重置</a>  
					<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" onclick="window.close()">关闭</a>  
				</center>
			</s:form>
	</body>
</html>
