<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>

<script type="text/javascript">
var pmbJobno = "${pmb.jobno }";
var pmbTaskId = "${pmb.taskId }";
var pmbStepCode = "${pmb.stepCode}";
var pmbProcessInstanceId = "${pmb.processInstanceId}";
//关闭工作
function closeWork(){
	top.layer.confirm('关闭工作后，该工作状态将会置为已完成，是否继续？', {title:false, shade: 0.4, shadeClose: false, closeBtn: 0, scrollbar: false}, function(index){
		top.layer.close(index);
		actWorkFlowObj.finishProcess();
	});
}




function showProcessMsg(msg){
	$('#processMsgModal').modal('show')
	$("#processMsgModalMsg").html(  msg + "<br/>" + $("#processMsgModalMsg").html());
}

function clearProcessMsg(){
	$("#processMsgModalMsg").html("");
}

$(function(){
	$('#processMsgModal').on('hidden.bs.modal', function (e) {
		clearProcessMsg()
	})
})
	
	
</script>

<c:if test="${ce == staticVarObj.y }">

	<c:if test="${ step.isFirstStep != '1'}">
		<button type="button" id="prev_btn" class="btn btn-success btn-sm" onclick="actWorkFlowObj.prev();">上一步</button>
	</c:if>
	<c:if test="${ step.isLastStep != '1'}">
		<button type="button" id="next_btn" class="btn btn-success btn-sm" onclick="actWorkFlowObj.next();">下一步</button>
	</c:if>
	<c:if test="${ step.isLastStep == '1' }">
		<button type="button" id="close_btn" class="btn btn-success btn-sm" onclick="actWorkFlowObj.close();">关闭工作</button>
	</c:if>

</c:if>

<button type="button" id="flow_quit" class="btn btn-danger btn-sm" onclick="actWorkFlowObj.closePage();">退出</button>

