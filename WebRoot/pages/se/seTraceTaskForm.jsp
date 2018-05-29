
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
		<title>任务信息</title>
	
<style type="text/css">
.select2-selection--single{border-top-left-radius:0px !important;border-bottom-left-radius:0px !important;}
</style>
<script>
var validationTool;
$(function(){

	
	var taskStatusSelect = $("#taskStatus").select2({
		  //默认文本
		  placeholder: 'Select an option',
		  allowClear: true,
		  width:200
		  
	  });

 $('#beginDate').datetimepicker({
		    language:'zh-CN',
			format:'yyyy-mm-dd',
			weekStart: 1,
			todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: "month",
			minView: "month",
			forceParse: 0
		}).on("changeDate", function(e) {
			 validationTool.data("formValidation").revalidateField("seTraceTask.beginDate");
	    });
 $('#finishDate').datetimepicker({
		    language:'zh-CN',
			format:'yyyy-mm-dd',
			weekStart: 1,
			todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: "month",
			minView: "month",
			forceParse: 0
		}).on("changeDate", function(e) {
			 validationTool.data("formValidation").revalidateField("seTraceTask.finishDate");
	    });
 
 $('#actBeginDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: "month",
		minView: "month",
		forceParse: 0
	})
	
 $('#actFinishDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: "month",
		minView: "month",
		forceParse: 0
	})

validationTool = $('#theForm').formValidation({
	err: {
	    container: ''
	   //container: 'popover'
	},
	icon: {
	    valid: 'glyphicon glyphicon-ok',
	    invalid: 'glyphicon glyphicon-remove',
	    validating: 'glyphicon glyphicon-refresh'
	},
	locale:"zh_CN", //国际化
	fields: {
		
		
		"seTraceTask.traceId": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		/*"seTraceTask.beginDate": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seTraceTask.finishDate": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},*/
		"seTraceTask.workLoad": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     lessThan: {
					value: 9999,
					inclusive: true,
					message: 'The Field has to be less than 9999'
			     },
			     greaterThan: {
					value: 0,
					inclusive: false,
					message: 'The Field has to be greater than or equals to 0'
			     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seTraceTask.currentProcess": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
					     lessThan: {
							value: 9999,
							inclusive: true,
							message: 'The Field has to be less than 9999'
					     },
					     greaterThan: {
							value: 0,
							inclusive: false,
							message: 'The Field has to be greater than or equals to 0'
					     }
	                }
		},
		"seTraceTask.taskTitle": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seTraceTask.taskRequire": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 256,
	                        message: '长度64以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seTraceTask.taskStatus": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},

		"seTraceTask.taskId": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seTraceTask.execNote": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     	stringLength: {
	                        max: 150,
	                        message: '长度150以内'
	                     }
	                }
		}
		
		
	}
});


$("#submitButton").click(function(){
    	validationTool.data("formValidation").validate();
    	var validateResult = validationTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theForm").submit();
    	};
});
})


function selectRequireTrace(){
	var url = "${ctx}/se/seRequirementTrace!seRequirementTraceSelect.do?seRequirementTrace.projectId=${seRequirementTrace.projectId}&cb=getParent().selectRequireTraceCb";
	showWin(url,350,500);
}

function selectRequireTraceCb(obj){
	$("#traceId").val(obj.id);
	$("#traceName").val(obj.text);
}
</script>
	</head>

	<body>
		<h3>Task</h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seTraceTaskFormSubmit" namespace="/se" method="post" id="theForm">
		
		<div class="row">
		
		<div class="col-xs-5">
			
				<div style="display: none;">
					操作种类 save为保存 update为更新： <input 
							class="form-control" 
							name="seTraceTask.traceId"
							id="traceId" 
							type="hidden"
							value="${seTraceTask.traceId}" /> 
							<br/>
							<input type="text" name="operate" value="${operate}"/>
				</div>

				
				
				<div class="form-group" style="display:none;">
					<label class="col-xs-3 control-label">任务ID</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							id="taskId"  
							name="seTraceTask.taskId"
							class="form-control" 
							placeholder="任务ID"
							value="${seTraceTask.taskId}"/> 
						</div>
					   </div>
						<span class="help-inline"> 
						</span>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-3 control-label">矩阵ID</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   
						   
						   <input 
						   type="text"
							id="traceName"  
							name="traceName"
							class="form-control" 
							readonly="readonly"
							value=" ${seRequirementTrace.traceName }"/> 
							
							<span class="input-group-btn">
										<button id="genpassword" class="btn btn-success" type="button" onclick="selectRequireTrace()">
										<i class="fa fa-arrow-left fa-fw" /></i> Select</button>
		                            </span>
		                            
		                            
						  
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">标题</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seTraceTask.taskTitle"
							id="taskTitle" 
							type="text"
							value="${seTraceTask.taskTitle}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">计划开始日期</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seTraceTask.beginDate"
							id="beginDate" 
							type="text"
							value="<fmt:formatDate value="${seTraceTask.beginDate}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">计划结束日期</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seTraceTask.finishDate"
							id="finishDate" 
							type="text"
							value="<fmt:formatDate value="${seTraceTask.finishDate}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">实际开始日期</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seTraceTask.actBeginDate"
							id="actBeginDate" 
							type="text"
							value="<fmt:formatDate value="${seTraceTask.actBeginDate}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">实际结束日期</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seTraceTask.actFinishDate"
							id="actFinishDate" 
							type="text"
							value="<fmt:formatDate value="${seTraceTask.actFinishDate}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">工作量	(人天)</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seTraceTask.workLoad"
							id="workLoad" 
							type="text"
							value="${seTraceTask.workLoad}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-3 control-label">进度</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seTraceTask.currentProcess"
							id="workLoad" 
							type="text"
							value="${seTraceTask.currentProcess}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
				<!--  
				<div class="form-group">
					<label class="col-xs-3 control-label">要求</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seTraceTask.taskRequire"
							id="taskRequire" 
							type="text"
							value="${seTraceTask.taskRequire}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				-->
				<div class="form-group">
					<label class="col-xs-3 control-label">状态</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						  
						  
						  
						  <s:select id="taskStatus"   name="seTraceTask.taskStatus"  cssClass="select2"  
							list="#request.taskStatusList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
						  
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="col-xs-3 control-label">参与人</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seTraceTask.operator"
							id="operator" 
							type="text"
							readonly="readonly"
							value="${seTraceTask.operator}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
				
				
				
		</div>
		<div class="col-xs-7">
			<h4>任务要求</h4>
			<s:textarea name="seTraceTask.taskRequire" id="taskRequire"></s:textarea>
			
			<h4>执行备注</h4>
			<div class="form-group" style="margin-top:10px;">
					<div class="col-xs-12">
						   <textarea 
						   rows="5"
							class="form-control" 
							name="seTraceTask.execNote"
							id="execNote" 
							type="text"
							> ${seTraceTask.execNote}</textarea>
					</div>
				</div>
				
		</div>
	




</div>
<div class="row text-center" style="margin-top:20px;">
            <button type="button" id="submitButton" class="btn green">Submit</button>
            <button type="button" class="btn default">Cancel</button>
</div>

<c:if test="${seTraceTask.taskId != null }">
<s:action name="common!commonFileList" namespace="/common" executeResult="true">
	<s:param name="seAttach.fid" value="#attr.seTraceTask.taskId"></s:param>
	<s:param name="seAttach.fkey"><%=StaticVar.ATTACHKEY_SETRACETASK%></s:param>
</s:action>
</c:if>
				
				
</s:form>
</div>

<script>
var ue;
ue = UE.getEditor('taskRequire',{
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
	</body>
</html>
