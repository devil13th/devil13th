
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJs.jsp"%>
		
		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
   		<!-- 编辑器源码文件 -->
   		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
   
   
		<title><s:text name="title.applyName"></s:text>
		</title>
	
<style>


 
</style>

<script>

var theForm;


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


//文本编辑器
var ue ;
function showText(){
	   var str =ue.getContentTxt();
	   alert(str);
	 
}
function showHtml(){
	   var html1 = ue.getContent();
	   alert(html1);
}
function stHtml(){
	   ue.setContent("hello world", true);
}


	


$(function(){
	theForm = $('#theForm').form({
		ajax:false
	});
	
	
	ue1 = UE.getEditor('noteContent',{
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
})
</script>
	</head>

	<body>
		<div id="pbody">
			<s:form action="se!seDayNoteFormSubmit" namespace="/se" method="post" id="theForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					日记id：<input 
							class="easyui-textbox" 
							name="seDayNote.noteId"
							id="noteId"  
							type="text"
							value="${seDayNote.noteId}" />
					项目id：<input 
							class="easyui-textbox" 
							name="seDayNote.projectId"
							id="projectId" 
							type="text"
							value="${seDayNote.projectId}" />
					是否删除:<input 
							class="easyui-textbox" 
							name="seDayNote.isDelete"
							id="isDelete" 
							type="text"
							value="${seDayNote.isDelete}" />
					创建时间：<input 
							class="easyui-datebox" 
							name="seDayNote.createTime"
							id="createTime" 
							type="text"
							value="${seDayNote.createTime}" />
							修改时间：<input 
							class="easyui-datebox" 
							name="seDayNote.updateTime"
							id="updateTime" 
							type="text"
							value="${seDayNote.updateTime}" />
				</div>
				<table class="common" width="100%">
					<tr>
						<th>
							日记日期
						</th>
						<td>
							<input 
							class="easyui-datebox" 
							name="seDayNote.noteDate"
							id="noteDate" 
							type="text"
							data-options="required:true"
							value="${seDayNote.noteDate}" />
						</td>
					</tr>
					<tr>
						<th>
							日记标题
						</th>
						<td>
							
							
							<s:select list="{'记事','会议','评审会','里程碑'}" name="seDayNote.noteType" cssClass="easyui-combobox" cssStyle="width:65px;"></s:select>
							
							
							<input 
							class="easyui-textbox" 
							name="seDayNote.noteTitle"
							id="noteTitle" 
							type="text"
							data-options="required:true,width:450" 
							value="${seDayNote.noteTitle}" />
						</td>
					</tr>
					<tr>
						<th>
							日记内容
						</th>
						<td>
							<!-- <input 
							name="seDayNote.noteContent"
							id="noteContent" 
							type="text"
							value="${seDayNote.noteContent}" />
							 -->
							<textarea name="seDayNote.noteContent" id="noteContent">${seDayNote.noteContent}</textarea>
							
						</td>
					</tr>
					<tr>
						<th>
							是否有效
						</th>
						<td>
							<select name="select" name="seDayNote.isValid" class="easyui-combobox" style="width:150px;">
							    <option value="1">有效</option>
							    <option value="0">无效</option>
							</select>	
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
