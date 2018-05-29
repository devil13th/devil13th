<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!--  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>批量上传文件</title>
<link rel="stylesheet" href="${ctx}/js/bootstrap/css/bootstrap.min.css" type="text/css"/>
<script src="${ctx}/js/jquery/jquery-1.11.1.min.js"></script>
<script src="${ctx}/js/bootstrap/js/bootstrap.min.js"></script>
<script>
</script>
	</head>

<body>
-->
<div class="row">
	<div class="col-sm-8">
	</div>
	<div class="col-sm-4">
		
		<hr/>
		<div class="row">
			<div class="col-sm-8">
				<b><i class="glyphicon glyphicon-paperclip"> </i> 相关附件 </b> 
			</div>
			<div class="col-sm-4 text-right" >
				<a href="${ctx}/common/common!commonUploaderBatch.do?seAttach.fid=${seAttach.fid}&seAttach.fkey=${seAttach.fkey}" onclick="showFThis(this);return false;" target="_blank" title="添加附件">
					<i class="glyphicon glyphicon-plus-sign"> </i>
				</a>
			</div>
		</div>
		<div style="padding-left:10px;">
		
			<br/>
			<div id="commonFileListDiv">
			<!--<c:forEach items="${fileList}" var="f">
				<div id="attach_${f.attachId}">
					<a href="${ctx}/${f.attachPath}" target="_blank"><i class="glyphicon glyphicon-save"></i></a>
					<a href="#" target="_blank" onclick="deleteFile('${f.attachId}');return false;" title="删除附件"><i class="glyphicon glyphicon-remove"></i></a>
					<a href="${ctx}/${f.attachPath}" target="_blank">${f.attachName } (${f.attachSize} Byte)  </a><br/>
				</div>
			</c:forEach>-->
			</div>
		</div>
	</div>
</div>
<script>
function showFThis(o){
	openWindow({
		url:o.href,
		height:400,
		width:900
	});
}

function addFile(fileId,fileName,filePath,fileSize){
	var div = $("<div id='attach_" + fileId + "'></div>");
	var lk = $("<a target='_blank'></a>");
	
	//lk.attr("href","${ctx}/" + filePath);
	lk.attr("href","${ctx}/common/common!commondownload.do?id=" + fileId);
	lk.html(fileName+"(" +fileSize+ " Byte)");
	
	
	
	var delk = $("<a></a>");
	delk.attr("href","#");
	delk.click(function(){
		deleteFile(fileId);
		return false;
	})
	delk.html('<i class="glyphicon glyphicon-remove"></i>');
	
	
	
	div.append(delk);
	
	div.append(lk);
	
	$("#commonFileListDiv").append(div);
}
<c:forEach items="${fileList}" var="f">
addFile("${f.attachId}","${f.attachName }","","${f.attachSize}");
</c:forEach>
function deleteFile(fileId){
	if(confirm("确定删除此附件吗?")){
		$.ajax("${ctx}/common/common!deleteCommonFileList.do",
			{
				type:"post",
				data:{id:fileId},
				success:function(r){
					if($.trim(r) == "<%=StaticVar.STATUS_SUCCESS%>"){
						alert("附加已删除");
						$("#attach_" + fileId).remove();
					}else{
						alert("操作失败:" + r);
					}
				}
			}
		)
	}
}
</script>
<!--  
</body>
</html>
-->
