<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html >

<html>
<head>

<meta charset="utf-8"/>
<title>jquery zTree</title>


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
		edit: {
			//是否可编辑  - 包括是否可拖动
			enable: true,
			//是否显示删除按钮
			showRemoveBtn: false,
			//是否显示重命名按钮
			showRenameBtn: false
		},
		callback: {
			//右键事件
			onRightClick: OnRightClick,
			//单击事件
			onClick:menuEditNode,
			beforeDrag: beforeDrag,
			//拖拽事件
			beforeDrop: beforeDrop
		}
};

var zNodes =[
	{ id:"${checklist.id}", pId:"0", name:"${checklist.cklistName}",code:"${checklist.treeCode}",isParent:true}
];

function beforeDrag(treeId, treeNodes){
	if(treeNodes.length > 1){
		alert("拖拽只可以拖动1个节点");
	}
}

function beforeDrop(treeId, treeNodes, targetNode, moveType) {
	alert(treeId + "|" + treeNodes[0].code + "|" + targetNode.code + "|" + moveType);
}

function OnRightClick(event, treeId, treeNode) {
	if(treeNode){
		zTree.selectNode(treeNode); 
		if(treeNode.getParentNode()){
			showRMenu("node", event.clientX, event.clientY);
		}else{
			showRMenu("root", event.clientX, event.clientY);
		}
	}
}


function showRMenu(type, x, y) {
	$("#rMenu ul").show();
	if (type=="root") {
		$("#m_del").hide();
		$("#m_check").hide();
		$("#m_unCheck").hide();
		$("#m_reset").hide();
	} else {
		$("#m_del").show();
		$("#m_check").show();
		$("#m_unCheck").show();
		$("#m_reset").show();
	}
	rMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});

	$(document).bind("mousedown", onBodyMouseDown);
}
//隐藏右键菜单
function hideRMenu() {
	if (rMenu) rMenu.css({"visibility": "hidden"});
	$(document).unbind("mousedown", onBodyMouseDown);
}

//隐藏菜单
function onBodyMouseDown(event){
	if (!(event.target.id == "rMenu" || $(event.target).parents("#rMenu").length>0)) {
		rMenu.css({"visibility" : "hidden"});
	}
}


//右键菜单刷新节点
function menuRefreshNode(){
	hideRMenu();
	var node = zTree.getSelectedNodes()[0].getParentNode();
	if(node){
		zTree.reAsyncChildNodes(node, "refresh");
	}else{
		zTree.reAsyncChildNodes(node, "refresh");
	}
	
}
//右键菜单编辑节点
function menuEditNode(){
	hideRMenu();
	var node = zTree.getSelectedNodes()[0];
	if(node){
		parent.rightFrame.document.location = "${ctx}/checklist/checklist!edit.do?checklist.id=" + node.id
	}else{
		alert("未找到节点");
	}
	
}
//右键菜单添加节点
function menuAddNode(){
	hideRMenu();
	var node = zTree.getSelectedNodes()[0];
	if(node){
		parent.rightFrame.document.location = "${ctx}/checklist/checklist!add.do?checklist.treeCode=" + node.code
	}else{
		alert("未找到节点");
	}
}

//右键菜单删除节点
function menuDeleteNode(){
	hideRMenu();
	var node = zTree.getSelectedNodes()[0];
	if(node){
		if(confirm("确定删除此节点么?")){
			var code = node.getParentNode().code;
			//alert(node.id);
			$.ajax({
			  url: '${ctx}/tree/tree_delete.do?tree.treeId=' + node.id,
			  success: function(data) {
			  	//alert(data)
			  	if($.trim(data)=="success"){
			  		refreshNode(code);
			  	}else{
			  		alert( data);
			  	}
			  }
			});
			
			
		}		
		
	}else{
		alert("未找到节点");
	}
}

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

//为添加节点刷新
function refreshForAddNode(code){
	var node = zTree.getNodeByParam("code",code, null);
	node.isParent=true;
	zTree.reAsyncChildNodes(node, "refresh");
}

var zTree, rMenu;
$(document).ready(function(){
	zTree=$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	rMenu = $("#rMenu");
	
	refreshNode("${checklist.cklistName}");
});



</script>
</head>
<body style="padding:0px;margin:0px;overflow:auto;">
<div id="rMenu">
	<ul>
		<li id="m_add" onclick="menuAddNode();">增加节点</li>
		<li id="m_del" onclick="menuEditNode();">编辑节点</li>
		<li id="m_check" onclick="menuDeleteNode();">删除节点</li>
		<li id="m_reset" onclick="menuRefreshNode();">刷新</li>
	</ul>
</div>


<ul id="treeDemo" class="ztree"></ul>


</body>
</html>