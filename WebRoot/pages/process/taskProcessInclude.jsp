<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div style="display:none;">
	<input type="text" name="seProcTask.taskId" id="traceTaskId" value="${seProcTask.taskId}"/>
	<input type="text" name="seProcTask.jobno" value="${seProcTask.jobno}"/>
	<input type="text" name="procInsId" value="${pmb.processInstanceId}"/>
	<input type="text" name="taskId" value="${pmb.taskId}"/>
</div>

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
		<c:if test="${task.taskDefinitionKey == 'regist'}">
			<div class="form-group" >
				<label class="col-xs-2 control-label">所属系统</label>
				<div class="col-xs-10">
				     <s:select id="projectId" 
					 name="seProcTask.projectId"  
					 cssClass="select2 form-control"  
					 list="#request.projectList"  listKey="projectId" listValue="projectName" headerKey="" headerValue="请选择"></s:select> 
				</div>
			</div>
			<div class="form-group" >
				<label class="col-xs-2 control-label">矩阵任务名称</label>
				<div class="col-xs-10">
				       <div class="input-group">
						<input 
						class="form-control" 
						id="traceTaskName" 
						readonly="readonly"
						type="text"
						value="${traceTaskName}" />
						<span class="input-group-btn">
							<button id="genpassword" class="btn btn-primary" type="button" onclick="selectRequireTrace()">
							<i class="fa fa-arrow-left fa-fw" /></i> Select</button>
                           </span>
					</div>
				</div>
			</div>

			<div class="form-group">
				<label  class="col-sm-2 control-label" >任务名称</label>
				<div class="col-sm-10">
					 <input 
					class="form-control" 
					name="seProcTask.taskName"
					id="taskName" 
					type="text"
					value="${seProcTask.taskName}" /> 
			 	</div>
			</div>
			 
			<div class="form-group">
				<label  class="col-sm-2 control-label" >执行人</label>
				<div class="col-sm-4">
					<s:select id="performer" multiple="true"
					 name="seProcTask.performer"  
					 cssClass="select2 form-control"  
					 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
			 	</div>
			 	<label  class="col-sm-2 control-label" >审核人</label>
				<div class="col-sm-4">
					<s:select id="auditer" multiple="true"
					 name="seProcTask.auditer"  
					 cssClass="select2 form-control"  
					 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
			 	</div>
			</div>
		</c:if>
		
		<c:if test="${task.taskDefinitionKey != 'regist'}">
			<div class="form-group" >
				<div class="col-xs-2 text-right">所属系统</div>
				<div class="col-xs-10">
				     ${project.proName }
				</div>
			</div>
			<div class="form-group" >
				<div class="col-xs-2 text-right">矩阵任务名称</div>
				<div class="col-xs-4">
					${traceTaskName}
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
		</c:if>
		
		 
		<div class="row">
			<div class="col-sm-11 col-sm-offset-1">
				<!-- Nav tabs -->
				<ul class="nav nav-tabs nav-justified" role="tablist">
					<li role="presentation" <c:if test="${task.taskDefinitionKey == 'regist'}">class="active"</c:if>><a href="#home" aria-controls="home" role="tab" data-toggle="tab">任务要求</a></li>
					<li role="presentation" <c:if test="${task.taskDefinitionKey == 'perform'}">class="active"</c:if>><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab">执行信息</a></li>
					<li role="presentation" <c:if test="${task.taskDefinitionKey == 'audit'}">class="active"</c:if>><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab">审核信息</a></li>
				</ul>
				
				<!-- Tab panes -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane <c:if test="${task.taskDefinitionKey == 'regist'}">active</c:if>" id="home">
						<s:textarea name="seProcTask.taskRequire" id="taskRequire"></s:textarea>
					</div>
					<div role="tabpanel" class="tab-pane <c:if test="${task.taskDefinitionKey == 'perform'}">active</c:if>" id="profile">
						<s:textarea name="seProcTask.performInfo" id="performInfo"></s:textarea>
					</div>
					<div role="tabpanel" class="tab-pane <c:if test="${task.taskDefinitionKey == 'audit'}">active</c:if>" id="messages">
						<s:textarea name="seProcTask.auditInfo" id="auditInfo"></s:textarea>
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

<c:if test="${task.taskDefinitionKey == 'regist'}">
ue2.addListener( 'ready', function( editor ) {
	 ue2.setDisabled('fullscreen');
} );
ue3.addListener( 'ready', function( editor ) {
	 ue3.setDisabled('fullscreen');
} );

</c:if>
<c:if test="${task.taskDefinitionKey == 'perform'}">
ue1.addListener( 'ready', function( editor ) {
	 ue1.setDisabled('fullscreen');
} );
ue3.addListener( 'ready', function( editor ) {
	 ue3.setDisabled('fullscreen');
} );
</c:if>
<c:if test="${task.taskDefinitionKey == 'audit'}">
ue1.addListener( 'ready', function( editor ) {
	 ue1.setDisabled('fullscreen');
} );
ue2.addListener( 'ready', function( editor ) {
	 ue2.setDisabled('fullscreen');
} );
</c:if>
</script>
				
				
				