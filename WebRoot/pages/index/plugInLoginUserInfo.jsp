<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<style>
.paginate_button {margin:0px !important;padding:0px !important;}
</style>






			
			
<div class="portlet portlet-sortable box blue-steel " >
	<div class="portlet-title ">
		<div class="caption">
			<i class="fa fa-user"></i>
			 Login User Info
		</div>
	</div>
	<div class="portlet-body portlet-body-self">   
		<div class="row">
			<div class="col-sm-3">姓名：</div>
			<div class="col-sm-9">${lui.userName}</div>
		</div>
		<hr/>
		<div class="row">
			<div class="col-sm-3">账号：</div>
			<div class="col-sm-9">${lui.account}</div>
		</div>
		<hr/>
		<div class="row">
			<div class="col-sm-3">系统角色：</div>
			<div class="col-sm-9">
				<c:forEach items="${lui.sysRoles}" var="r">
					${r} <br/>
				</c:forEach>
			</div>
		</div>
		<hr/>
		<div class="row">
			<div class="col-sm-3">项目：</div>
			<div class="col-sm-9">
				<c:forEach items="${lui.projects}" var="pro">
					<b>${pro.key}:</b>  ${pro.value}<br/> 
				</c:forEach>
			</div>
		</div>
		
	</div>
</div>

<script>
</script>