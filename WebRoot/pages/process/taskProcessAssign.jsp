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
	//var url = "${ctx}/se/seRequirementTrace!seRequirementTraceSelect.do?cb=getParent().selectRequireTraceCb";
	
	var projectId = $("#projectId").val();
	if(!projectId){
		layer.tips('请先选择所属系统', '#projectId', {
		  tips: [1, '#3595CC'],
		  time: 2000
		});
		
		return false;
	}
	var url = "${ctx}/se/seRequirementTrace!seRequirementTraceTaskSelect.do?seRequirementTrace.projectId=" + projectId + "&cb=getParent().selectRequireTraceCb";
	showWin(url,900,500);
}


function selectRequireTraceCb(obj){
	console.log(obj);
	$("#traceTaskId").val(obj.TASK_ID);
	$("#traceTaskName").val(obj.TASK_TITLE);
	$("#taskName").val(obj.TASK_TITLE);
	
}

function theFormSubmit(next){
	var obj = getFormJsonData("theForm");
	console.log(obj);
	var formParams = $("#theForm").serialize();
	$.ajax("${ctx}/seProcess/seProcess!taskProcessAssignSubmit.do",
		{
			type:"post",
			async:false,
			data:formParams,
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
	
	//$("#theForm").submit();
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
								try{
									parent.reloadMyTodoTab();
									parent.closeLayer(1);
								}catch(e){
									try{
										parent.clw();
									}catch(e){
										window.close();
									}
								}
							}
						});
						//parent.clw();
					}else{
						showMsg("err","流程跳转失败");
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
	<%-- 
	<c:import  url="${serverAddr}/seProcess/seProcess!commonProcessInfo.do?jobno=${jobno}&procInsId=${procInsId}&taskId=${taskId}" charEncoding="utf-8">
	</c:import>
	--%>
</div>
</div>

</div>

<div class="navbar-fixed-bottom" style="padding:10px;background:#eee;">
	<div class="row">
		<div class="col-sm-6 text-left">
			<button class="btn btn-primary" type="button" onclick="setDisabled()">创建遗留备忘</button>
		</div>
		<div class="col-sm-6 text-right">
			<div style="display:none;">
				<input type="text" value="${pmb.taskId}" name="taskId" id="taskId"/>
				<input type="text" value="${loginUserInfo.account}" name="stepOperator" id="stepOperator"/>
			</div>
			<button class="btn btn-primary" type="button" onclick="return theFormSubmit()">保存</button>
			<button class="btn btn-primary" type="button" onclick="return theFormSubmit('next')">下一步</button>
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

	
</body>
</html>
