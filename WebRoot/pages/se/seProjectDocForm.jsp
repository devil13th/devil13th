<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		
		<link href="${ctx}/js/bootstrap-fileinput/css/fileinput.css" media="all" rel="stylesheet" type="text/css" />
		<script src="${ctx}/js/bootstrap-fileinput/js/fileinput.js" type="text/javascript"></script>
		<script src="${ctx}/js/bootstrap-fileinput/js/locales/fr.js" type="text/javascript"></script>
		<script src="${ctx}/js/bootstrap-fileinput/js/locales/es.js" type="text/javascript"></script>

		<title></title>
	
<style type="text/css">
</style>
<script>
var validationSeProjectDocTool;
$(function(){

	$(".select2").select2({
		 //默认文本,placeholder才可以使用allowClear 否则JS报错
		placeholder: 'Select an option',
		allowClear: true,
		width:"100%"
	});
	
	 $('#uploadTime').datetimepicker({
		    language:'zh-CN',
			format:'yyyy-mm-dd hh:ii:ss',
			weekStart: 1,
			todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: "month",
			minView: "hour",
			forceParse: 0
		});
	 
	 <c:if test="${attach != null }">
	 addFile("${attach.attachId }","${attach.attachName}","${attach.attachPath}","${attach.attachSize}");
	</c:if>


validationSeProjectDocTool = $('#theSeProjectDocForm').formValidation({
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
		
		
		"seProjectDoc.projectId": {
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
		"seProjectDoc.docName": {
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
		"seProjectDoc.docCode": {
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
		"seProjectDoc.docVersoin": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                     }
	                }
		},
		"seProjectDoc.docDesc": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                     }
	                }
		}
	}
});


$("#submitButton").click(function(){
    	validationSeProjectDocTool.data("formValidation").validate();
    	var validateResult = validationSeProjectDocTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theSeProjectDocForm").submit();
    	};
});
})





function addFile(fileId,fileName,filePath,fileSize){
	$("#commonFileListDiv").html();
	var div = $("<div id='attach_" + fileId + "'></div>");
	var lk = $("<a target='_blank'></a>");
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
	</head>

	<body>
		<h3> Project Doc.</h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seProjectDocFormSubmit" namespace="/se" method="post" id="theSeProjectDocForm">
		
		<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-10">
			
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
				</div>
				<div class="form-group" style="display:none;">
					<label class="col-xs-3 control-label">上传人</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seProjectDoc.uploader"
							id="uploader" 
							type="text"
							value="${seProjectDoc.uploader}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group" style="display:none;">
					<label class="col-xs-3 control-label">上传时间</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seProjectDoc.uploadTime"
							id="uploadTime" 
							type="text"
							value="<fmt:formatDate value="${seProjectDoc.uploadTime}"  pattern="yyyy-MM-dd HH:mm:ss"/>"  />
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group"  style="display:none;">
					<label class="col-xs-3 control-label">是否删除</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seProjectDoc.isDelete"
							id="isDelete" 
							type="text"
							value="${seProjectDoc.isDelete}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				
				<div class="form-group" style="display:none;">
					<label class="col-xs-3 control-label">文档ID</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							id="docId"  
							name="seProjectDoc.docId"
							class="form-control" 
							placeholder="文档ID"
							value="${seProjectDoc.docId}"/> 
						</div>
					   </div>
						<span class="help-inline"> 
						</span>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-3 control-label">所属项目</label>
					<div class="col-xs-9">
						   
						   <s:select id="projectId" 
					 name="seProjectDoc.projectId"  
					 cssClass="select2 form-control"  
					 list="#request.projectList"  listKey="projectId" listValue="projectName" headerKey="" headerValue="请选择"></s:select> 
					 
						  
					  
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-3 control-label">标准文档CODE</label>
					<div class="col-xs-9">
						
						
						
						
						<s:select id="docCode" 
					 name="seProjectDoc.docCode"  
					 cssClass="select2 form-control"  
					 list="#request.standarDocCodeList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select> 
					 
					 <!-- 
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seProjectDoc.docCode"
							id="docCode" 
							type="text"
							value="${seProjectDoc.docCode}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					    -->
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">文档文件</label>
					<div class="col-xs-9">
					   <input id="file-1" type="file" name="file" multiple class="file" data-overwrite-initial="false" data-min-file-count="1">
					   <div id="fileList"></div>
					   <div id="commonFileListDiv"></div>
					</div>
				</div>
				
				<div class="form-group" style="display:none;">
					<label class="col-xs-3 control-label">附件ID</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seProjectDoc.attachId"
							id="attachId" 
							type="text"
							value="${seProjectDoc.attachId}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">文档名称</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seProjectDoc.docName"
							id="docName" 
							type="text"
							value="${seProjectDoc.docName}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">版本</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seProjectDoc.docVersoin"
							id="docVersoin" 
							type="text"
							value="${seProjectDoc.docVersoin}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">文档说明</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seProjectDoc.docDesc"
							id="docDesc" 
							type="text"
							value="${seProjectDoc.docDesc}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				
				
		</div>
	

	




</div>
<div class="row text-center">
            <button type="button" id="submitButton" class="btn green">Submit</button>
            <button type="button" class="btn default">Cancel</button>
</div>
</s:form>



</div>

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
	    //alert(filePath)
	    var fileSize = data.response.attachSize;
	    
	    $("#fileList").append($("<div class='alert alert-success'><span class='glyphicon glyphicon-ok' ></span> 文件提交成功    name:" + data.response.attachName+ "</div>"));
	    $("#docName").val(fileName);
	    $("#attachId").val(fileId);
	    addFile(fileId,fileName,filePath,fileSize);
	});

	
	  
	  
</script>					
	</body>
</html>
