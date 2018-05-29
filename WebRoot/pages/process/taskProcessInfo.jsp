<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../../pub/pubCssJsForBootstrap.jsp"%>
		<title>
			开启流程
		</title>
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
<style type="text/css">
</style>
<script>

</script>
	</head>

	<body>


<div class="container-fluid">
	


<div class="row" style="padding-bottom:50px;margin-top:10px;">
	<div class="col-md-9">
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<div class="row">
							<div class="col-sm-6"></div>
							<div class="col-sm-6 text-right">
								<b>JOBNO :</b> ${jobno}
							</div>
						</div>
					</div>
					<div class="panel-body form-horizontal">
						<div class="form-group" >
							<div class="col-xs-2 text-right">矩阵名称</div>
							<div class="col-xs-4">
								${traceName}
							</div>
							<div  class="col-sm-2 text-right" >任务名称</div>
							<div class="col-sm-4">
								${seProcTask.taskName}
						 	</div>
						</div>
			
						<div class="form-group">
							<div  class="col-sm-2 text-right" >执行人</div>
							<div class="col-sm-4">
								${seProcTask.performerNames }
						 	</div>
						 	<div  class="col-sm-2 text-right" >审核人</div>
							<div class="col-sm-4">
								${seProcTask.auditerNames }
						 	</div>
						</div>
						
						 
						<div class="row">
							<div class="col-sm-11 col-sm-offset-1">
							
								<ul class="nav nav-tabs nav-justified" role="tablist">
									<li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">任务要求</a></li>
									<li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">执行信息</a></li>
									<li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">审核信息</a></li>
								</ul>
								<!-- Tab panes -->
								<div class="tab-content">
									<div role="tabpanel" class="tab-pane active" id="home">
										<textarea name="seProcTask.taskRequire" id="taskRequire">${seProcTask.taskRequire }</textarea>
									</div>
									<div role="tabpanel" class="tab-pane" id="profile">
										<textarea name="seProcTask.performInfo" id="performInfo">${seProcTask.performInfo}</textarea>
									</div>
									<div role="tabpanel" class="tab-pane" id="messages">
										<textarea name="seProcTask.auditInfo" id="auditInfo">${seProcTask.auditInfo}</textarea>
									</div>
									
								</div>
						  </div>
						</div>
					</div>
				</div>
								
								
				<script>
				var ue1;
				ue1 = UE.getEditor('taskRequire',{
					serverUrl: "${ctx}/se/se!uploadFile.do",
				   	imageUrlPrefix:"",
				   	imageActionName:'img',
				   	imageFieldName:'imgFile',
				   	imageAllowFiles:[".png", ".jpg", ".jpeg", ".gif", ".bmp"],
				   	initialFrameWidth:'100%',   //初始化编辑器宽度,默认1000 
				    initialFrameHeight:220,  //初始化编辑器高度,默认320
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
				
				
				
				
				var ue2;
				ue2 = UE.getEditor('performInfo',{
					serverUrl: "${ctx}/se/se!uploadFile.do",
				   	imageUrlPrefix:"",
				   	imageActionName:'img',
				   	imageFieldName:'imgFile',
				   	imageAllowFiles:[".png", ".jpg", ".jpeg", ".gif", ".bmp"],
				   	initialFrameWidth:'100%',   //初始化编辑器宽度,默认1000 
				    initialFrameHeight:220,  //初始化编辑器高度,默认320
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
				
				var ue3;
				ue3 = UE.getEditor('auditInfo',{
					serverUrl: "${ctx}/se/se!uploadFile.do",
				   	imageUrlPrefix:"",
				   	imageActionName:'img',
				   	imageFieldName:'imgFile',
				   	imageAllowFiles:[".png", ".jpg", ".jpeg", ".gif", ".bmp"],
				   	initialFrameWidth:'100%',   //初始化编辑器宽度,默认1000 
				    initialFrameHeight:220,  //初始化编辑器高度,默认320
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
				ue1.addListener( 'ready', function( editor ) {
					 ue1.setDisabled('fullscreen');
				} );
				ue2.addListener( 'ready', function( editor ) {
					 ue2.setDisabled('fullscreen');
				} );
				ue3.addListener( 'ready', function( editor ) {
					 ue3.setDisabled('fullscreen');
				} );
				
				
				</script>
			</div>
		</div>
	</div>
<div class="col-md-3">
	<s:action name="seProcess!commonProcessHisInfo" namespace="/seProcess"  executeResult="true">
		<s:param name="jobno" value="#attr.jobno"></s:param>
	</s:action>
</div>
</div>

</div>

<div class="navbar-fixed-bottom" style="padding:10px;background:#eee;">
	<div class="row">
		<div class="col-sm-6 text-left">
		</div>
		<div class="col-sm-6 text-right">
			<button class="btn btn-default" type="button">关闭</button>
		</div>
	</div>
	
</div>

<div  id="msgInfo" style="display:none;margin:0px;width:300px;">
	<div class="panel panel-primary">
		<div class="panel-heading"><b>JOBNO :</b> 2017TASK00012</div>
		<div class="panel-body" >
			<b>TASK :</b> 任务登记及派工 
		</div>
	</div>
</div>

	
</body>
</html>
