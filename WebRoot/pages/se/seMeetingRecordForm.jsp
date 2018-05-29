
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
var validationSeMeetingRecordTool;
$(function(){




validationSeMeetingRecordTool = $('#theSeMeetingRecordForm').formValidation({
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
		
		
		"seMeetingRecord.meetingCode": {
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
		"seMeetingRecord.itemIssuer": {
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
		"seMeetingRecord.itemClassify": {
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
		"seMeetingRecord.itemDesc": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 500,
	                        message: '长度500以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMeetingRecord.itemPerformer": {
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
		"seMeetingRecord.itemStatus": {
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
		/*"seMeetingRecord.isDelete": {
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
		},*/

		"seMeetingRecord.itemId": {
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
    	validationSeMeetingRecordTool.data("formValidation").validate();
    	var validateResult = validationSeMeetingRecordTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theSeMeetingRecordForm").submit();
    	};
});
})
</script>
	</head>

	<body>
	
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seMeetingRecordFormSubmit" namespace="/se" method="post" id="theSeMeetingRecordForm">
		
		<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-10">
			
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
				</div>

				
				
				<div class="form-group" style="display:none;">
					<label class="col-xs-3 control-label">条目ID</label>
					<div class="col-xs-9">
					   <div class="input-inline input-medium">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							id="itemId"  
							name="seMeetingRecord.itemId"
							class="form-control" 
							placeholder="条目ID"
							value="${seMeetingRecord.itemId}"/> 
						</div>
					   </div>
						<span class="help-inline"> 
						</span>
					</div>
				</div>
				<div class="form-group" style="display:none;">
					<label class="col-xs-3 control-label">是否删除</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMeetingRecord.isDelete"
							id="isDelete" 
							type="text"
							value="${seMeetingRecord.isDelete}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-3 control-label">会议CODE</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMeetingRecord.meetingCode"
							id="meetingCode" 
							type="text"
							value="${seMeetingRecord.meetingCode}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">提出人</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMeetingRecord.itemIssuer"
							id="itemIssuer" 
							type="text"
							value="${seMeetingRecord.itemIssuer}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">分类</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMeetingRecord.itemClassify"
							id="itemClassify" 
							type="text"
							value="${seMeetingRecord.itemClassify}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">描述</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMeetingRecord.itemDesc"
							id="itemDesc" 
							type="text"
							value="${seMeetingRecord.itemDesc}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">执行人</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMeetingRecord.itemPerformer"
							id="itemPerformer" 
							type="text"
							value="${seMeetingRecord.itemPerformer}" /> 
						  
					       </div>
					   </div>
					   <span class="help-inline">
					   </span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-3 control-label">状态</label>
					<div class="col-xs-9">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							class="form-control" 
							name="seMeetingRecord.itemStatus"
							id="itemStatus" 
							type="text"
							value="${seMeetingRecord.itemStatus}" /> 
						  
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
