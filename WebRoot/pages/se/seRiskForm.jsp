<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		<title>项目风险</title>
	
<style type="text/css">
/* 点击变颜色 用于bootstrap样式的datatable */
table.table tbody tr.selected {
	background:#32c5d2 !important;
}
.panel-body{background:#e4ecf3;}
.c_blue{color:#09C;}
.table{background:#fff;border:3px solid #fff;}

/* 点击变颜色 用于bootstrap样式的datatable */
table.table tbody tr.selected {
	background:#32c5d2 !important;
}
</style>
<script>
$(function(){
	$(".select2").select2({
		//默认文本
		placeholder: 'Select an option',
		allowClear: true,
		width:"100%"
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
				  console.log(data);
				  
				  if(data){
					  $('#personInCharge').html("");
					  var optStr = "";
					  for(var i = 0 , j = data.length ; i < j ; i++){
						  var opt = $("<option></option>");
						  opt.val(data[i].value);
						  opt.html(data[i].text);
						  $('#personInCharge').append(opt);
					  }
					  $('#personInCharge').trigger("change");
				  }
				  
			  }
		  })
	});
	
	$('#identDate,#closeDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: "month",
		minView: "month",
		forceParse: 0
	})
	
	
	validationSeRiskTool = $('#theSeRiskForm').formValidation({
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
			
			
			"seRisk.riskContent": {
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
	
			"seRisk.projectId": {
				row:'.form-group',//变红色字体的范围容器
		        	validators: {
				     	notEmpty: {
		                	message: 'The field is required'
		                }
		        	}
			}
			
		}
	});
	
	$("#submitButton").click(function(){
    	validationSeRiskTool.data("formValidation").validate();
    	var validateResult = validationSeRiskTool.data("formValidation").isValid();
    	if(validateResult){
    		submitRiskForm();
    	};
	});
})



function submitRiskForm(){
	var formData = $("#theSeRiskForm").serialize();
	$.ajax("${ctx}/se/se!seRiskFormSubmit.do",
		{
			type:"post",
			async:false,
			data:formData,
			success:function(r){
				var str = $.trim(r);
				//alert(str);
				if(str == "SUCCESS"){
					//alert("保存成功");
					//layer.alert('保存成功');
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
									parent.reloadRiskTab();
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
	
	
	<div class="container-fluid">
	<h1> Risk </h1>
	<hr/>
	<s:form cssClass="form-horizontal" action="se!seRiskFormSubmit" namespace="/se" method="post" id="theSeRiskForm">
				<div style="display: none;">
					操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
					<input 
							name="seRisk.isDelete"
							type="text"
							value="${seRisk.isDelete}" />
					风险ID<input 
							class="easyui-textbox" 
							name="seRisk.riskId"
							id="riskId" 
							type="text"
							value="${seRisk.riskId}" />
							
							
					
				</div>
	<div class="panel panel-primary">
	<div class="panel-heading">基本信息</div>
	<div class="panel-body" >

	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">所属项目</label>
				<div class="col-xs-10">
						   
					   <s:select id="projectId" 
						 name="seRisk.projectId"  
						 cssClass="select2 form-control"  
						 list="#request.projectList"  listKey="projectId" listValue="projectName" headerKey="" headerValue="请选择"></s:select> 
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">风险状态</label>
				<div class="col-xs-10">
						    <s:select 
							 id="riskStatus" 
							 cssClass="select2" 
							 name="seRisk.riskStatus" 
							 list="#{'跟踪':'跟踪','已发生':'已发生','未发生':'未发生','已关闭':'已关闭'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="form-group">
				<label class="col-xs-1 control-label">风险描述</label>
				<div class="col-xs-11">
				   <div class="input-inline ">
				       <div class="input-group">
					   <span class="input-group-addon">
					   			<i class="glyphicon glyphicon-console"></i>
					   </span>
					   
							
					   <input 
				class="form-control" 
				placeholder="风险描述"
				name="seRisk.riskContent"
				id="riskContent" 
				type="text"
				value="${seRisk.riskContent}" /> 
					  
				       </div>
				   </div>
				   <span class="help-inline">
				   </span>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">类别</label>
				<div class="col-xs-10">
				 
						   <s:select 
							 id="riskClassify" 
							 cssClass="select2" 
							 name="seRisk.riskClassify" 
							 list="#{'需求风险':'需求风险','计划编制风险':'计划编制风险','设计和实现风险':'设计和实现风险','测试相关风险':'测试相关风险','组织和管理风险':'组织和管理风险数','人员风险':'人员风险','开发环境风险':'开发环境风险','管理过程风险':'管理过程风险','技术风险':'技术风险'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>  
				       
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">概率</label>
				<div class="col-xs-10">
					<s:select 
						 id="riskProbability" 
						 cssClass="select2" 
						 name="seRisk.riskProbability" 
						 list="#{'极高':'极高','比较低':'比较低','中等':'中等','比较低':'比较低','极低':'极低'}" 
						 headerKey="" 
						 headerValue="请选择">
						 </s:select>  
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">影响</label>
				<div class="col-xs-10">
				 
						  <s:select 
							 id="riskSway" 
							 cssClass="select2" 
							 name="seRisk.riskSway" 
							 list="#{'极高':'极高','比较低':'比较低','中等':'中等','比较低':'比较低','极低':'极低'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>  
				       
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">等级</label>
				<div class="col-xs-10">
					<s:select 
							 id="riskLevel" 
							 cssClass="select2" 
							 name="seRisk.riskLevel" 
							 list="#{'高':'高','中':'中','低':'低'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">优先级</label>
				<div class="col-xs-10">
				 
						 <s:select 
							 id="riskPriority" 
							 cssClass="select2" 
							 name="seRisk.riskPriority" 
							 list="#{'高':'高','中':'中','低':'低'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>
				       
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">应对方式</label>
				<div class="col-xs-10">
					<s:select 
							 id="dealType" 
							 cssStyle="width:150px;"
							 cssClass="select2" 
							 name="seRisk.dealType" 
							 list="#{'规避':'规避','转移':'转移','接受':'接受','减缓':'减缓'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">责任人</label>
				<div class="col-xs-10">
						   <s:select id="personInCharge" 
							 name="seRisk.personInCharge"  
							 cssClass="select2"  
							 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
						
				       
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">识别日期</label>
				<div class="col-xs-10">
					<div class="input-inline ">
				       <div class="input-group">
					   <span class="input-group-addon">
					   			<i class="glyphicon glyphicon-calendar"></i>
					   </span>
					  	<input 
							class="form-control" 
							name="seRisk.identDate"
							id="identDate" 
							type="text"
							value="<fmt:formatDate value="${seRisk.identDate}"  pattern="yyyy-MM-dd"/>"  />
					 
					  	
				       </div>
				   </div>
				   <span class="help-inline">
				   </span>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<label class="col-xs-1 control-label">应急措施</label>
					<div class="col-xs-11">
						<textarea 
							class="form-control" 
							name="seRisk.emergencyPreplan"
							id="emergencyPreplan" 
							rows="10"
							 >${seRisk.emergencyPreplan}</textarea>
					   
					</div>
				</div>
			</div>
		</div>
	
	
	</div>
	</div>
	
	
	
	<div class="panel panel-primary">
	<div class="panel-heading">处理措施</div>
	<div class="panel-body" >
		
			<div class="row">
			<div class="col-sm-12">
				<div class="form-group">
					<label class="col-xs-1 control-label">处理措施</label>
					<div class="col-xs-11">
						<textarea 
							class="form-control" 
							name="seRisk.riskDealContent"
							id="riskDealContent" 
							rows="10"
							 >${seRisk.riskDealContent}</textarea>
							 
							 
					  
					</div>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-6">
				<div class="form-group">
					<label class="col-xs-2 control-label">是否关闭</label>
					<div class="col-xs-10">
								 
								  <s:select 
							 id="isClose" 
							 cssClass="select2" 
							 name="seRisk.isClose" 
							 list="#{'1':'已关闭','0':'未关闭'}" 
							 headerKey="" 
							 headerValue="请选择">
							 </s:select>
							 
					       
					</div>
				</div>
			</div>
			<div class="col-sm-6">
				<div class="form-group">
					<label class="col-xs-2 control-label">关闭日期</label>
					<div class="col-xs-10">
					<div class="input-inline ">
				       <div class="input-group">
						   <span class="input-group-addon">
						   			<i class="glyphicon glyphicon-calendar"></i>
						   </span>
						   
						   <input 
							class="form-control" 
							name="seRisk.closeDate"
							id="closeDate" 
							type="text"
							value="<fmt:formatDate value="${seRisk.closeDate}"  pattern="yyyy-MM-dd"/>"  />
					 
					 
					 
					 
				       </div>
				   </div>
				   <span class="help-inline">
				   </span>
				   </div>
				</div>
			</div>
		</div>
	
	
	</div>
	</div>
	
	
	<nav class="navbar navbar-default navbar-fixed-bottom">
	  <div class=" text-right container-fluid" style="padding-top:6px;background:#fff;">
			<button type="button" id="submitButton" class="btn btn-primary green-turquoise">Submit</button>
			<button type="button" id="closeButton" class="btn btn-default">Close</button>
	  </div>
	</nav>	
	
	
	
	<c:if test="${seRisk.riskId != null }">
	<s:action name="common!commonFileList" namespace="/common" executeResult="true">
		<s:param name="seAttach.fid" value="#attr.seRisk.riskId"></s:param>
		<s:param name="seAttach.fkey"><%=StaticVar.ATTACHKEY_SERISK%></s:param>
	</s:action>
	</c:if>


	</s:form>
	
	
	
	</div>
	
	
	
	
	<div style="height:60px;">
	
	
	
	
	
	</body>
</html>
