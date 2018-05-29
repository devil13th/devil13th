
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
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
<style type="text/css">
</style>
<script>
$(function(){
	$(".select2").select2({
		//默认文本
		allowClear: true,
		width:"100%"
	});
})


function selectRequireTrace(){
	var url = "${ctx}/se/seRequirementTrace!seRequirementTraceSelect.do?cb=getParent().selectRequireTraceCb";
	showWin(url,350,500);
}


function selectRequireTraceCb(obj){
	$("#traceId").val(obj.id);
	$("#traceName").val(obj.text);
	$("#taskName").val(obj.text);
	
}

function theFormSubmit(next){
	var obj = getFormJsonData("theForm");
	console.log(obj);
	$.ajax("${ctx}/seProcess/seProcess!taskProcessPerformSubmit.do",
		{
			type:"post",
			async:false,
			data:obj,
			success:function(r){
				var str = $.trim(r);
				//alert(str);
				if(str == "SUCCESS"){
					showMsg("success","保存成功");
				}else{
					showMsg("err","保存失败");
				};
				//ue1.setContent(str, false);
			}
		}
	)
	
	//alert(next);
	if(next){
		var taskId = $("#taskId").val();
		var stepOperator = $("#stepOperator").val();
		nextStep(taskId,stepOperator);
	}
	
	//return false;
}

function nextStep(taskId,stepOperator){
	//alert(2);
	$.ajax("${ctx}/seProcess/seProcess!nextStep.do",
			{
				type:"post",
				data:{
					taskId:taskId,
					stepOperator:stepOperator
				},
				success:function(r){
					var str = $.trim(r);
					//alert(str);
					if(str == "SUCCESS"){
						showMsg("success","流程跳转成功",function(){
							try{
								parent.reloadDg();
								parent.clw();
							}catch(e){
								parent.reloadMyTodoTab();
								parent.closeLayer(1);
							}
						});
					}else{
						showMsg("err","流程跳转失败");
					};
					//ue1.setContent(str, false);
				}
			}
		)
}


function setProcVar(status){
	var obj = {
		performStatus:status
	}
	var jsonStr = (JSON.stringify(obj));
	$.ajax("${ctx}/seProcess/seProcess!setProcessVar.do",
			{
				type:"post",
				data:{
					procInsId:"${pmb.processInstanceId}",
					processVarStr:jsonStr
				},
				success:function(r){
					var str = $.trim(r);
					if(str == "SUCCESS"){
					}else{
						showMsg("err","流程变量设置失败");
					};
					//ue1.setContent(str, false);
				}
			}
		)
}

function showMsg(css,msg,fn){
	
	var cssStype = "alert-success";
	if("err" == css){
		var cssStype = "alert-danger";
	}
	$("#msgInfo").removeClass("alert-danger").removeClass("alert-success").addClass(cssStype);
	//$("#msgInfo").html(msg);
	
	layer.alert(msg, 
		{
		skin: 'layui-layer-lan',
		shade: 0.3,
		shadeClose: false, //关闭遮罩关闭
		shift: 1 //动画类型
		},fn
	);
}

</script>
	</head>

	<body>


<div class="container-fluid">
	


<div class="row" style="padding-bottom:50px;margin-top:10px;">
	<div class="col-md-9">
		<div class="row">
			<div class="col-md-12">
				<s:form cssClass="form-horizontal" action="seProcess!taskProcessAssignSubmit.do" namespace="/process" method="post" id="theForm">
					<%@include file="taskProcessInclude.jsp" %>
				</s:form>
			</div>
		</div>
	</div>
	<div class="col-md-3">
		<s:action name="seProcess!commonProcessInfo" namespace="/seProcess"  executeResult="true">
			<s:param name="jobno" value="#attr.pmb.jobno"></s:param>
			<s:param name="procInsId" value="#attr.pmb.processInstanceId"></s:param>
			<s:param name="taskId" value="#attr.pmb.taskId"></s:param>
		</s:action>
	</div>
</div>



</div>


<div class="navbar-fixed-bottom" style="padding:10px;background:#eee;">
	<div class="row">
		<div class="col-sm-6 text-left">
			<button class="btn btn-primary" type="button">创建遗留备忘</button>
		</div>
		<div class="col-sm-6 text-right">
			<div style="display:none;">
				<input type="text" value="${pmb.taskId}" name="taskId" id="taskId"/>
				<input type="text" value="${loginUserInfo.account}" name="stepOperator" id="stepOperator"/>
			</div>
			<button class="btn btn-primary" type="button" onclick="return theFormSubmit()">保存</button>
			<button class="btn btn-primary" type="button" onclick="setProcVar(0);return theFormSubmit('next')">上一步</button>
			<button class="btn btn-primary" type="button" onclick="setProcVar(1);return theFormSubmit('next')">下一步</button>
			<button class="btn btn-default" type="button">关闭</button>
		</div>
	</div>
</div>

<div  id="msgInfo" style="display:none;margin:0px;width:300px;">
	<div class="panel panel-primary">
		<div class="panel-heading"><b>JOBNO :</b> 2017TASK00012</div>
		<div class="panel-body" >
			<b>TASK :</b> 任务登记及派工 
		</div>
	</div>
</div>

</script>
	
</body>
</html>
