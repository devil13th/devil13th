<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>




 
<div class="portlet portlet-sortable box purple" data-step="1" data-intro="系统功能入口">
	<div class="portlet-title">
		<div class="caption">
			<i class="glyphicon glyphicon-screenshot"></i> <s:text name="common.projectPortal"></s:text> 
		</div>
	</div>
	<div class="portlet-body portlet-body-self">
		
		<c:if test="${projectId == null || projectId == '' }">
			<c:if test="${projectList !=null }">
				<select class="select2" id="projectPortalProjectList">
					<c:forEach items="${projectList}" var="pro">
						<option value="${pro.projectId}" <c:if test="${pro.projectId == projectId}">selected="selected"</c:if>> ${pro.projectName}</option>
					</c:forEach>
				</select>
			</c:if>
		</c:if>
		<div class="row">
			<div class="col-sm-6">
				<div class="list-group" style="margin-top:15px;">
					<a href="#" onclick="projectPortal.goToTraceRequirement();return false;" target="_blank" class=" list-group-item "><i class="fa fa-tag"></i> &nbsp; WBS </a>
					<a href="#" onclick="projectPortal.goToTraceTaskUnion();return false;" target="_blank" class=" list-group-item "><i class="fa fa-tag"></i> &nbsp; KPI </a>
					<a href="#" onclick="projectPortal.goToPlanView();return false;" target="_blank" class=" list-group-item "><i class="fa fa-plane"></i> &nbsp; 本周计划 </a>
					<a href="#" onclick="projectPortal.goToLog();return false;" target="_blank" class=" list-group-item "><i class="fa fa-space-shuttle"></i> &nbsp; 填写日志</a>
					<a href="#" onclick="projectPortal.goToMeetingList();return false;" target="_blank" class=" list-group-item "><i class="fa fa-pencil-square-o"></i> &nbsp; 会议列表</a>
				</div>
			</div>
			<div class="col-sm-6">
				
				<div class="list-group" style="margin-top:15px;">
					<a href="#" onclick="projectPortal.goToDayNote();return false;" target="_blank" class=" list-group-item "><i class="fa fa-paint-brush"></i> &nbsp; 项目记事</a>
					<a href="#" onclick="projectPortal.goToRisk();return false;" target="_blank" class=" list-group-item "><i class="fa fa-bolt"></i> &nbsp; 项目风险</a>
					<a href="#" onclick="projectPortal.goToPubModule();return false;" target="_blank" class=" list-group-item "><i class="fa fa-jsfiddle"></i> &nbsp; 知识积累</a>
					<a href="#" onclick="projectPortal.goToDoc();return false;" target="_blank" class=" list-group-item "><i class="fa fa-file-text-o"></i> &nbsp; 项目文档</a>
				</div>
			</div>
			
                                                        
		</div>
		
	</div>
</div>
<script>

var projectPortal = {
	projectId:"${projectId}",
	planCode:"${planCode}",
	goToTraceRequirement : function(){
		var url = "${ctx}/se/seRequirementTrace!seRequirementTraceIndex.do?seRequirementTrace.projectId=" + this.projectId;
		showWin(url);
	},
	goToPlanView : function(){
		var url = "${ctx}/plan/plan!planView.do?planInfo.planCode=" + this.planCode + "&projectId=" + this.projectId;
		//openLayer("本周计划",url);
		showWin(url);
	},
	goToLog : function(){
		
		var url = "${ctx}/se/se!seUserLog.do";
		//openLayer("本周计划",url);
		showWin(url);
	},
	goToMeetingList : function(){
		var url = "${ctx}/se/se!seMeetingList.do?seMeeting.projectId=" + this.projectId;
		//openLayer("会议列表",url);
		showWin(url);
	},
	goToDayNote : function(){
		var url = "${ctx}/se/se!seDayNoteList.do?seDayNote.projectId=" + this.projectId;
		//openLayer("项目记事",url);
		showWin(url);
	},
	goToRisk : function(){
		var url = "${ctx}/se/se!seRiskList.do?seRisk.projectId=" + this.projectId;
		//openLayer("项目风险",url);
		showWin(url);
	},
	goToPubModule : function(){
		var url = "${ctx}/se/se!sePubModuleList.do?sePubModule.projectId=" + this.projectId;
		//openLayer("项目风险",url);
		showWin(url);
	},
	goToDoc : function(){
		var url = "${ctx}/se/se!seProjectDocList.do?seProjectDoc.projectId=" + this.projectId;
		//openLayer("项目风险",url);
		showWin(url);
	},
	goToTraceTaskUnion : function(){
		var url = "${ctx}/se/seRequirementTrace!seRequirementTraceTaskUnion.do?projectId=" + this.projectId;
		//openLayer("矩阵任务",url);
		showWin(url);
	}
	
}

$(function(){
	
	if(projectPortal.projectId == ""){
		projectPortal.projectId = $("#projectPortalProjectList").val();
	}
	
	var projectPortalProjectListSelect = $("#projectPortalProjectList").select2({
		//默认文本
		allowClear: true,
		width:"100%"
	})
	
	projectPortalProjectListSelect.on('change', function (evt) {
		projectPortal.projectId = $(this).val();
	});
})

</script>