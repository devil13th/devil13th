<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<div class="container-fluid">
	
	<blockquote>
	<div class="row text-primary">
		<div class="col-xs-1">
			<c:if test="${bli.expireStatus == '删除'}"><span class="label label-default">${bli.expireStatus}</span></c:if>
			<c:if test="${bli.expireStatus == '完成'}"><span class="label label-success">${bli.expireStatus}</span></c:if>
			<c:if test="${bli.expireStatus == '正常'}"><span class="label label-primary">${bli.expireStatus}</span></c:if>
			<c:if test="${bli.expireStatus == '预警'}"><span class="label label-warning">${bli.expireStatus}</span></c:if>
			<c:if test="${bli.expireStatus == '过期'}"><span class="label label-danger">${bli.expireStatus}</span></c:if>
		</div>
		<div class="col-xs-11">
			<i class="glyphicon glyphicon-info-sign"></i> 
			<c:out value="${bli.blContent}"></c:out>
		</div>
	</div>
	<hr/>
	<div class="row">
		<div class="col-xs-2">
		</div>
		<div class="col-xs-6">
			<div class="row">
				<div class="col-xs-2">编&nbsp;&nbsp;&nbsp;&nbsp;号：</div>
				<div class="col-xs-10"><c:out value="${bli.blId}"></c:out></div>
			</div>
			<div class="row">
				<div class="col-xs-2">状&nbsp;&nbsp;&nbsp;&nbsp;态：</div>
				<div class="col-xs-10">
					${bli.expireStatus}
					<!--<c:if test="${bli.blStatus == '1'}"><span class="label label-primary">正常</span></c:if>
					<c:if test="${bli.blStatus == '0'}"><span class="label label-primary">删除</span></c:if>
					<c:out value="${bli.blStatus}"></c:out>-->
				</div>
			</div>
			<div class="row">
				<div class="col-xs-2">分&nbsp;&nbsp;&nbsp;&nbsp;类：</div>
				<div class="col-xs-10"><c:out value="${bli.blClassify}"></c:out></div>
			</div>
			<div class="row">
				<div class="col-xs-2">系&nbsp;&nbsp;&nbsp;&nbsp;统：</div>
				<div class="col-xs-10"><c:out value="${bli.blSys}"></c:out></div>
			</div>
			<div class="row">
				<div class="col-xs-2">执&nbsp;&nbsp;&nbsp;&nbsp;行：</div>
				<div class="col-xs-10"><c:out value="${bli.blExeUser}"></c:out></div>
			</div>
			<div class="row">
				<div class="col-xs-2">签&nbsp;&nbsp;&nbsp;&nbsp;发：</div>
				<div class="col-xs-10"><c:out value="${bli.blIssueUser}"></c:out></div>
			</div>
			<div class="row">
				<div class="col-xs-2">开&nbsp;&nbsp;&nbsp;&nbsp;始：</div>
				<div class="col-xs-10"><fmt:formatDate value="${bli.startDate}" pattern="yyyy-MM-dd HH:ss"/>  </div>
			</div>
			<div class="row">
				<div class="col-xs-2">结&nbsp;&nbsp;&nbsp;&nbsp;束：</div>
				<div class="col-xs-10"><fmt:formatDate value="${bli.fnshDate}" pattern="yyyy-MM-dd HH:ss"/> </div>
			</div>
			<div class="row">
				<div class="col-xs-2">创&nbsp;&nbsp;&nbsp;&nbsp;建：</div>
				<div class="col-xs-10"><fmt:formatDate value="${bli.createDate}" pattern="yyyy-MM-dd HH:ss"/></div>
			</div>
			<div class="row">
				<div class="col-xs-2">预&nbsp;&nbsp;&nbsp;&nbsp;警：</div>
				<div class="col-xs-10"><fmt:formatDate value="${bli.expireDate}" pattern="yyyy-MM-dd"/>(<c:out value="${bli.alarmDays}"></c:out>)</div>
			</div>
			<div class="row">
				<div class="col-xs-3"> <hr/></div>
				<div class="col-xs-9"></div>
			</div>
			<div class="row">
				<div class="col-xs-2">级&nbsp;&nbsp;&nbsp;&nbsp;别：</div>
				<div class="col-xs-10">
					<c:if test="${bli.blLevel == '1'}"><span class="label label-default">可暂缓</span></c:if>
					<c:if test="${bli.blLevel == '2'}"><span class="label label-success">不紧急</span></c:if>
					<c:if test="${bli.blLevel == '3'}"><span class="label label-primary">正常</span></c:if>
					<c:if test="${bli.blLevel == '4'}"><span class="label label-warning">紧急</span></c:if>
					<c:if test="${bli.blLevel == '5'}"><span class="label label-danger">非常紧急</span></c:if>
					<!--<c:out value="${bli.blLevel}"></c:out>-->
				</div>
			</div>
			
		</div>
		<div class="col-xs-4">
			
		</div>
	</div>
	
	
	</blockquote>
	
	
	<div class="note note-success">
		<h4 class="block">详情</h4>
		<p> ${note}</p>
	</div>
</div>
