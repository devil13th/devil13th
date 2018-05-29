<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>Plan Task Detail</title>
<meta charset="utf-8" />
<%@ include file="../../../pub/pubCssJsForBootstrap.jsp"%>
<style>
</style>

<script>
</script>
</head>
<body>

<div class="container-fluid" >
<div class="row">
	<div class="panel panel-primary">
	  <!-- Default panel contents -->
	  <div class="panel-heading">${task.taskTitle}</div>
		<ol class="breadcrumb" style="margin-bottom:0px;">
			<li class="active">Trace Task Information</li>
		</ol>
		<div class="panel-body">
			${task.taskRequire}
		</div>
		
		<!-- List group -->
		<ul class="list-group">
			<li class="list-group-item"> 
			    <div class="row"> 
				    <div class="col-sm-3">Trace Name:</div> 
				    <div class="col-sm-9">${trace.traceName }</div>
			    </div>
		    </li>
		    <li class="list-group-item"> 
			    <div class="row">
				    <div class="col-sm-3">Plan Start Time :</div> 
				    <div class="col-sm-3">${task.beginDate }</div>
				    <div class="col-sm-3">Plan Complete Time :</div> 
				    <div class="col-sm-3">${task.finishDate }</div>
			    </div>
		    </li>
		    
		    <li class="list-group-item"> 
			    <div class="row">
				    <div class="col-sm-3">Percent Complete :</div> 
				    <div class="col-sm-3">${task.currentProcess }</div>
			    </div>
		    </li>
		    <li class="list-group-item"> 
			    <div class="row">
				    <div class="col-sm-3">Operator :</div> 
				    <div class="col-sm-9">${task.operator }</div>
			    </div>
		    </li>
		    
		  	
		  
		</ul>
		
		<ol class="breadcrumb" style="margin-bottom:0px;">
		  <li class="active">Plan Information</li>
		</ol>
		<s:form action="plan!updatePlanExecution.do" namespace="/plan" cssClass="form-horizontal" method="post">
			<input type="hidden" value="${planExecution.id}" name="planExecution.id"/>
			<ul class="list-group">
				<li class="list-group-item"> 
				  	<div class="row">
					  	<label class="col-sm-3 control-label" style="text-align:left;">Plan Percent Complete :</label>
					  	<div class="col-sm-3"><input type="text" class="form-control" placeholder="Text input" name="planExecution.planProgress" value="${planExecution.planProgress }"/></div>
					  	<label class="col-sm-3 control-label" style="text-align:left;">Actual Percent Complete :</label>
			  			<div class="col-sm-3"><input type="text" class="form-control" placeholder="Text input"  name="planExecution.finishProgress" value="${planExecution.finishProgress }"></div>
				  	</div>
			  	</li>
			  	<li class="list-group-item"> 
				    <div class="row">
					    <label class="col-sm-3 control-label" style="text-align:left;">Remark :</label>
					  	<div class="col-sm-9"><input type="text" class="form-control" placeholder="Text input" name="planExecution.planRemark" value="${planExecution.planRemark }"></div>
				    </div>
			    </li>
			</ul>	
			<div class="text-center">
				<button type="submit" class="btn green"><i class="fa fa-floppy-o"></i> 保存 </button>
			</div>
		</s:form>
	</div>
	
</div>
</div>
</body>
</html>
