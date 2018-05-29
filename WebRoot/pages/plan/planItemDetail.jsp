<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>myBootStrap</title>
<meta charset="utf-8" />
<script src="${ctx}/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="${ctx}/js/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctx}/js/datatables/js/jquery.dataTables.js" type="text/javascript"></script>
<script src="${ctx}/js/datatables/js/dataTables.bootstrap.js" type="text/javascript"></script>
<script src="${ctx}/js/echarts/dist/echarts-all.js"></script>
<script src="${ctx}/js/formvalidation/js/formValidation.min.js"></script>
<script  src="${ctx}/js/formvalidation/js/framework/bootstrap.js"></script>


<link href="${ctx}/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/js/datatables/css/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/js/mybootstrap/css/components.min.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/js/formvalidation/css/formValidation.min.css" rel="stylesheet"  type="text/css"/>
<style>
.timeline-badge{width:80px !important;padding:0px !important;height:auto !important;}
.timeline .timeline-body-arrow {top:8px !important;}
.bor_f{border:3px solid #fff;position:absolute;top:8px;left:3px;}
.timeline-body{padding-top:10px !important;padding-bottom:7px !important;}
</style>

<script>

var validationTool;
$(function(){
	validationTool = $('#defaultForm').formValidation({
        err: {
            container: 'popover'
        },
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	planProgress : {
            	row:'.form-group',//变红色字体的范围容器
            	validators: {
            		notEmpty: {
	                	message: '请填写内容'
	                },
	                integer:{
	                	message:'请填写整数'
	                }
                }
            },
            finishProgress : {
            	row:'.form-group',//变红色字体的范围容器
            	validators: {
            		notEmpty: {
	                	message: '请填写内容'
	                },
	                integer:{
	                	message:'请填写整数'
	                }
                }
            },
            planRemark : {
            	row:'.form-group',//变红色字体的范围容器
            	validators: {
            		notEmpty: {
	                	message: '请填写内容'
	                }
                }
            }
        }  
   });
	
	$("#savePlanExecutionResult").hide();
})


function showMes(id,status,mess){
	$("#" + id).removeClass();
	if(status == "success"){
		$("#" + id).addClass("alert alert-success")
	}else if(status = "danger"){
		$("#" + id).addClass("alert alert-danger")
	}else{
		$("#" + id).addClass("alert alert-info")
	}
	
	$("#" + id).html(mess);
	$("#"+id).show();
	setTimeout(function(){
		$("#"+id).hide();
	},3000);
}



function updatePlanExecution(){
	validationTool.data("formValidation").validate();
	var validateResult = validationTool.data("formValidation").isValid();
	if(validateResult){
		
		
		var planProgress = $("#planProgress").val();
		var finishProgress = $("#finishProgress").val();
		var planRemark = $("#planRemark").val();
		
		
		$.ajax({
			  dataType: "text",
			  url: "${ctx}/plan/plan!updatePlanExecution.do",
			  data : {
				  	"planExecution.id":"${planExecution.id}",
				  	"planExecution.planProgress":planProgress,
				  	"planExecution.finishProgress":finishProgress,
				  	"planExecution.planRemark":planRemark
			  },
			  success: function(data){
				if($.trim(data) == "SUCCESS"){
					showMes("savePlanExecutionResult","success","保存成功");
					parent.reloadTable();
				}else{
					showMes("savePlanExecutionResult","danger","保存失败");
				}
				document.getElementById("savePlanExecutionBton").removeAttribute("disabled");
			  },
			  type:"post"
		});
	}else{
		document.getElementById("savePlanExecutionBton").removeAttribute("disabled");
	}
}




</script>
</head>
<body>

<div class="container-fluid" >
<div class="row">
	<div class="col-md-6">
	<h4 class="text-primary"><b>历史信息</b></h4>
	<div class="portlet light portlet-fit bg-inverse ">
	<div class="portlet-body">
	<div class="timeline  white-bg ">
	
<c:forEach items="${hisList}" var="his">
	<!-- TIMELINE ITEM -->
	<div class="timeline-item">
		<div class="timeline-badge">
			<span class="label label-danger bor_f"><i class="fa fa-clock-o"></i> <fmt:formatDate value="${his.creTime}" pattern="yy.MM.dd"/></span>
                 </div>
		<div class="timeline-body">
			<div class="timeline-body-arrow"> </div>
			<div class="timeline-body-head">
				<div class="timeline-body-head-caption">
					<a href="javascript:;" class="timeline-body-title font-blue-madison"> ${his.planCode } </a>
					
					<span class="timeline-body-time font-grey-cascade">
					
					<fmt:formatDate value="${his.startDate}" pattern="yy.MM.dd"/> - <fmt:formatDate value="${his.finishDate}" pattern="yy.MM.dd"/>
					<br/>
					计划：${his.planProgress} %
					&nbsp;
					实际：${his.finishProgress} %
					</span>
				</div>
			</div>
		</div>
	</div>
	<!-- TIMELINE ITEM END-->

</c:forEach>
	</div>
	</div>
	</div>
	</div>
	<div class="col-md-6">
		<h4 class="text-primary"><b>本次执行信息</b></h4>
		
		<div style="background:#f1f4f7;border-radius:3px;padding:10px 0px;">
			<form  id="defaultForm" class="form-horizontal row" >
				<div class="form-group form-md-line-input col-xs-12">
					<label class="col-xs-5 control-label" for="planProgress">计划百分比</label>
					<div class="col-xs-7">
						<input type="text" class="form-control" name="planProgress" value="<c:out value="${planExecution.planProgress}"></c:out>" id="planProgress" placeholder="">
						<div class="form-control-focus"> </div>
						<span class="help-block">计划百分比 - 填写整数</span>
					</div>
				</div>			
				
				<div class="form-group form-md-line-input  col-xs-12">
					<label class="col-xs-5 control-label" for="finishProgress">实际百分比</label>
					<div class="col-xs-7">
						<input type="text" class="form-control" name="finishProgress" id="finishProgress" placeholder="" value="<c:out value="${planExecution.finishProgress}"></c:out>">
						<div class="form-control-focus"> </div>
						<span class="help-block">实际完成百分比 - 填写整数</span>
					</div>
				</div>
				<div class="form-group form-md-line-input  col-xs-12">
					<label class="col-xs-5 control-label" for="planNote">备  注</label>
					<div class="col-xs-7">
						<textarea class="form-control" rows="10" name="planRemark" id="planRemark" ><c:out value="${planExecution.planRemark}"></c:out></textarea>
						<div class="form-control-focus"> </div>
						<span class="help-block">请填写计划内容或完成情况</span>
					</div>
				</div>	
			</form>
			<div class="text-center">
				<button type="button" class="btn green" id="savePlanExecutionBton" onclick="this.disabled='disabled';updatePlanExecution();"><i class="fa fa-plus"></i> 保存 </button>
			</div>
			
			<div class="row" style="margin-top:10px;">
			<div class="col-xs-8 col-xs-offset-2">
			<div class="alert alert-warning"  id="savePlanExecutionResult">
			  
			</div>
			</div>
			</div>


		</div>
	</div>
</div>
</div>
</body>
</html>
