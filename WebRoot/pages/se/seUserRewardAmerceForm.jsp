
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
var validationSeUserRewardAmerceTool;
var projectSelect;
$(function(){




validationSeUserRewardAmerceTool = $('#theSeUserRewardAmerceForm').formValidation({
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
		
		
		"seUserRewardAmerce.projectId": {
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
		"seUserRewardAmerce.userId": {
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
		"seUserRewardAmerce.raLevel": {
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
		"seUserRewardAmerce.remark": {
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
		"seUserRewardAmerce.isDelete": {
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

		"seUserRewardAmerce.id": {
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
    	validationSeUserRewardAmerceTool.data("formValidation").validate();
    	var validateResult = validationSeUserRewardAmerceTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theSeUserRewardAmerceForm").submit();
    	};
});


projectSelect = $(".select2").select2({
	  //默认文本
	  placeholder: 'Select an option',
	  allowClear: true,
	  width:200
	  
});


})
</script>
	</head>

	<body>
		<h3>奖惩记录</h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seUserRewardAmerceFormSubmit" namespace="/se" method="post" id="theSeUserRewardAmerceForm">
		
		<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-10">
			
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					<input 
							class="form-control" 
							name="seUserRewardAmerce.isDelete"
							id="isDelete" 
							type="text"
							value="${seUserRewardAmerce.isDelete}" /> 
				</div>

				
				
				<div class="form-group" style="display:none;">
					<label class="col-xs-3 control-label">主键</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							id="id"  
							name="seUserRewardAmerce.id"
							class="form-control" 
							placeholder="主键"
							value="${seUserRewardAmerce.id}"/> 
						</div>
					   </div>
						<span class="help-inline"> 
						</span>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-3 control-label">所属系统</label>
					<div class="col-xs-9">
							 <s:select id="projectId" 
							 name="seUserRewardAmerce.projectId"  
							 cssClass="select2"  
							 list="#request.projectList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">用户</label>
					<div class="col-xs-9">
						  	<s:select id="userId" 
							 name="seUserRewardAmerce.userId"  
							 cssClass="select2"  
							 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">等级</label>
					<div class="col-xs-9">
						
						<s:select id="raLevel" 
							 name="seUserRewardAmerce.raLevel"  
							 cssClass="select2"  
							 list="#{1:'好',2:'很好',3:'非常好',-1:'轻微错误',-2:'一般错误',-3:'严重错误'}"  headerKey="" headerValue="请选择"></s:select>  
					   
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">备注</label>
					<div class="col-xs-9">
					   <textarea class="form-control" rows="3" id="remark"  name="seUserRewardAmerce.remark">${seUserRewardAmerce.remark}</textarea>
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
