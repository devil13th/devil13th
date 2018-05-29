<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<div class="panel panel-success">
	<div class="panel-heading"><b>JOBNO :</b> ${jobno}</div>
	<div class="panel-body">
		<ul class="list-group">
			<c:forEach items="${taskHisList }" var="taskHis">
			<li class="list-group-item">
			  <span class="badge">${taskHis.assignee }</span>
			  <b>${taskHis.name }</b><br/>
			 <i class="glyphicon glyphicon-record"></i> <fmt:formatDate value="${taskHis.startTime }" pattern="yyyy-MM-dd hh:mm:ss"/><br/>
			 <i class="glyphicon glyphicon-ban-circle"></i> <fmt:formatDate value="${taskHis.endTime }" pattern="yyyy-MM-dd hh:mm:ss"/>
			</li>
		  	</c:forEach>
		</ul>
	</div>
	<div class="panel-footer">Operator:${loginUserInfo.userName }</div>
</div>




