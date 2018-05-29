<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html >

<html>
<head>

<meta charset="utf-8"/>
<title>jquery zTree</title>
<!-- jquery ztree css -->
<link rel="stylesheet" href="${ctx}/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">

<!-- jquery js -->
<script src="${ctx}/js/jquery/jquery-1.8.0.min.js"></script>
<!-- jquery ztree -->
<script src="${ctx}/js/ztree/js/jquery.ztree.all-3.5.js"></script>


<script>




<c:if test="${refreshParent != null}">
parent.leftFrame.refreshParentNode("${refreshParent}");
</c:if>
<c:if test="${msg != null}">
alert("${msg}");
</c:if>
<c:if test="${refresh != null}">
parent.leftFrame.refreshForAddNode("${refresh}");
</c:if>
<c:if test="${focus != null}">
parent.leftFrame.focusNode("${focus}");
</c:if>

document.location.href = "${url}";
</script>
</head>
<body style="padding:0px;margin:0px; ">

</body>
</html>