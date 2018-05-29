
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		
		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
   		<!-- 编辑器源码文件 -->
   		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
   
   
		<title><s:text name="title.applyName"></s:text>
		</title>
	
<style type="text/css">
.select2-selection--single{border-top-left-radius:0px !important;border-bottom-left-radius:0px !important;}
</style>

<script>


var validationTool;
//文本编辑器
var ue ;
function showText(){
	   var str =ue.getContentTxt();
	   alert(str);
	 
}
function showHtml(){
	   var html1 = ue.getContent();
	   alert(html1);
}
function stHtml(){
	   ue.setContent("hello world", true);
}


function theFormSubmit(){
	var formData = $("#theForm").serialize();
	$.ajax("${ctx}/se/se!seDayNoteFormSubmit.do",
		{
			type:"post",
			async:false,
			data:formData,
			success:function(r){
				var str = $.trim(r);
				//alert(str);
				if(str == "SUCCESS"){
					layer.alert(
						'保存成功', 
						{
							skin: 'layui-layer-molv',//样式类名
							closeBtn: 0
						}, 
						function(){
							try{
								getParent().reloadDg();
								window.close();
							}catch(e){
								try{
									parent.reloaddayNoteTab();
									parent.closeLayer(1);
								}catch(e){
									window.close();
								}
							}
						}
					);
					
					/*alert("保存成功");
					try{
						getParent().reloadDg();
						window.close();
					}catch(e){
						try{
							parent.reloaddayNoteTab();
							parent.closeLayer(1);
						}catch(e){
							window.close();
						}
					}*/
				}else{
					alert("保存失败");
				};
				//ue1.setContent(str, false);
			}
		}
	)
}



$(function(){
	
	
	 $('#noteDate').datetimepicker({
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
	 
	 
	  $("#noteType").select2({
		  //默认文本
		  placeholder: 'Select an option',
		  allowClear: true,
		  width:200
		  
	  });
	  
	  $("#projectId").select2({
		  //默认文本
		  placeholder: 'Select an option',
		  allowClear: true,
		  width:200
		  
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
				"seDayNote.noteType": {
					row:'.form-group',//变红色字体的范围容器
			        validators: {
					     notEmpty: {
			                        message: 'The field is required'
			             }
			         }
				},
				/*"seDayNote.projectId": {
					row:'.form-group',//变红色字体的范围容器
			        validators: {
					     notEmpty: {
							message: 'The field is required'
			             }
			         }
				},*/
				"seDayNote.noteTitle": {
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

		/*
		$("#submitButton").click(function(){
		    	validationTool.data("formValidation").validate();
		    	var validateResult = validationTool.data("formValidation").isValid();
		    	if(validateResult){
		    		document.getElementById("theForm").submit();
		    	};
		});
		*/
		
		$("#submitButton").click(function(){
	    	validationTool.data("formValidation").validate();
	    	var validateResult = validationTool.data("formValidation").isValid();
	    	if(validateResult){
	    		theFormSubmit();
	    	};
		});
	 
	
	ue1 = UE.getEditor('noteContent',{
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
        
        initialFrameWidth:'100%',   //初始化编辑器宽度,默认1000 
        initialFrameHeight:320,  //初始化编辑器高度,默认320
        
        videoActionName: "uploadvideo", /* 执行上传视频的action名称 */
        videoFieldName: "imgFile", /* 提交的视频表单名称 */
        videoMaxSize: 102400000, /* 上传大小限制，单位B，默认100MB */
        videoAllowFiles: [
            ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
            ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"], /* 上传视频格式显示 */

    });
})
</script>
	</head>

<body>
	<div class="container-fluid">
	<h3> Note </h3>
	<hr/>
	<s:form cssClass="form-horizontal" action="se!seDayNoteFormSubmit" namespace="/se" method="post" id="theForm">
		
		<div style="display: none;">
			操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
			日记id：<input 
					name="seDayNote.noteId"
					id="noteId"  
					type="text"
					value="${seDayNote.noteId}" />
			是否删除:<input 
					name="seDayNote.isDelete"
					id="isDelete" 
					type="text"
					value="${seDayNote.isDelete}" />
			是否有效:<input 
					name="seDayNote.isValid"
					id="isDelete" 
					type="text"
					value="${seDayNote.isValid}" />
			创建时间：<input 
					name="seDayNote.createTime"
					id="createTime" 
					type="text"
					value="${seDayNote.createTime}" />
			修改时间：<input 
					name="seDayNote.updateTime"
					id="updateTime" 
					type="text"
					value="${seDayNote.updateTime}" />
		</div>
		
		
		
		
		
		<div class="row">
			<div class="col-xs-1"></div>
			<div class="col-xs-5">
				<div class="form-group">
					<label class="col-xs-3 control-label">分&nbsp;&nbsp;类</label>
					<div class="col-xs-9">
						<div class="input-group">
							<span class="input-group-addon">
								<i class="glyphicon glyphicon-console"></i>
							</span>
						  	<s:select id="noteType" 
							 name="seDayNote.noteType"  
							 cssClass="select2"  
							 list="#request.noteTypeList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
							 
							 
					   </div>
					   <span class="help-inline">
					   </span>
					   
					</div>
				</div>
			</div>
			<div class="col-xs-5">
				<div class="form-group">
					<label class="col-xs-3 control-label">所属系统</label>
					<div class="col-xs-9">
					<div class="input-group">
						<span class="input-group-addon">
							<i class="glyphicon glyphicon-console"></i>
						</span>
						 <s:select id="projectId" 
							 name="seDayNote.projectId"  
							 cssClass="select2 form-control"  
							 list="#request.projectList"  listKey="projectId" listValue="projectName" headerKey="" headerValue="全部"></s:select> 
					</div>
				    <span class="help-inline">
				    </span>
					</div>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-1"></div>
			<div class="col-xs-5">
				<div class="form-group">
					<label class="col-xs-3 control-label">标&nbsp;&nbsp;题</label>
					<div class="col-xs-9">
						<div class="input-inline">
							<div class="input-group">
								<span class="input-group-addon">
									<i class="glyphicon glyphicon-console"></i>
								</span>
								<input 
									class="form-control" 
									name="seDayNote.noteTitle"
									id="noteTitle" 
									type="text"
									data-options="required:true,width:450" 
									value="${seDayNote.noteTitle}" />
							</div>
						</div>
						<span class="help-inline">
						</span>
					</div>
				</div>
			</div>
			<div class="col-xs-5">
				<div class="form-group">
					<label class="col-xs-3 control-label">日&nbsp;&nbsp;期</label>
					<div class="col-xs-9">
						<div class="input-inline">
							<div class="input-group">
								<span class="input-group-addon">
									<i class="glyphicon glyphicon-console"></i>
								</span>
								<input 
								class="form-control" 
								name="seDayNote.noteDate"
								id="noteDate" 
								type="text"
								value="<fmt:formatDate value="${seDayNote.noteDate}"  pattern="yyyy-MM-dd"/>"  />
							</div>
						</div>
						<span class="help-inline">
						</span>
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		<div class="form-group">
			<div class="col-xs-2"></div>
			<div class="col-xs-9">
			<textarea name="seDayNote.noteContent" id="noteContent">${seDayNote.noteContent}</textarea>
			</div>
		</div>
		
		
		
		<c:if test="${seDayNote.noteId != null }">
		<s:action name="common!commonFileList" namespace="/common" executeResult="true">
			<s:param name="seAttach.fid" value="#attr.seDayNote.noteId"></s:param>
			<s:param name="seAttach.fkey"><%=StaticVar.ATTACHKEY_SEDAYNOTE%></s:param>
		</s:action>
		</c:if>
		<div style="padding-bottom:70px;"></div>

		<nav class="navbar navbar-default navbar-fixed-bottom">
  			<div class=" text-right container-fluid" style="padding-top:6px;background:#fff;">
		
			<!-- 
				<button type="button" id="submitButton" class="btn green">Submit</button> -->
				<button type="button" id="submitButton" class="btn green">Submit</button>
	            <button type="button" class="btn default" onclick="window.close()">Cancel</button>
			</div>
		</nav>
	
	</s:form>
	</div>
					
				
</body>
</html>
