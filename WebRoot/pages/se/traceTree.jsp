
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!-- jquery ztree css -->
<link rel="stylesheet" href="${ctx}/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">
<!-- jquery js -->
<script src="${ctx}/js/jquery/jquery-1.8.0.min.js"></script>
<!-- jquery ztree -->
<script src="${ctx}/js/ztree/js/jquery.ztree.all-3.5.js"></script>


		<title>
			TraceTree
		</title>
	
<style>

</style>

<script>
var setting = {
		data: {
			simpleData: {
				enable: true
			}
		},
		view:{
			selectedMulti :true,
			expandSpeed:''
		}
	};


var zNodes =[
<c:forEach items="${treeNodes }" var="node" varStatus="index">
{ id:"${node.id}", pId:"${node.pId}", name:"${node.name}", isParent:"${node.isParent}"}<c:if test="${fn:length(treeNodes) != index.index+1}">,</c:if>  
</c:forEach>
];

var zTree;
$(function(){
	zTree=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	//open("1");
	//open("2c9a40dd5b1cb443015b1cddb33e001d");
});

function openAll(){
	zTree.expandAll(true);
}

function closeAll(){
	zTree.expandAll(false);
}

function open(nodeId){
	closeAll();
	zTree.cancelSelectedNode(zTree.getSelectedNodes()[0]);
	var nodes = zTree.getNodesByParam("id", nodeId, null);
	zTree.expandNode(nodes[0],true, false , true);
	zTree.selectNode(nodes[0],true);
	/*zTree.cancelSelectedNode(zTree.getSelectedNodes()[0]);
	alert(1);
	
	if(nodeId){
		var nodes = zTree.getNodesByParam("id", nodeId, null);
		zTree.expandNode(nodes[0],true, false , true);
		zTree.selectNode(nodes[0],true);
		if(nodes.pid != "1"){
			open(nodes.pid);
		}
	}*/
}

</script>
	</head>

<body>
	<input type="button" value="打开所有" onclick="openAll()"/>
	<input type="button" value="关闭所有" onclick="closeAll()"/>
	<ul id="treeDemo" class="ztree"></ul>
	
</body>
</html>
