
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		<title></title>
	
<style type="text/css">
.select2-selection--single{border-top-left-radius:0px !important;border-bottom-left-radius:0px !important;}
</style>
<script>
var validationSeRoleTool;
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
			 validationSeRoleTool.data("formValidation").revalidateField("seRole.createTime");
	    });;
 $('#modiTime').datetimepicker({
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
			 validationSeRoleTool.data("formValidation").revalidateField("seRole.modiTime");
	    });;


validationSeRoleTool = $('#theSeRoleForm').formValidation({
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
		
		
		"seRole.roleName": {
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
		"seRole.roleLevel": {
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
		"seRole.roleClassify": {
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
		"seRole.isValid": {
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
		"seRole.creator": {
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
		"seRole.createTime": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seRole.modifier": {
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
		"seRole.modiTime": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},

		"seRole.roleCode": {
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
    	validationSeRoleTool.data("formValidation").validate();
    	var validateResult = validationSeRoleTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theSeRoleForm").submit();
    	};
});
})
</script>
	</head>

	<body>
		<h3> --- Page Title</h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seRoleFormSubmit" namespace="/se" method="post" id="theSeRoleForm">
		
		<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-10">
			
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					
					
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
								name="seRole.isValid"
								id="isValid" 
								type="text"
								value="${seRole.isValid}" /> 
							  
						       </div>
						   </div>
						   <span class="help-inline">
						   </span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-3 control-label">创建人</label>
						<div class="col-xs-9">
						   <div class="input-inline input-medium">
						       <div class="input-group">
							   <span class="input-group-addon">
							   			<i class="glyphicon glyphicon-console"></i>
							   </span>
							   <input 
								class="form-control" 
								name="seRole.creator"
								id="creator" 
								type="text"
								value="${seRole.creator}" /> 
							  
						       </div>
						   </div>
						   <span class="help-inline">
						   </span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-3 control-label">创建时间</label>
						<div class="col-xs-9">
						   <div class="input-inline input-medium">
						       <div class="input-group">
							   <span class="input-group-addon">
							   			<i class="glyphicon glyphicon-calendar"></i>
							   </span>
							   <input 
								class="form-control" 
								name="seRole.createTime"
								id="createTime" 
								type="text"
								value="<fmt:formatDate value="${seRole.createTime}"  pattern="yyyy-MM-dd hh:mm:ss"/>"  />
							  
						       </div>
						   </div>
						   <span class="help-inline">
						   </span>
						</div>
					</div>
				</div>

				
				<div class="form-group">
					<label class="col-xs-3 control-label">角色Code</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							id="roleCode"  
							name="seRole.roleCode"
							class="form-control" 
							placeholder="角色Code"
							value="${seRole.roleCode}"/> 
						</div>
					   </div>
						<span class="help-inline"> 
						</span>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-3 control-label">角色名称</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seRole.roleName"
							id="roleName" 
							type="text"
							value="${seRole.roleName}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">角色等级</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
							 
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seRole.roleLevel"
							id="roleLevel" 
							type="text"
							value="${seRole.roleLevel}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">角色分类</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
					       
					       <span class="input-group-addon">
						   		<i class="glyphicon glyphicon-console"></i>
						   </span>
						   
						    <s:select 
							 id="roleClassify" 
							 cssClass="select2" 
							 name="seRole.roleClassify" 
							 list="#{'SYSTEM':'系统角色','PROJECT':'项目角色'}" 
							 headerKey="" 
							 headerValue="请选择"></s:select>
								 
								 
								 
						  
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<!-- 
				<div class="form-group">
					<label class="col-xs-3 control-label">修改人</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seRole.modifier"
							id="modifier" 
							type="text"
							value="${seRole.modifier}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">修改时间</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seRole.modiTime"
							id="modiTime" 
							type="text"
							value="<fmt:formatDate value="${seRole.modiTime}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				-->
		</div>
	

	




</div>
<div class="row text-center">
            <button type="button" id="submitButton" class="btn green">Submit</button>
            <button type="button" class="btn default">Cancel</button>
</div>
</s:form>
</div>

					
	</body>
</html>
