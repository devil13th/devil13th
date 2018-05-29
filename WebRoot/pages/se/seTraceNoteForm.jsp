
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
		<title>遗留备忘</title>
	
<style type="text/css">
.select2-selection--single{border-top-left-radius:0px !important;border-bottom-left-radius:0px !important;}
</style>
<script>

var validationTool;

function dealResolveDateDiv(s){
	if(s=='已落实'){
		$("#resolveDateDiv").show();
	}else{
		$("#resolveDateDiv").hide();
		$("#resolveDate").val("");
		//$("#resolveDate").attr("readonly","readonly");
	}
}

$(function(){
	
	dealResolveDateDiv("${seTraceNote.noteStatus}");
	var taskStatusSelect = $(".select2").select2({
		  //默认文本
		  placeholder: 'Select an option',
		  allowClear: true,
		  width:200
		  
	  });
	
	 $("#noteStatus").on('change', function (evt) {
		var _this = $(this);
		//alert(_this.val());
		dealResolveDateDiv(_this.val());
	  });
	
	
	
	 $('#alarmDate').datetimepicker({
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
	 $('#resolveDate').datetimepicker({
		    language:'zh-CN',
			format:'yyyy-mm-dd',
			weekStart: 1,
			todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: "month",
			minView: "month",
			forceParse: 0
		});
	 
	 
	 
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
				
				
				"seTraceNote.noteType": {
					row:'.form-group',//变红色字体的范围容器
					validators: {
						notEmpty: {
							message: 'The field is required'
						}
					}
				},
				
				"seTraceNote.exeUser": {
					row:'.form-group',//变红色字体的范围容器
					validators: {
						notEmpty: {
							message: 'The field is required'
						}
					}
				},
				"seTraceNote.issueUser": {
					row:'.form-group',//变红色字体的范围容器
					validators: {
						notEmpty: {
							message: 'The field is required'
						}
					}
				},
				"seTraceNote.noteTitle": {
					row:'.form-group',//变红色字体的范围容器
					validators: {
						notEmpty: {
							message: 'The field is required'
						}
					}
				},
				"seTraceNote.noteStatus": {
					row:'.form-group',//变红色字体的范围容器
					validators: {
						notEmpty: {
							message: 'The field is required'
						}
					}
				},
				"seTraceNote.alarmDays": {
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
	
	
	
	<h3>遗留备忘</h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seTraceNoteFormSubmit" namespace="/se" method="post" id="theForm">
		
		<div class="row">
		
		<div class="col-xs-6">
		
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					遗留备忘id<input 
							class="easyui-textbox" 
							name="seTraceNote.noteId"
							id="noteId" 
							type="text"
							value="${seTraceNote.noteId}" />
							创建时间
							<input 
							class="easyui-datebox" 
							name="seTraceNote.createTime"
							id="createTime" 
							type="text"
							value="<fmt:formatDate value="${seTraceNote.createTime}"  pattern="yyyy-MM-dd hh:mm:ss"/>" />
							修改时间
							<input 
							class="easyui-datebox" 
							name="seTraceNote.updateTime"
							id="updateTime" 
							type="text"
							value="<fmt:formatDate value="${seTraceNote.updateTime}"  pattern="yyyy-MM-dd hh:mm:ss"/>" />
							矩阵ID
							<input 
							class="easyui-textbox" 
							name="seTraceNote.traceId"
							id="traceId" 
							type="text"
							value="${seTraceNote.traceId}" />
							是否有效
							<input 
							class="easyui-textbox" 
							name="seTraceNote.isValid"
							id="isValid" 
							type="text"
							value="${seTraceNote.isValid}" />
							是否删除
							<input 
							class="easyui-textbox" 
							name="seTraceNote.isDelete"
							id="isDelete" 
							type="text"
							value="${seTraceNote.isDelete}" />
							创建人
							<input 
							class="easyui-textbox" 
							name="seTraceNote.creator"
							id="creator" 
							type="text"
							value="${seTraceNote.creator}" />
				</div>
				
				
				
				<div class="form-group" >
					<label class="col-xs-3 control-label">矩阵名称</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						  
							<input 
							class="form-control" 
							id="traceName" 
							readonly="readonly"
							type="text"
							value="${seRequirementTrace.traceName}" />
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
					<label class="col-xs-3 control-label">记事种类</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
							   <span class="input-group-addon">
							   			<i class="glyphicon glyphicon-console"></i>
							   </span>
							   
							    <s:select 
								 id="noteType" 
								 cssClass="select2" 
								 name="seTraceNote.noteType" 
								 list="#{'遗留':'遗留','备忘':'备忘','缺陷':'缺陷','BUG':'BUG','变更':'变更','设计缺陷':'设计缺陷','开发疑问':'开发疑问'}" 
								 headerKey="" 
								 headerValue="请选择"></s:select>
						  
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
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
							<input 
							class="form-control" 
							name="seTraceNote.noteTitle"
							id="noteTitle" 
							type="text"
							value="${seTraceNote.noteTitle}" />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-3 control-label">签发人</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
							<s:select id="issueUser" 
							 name="seTraceNote.issueUser"  
							 cssClass="select2"  
							 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="col-xs-3 control-label">遗留备忘状态</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
							<s:select 
							 id="noteStatus" 
							 cssClass="select2" 
							 name="seTraceNote.noteStatus" 
							 list="#{'未落实':'未落实','已落实':'已落实','已关闭':'已关闭'}" 
							 headerKey="" 
							 headerValue="请选择"></s:select>
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="col-xs-3 control-label">提醒日期</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
							<input 
							class="form-control" 
							name="seTraceNote.alarmDate"
							id="alarmDate" 
							type="text"
							value="<fmt:formatDate value="${seTraceNote.alarmDate}" pattern="yyyy-MM-dd"/>" />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="col-xs-3 control-label">预警天数</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
							<input 
							class="form-control" 
							name="seTraceNote.alarmDays"
							id="alarmDays" 
							type="text" 
							value="${seTraceNote.alarmDays}" />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="col-xs-3 control-label">执行人</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
							<s:select id="exeUser" 
							 name="seTraceNote.exeUser"  
							 cssClass="select2"  
							 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
				
				<div class="form-group" id="resolveDateDiv">
					<label class="col-xs-3 control-label">落实日期</label>
					<div class="col-xs-9">
					   <div class="input-inline">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
							<input 
							class="form-control" 
							name="seTraceNote.resolveDate"
							id="resolveDate" 
							type="text"
							value="<fmt:formatDate value="${seTraceNote.resolveDate}" pattern="yyyy-MM-dd"/>" />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   
					   </span>
					</div>
				</div>
				
		</div>
		
		<div class="col-xs-6">
			<h4>具体描述</h4>
			<s:textarea name="seTraceNote.noteContent" id="noteContent" ></s:textarea>
		</div>
		
	</div>
	<div class="row text-center" style="margin-top:20px;">
			<button type="button" id="submitButton" class="btn green" >Submit</button>
            <button type="button" class="btn default" onclick="resetForm()">Cancel</button>
            <button type="button" class="btn default" onclick="window.close()">Close</button>
		</div>
	</s:form>
	
	
	<c:if test="${seTraceNote.noteId != null }">
	<s:action name="common!commonFileList" namespace="/common" executeResult="true">
		<s:param name="seAttach.fid" value="#attr.seTraceNote.noteId"></s:param>
		<s:param name="seAttach.fkey"><%=StaticVar.ATTACHKEY_SETRACENOTE%></s:param>
	</s:action>
	</c:if>


</div>
<script>
var ue;
ue = UE.getEditor('noteContent',{
	serverUrl: "${ctx}/se/se!uploadFile.do",
   	imageUrlPrefix:"",
   	imageActionName:'img',
   	imageFieldName:'imgFile',
   	imageAllowFiles:[".png", ".jpg", ".jpeg", ".gif", ".bmp"],
   	initialFrameWidth:500,   //初始化编辑器宽度,默认1000 
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
