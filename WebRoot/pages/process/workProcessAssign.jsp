<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../../pub/pubCssJsForBootstrap.jsp"%>
		<script src="${ctx}/js/process.jsp?a=<%=Math.random() %>>"></script>
		<title>
			开启流程
		</title>
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
<style type="text/css">
</style>
<script>
$(function(){
	$(".select2").select2({
		//默认文本
		allowClear: true,
		width:"100%"
	});
})


function selectRequireTrace(){
	//var url = "${ctx}/se/seRequirementTrace!seRequirementTraceSelect.do?cb=getParent().selectRequireTraceCb";
	
	var projectId = $("#projectId").val();
	if(!projectId){
		layer.tips('请先选择所属系统', '#projectId', {
		  tips: [1, '#3595CC'],
		  time: 2000
		});
		
		return false;
	}
	var url = "${ctx}/se/seRequirementTrace!seRequirementTraceTaskSelect.do?seRequirementTrace.projectId=" + projectId + "&cb=getParent().selectRequireTraceCb";
	showWin(url,900,500);
}


function selectRequireTraceCb(obj){
	console.log(obj);
	$("#traceTaskId").val(obj.TASK_ID);
	$("#traceTaskName").val(obj.TASK_TITLE);
	$("#taskName").val(obj.TASK_TITLE);
	
}

function theFormSubmit(next){
	var obj = getFormJsonData("theForm");
	console.log(obj);
	var formParams = $("#theForm").serialize();
	$.ajax("${ctx}/seProcess/seProcess!taskProcessAssignSubmit.do",
		{
			type:"post",
			async:false,
			data:formParams,
			success:function(r){
				var str = $.trim(r);
				//alert(str);
				if(str == "SUCCESS"){
					showMsg("success","保存成功");
				}else{
					showMsg("err","保存失败");
				};
				//ue1.setContent(str, false);
			}
		}
	)
	
	//alert(next);
	if(next){
		var taskId = $("#taskId").val();
		var stepOperator = $("#stepOperator").val();
		nextStep(taskId,stepOperator);
	}
	
	//$("#theForm").submit();
	//return false;
}

function nextStep(taskId,stepOperator){
	//alert(2);
	$.ajax("${ctx}/seProcess/seProcess!nextStep.do",
			{
				type:"post",
				data:{
					taskId:taskId,
					stepOperator:stepOperator
				},
				success:function(r){
					var str = $.trim(r);
					//alert(str);
					if(str == "SUCCESS"){
						showMsg("success","流程跳转成功",function(){
							try{
								parent.reloadDg();
								parent.clw();
							}catch(e){
								try{
									parent.reloadMyTodoTab();
									parent.closeLayer(1);
								}catch(e){
									try{
										parent.clw();
									}catch(e){
										window.close();
									}
								}
							}
						});
						//parent.clw();
					}else{
						showMsg("err","流程跳转失败");
					};
					//ue1.setContent(str, false);
				}
			}
		)
}

function showMsg(css,msg,fn){
	
	var cssStype = "alert-success";
	if("err" == css){
		var cssStype = "alert-danger";
	}
	$("#msgInfo").removeClass("alert-danger").removeClass("alert-success").addClass(cssStype);
	//$("#msgInfo").html(msg);
	
	layer.alert(msg, 
		{
		skin: 'layui-layer-lan',
		shade: 0.3,
		shadeClose: false, //关闭遮罩关闭
		shift: 1 //动画类型
		},fn
	);
}




actWorkFlowObj.save = function (){
	var obj = getFormJsonData("theForm");
	console.log(obj);
	var formParams = $("#theForm").serialize();
	var obj = {};
	$.ajax({
		url:"${ctx}/workProcess/workProcess!workProcessAssignSubmit.do",//请求地址
		method:"post",//提交方式
		async:false,//是否异步
		cache:false,//是否缓存
		data:formParams,
		dataType:"json",//返回数据的格式 xml, json, script, or html
		success:function(r){//回调函数
			obj = r;
			//alert("|" + r.status + "|");
			if(r.status == "SUCCESS"){
				showProcessMsg("[成功]数据保存")
			}else{
				showProcessMsg("[失败]数据保存:" + r.message);
			};
		}
	})
	return obj;
}
</script>
	</head>

	<body>


<div class="container-fluid">
	


<div class="row" style="padding-bottom:50px;margin-top:10px;">
	<div class="col-md-12">
		<div class="row">
			<div class="col-md-12">
				<s:form cssClass="form-horizontal" action="workProcess!workProcessAssignSubmit.do" namespace="/process" method="post" id="theForm">
					
					
					<div style="display:none;">
						<input type="text" name="seProcTask.taskId" id="traceTaskId" value="${seProcTask.taskId}"/>
						<input type="text" name="seProcTask.jobno" value="${seProcTask.jobno}"/>
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
						
								<div <c:if test="${workprocessAssign != pmb.stepCode}">style="display:none"</c:if>>
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
								<hr/>
								<div class="row">
									<div class="col-sm-11 col-sm-offset-1">
										<ul class="nav nav-tabs">
										  <li role="presentation" class="active"><a href="#"><i class="glyphicon glyphicon-info-sign"></i> 任务要求</a></li>
										</ul>
										<s:textarea name="seProcTask.taskRequire" id="taskRequire"></s:textarea>
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
										</script>
									</div>
								</div>
							
								</div>
							
							
							
							<c:if test="${ workprocessAssign != pmb.stepCode}">
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
								
								<div class="row">
									<div class="col-sm-11 col-sm-offset-1">
										<ul class="nav nav-tabs">
										  <li role="presentation" class="active"><a href="#"><i class="glyphicon glyphicon-info-sign"></i> 任务要求</a></li>
										</ul>
										${seProcTask.taskRequire}
									</div>
								</div>
							</c:if>
							
							<br/>
							
							<c:if test="${workprocessExecute == pmb.stepCode}">
								<div class="row">
									<div class="col-sm-11 col-sm-offset-1">
										<ul class="nav nav-tabs">
										  <li role="presentation" class="active"><a href="#"><i class="glyphicon glyphicon-info-sign"></i> 执行过程说明</a></li>
										</ul>
										<s:textarea name="seProcTask.performInfo" id="performInfo"></s:textarea>
									</div>
								</div>
								<script>
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

								</script>
							</c:if>
							<c:if test="${workprocessExecute != pmb.stepCode}">
								<div class="row">
									<div class="col-sm-11 col-sm-offset-1">
										<ul class="nav nav-tabs">
										  <li role="presentation" class="active"><a href="#"><i class="glyphicon glyphicon-info-sign"></i> 执行过程说明</a></li>
										</ul>
										${seProcTask.performInfo }
									</div>
								</div>
							</c:if>
							
							<br/>
							
							
							<c:if test="${workprocessInspect == pmb.stepCode}">
								<div class="row">
									<div class="col-sm-11 col-sm-offset-1">
										<ul class="nav nav-tabs">
										  <li role="presentation" class="active"><a href="#"><i class="glyphicon glyphicon-info-sign"></i> 审核意见</a></li>
										</ul>
										<s:textarea name="seProcTask.auditInfo" id="auditInfo"></s:textarea>
									</div>
								</div>
								
<script>
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
</script>	
							</c:if>
							<c:if test="${workprocessInspect != pmb.stepCode}">
								<div class="row">
									<div class="col-sm-11 col-sm-offset-1">
										<ul class="nav nav-tabs">
										  <li role="presentation" class="active"><a href="#"><i class="glyphicon glyphicon-info-sign"></i> 审核意见</a></li>
										</ul>
										${seProcTask.auditInfo}
									</div>
								</div>
								<hr/>
							</c:if>
						</div>
					</div>
				</s:form>
			</div>
		</div>
	</div>
</div>

<div class="navbar-fixed-bottom" style="padding:10px;background:#eee;">
	<div class="row">
		<div class="col-md-7">
		</div>
		<div class="col-md-5 text-right">
			<c:if test="${ce == staticVarObj.y }">
				<button type="button" id="prev_btn" class="btn btn-primary btn-sm" onclick="actWorkFlowObj.save();">保存</button>
			</c:if>
			<s:action name="seProcess!commonBton" namespace="/seProcess"  executeResult="true">
				<s:param name="jobno" value="#attr.processMethodBean.iJobno"></s:param>
				<s:param name="taskId" value="#attr.processMethodBean.iTaskId"></s:param>
				<s:param name="stepCode" value="#attr.stepCode"></s:param>
				<s:param name="ce" value="#attr.ce"></s:param>
			</s:action>
		</div>
	</div>
</div>




<!-- Modal 流程扭转信息提示 -->
<jsp:include page="processMsg.jsp"></jsp:include>



</body>
</html>
