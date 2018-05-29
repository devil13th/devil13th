<%@ page language="java" contentType="application/msword;charset=UTF-8"%>  
<% response.setHeader("Content-disposition","attachment; filename=apply.doc");%>

<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>Plan Doc</title>
<meta charset="utf-8" />
<style>
td,th{padding:10px;}
caption h3{text-align:left;padding-left:2em;}
</style>
<body>
<h1 style="text-align:center">${projectInfo.proName} ${planClassifyStr}计划总结 </h1>
<div style="text-align:center">
	报告日期范围：
	<fmt:formatDate value="${planInfo.startDate}" pattern="yyyy-MM-dd"/>  
	 至
	<fmt:formatDate value="${planInfo.finishDate}" pattern="yyyy-MM-dd"/>  
</div>
<hr/>

<table border="1" width="100%" cellpadding="0" cellspacing="0">
	<caption>
		<h3>本周计划完成情况</h3>
	</caption>
	<thead>
		<tr>
			<th width="5%">序号</th>
			<th width="35%">模块</th>
			<th width="35%">任务</th>
			<th width="20%" align="center">执行人</th>
			<th width="10%" align="center">百分比</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${planList.data}" var="plan" varStatus="index">
			<tr>
				<td align="center">${index.index + 1}</td>
				<td>${plan.traceName }</td>
				<td>${plan.taskTitle }</td>
				<td align="center">${plan.exeUser }</td>
				<td align="center">${plan.currentProcess}%</td>
			</tr>
		</c:forEach>
	</tbody>
</table>


<table border="1" width="100%" cellpadding="0" cellspacing="0">
	<caption>
		<h3>本周开发模块</h3>
	</caption>
	<thead>
		<tr>
			<th width="5%">序号</th>
			<th width="50%">模块</th>
			<th width="45%">任务</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${taskList}" var="task" varStatus="index">
			<tr>
				<td align="center">${index.index + 1}</td>
				<td>${task.traceName }</td>
				<td>${task.taskTitle }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>



<table border="1" width="100%" cellpadding="0" cellspacing="0">
	<caption>
		<h3>人员工作工时</h3>
	</caption>
	<thead>
		<tr>
			<th width="5%">序号</th>
			<th width="50%">人员</th>
			<th width="45%">工时</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${workLoadList}" var="wl" varStatus="index">
			<tr>
				<td align="center">${index.index + 1}</td>
				<td>${wl.userName }</td>
				<td>${wl.workLoad }</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<table border="1" width="100%" cellpadding="0" cellspacing="0">
	<caption>
		<h3>计划概况</h3>
	</caption>
	<tbody>
	<tr>
		<td>${planInfo.planRemark}</td>
	</tr>
	</tbody>
</table>

<table border="1" width="100%" cellpadding="0" cellspacing="0">
	<caption>
		<h3>本周总结</h3>
	</caption>
	<tbody>
	<tr>
		<td>${planInfo.finishRemark}</td>
	</tr>
	</tbody>
</table>

</body>
</html>