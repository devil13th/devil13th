<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>myBootStrap</title>
<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>


<style>

</style>
<script>
$(function(){

	

})
</script>



</head>
<body>
<div class="container-fluid">
	
	
	<div class="row">
	</div>
	
	
	<div class="row">
		<div class="col-sm-4" id="menu" style="height:100%;overflow:auto;">
			<ul class="nav nav-pills nav-stacked" >
				<c:forEach items="${list}" var="m">
					<li class="" ><a href="#m_${m.MODULE_ID}">${m.MODULE_TITLE}</a></li>
				</c:forEach>
			</ul>
		</div>
		<div class="col-sm-8" data-spy="scroll" data-target="#menu" style="height:100%;overflow:auto;">
			<c:forEach items="${list}" var="m">
				<div class="panel panel-primary" id="m_${m.MODULE_ID}">
					<div class="panel-heading">${m.MODULE_TITLE}</div>
					<div class="panel-body" >
						<div class="text-right">
							<a href="${ctx}/se/se!sePubModuleForm.do?sePubModule.ModuleId=${m.MODULE_ID}" target="_blank">[查看详细]</a>
						</div>
						${m.MODULE_DESC}
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	


</div>


</body>
</html>