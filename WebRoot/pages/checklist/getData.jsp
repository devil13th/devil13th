<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
[
	<c:forEach items="${checklists}" var="cklist" varStatus="index">
	{ 
		"id":"${cklist.id}",
		"name":"${cklist.name}",
		"code":"${cklist.code}",
		"isParent":<c:if test="${cklist.leaf == '1'}">false</c:if><c:if test="${cklist.leaf != '1'}">true</c:if>
	}
	<c:if test="${(index.index+1)!=fn:length(checklists)}">,</c:if>
</c:forEach>
]


