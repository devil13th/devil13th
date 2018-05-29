<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html >

<html>
<head>

<meta charset="utf-8"/>
<title>jquery zTree</title>
<%@ include file="../../../pub/pubCssJs.jsp"%>

<style>
.ztree{height:100%;overflow:auto;}
div#rMenu {z-index:4;position:absolute;width:100px;visibility:hidden; top:0; background-color: #555;padding: 1px;}
div#rMenu ul{margin:0px;padding:0px;}
div#rMenu ul li{
	font-size:12px;line-height:20px;
	margin:0px;padding:0px;
	cursor: pointer;
	list-style: none outside none;
	background-color: #DFDFDF;
	border-bottom:1px solid #fff;
	padding-left:3px;
}

div#rMenu ul li:hover{background:#eee;}
</style>

<!-- jquery ztree css -->
<link rel="stylesheet" href="${ctx}/js/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css">

<!-- jquery js -->
<script src="${ctx}/js/jquery/jquery-1.8.0.min.js"></script>
<!-- jquery ztree -->
<script src="${ctx}/js/ztree/js/jquery.ztree.all-3.5.js"></script>


<script>
var setting = {
		async: {
			enable: true,
			url:"${ctx}/checklist/checklist!getData.do",
			autoParam:["id", "code=checklist.treeCode"]
		},
		check: {
			enable: true,
			//选择类型 默认是checkbox
			chkStyle: "radio", 
			//选择级联形式
			chkboxType : { "N" : "N", "N" : "N" },
			radioType : "all",
			
			end:"-"
		}

};

var zNodes =[
	{ id:"${checklist.id}", pId:"0", name:"${checklist.cklistName}",code:"${checklist.treeCode}",isParent:true}
];


//焦点
function focusNode(code){
	var node = zTree.getNodeByParam("code",code, null);
	if(node){
		zTree.selectNode(node); 
	}else{
		setTimeout(function(){
			focusNode(code);
		},10);
	}
}


//刷新节点
function refreshNode(code){ 
	var node = zTree.getNodeByParam("code",code, null);
	if(node){
		zTree.reAsyncChildNodes(node, "refresh");
	}else{
		setTimeout(function(){
			refreshNode(code);
		},10);
	}
}

//刷新父节点
function refreshParentNode(code){
	var node = zTree.getNodeByParam("code",code, null);
	var pNode = node.getParentNode();
	if(pNode){
		refreshNode(pNode.code);
	}else{
		refreshNode("root");
	}
}

var zTree, rMenu;
$(document).ready(function(){
	zTree=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	rMenu = $("#rMenu");
	
	refreshNode("${checklist.cklistName}");
});


function selectChecklist(){
	
	var nodes = zTree.getCheckedNodes(true);
	if(nodes.length  != 1){
		alert("请选择一个节点");
	}else{
		var node = nodes[0];
		getParent().selectChecklistCb(node);
		window.close();
	}
	
}
</script>
</head>
<body style="padding:0px;margin:0px;overflow:auto;">

<input type="button" value="确定" onclick="selectChecklist()">
<ul id="treeDemo" class="ztree"></ul>


</body>
</html>