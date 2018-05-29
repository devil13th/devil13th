<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>





<div class="portlet portlet-sortable light bordered" data-step="3" data-intro="新增功能，开启流程，目前只有任务流程,派工-执行-审核">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-lastfm"></i> <s:text name="common.processEnter"></s:text> </div>
		<div class="actions">
			<!--  <a href="javascript:;" class="btn btn-default btn-sm">
				<i class="fa fa-pencil"></i> Edit </a>
			<a href="javascript:;" class="btn btn-default btn-sm">
				<i class="fa fa-plus"></i> Add </a>
			<a class="btn btn-sm btn-icon-only btn-default fullscreen" href="javascript:;"></a>-->
		</div>
	</div>
	<div class="portlet-body portlet-body-self">
		<h6>选择流程后点击Start按钮</h6>
		<!-- 
		<form action="${ctx}/seProcess/seProcess!startTaskProcess.do" method="post" target="_blank"> -->
		<form action="${ctx}/seProcess/seProcess!startProcess.do" method="post" target="_blank">
		
		
			<input type="hidden" id="key" name="key" value=""/>
			<input type="hidden" id="startUser" name="startUser" value="${loginUserInfo.seUser.userId }"/>
			
			<div class="list-group" id="processList">
			  <a href="#" class="list-group-item active" key="taskProcess">
			    <h4 class="list-group-item-heading">Task Process</h4>
			    <p class="list-group-item-text">任务流程</p>
			  </a>
			  <a href="#" class="list-group-item " key="WorkProcess">
			    <h4 class="list-group-item-heading">通用执行流程</h4>
			    <p class="list-group-item-text">派工、执行、检查、通知四个步骤的通用流程</p>
			  </a>
			  <a href="#" class="list-group-item ">
			    <h4 class="list-group-item-heading">其他流程</h4>
			    <p class="list-group-item-text">尚未开发</p>
			  </a>
			</div>  
			<div class="text-right">
				<button class="btn btn-primary btn-sm" type="submit">
					Start
					<span class="glyphicon glyphicon-play-circle" aria-hidden="true"></span>
				</button>
			</div>
		</form>
	</div>
</div>

<script>


$("#processList .list-group-item").click(function(o){
	var _this =$(this);
	$("#processList .list-group-item").removeClass("active");
	_this.addClass("active");
	selectProcess();
	return false;
})

function selectProcess(){
	var k = $("#processList a.active").attr("key");
	$("#key").val(k);
}
selectProcess();
</script>