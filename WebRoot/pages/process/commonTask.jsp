
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<title><s:text name="流程"></s:text>
		</title>
	
<style type="text/css">
</style>
<script>

</script>
	</head>

	<body>
			
			
		taskDefinitionKey:<c:out value="${taskDefinitionKey}"></c:out><hr/>
		taskId:<c:out value="${taskId}"></c:out><hr/>
		taskName:<c:out value="${taskName}"></c:out><hr/>
		taskFormKey:<c:out value="${taskFormKey}"></c:out><hr/>
		candidaters:
		<c:forEach items="${candidaters}" var="u">
			${u.userId} |||
		</c:forEach>
		<hr/>
	</body>
</html>
