
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<title>公共功能</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
<style type="text/css">
.select2-selection--single{border-top-left-radius:0px !important;border-bottom-left-radius:0px !important;}
</style>
<script>
var validationTool;
var sePubModuleForm;
var projectSelect;
var userSelect;
$(function(){
	
	  projectSelect = $("#projectId").select2({
		  //默认文本
		  placeholder: 'Select an option',
		  allowClear: true,
		  width:200
		  
	  });
	  userSelect = $("#moduleUser").select2({
		  //默认文本
		  placeholder: 'Select an option',
		  allowClear: true,
		  width:200
		  
	  });
	  
	  
	  $('#projectId').on('change', function (evt) {
		  //alert($(this).val() + "|" + $("option:selected",$(this)).html());
		  var projectId = $(this).val();
		  //alert(projectId);
		  $.ajax({
			  dataType: "json",
			  method : "post",
			  async:false,
			  url:'${ctx}/se/se!queryUserOfprojectForBootstrap.do',
			  data:{projectId:projectId},
			  success: function(data){
				  //console.log(data);
				  if(data){
					  $('#moduleUser').html("");
					  var optStr = "";
					  for(var i = 0 , j = data.length ; i < j ; i++){
						  var opt = $("<option></option>");
						  opt.val(data[i].value);
						  opt.html(data[i].text);
						  $('#moduleUser').append(opt);
					  }
					  $('#moduleUser').trigger("change");
				  }
				  
			  }
		  })
	});
	  
	  validationTool = $('#sePubModuleForm').formValidation({
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
	        	
	        	"sePubModule.moduleTitle": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                    },
	                    notEmpty: {
	                        message: 'The first name is required'
	                    }
	                }
	            },
	            "sePubModule.moduleName": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                    },
	                    notEmpty: {
	                        message: 'The first name is required'
	                    }
	                }
	            },
	            "sePubModule.moduleClassify": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    notEmpty: {
	                        message: 'The first name is required'
	                    }
	                }
	            },
	            "sePubModule.moduleUser": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    notEmpty: {
	                        message: 'This Field is required'
	                    }
	                }
	            },
	            "sePubModule.projectId": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    notEmpty: {
	                        message: 'This Field is required'
	                    }
	                }
	            },
	            "sePubModule.moduleInput": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    stringLength: {
	                        max: 256,
	                        message: '长度256以内'
	                    }
	                }
	            },
	            "sePubModule.moduleOutput": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    stringLength: {
	                        max: 256,
	                        message: '长度256以内'
	                    }
	                }
	            },
	            "sePubModule.moduleOutput": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    stringLength: {
	                        max: 256,
	                        message: '长度256以内'
	                    }
	                }
	            },
	              
	            "sePubModule.moduleExample": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    stringLength: {
	                        max: 256,
	                        message: '长度256以内'
	                    }
	                }
	            },
	            "sePubModule.moduleFile": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    stringLength: {
	                        max: 256,
	                        message: '长度256以内'
	                    }
	                }
	            },
	            "sePubModule.moduleDate": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                    },
	                    notEmpty: {
	                        message: 'The first name is required'
	                    }
	                }
	            }
	            
	           
	        }
	    });
	
	 $('input.rdo').iCheck({
		    checkboxClass: 'icheckbox_flat-blue',
		    radioClass: 'iradio_flat-blue'
	  });
	 
	 $('input.rdo').on('ifChecked', function(event){
		 validationTool.data("formValidation").revalidateField("sePubModule.moduleClassify");
	 });
	 
	 $('#moduleDate').datetimepicker({
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
			 validationTool.data("formValidation").revalidateField("sePubModule.moduleDate");
	    });
	
	 $("#submitButton").click(function(){
    	validationTool.data("formValidation").validate();
    	var validateResult = validationTool.data("formValidation").isValid();
    	if(validateResult){
    		//document.getElementById("sePubModuleForm").submit();
    		submitModuleForm();
    	};
	 });
	 <c:if test="${sePubModule.moduleClassify != '' }">
	 	$('#ck_${sePubModule.moduleClassify}').iCheck('check');
	 </c:if>
	
})


function submitModuleForm(){
	var formData = $("#sePubModuleForm").serialize();
	$.ajax("${ctx}/se/se!sePubModuleFormSubmit.do",
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
									parent.reloadModuleTab();
									parent.closeLayer(1);
								}catch(e){
									window.close();
								}
							}
						}
					);
					
				}else{
					alert("保存失败");
				};
			}
		}
	)
	
}
</script>
	</head>

	<body>
	
	
<h3>Public Module Info</h3>
<hr/>
<div class="container-fluid">
<div class="row">
<s:form action="se!sePubModuleFormSubmit" cssClass="form-horizontal" namespace="/se" method="post" id="sePubModuleForm">
<div class="col-xs-10">


<div style="display: none;">
	操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
	组件ID<input 
			class="easyui-textbox" 
			name="sePubModule.moduleId"
			id="moduleId" 
			type="text"
			value="${sePubModule.moduleId}" />
</div>

<div class="form-body">
			<div class="form-group">
               <label class="col-xs-3 control-label">所属项目</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
							<s:select id="projectId"   name="sePubModule.projectId"  cssClass="select2"  list="#request.projectList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
					    </div>
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-xs-3 control-label">负责人</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                         
							<s:select id="moduleUser"   name="sePubModule.moduleUser"  cssClass="select2"  
							list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
					    
							
					    </div>
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           <div class="form-group">
               <label class="col-xs-3 control-label">组件标题</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input 
							class="form-control" 
							placeholder="组件标题"
							name="sePubModule.moduleTitle"
							id="moduleTitle" 
							type="text"
							value="${sePubModule.moduleTitle}" />
					    </div>
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-xs-3 control-label">组件名称</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input 
							class="form-control" 
							placeholder="组件名称"
							name="sePubModule.moduleName"
							id="moduleName" 
							type="text"
							value="${sePubModule.moduleName}" />
					    </div>
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           
           
           <div class="form-group">
               <label class="col-xs-3 control-label">组件分类</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                      
                           <c:forEach items="${classifyList}" var="clf">
                           		<input class="rdo" type="radio" id="ck_${clf.value }" value="${clf.value }" name="sePubModule.moduleClassify" />
                           		${clf.text } &nbsp; &nbsp;
                           </c:forEach>
							
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           
           
           <div class="form-group">
               <label class="col-xs-3 control-label">输入</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input 
							class="form-control" 
							placeholder="输入"
							name="sePubModule.moduleInput"
							id="moduleInput" 
							type="text"
							value="${sePubModule.moduleInput}" />
					    </div>
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           
           
           <div class="form-group">
               <label class="col-xs-3 control-label">输出</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input 
							class="form-control" 
							placeholder="输出"
							name="sePubModule.moduleOutput"
							id="moduleOutput" 
							type="text"
							value="${sePubModule.moduleOutput}" />
					    </div>
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           
           
           
           
           <div class="form-group">
               <label class="col-xs-3 control-label">所在文件</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input 
							class="form-control" 
							placeholder="所在文件"
							name="sePubModule.moduleFile"
							id="moduleFile" 
							type="text"
							value="${sePubModule.moduleFile}" />
					    </div>
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-xs-3 control-label">组件示例</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input 
							class="form-control" 
							placeholder="组件示例"
							name="sePubModule.moduleExample"
							id="moduleExample" 
							type="text"
							value="${sePubModule.moduleExample}" />
					    </div>
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           
           
           <div class="form-group">
               <label class="col-xs-3 control-label">发布日期</label>
               <div class="col-xs-9">
                   <div class="input-inline ">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input 
							class="form-control" 
							placeholder="发布日期"
							name="sePubModule.moduleDate"
							id="moduleDate" 
							type="text"
							value="<fmt:formatDate value="${sePubModule.moduleDate}" pattern="yyyy-MM-dd"/>" />
					    </div>
                   </div>
                   <span class="help-inline"> 
                   </span>
               </div>
           </div>
           
           
           
           
           
           <div class="form-group">
               <label class="col-xs-3 control-label">描述</label>
               <div class="col-xs-9">
                   <s:textarea name="sePubModule.moduleDesc" id="moduleDesc"></s:textarea>
               </div>
           </div>
</div>







<!--  
	<div class="form-group">
         <label class="col-xs-3 control-label">描述</label>
         <div class="col-xs-9">
             <div class="input-inline ">
                 <div class="input-group">
                     <span class="input-group-addon">
                         <i class="fa fa-gears"></i>
                     </span>
                     <input 
	class="form-control" 
	placeholder="描述"
	name="sePubModule.moduleDesc"
	id="moduleDesc" 
	type="text"
	value="${sePubModule.moduleDesc}" />
   </div>
             </div>
             <span class="help-inline"> 
             		描述
             </span>
         </div>
     </div>
     -->
</div>


    



</div>
<div class="row">
        <div class="text-center">
            <button type="button" id="submitButton" class="btn green">Submit</button>
            <button type="button" class="btn default">Cancel</button>
        </div>
</div>
</s:form>

<c:if test="${sePubModule.moduleId != null }">
<s:action name="common!commonFileList" namespace="/common" executeResult="true">
	<s:param name="seAttach.fid" value="#attr.sePubModule.moduleId"></s:param>
	<s:param name="seAttach.fkey"><%=StaticVar.ATTACHKEY_SEPUBMODULE%></s:param>
</s:action>
</c:if>
						
						
<script>
var ue;
ue = UE.getEditor('moduleDesc',{
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
    initialFrameWidth:'100%',   //初始化编辑器宽度,默认1000 
    initialFrameHeight:320,  //初始化编辑器高度,默认320
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
