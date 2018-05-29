<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>快速创建遗留备忘</title>
<meta charset="utf-8" />
<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		<title>
			需求信息
		</title>
	
<style type="text/css">
</style>
<script>
var validationTool;
$(function(){
	
	 $('input.rdo').iCheck({
		    checkboxClass: 'icheckbox_flat-blue',
		    radioClass: 'iradio_flat-blue'
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
        	"seRequirementTrace.projectId": {
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
            "seRequirementTrace.traceNo": {
            	row:'.form-group',//变红色字体的范围容器
                validators: {
                	lessThan: {
                        value: 100,
                        inclusive: true,
                        message: 'The ages has to be less than 100'
                    },
                    greaterThan: {
                        value: -1,
                        inclusive: false,
                        message: 'The ages has to be greater than or equals to 0'
                    }
                }
            },
            
            "seRequirementTrace.traceName": {
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
            
            
            "seRequirementTrace.traceOrder" : {
            	row:'.form-group',//变红色字体的范围容器
                validators: {
                	lessThan: {
                        value: 100,
                        inclusive: true,
                        message: 'The ages has to be less than 100'
                    },
                    greaterThan: {
                        value: -1,
                        inclusive: false,
                        message: 'The ages has to be greater than or equals to 0'
                    }
                }
            }
        }
    });
	
	
	
	test01 = $("#projectId").select2({
		  //默认文本
		  placeholder: 'Select an option',
		  allowClear: true,
		  width:200
		  
	  });
	
});

function theFormSubmit(){
	validationTool.data("formValidation").validate();
	var validateResult = validationTool.data("formValidation").isValid();
	if(validateResult){
		document.getElementById("theForm").submit();
	}
}
</script>
	</head>

	<body>
	
<h1>Trace Information</h1>
<div class="container-fluid">

<div class="row">
<div class="col-md-1"></div>
<div class="col-md-10">
			<s:form action="seRequirementTrace!seRequirementTraceFormSubmit" cssClass="form-horizontal" namespace="/se" method="post" id="theForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					创建时间<input 
							name="seRequirementTrace.createTime"
							id="createTime" 
							type="text"
							data-options=""
							value="<fmt:formatDate value="${seRequirementTrace.createTime}"  pattern="yyyy-MM-dd hh:mm:ss"/>" /><br/>
							
							更新时间<input 
							name="seRequirementTrace.updateTime"
							id="updateTime" 
							type="text"
							data-options=""
							value="<fmt:formatDate value="${seRequirementTrace.updateTime}"  pattern="yyyy-MM-dd hh:mm:ss"/>" /><br/>
							是否叶子节点<input 
							name="seRequirementTrace.isLeaf"
							id="isLeaf" 
							type="text"
							value="${seRequirementTrace.isLeaf}" /><br/>
							是否删除<input 
							name="seRequirementTrace.isDelete"
							id="isDelete" 
							type="text"
							value="${seRequirementTrace.isDelete}" /><br/>
							矩阵ID<input
							name="seRequirementTrace.traceId"
							id="traceId" 
							type="text"
							value="${seRequirementTrace.traceId}" /><br/>
							树形目录代码<input 
							name="seRequirementTrace.treeCode"
							id="treeCode" 
							type="text"
							value="${seRequirementTrace.treeCode}" /><br/>
							父节点ID<input 
							name="seRequirementTrace.parentId"
							id="parentId" 
							type="text"
							value="${seRequirementTrace.parentId}" /><br/>
				</div>
			              	
				
				
				
<div class="form-body">
           <div class="row">
               <div class="col-md-offset-3 col-md-9">
                   <button  id="submitButton" class="btn green" onclick="theFormSubmit()">Submit</button>
               </div>
           </div>
           <hr/>
				
				
			<div class="form-group">
               <label class="col-md-3 control-label">Belong System</label>
               <div class="col-md-9">
                    <s:select id="projectId" name="seRequirementTrace.projectId"  cssClass="select2"  list="#request.projectList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Trace No.</label>
               <div class="col-md-9">
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input id="traceNo" name="seRequirementTrace.traceNo" value="${seRequirementTrace.traceNo}"  class="form-control" placeholder="矩阵编号"/> </div>
                   </div>
                   <span class="help-inline"> 
                   		矩阵编号
                   </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Trace Name</label>
               <div class="col-md-9">
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input id="traceName"  name="seRequirementTrace.traceName" value="${seRequirementTrace.traceName}" value="${seRequirementTrace.traceNo}"  class="form-control" placeholder="矩阵名称"/> </div>
                   </div>
                   <span class="help-inline"> 
                   		矩阵名称
                   </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Trace Sort</label>
               <div class="col-md-9">
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input id="traceOrder"  name="seRequirementTrace.traceOrder" value="${seRequirementTrace.traceOrder}"  class="form-control" placeholder="排序号"/> </div>
                   </div>
                   <span class="help-inline"> 
                   		排序号
                   </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Is Valid</label>
               <div class="col-md-1">
                   <!--<s:select  id="validSelect" name="seRequirementTrace.isValid"   cssClass="select2" list="#{'1':'有效','0':'无效'}" headerKey="" headerValue="请选择"></s:select>  
                         -->
					<input class="rdo" type="radio" value="1" name="seRequirementTrace.isValid" <c:if test="${seRequirementTrace.isValid == '1'}">checked="checked"</c:if>/>
					
					<label>Valid</label>
               </div>
               <div class="col-md-2">
					<input class="rdo" type="radio" value="0" name="seRequirementTrace.isValid" <c:if test="${seRequirementTrace.isValid != '1'}">checked="checked"</c:if>/>
					<label>Invalid</label>
               </div>
           </div>
           
</div>       
				
					
				<br />
				<center>
					
					<button onclick="theFormSubmit()" type="submit" class="btn green">Submit</button>
				</center>
			</s:form>
			
<c:if test="${seRequirementTrace.traceId != null }">
<s:action name="common!commonFileList" namespace="/common" executeResult="true">
	<s:param name="seAttach.fid" value="#attr.seRequirementTrace.traceId"></s:param>
	<s:param name="seAttach.fkey"><%=StaticVar.ATTACHKEY_SEREQUIREMENTTRACE%></s:param>
</s:action>
</c:if>
		</div>
		</div>
		</div>
	</body>
</html>
