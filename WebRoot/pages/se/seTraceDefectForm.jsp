
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
		<title></title>
	
<style type="text/css">
.select2-selection--single{border-top-left-radius:0px !important;border-bottom-left-radius:0px !important;}
</style>
<script>
var validationSeTraceDefectTool;
$(function(){

	$(".select2").select2({
		  //默认文本
		  placeholder: 'Select an option',
		  allowClear: true,
		  width:200
		  
	  });
 $('#createTime').datetimepicker({
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
			 validationSeTraceDefectTool.data("formValidation").revalidateField("seTraceDefect.createTime");
	    });;
 $('#updateTime').datetimepicker({
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
			 validationSeTraceDefectTool.data("formValidation").revalidateField("seTraceDefect.updateTime");
	    });;


validationSeTraceDefectTool = $('#theSeTraceDefectForm').formValidation({
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
		
		
		"traceName": {
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
		"seTraceDefect.defectDesc": {
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
		"seTraceDefect.defectClassify": {
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
		"seTraceDefect.defectStatus": {
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
		"seTraceDefect.developer": {
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
		"seTraceDefect.testUser": {
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
		}
	}
});


$("#submitButton").click(function(){
    	validationSeTraceDefectTool.data("formValidation").validate();
    	var validateResult = validationSeTraceDefectTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theSeTraceDefectForm").submit();
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
		<h3>  Trace Defect</h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seTraceDefectFormSubmit" namespace="/se" method="post" id="theSeTraceDefectForm">
		
			
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					矩阵ID： <input 
									class="form-control" 
									name="seTraceDefect.traceId"
									id="traceId" 
									type="text"
									value="${seTraceDefect.traceId}" />
					是否删除：<input type="text" name="seTraceDefect.isDelete" value="${seTraceDefect.isDelete}"/>
					<div class="form-group" >
						<label class="col-xs-3 control-label">记录id</label>
						<div class="col-xs-9">
						   <div class="input-inline ">
						       <div class="input-group">
							   <span class="input-group-addon">
							   			<i class="glyphicon glyphicon-console"></i>
							   </span>
							   <input 
								id="defectId"  
								name="seTraceDefect.defectId"
								class="form-control" 
								placeholder="记录id"
								value="${seTraceDefect.defectId}"/> 
							</div>
						   </div>
							<span class="help-inline"> 
							</span>
						</div>
					</div>
					<div class="form-group">
							<label class="col-xs-3 control-label">创建时间</label>
							<div class="col-xs-9">
							   <div class="input-inline ">
							       <div class="input-group">
								   <span class="input-group-addon">
								   			<i class="glyphicon glyphicon-calendar"></i>
								   </span>
								   <input 
									class="form-control" 
									name="seTraceDefect.createTime"
									id="createTime" 
									type="text"
									value="<fmt:formatDate value="${seTraceDefect.createTime}"  pattern="yyyy-MM-dd hh:mm:ss"/>"  />
								  
							       </div>
							   </div>
							   <span class="help-inline">
							   </span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">更新时间</label>
							<div class="col-xs-9">
							   <div class="input-inline ">
							       <div class="input-group">
								   <span class="input-group-addon">
								   			<i class="glyphicon glyphicon-calendar"></i>
								   </span>
								   <input 
									class="form-control" 
									name="seTraceDefect.updateTime"
									id="updateTime" 
									type="text"
									value="<fmt:formatDate value="${seTraceDefect.updateTime}" pattern="yyyy-MM-dd hh:mm:ss"/>"  />
								  
							       </div>
							   </div>
							   <span class="help-inline">
							   </span>
							</div>
						</div>
				</div>

				
				
				
				<div class="row">
		
					<div class="col-xs-6">
						
						
						<div class="form-group" >
							<label class="col-xs-3 control-label">矩阵名称</label>
							<div class="col-xs-9">
							   <div class="input-inline">
							       <div class="input-group">
								  
									<input 
									class="form-control" 
									id="traceName" 
									name="traceName"
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
				
				<!-- 
						<div class="form-group">
							<label class="col-xs-3 control-label">矩阵id</label>
							<div class="col-xs-9">
							   <div class="input-inline ">
							       <div class="input-group">
								   <span class="input-group-addon">
								   			<i class="glyphicon glyphicon-console"></i>
								   </span>
								   <input 
									class="form-control" 
									name="seTraceDefect.traceId"
									id="traceId" 
									type="text"
									value="${seTraceDefect.traceId}" /> 
								  
							       </div>
							   </div>
							   <span class="help-inline">
							   </span>
							</div>
						</div> -->
						<div class="form-group">
							<label class="col-xs-3 control-label">缺陷描述</label>
							<div class="col-xs-9">
							   <div class="input-inline ">
							       <div class="input-group">
								   <span class="input-group-addon">
								   			<i class="glyphicon glyphicon-console"></i>
								   </span>
								   <input 
									class="form-control" 
									name="seTraceDefect.defectDesc"
									id="defectDesc" 
									type="text"
									value="${seTraceDefect.defectDesc}" /> 
								  
							       </div>
							   </div>
							   <span class="help-inline">
							   </span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">缺陷分类</label>
							<div class="col-xs-9">
							   <div class="input-inline ">
							       <div class="input-group">
								   <span class="input-group-addon">
								   			<i class="glyphicon glyphicon-console"></i>
								   </span>
								   
								    <s:select 
								 id="defectClassify" 
								 cssClass="select2" 
								 name="seTraceDefect.defectClassify"
								 list="#{'1、致命错误':'1、致命错误','2、严重错误':'2、严重错误','3、一般错误':'3、一般错误','4、细微错误':'4、细微错误','5、改进建议':'5、改进建议'}" 
								 headerKey="" 
								 headerValue="请选择问题分类"></s:select>
								 
								  
							       </div>
							   </div>
							   <span class="help-inline">
							   </span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">缺陷状态</label>
							<div class="col-xs-9">
							   <div class="input-inline ">
							       <div class="input-group">
								   <span class="input-group-addon">
								   			<i class="glyphicon glyphicon-console"></i>
								   </span>
								    
								     <s:select 
								 id="defectStatus" 
								 cssClass="select2" 
								 name="seTraceDefect.defectStatus" 
								 list="#{'问题提出':'问题提出','已修改':'已修改','关闭':'关闭','重新打开':'重新打开','遗留问题':'遗留问题'}" 
								 headerKey="" 
								 headerValue="请选择缺陷状态"></s:select>
								 
								 
							       </div>
							   </div>
							   <span class="help-inline">
							   </span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">开发人员</label>
							<div class="col-xs-9">
							   <div class="input-inline ">
							       <div class="input-group">
								   <span class="input-group-addon">
								   			<i class="glyphicon glyphicon-console"></i>
								   </span>
								   <s:select id="developer" 
									 name="seTraceDefect.developer"  
									 cssClass="select2"  
									 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
							       </div>
							   </div>
							   <span class="help-inline">
							   </span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-3 control-label">测试人员</label>
							<div class="col-xs-9">
							   <div class="input-inline ">
							       <div class="input-group">
								   <span class="input-group-addon">
								   			<i class="glyphicon glyphicon-console"></i>
								   </span>
								   <s:select id="testUser" 
									 name="seTraceDefect.testUser"  
									 cssClass="select2"  
									 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
								  
							       </div>
							   </div>
							   <span class="help-inline">
							   </span>
							</div>
						</div>
						
				
				
				
				
				</div>
				<div class="col-xs-6">
					<h4>具体描述</h4>
					<s:textarea name="seTraceDefect.defectPic" id="defectPic" ></s:textarea>
				</div>
				</div>
				
				
<div class="row text-center">
	<c:if test="${canEdit == staticVarObj.y }">
		<button type="button" id="submitButton" class="btn green">Submit</button>
	</c:if>
		<button type="button" class="btn default">Cancel</button>
</div>
</s:form>


<c:if test="${seTraceDefect.defectId != null }">
<s:action name="common!commonFileList" namespace="/common" executeResult="true">
	<s:param name="seAttach.fid" value="#attr.seTraceDefect.defectId"></s:param>
	<s:param name="seAttach.fkey"><%=StaticVar.ATTACHKEY_SETRACEDEFECT%></s:param>
</s:action>
</c:if>


</div>

<script>
var ue;
ue = UE.getEditor('defectPic',{
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
