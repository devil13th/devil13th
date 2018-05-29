<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<title>[${seWorkList.jobno}] ${seWorkList.workName}</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="${ctx}/js/process.jsp?_r=<%=Math.random() %>"></script>
		<script src="${ctx}/js/vue/vue.js" type="text/javascript"></script>
		
		<script type="text/javascript">
		
$(function(){
	$('#processMenuTree').tree({
		onSelect : function(node){
			console.log(node);
		}
	});
	$("#processContentFrame").attr("src","${ctx}${funList[0].FUN_URL}?jobno=${pmb.jobno}&stepCode=${pmb.stepCode}&ce=${ce}");
})
		</script>
	</head>
<body class="easyui-layout">



<div data-options="region:'north',split:true,hideCollapsedContent:false" style="height:34px;padding:3px;text-align:left;">
<b>JOBNO：</b>${seWorkList.jobno}
&nbsp; 
<b>WORK NAME：</b>${seWorkList.workName}
&nbsp; 
<b>Process Start Time：</b>${seWorkList.startTime}
&nbsp; | &nbsp; 
<b>Process Name：</b>${process.processName}
&nbsp; 
<b>Step Name：</b>${step.stepName}
</div>

<div data-options="region:'east',split:true,hideCollapsedContent:false,collapsed:true" title="Process Information" style="width:200px;">
	<!--  <img src="${ctx}/seProcess/seProcess!showProcessImage.do?taskId=${pmb.taskId}">-->
	
	<div id="hisStepsVue">
		<template v-for="step in data">
			<div @click="goInTodo(step.formKey,step.businessKey,step.taskKey)" style="border:1px solid red;">
				{{step.taskName}} | {{step.taskKey}} |  {{step.startTime}} |  {{step.taskKey}}
			</div>
		</template>
	</div>
	<br/>
	
	<a href="${ctx}/seProcess/seProcess!showProcessImage.do?taskId=${pmb.taskId}" target="_blank">查看流程图</a>
</div>
<div data-options="region:'west',split:true,hideCollapsedContent:false" title="Menu" style="width:250px;padding:1px;" >

	<ul id="processMenuTree">
	
		<li><span>步骤功能</span>
			<ul>
				<c:forEach items="${funList}" var="fun">
					<li><a href="${ctx}${fun.FUN_URL}?jobno=${pmb.jobno}&stepCode=${pmb.stepCode}&ce=${ce}" target="processContentFrame">${fun.FUN_NAME}</a></li>
				</c:forEach>
				<!-- 
				<li><a href="${ctx}/workProcess/workProcess!workProcessAssign.do?taskId=${pmb.taskId}&jobno=${pmb.jobno}&stepId=${pmb.stepId}" target="taskFrame">工作信息</a></li>
				<li><a href="${ctx}/seProcess/seProcess!stepBlank.do?taskId=${pmb.taskId}&jobno=${pmb.jobno}&stepId=${pmb.stepId}" target="taskFrame">流程节点信息</a></li>
				 -->
			</ul>
		</li>
	</ul>
</div>
<div data-options="region:'center',title:'Task Information'" style="overflow:hidden;">
	<iframe frameborder="0" width="100%" height="100%" id="processContentFrame" name="processContentFrame"></iframe>
 </div>

<div data-options="region:'south',split:true,title:'Development Info',hideCollapsedContent:false,collapsed:true" style="height:450px;overflow:hidden;">
	<!-- 
	<iframe width="100%" height="100%" frameborder="0" src="${ctx}/seProcess/seProcess!stepBlank.do?taskId=${pmb.taskId}&jobno=${pmb.jobno}&stepId=${pmb.stepId}">
	 -->
</div>


<script>

	
	
$(function(){
	
$.ajax({
	url:"${ctx}/seProcess/seProcess!queryHistoryTaskForVue.do",//请求地址
	method:"post",//提交方式
	async:false,//是否异步
	cache:false,//是否缓存
	data:{id:"${seWorkList.procInsId}"},//可以是字符串也可以是json对象，字符串类似本例子中的内容
	dataType:"json",//返回数据的格式 xml, json, script, or html
	success:function(r){//回调函数
		initHisStepVue(r)
	}
})
var hisStepVue;

function initHisStepVue(d){
	hisStepVue = new Vue({
		el : "#hisStepsVue",
		data : {data:d},
		methods : {
			
			goInTodo : function(url,jobno,stepCode){
				var url = "${ctx}/" + url +"?jobno=" + jobno + "&stepCode=" + stepCode;
				showWin(url);
			}
			
		}
	})
}

	
})
</script>


</body>

</html>
