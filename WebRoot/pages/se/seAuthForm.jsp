
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
var validationSeAuthTool;
$(function(){




validationSeAuthTool = $('#theSeAuthForm').formValidation({
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
		
		
		"seAuth.authDesc": {
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

		"seAuth.authCode": {
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
    	validationSeAuthTool.data("formValidation").validate();
    	var validateResult = validationSeAuthTool.data("formValidation").isValid();
    	if(validateResult){
    		document.getElementById("theSeAuthForm").submit();
    	};
});
})
</script>
	</head>

	<body>
		<h3> Auth Dic </h3>
		<hr/>
		<div class="container-fluid">
		<s:form cssClass="form-horizontal" action="se!seAuthFormSubmit" namespace="/se" method="post" id="theSeAuthForm">
		
		<div class="row">
		<div class="col-xs-1"></div>
		<div class="col-xs-10">
			
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
				</div>

				
				
				<div class="form-group">
					<label class="col-xs-2 control-label">标记</label>
					<div class="col-xs-10">
					   <div class="input-inline ">
					       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-console"></i>
						   </span>
						   <input 
							id="authCode"  
							name="seAuth.authCode"
							class="form-control" 
							placeholder="标记"
							value="${seAuth.authCode}"/> 
							
							
						</div>
					   </div>
						<span class="help-inline"> 
						</span>
					</div>
				</div>

				<div class="form-group">
					<label class="col-xs-2 control-label">备注</label>
					<div class="col-xs-10">
						<div class="input-inline ">
							<div class="input-group">
								<span class="input-group-addon">
									<i class="glyphicon glyphicon-console"></i>
								</span>
								<input 
								id="authDesc"  
								name="seAuth.authDesc"
								class="form-control" 
								placeholder="备注"
								value="${seAuth.authDesc}"/> 
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

</script>			
	</body>
</html>
