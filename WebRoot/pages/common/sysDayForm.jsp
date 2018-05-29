
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
var validationSysDayTool;
$(function(){


 $('#day').datetimepicker({
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
			 validationSysDayTool.data("formValidation").revalidateField("sysDay.day");
	    });;


validationSysDayTool = $('#theSysDayForm').formValidation({
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
		
		
		"sysDay.day": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"sysDay.status": {
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

		"sysDay.id": {
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
    	validationSysDayTool.data("formValidation").validate();
    	var validateResult = validationSysDayTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theSysDayForm").submit();
    	};
});
})
</script>
	</head>

	<body>
		<h3> --- Page Title</h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="common!sysDayFormSubmit" namespace="/common" method="post" id="theSysDayForm">
		
		<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-10">
			
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
				</div>

				
				
				<div class="form-group" >
					<label class="col-xs-3 control-label"></label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							id="id"  
							name="sysDay.id"
							class="form-control" 
							placeholder=""
							value="${sysDay.id}"/> 
						</div>
					   </div>
						<span class="help-inline"> 
						</span>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-3 control-label"></label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   <input 
							class="form-control" 
							name="sysDay.day"
							id="day" 
							type="text"
							value="<fmt:formatDate value="${sysDay.day}"  pattern="yyyy-MM-dd"/>"  />
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label"></label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="sysDay.status"
							id="status" 
							type="text"
							value="${sysDay.status}" /> 
						  
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

					
	</body>
</html>
