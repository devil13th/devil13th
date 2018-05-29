
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		<title></title>
	
<style type="text/css">
</style>
<script>
var validationSeMapProjectUserTool;
$(function(){
	$(".select2").select2({
		  //默认文本
		  placeholder: 'Select an option',
		  allowClear: true,
		  width:200
		  
	});

 $('#planDuty').datetimepicker({
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
			 validationSeMapProjectUserTool.data("formValidation").revalidateField("seMapProjectUser.planDuty");
	    });;
 $('#planUnduty').datetimepicker({
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
			 validationSeMapProjectUserTool.data("formValidation").revalidateField("seMapProjectUser.planUnduty");
	    });;
 $('#actDuty').datetimepicker({
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
			 validationSeMapProjectUserTool.data("formValidation").revalidateField("seMapProjectUser.actDuty");
	    });;
 $('#actUnduty').datetimepicker({
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
			 validationSeMapProjectUserTool.data("formValidation").revalidateField("seMapProjectUser.actUnduty");
	    });;


validationSeMapProjectUserTool = $('#theSeMapProjectUserForm').formValidation({
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
		
		
		"seMapProjectUser.projectId": {
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
		"seMapProjectUser.userId": {
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
		"seMapProjectUser.userName": {
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
		"seMapProjectUser.userCost": {
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
		"seMapProjectUser.userPos": {
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
		"seMapProjectUser.userLevel": {
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
		/*
		"seMapProjectUser.planDuty": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMapProjectUser.planUnduty": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMapProjectUser.actDuty": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMapProjectUser.actUnduty": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},*/

		"seMapProjectUser.rid": {
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
    	validationSeMapProjectUserTool.data("formValidation").validate();
    	var validateResult = validationSeMapProjectUserTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theSeMapProjectUserForm").submit();
    	};
});
})
</script>
	</head>

	<body>
		<h3> 项目人员信息 </h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seMapProjectUserFormSubmit" namespace="/se" method="post" id="theSeMapProjectUserForm">
		
		<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-10">
			
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
				</div>

				
				
				<div class="form-group" style="display:none;">
					<label class="col-xs-3 control-label"></label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							id="rid"  
							name="seMapProjectUser.rid"
							class="form-control" 
							placeholder=""
							value="${seMapProjectUser.rid}"/> 
						</div>
					   </div>
						<span class="help-inline"> 
						</span>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-3 control-label">项目</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   
						    <s:select id="projectId" 
							 name="seMapProjectUser.projectId"  
							 cssClass="select2"  
							 list="#request.projectList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
							 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">用户ID</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
						   
						   <s:select id="userId" 
							 name="seMapProjectUser.userId"  
							 cssClass="select2"  
							 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
							 
							 
						 
						  
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-3 control-label">个人成本(万/月)</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-dashboard"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMapProjectUser.userCost"
							id="userCost" 
							type="text"
							value="${seMapProjectUser.userCost}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">岗位</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
						  
						  	<s:select id="userPos" 
							 name="seMapProjectUser.userPos"  
							 cssClass="select2"  
							 list="#request.postList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
							 
							 
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">用户级别</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
						  	<s:select id="userLevel" 
							 name="seMapProjectUser.userLevel"  
							 cssClass="select2"  
							 list="#request.postLevelList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
							 
							 
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">计划到岗日期</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMapProjectUser.planDuty"
							id="planDuty" 
							type="text"
							value="<fmt:formatDate value="${seMapProjectUser.planDuty}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">计划离岗日期</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMapProjectUser.planUnduty"
							id="planUnduty" 
							type="text"
							value="<fmt:formatDate value="${seMapProjectUser.planUnduty}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">实际到岗日期</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMapProjectUser.actDuty"
							id="actDuty" 
							type="text"
							value="<fmt:formatDate value="${seMapProjectUser.actDuty}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">实际离岗日期</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMapProjectUser.actUnduty"
							id="actUnduty" 
							type="text"
							value="<fmt:formatDate value="${seMapProjectUser.actUnduty}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-xs-3 control-label">是否在岗</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
						  	<s:select id="userLevel" 
							 name="seMapProjectUser.onPosition"  
							 cssClass="select2"  
							  list="#{'1':'在岗','0':'离岗'}"   ></s:select>  
							 
							 
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

					
	</body>
</html>
