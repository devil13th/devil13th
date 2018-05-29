<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>




<div class="portlet portlet-sortable box green-haze" >
	<div class="portlet-title">
		<div class="caption">
			<i class="glyphicon glyphicon-screenshot"></i> Appoint Plan  </div>
		<div class="actions">
			<a href="javascript:;" class="btn btn-default btn-sm">
				<i class="fa fa-pencil"></i> Edit </a>
			<a href="javascript:;" class="btn btn-default btn-sm">
				<i class="fa fa-plus"></i> Add </a>
			<a class="btn btn-sm btn-icon-only btn-default fullscreen" href="javascript:;"></a>
		</div>
	</div>
	<div class="portlet-body">
		<h6>点击进入项目计划</h6>
		<div class="list-group">
			<c:forEach items="${projectList}" var="pro">
			  <a href="${ctx}/plan/plan!planList.do?projectId=${pro.projectId}" target="_blank" class=" list-group-item "><i class="glyphicon glyphicon-hand-right"></i> &nbsp;  ${pro.projectName}</a>
			</c:forEach>
		</div>
	</div>
</div>