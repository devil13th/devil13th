
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
</style>
<script>
var validationSeMenuTool;
$(function(){




validationSeMenuTool = $('#theSeMenuForm').formValidation({
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
		
		
		"seMenu.menuName": {
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
		"seMenu.menuNameEn": {
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
		"seMenu.treeCode": {
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
		"seMenu.isLeaf": {
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
		"seMenu.menuUrl": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 128,
	                        message: '长度128以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMenu.isValid": {
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
		"seMenu.menuIco": {
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
		"seMenu.openType": {
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

		"seMenu.menuId": {
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
    	validationSeMenuTool.data("formValidation").validate();
    	var validateResult = validationSeMenuTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theSeMenuForm").submit();
    	};
});
})
</script>
	</head>

	<body>
		<h3> 菜单信息 </h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seMenuFormSubmit" namespace="/se" method="post" id="theSeMenuForm">
		
		<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-10">
			
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					<input type="text" name="id" value="${id}"/>
					 <input 
								class="form-control" 
								name="seMenu.parentId"
								id="isValid" 
								type="text"
								value="${seMenu.parentId}" /> 
					
					<div class="form-group">
						<label class="col-xs-3 control-label">是否叶子节点</label>
						<div class="col-xs-9">
						   <div class="input-inline input-medium">
						       <div class="input-group">
							   <span class="input-group-addon">
							   			<i class="glyphicon glyphicon-console"></i>
							   </span>
							   <input 
								class="form-control" 
								name="seMenu.isLeaf"
								id="isLeaf" 
								type="text"
								value="${seMenu.isLeaf}" /> 
							  
						       </div>
						   </div>
						   <span class="help-inline">
						   </span>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-xs-3 control-label">树形代码</label>
						<div class="col-xs-9">
						   <div class="input-inline input-medium">
						       <div class="input-group">
							   <span class="input-group-addon">
							   			<i class="glyphicon glyphicon-console"></i>
							   </span>
							   <input 
								class="form-control" 
								name="seMenu.treeCode"
								id="treeCode" 
								type="text"
								value="${seMenu.treeCode}" /> 
							  
						       </div>
						   </div>
						   <span class="help-inline">
						   </span>
						</div>
					</div>
					<div class="form-group" style="display:none;">
						<label class="col-xs-3 control-label">菜单ID</label>
						<div class="col-xs-9">
						   <div class="input-inline input-medium">
						       <div class="input-group">
							   <span class="input-group-addon">
							   			<i class="glyphicon glyphicon-console"></i>
							   </span>
							   <input 
								id="menuId"  
								name="seMenu.menuId"
								class="form-control" 
								placeholder="菜单ID"
								value="${seMenu.menuId}"/> 
							</div>
						   </div>
							<span class="help-inline"> 
							</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-3 control-label">是否有效</label>
						<div class="col-xs-9">
						   <div class="input-inline input-medium">
						       <div class="input-group">
							   <span class="input-group-addon">
							   			<i class="glyphicon glyphicon-console"></i>
							   </span>
							   <input 
								class="form-control" 
								name="seMenu.isValid"
								id="isValid" 
								type="text"
								value="${seMenu.isValid}" /> 
							  
						       </div>
						   </div>
						   <span class="help-inline">
						   </span>
						</div>
					</div>
				
				</div>

				
				
				

				<div class="form-group">
					<label class="col-xs-3 control-label">菜单名称</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMenu.menuName"
							id="menuName" 
							type="text"
							value="${seMenu.menuName}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-3 control-label">菜单英文名称</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMenu.menuNameEn"
							id="menuNameEn" 
							type="text"
							value="${seMenu.menuNameEn}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="col-xs-3 control-label">菜单URL</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMenu.menuUrl"
							id="menuUrl" 
							type="text"
							value="${seMenu.menuUrl}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">功能描述</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
							
							<s:textarea name="seMenu.menuDesc" id="menuDesc" ></s:textarea>
						  
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">排序号</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMenu.menuOrder"
							id="menuOrder" 
							type="text"
							value="${seMenu.menuOrder}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">图标样式</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMenu.menuIco"
							id="menuIco" 
							type="text"
							value="${seMenu.menuIco}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">打开方式</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMenu.openType"
							id="openType" 
							type="text"
							value="${seMenu.openType}" /> 
						  
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
var ue;
ue = UE.getEditor('menuDesc',{
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
