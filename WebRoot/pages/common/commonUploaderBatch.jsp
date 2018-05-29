<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>批量上传文件</title>
<link rel="stylesheet" href="${ctx}/js/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link href="${ctx}/js/bootstrap-fileinput/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
<script src="${ctx}/js/jquery/jquery-1.11.1.min.js"></script>
<script src="${ctx}/js/bootstrap-fileinput/js/fileinput.js" type="text/javascript"></script>
<script src="${ctx}/js/bootstrap-fileinput/js/locales/fr.js" type="text/javascript"></script>
<script src="${ctx}/js/bootstrap-fileinput/js/locales/es.js" type="text/javascript"></script>
<script src="${ctx}/js/bootstrap/js/bootstrap.min.js"></script>
<script src="${ctx}/js/fun.js?a=1"></script>
<script>
</script>
	</head>

<body>
<form action="" method="post">
    <div class="form-group">
        <input id="file-1" type="file" name="file" multiple class="file" data-overwrite-initial="false" data-min-file-count="1">
    </div>
    <!-- 
    <input type="submit" value="提交"/>
     -->
    <div id="fileList">
    </div>
</form>


<script>
	$("#file-1").fileinput({
	    uploadUrl: '${ctx}/common/common!commonUploaderSubmit.do', // you must set a valid URL here else you will get an error
	    //allowedFileExtensions : ['jpg', 'png','gif','txt','doc','docx'],
	    overwriteInitial: false,
	    uploadExtraData: {"seAttach.fid": "${seAttach.fid}", "seAttach.fkey":"${seAttach.fkey}",value: '100 Details'},
	    maxFileSize: 1000000,
	    maxFilesNum: 10,
	    minFileCount:1,
	    //allowedFileTypes: ['image', 'video', 'flash'],
	    slugCallback: function(filename) {
	        return filename.replace('(', '_').replace(']', '_');
	    }
	});
	
	$('#file-1').on('fileerror', function(event, data, msg) {
	   console.log(data.id);
	   console.log(data.index);
	   console.log(data.file);
	   console.log(data.reader);
	   console.log(data.files);
	   // get message
	   alert(msg);
	});
	
	$('#file-1').on('change', function(event) {
		console.log("change");
	});
	
	$('#file-1').on('fileselect', function(event, numFiles, label) {
		console.log("fileselect");
	});
	
	$('#file-1').on('fileclear', function(event) {
		console.log("fileclear");
	});
	
	$('#file-1').on('filecleared', function(event) {
		console.log("filecleared");
	});
	
	$('#file-1').on('fileloaded', function(event, file, previewId, index, reader) {
		console.log("fileloaded");
	});
	
	$('#file-1').on('fileuploaded', function(event, data, previewId, index) {
	    var form = data.form, files = data.files, extra = data.extra,
	        response = data.response, reader = data.reader;
	    console.log(data);
	    console.log(data.response);
	    console.log('File uploaded triggered:' + response);

	    var fileName = data.response.attachName;
	    var fileId = data.response.attachId;
	    var filePath = data.response.attachPath;
	    var fileSize = data.response.attachSize;
	    
	    $("#fileList").append($("<div class='alert alert-success'><span class='glyphicon glyphicon-ok' ></span> 文件提交成功    name:" + data.response.attachName+ "</div>"));
	    
	    getParent().addFile(fileId,fileName,filePath,fileSize);
	});

	
	  
	  
</script>	
</body>
</html>
