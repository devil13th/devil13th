
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../../pub/pubCssJsForBootstrap.jsp"%>
		<title>
			开启流程
		</title>
	
<style type="text/css">
</style>
<script>
$(function(){
	
	$(".select2").select2({
	  //默认文本
	  placeholder: 'Select an option',
	  allowClear: true,
	  width:"100%"
  });
	
	selectProcess();
	
	
	$("#processType a").click(function(){
		var _this = $(this);
		$("#processType a").removeClass("active");
		_this.addClass("active");
		selectProcess();
		return false;
	})
	
})
function selectProcess(){
	var k = $("#processType a.active").attr("key");
	$("#key").val(k);
	//alert(k);
}
</script>
	</head>

	<body>
<h1>Start Process</h1>
<hr/>
<div class="container-fluid">

<div class="row">
<div class="col-md-4"></div>
<div class="col-md-4">
	<s:form cssClass="form-horizontal" action="seProcess!startTaskProcess" namespace="/seProcess" method="post" id="theForm">
		
		<div class="form-group">
			<label>请选择流程</label>
			<div class="list-group" id="processType">
			  <a href="#" class="list-group-item active" key="taskProcess">通常任务</a>
			  <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
			  <a href="#" class="list-group-item">Morbi leo risus</a>
			  <a href="#" class="list-group-item">Porta ac consectetur ac</a>
			  <a href="#" class="list-group-item">Vestibulum at eros</a>
			</div>
		</div>
		<div class="form-group">
			<label>流程开启人</label>
			
			<s:select id="startUser" 
			 name="startUser"  
			 cssClass="select2 form-control"  
			 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
							 
		</div>
		<div class="text-center">
			<input type="hidden" name="key" id="key"/>
			<input type="submit" class="btn  btn-primary btn-lg btn-block" value="Create Job"/>
		</div>
	</s:form>
</div>
<div class="col-md-4"></div>
</div>
</div>	
	</body>
</html>
