<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html >

<html>
<head>

<meta charset="utf-8"/>
<title>jquery zTree</title>


<style>
</style>

<!-- jquery ztree css -->
<link rel="stylesheet" href="${ctx}/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">

<!-- jquery js -->
<script src="${ctx}/js/jquery/jquery-1.8.0.min.js"></script>
<!-- jquery ztree -->
<script src="${ctx}/js/ztree/js/jquery.ztree.all-3.5.js"></script>

<script>

//选择树后的处理函数
function getData(str){
	alert(str);
}


function checkTree(){
	var url = "${ctx}/tree/tree_select.do?ckType=checkbox&checkCodes=" + $("#codes").val();
	url+="&callBackPath=parent.getData"
	document.getElementById("f").src= url;
	
}
</script>
</head>
<body style="padding:0px;margin:0px;">

输入要勾选节点的code,多个code用","隔开<br/>
<input type="text" id="codes" name="ckCodes" style="width:300px;" value="root.00001,root.00002.00001,root.00003.00001.00001"/><br/>
<input type="submit" value="选择树" onclick="checkTree()"/><br/>
<iframe src="" id="f" name="f"></iframe> 

</body>
</html>