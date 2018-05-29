<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html >

<html>
<head>

<meta charset="utf-8"/>
<title>Check List</title>




<script>

</script>


</head>
<body style="padding:0px;margin:0px; ">

<c:forEach items="${ckList}" var="l">
<div style="padding-left:${l.len*2}em">

<h${l.len}> ${fn:replace(l.tree_code, 'root.', '')}${l.cklist_name}</h${l.len}>
<div style="padding-left:2em">
${l.cklist_content}
</div>
</div>
</c:forEach>

</body>
</html>