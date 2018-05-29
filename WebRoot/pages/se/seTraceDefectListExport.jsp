<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">


		</script>
	</head>
	<body>
<c:forEach items="${list}" var="l">
	
		<table>
			<tr>
				<td>缺陷标题：</td>
				<td colspan="3">${l.DEFECT_DESC}</td>
			</tr>
			<tr>
				<td width="130">状&nbsp;&nbsp;态：</td>
				<td width="200">${l.DEFECT_STATUS} </td>
				<td width="130">级&nbsp;&nbsp;别：</td>
				<td width="200">${l.DEFECT_CLASSIFY} </td>
			</tr>
			<tr>
				<td>创建人：</td>
				<td>${l.TEST_USER}</td>
				<td>修改人：</td>
				<td>${l.DEVELOPER} </td>
			</tr>
			<tr>
				<td>创建时间：</td>
				<td><fmt:formatDate value="${l.CREATE_TIME}" pattern="yyyy-MM-dd"/></td>
				<td>修改时间：</td>
				<td><fmt:formatDate value="${l.UPDATE_TIME}" pattern="yyyy-MM-dd"/></td>
			</tr>
		</table>
		详细描述：
		<div>${l.DEFECT_PIC}</div>
		<hr/>
</c:forEach>	
		
	</body>

</html>
