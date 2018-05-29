<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html >

<html>
<head>

<meta charset="utf-8"/>
<title>jquery zTree</title>



<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>

<script>

//编辑器2定义
var ue ;
window.onload = function(){
    ue = UE.getEditor('container',{
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
}

function exportCkList(){
	window.open("${ctx}/checklist/checklist!export.do?checklist.id=${checklist.id}");
}
</script>


</head>
<body style="padding:0px;margin:0px; ">
<input type="button" value="导出" onclick="exportCkList()"/>
<s:form action="checklist!editSubmit" namespace="/checklist" method="post">
        主键：<s:textfield name="checklist.id" readonly="true"></s:textfield><br/>
	编码：<s:textfield name="checklist.treeCode" readonly="true"></s:textfield><br/>
	父节点ID：<s:textfield name="checklist.parentId" readonly="true"></s:textfield><br/>
	名称：<s:textfield name="checklist.cklistName"></s:textfield><br/>
	简述：<s:textfield name="checklist.cklistDesc"></s:textfield><br/>
	内容：
	<div>
		 <s:textarea name="checklist.cklistContent" id="container"></s:textarea>
	</div>
		
	
	叶子节点：<s:textfield name="checklist.isLeaf"></s:textfield><br/>
	是否有效：<s:textfield name="checklist.isValid"></s:textfield><br/>
	是否删除：<s:textfield name="checklist.isDelete"></s:textfield><br/>
	<input type="submit" value="保存"/>
	
	
</s:form>

</body>
</html>