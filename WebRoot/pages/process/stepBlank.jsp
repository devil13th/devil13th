<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJsForBootstrap.jsp"%>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="${ctx}/js/process.jsp?a=1"></script>
<script type="text/javascript">
function setProcInstVar(){
	var obj = {
		varKey:$("#varKey").val(),
		varValue:$("#varValue").val(),
		procInsId:"${seWorkList.procInsId}"
	}
	
	
	$.ajax({
		url:"${ctx}/seProcess/seProcess!customSetProcessInstVar.do",//请求地址
		method:"post",//提交方式
		async:false,//是否异步
		cache:false,//是否缓存
		data:obj,//可以是字符串也可以是json对象，字符串类似本例子中的内容
		dataType:"json",//返回数据的格式 xml, json, script, or html
		success:function(r){//回调函数
			if(r.status == "<%=cn.thd.bean.StaticVar.STATUS_SUCCESS%>"){
			  alert("保存成功");
			  $('#myModal').modal("hide");
			}else{
			  alert("流程变量设置失败:" + r.message);
			  $('#myModal').modal("hide");
			};
		}
	})
}
</script>
	</head>
	<body >
	<div class="container-fluid">
	<dic class="row">
		<div class="col-md-6">
			<h2>工作信息</h2>
			jobno:${seWorkList.jobno}<br/>	
			procInsId:${seWorkList.procInsId}<br/>	
			workType:${seWorkList.workType}<br/>	
			workName:${seWorkList.workName}<br/>	
			startUser:${seWorkList.startUser}<br/>	
			startTime:${seWorkList.startTime}<br/>	
			jobStatus:${seWorkList.jobStatus}<br/>	
			projectId:${seWorkList.projectId}<br/>	
			</hr>
		</div>
		<div class="col-md-6">
			<h2>流程公共信息</h2>
			iJobno:${pmb.jobno}<br/>	
			iTaskId:${pmb.taskId}<br/>	
			dProcessInstanceId:${pmb.processInstanceId}<br/>	
			dProcessId:${pmb.processId}<br/>	
			dStepId:${pmb.stepId}<br/>	
			dProcessCode:${pmb.processCode}<br/>	
			dStepCode:${pmb.stepCode}<br/>	
			dProcessService:${pmb.processService}<br/>	
			</hr>
		</div>
	</dic>
	
	<dic class="row">
		<div class="col-md-6">
			<h2>流程关联字典信息</h2>
			processId:${process.processId}<br/>	
			processKey:${process.processKey}<br/>	
			processName:${process.processName}<br/>	
			processDefId:${process.processDefId}<br/>	
			processService:${process.processService}<br/>	
			</hr>
			
		</div>
		<div class="col-md-6">
			<h2>步骤关联字典信息</h2>
			stepId:${step.stepId}<br/>	
			processId:${step.processId}<br/>
			stepCode:${step.stepCode}<br/>	
			stepName:${step.stepName}<br/>	
			stepOrder:${step.stepOrder}<br/>	
			isFirstStep:${step.isFirstStep}<br/>	
			isLastStep:${step.isLastStep}<br/>	
			</hr>
		</div>
	</dic>
	
	<dic class="row">
		<div class="col-md-12">
			<h2>流程变量信息</h2>
			${processProcessVar }
			
			<br/>
			<button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#myModal">
			设置流程实例变量
			</button>	
			</hr>
		</div>
	</dic>
	
	
	
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">设置流程实例变量</h4>
	      </div>
	      <div class="modal-body">
	       		Key:<input type="text" class="form-control" id="varKey"/>
	       		Value:<input type="text" class="form-control" id="varValue"/>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onclick="setProcInstVar()">Save</button>
	      </div>
	    </div>
	  </div>
	</div>


	
	
	<div class="navbar-fixed-bottom" style="padding:10px;background:#eee;">
		<s:action name="seProcess!commonBton" namespace="/seProcess"  executeResult="true">
			<s:param name="jobno" value="#attr.pmb.iJobno"></s:param>
			<s:param name="taskId" value="#attr.pmb.iTaskId"></s:param>
			<s:param name="ce" value="#attr.ce"></s:param>
		</s:action>
	</div>
	
	</div>
	
	
	
	
	
	
	<!-- Modal 流程扭转信息提示 -->
	<jsp:include page="processMsg.jsp"></jsp:include>

	
	
	
	</body>

</html>
