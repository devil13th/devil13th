
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<%@ include file="../../pub/pubCssJs.jsp"%>
   
		<title>
			项目需求矩阵
		</title>
	
<style>

</style>

<script>
//矩阵树
var t ;

$(function(){
	
	
	
	
	//矩阵树初始化
	t = $('#tree').tree({
		//是否显示树节点前的竖线
		lines:true,
		//是否需要动画效果
		animate:true,
		//查询节点提交方式
		method:"post",
		//查询节点地址(异步)
	    //url:'${ctx}/se/seRequirementTrace!getNextData.do',
	    //查询节点地址(同步查询)
	    url:'${ctx}/se/seRequirementTrace!queryTraceTreeData.do',
	    //是否有checkbox
	    checkbox:false, 
	    //是否只显示叶子节点前的checkbox
	    //onlyLeafCheck:true,
	    //默认查询参数
	    queryParams:{'seRequirementTrace.projectId':'${seRequirementTrace.projectId}'},
	    dnd:false
	    //格式化节点
	    /*formatter:function(node){
			return node.text + "(" + node.id + ")";
		},*/
	    
	});
})


function getSelected(){
	var node = $('#tree').tree('getSelected');
	console.log(node);
	${cb}(node);
	window.close();
}


function filterTrace(){
	var k = $("#kw").textbox("getValue");
	//alert(k);
	//t.tree('expandTo', k);
	
	//前台过滤
	//t.tree('doFilter', '');
	t.tree('doFilter', k);
	t.tree('expandAll');
	
	//后台过滤
	/*
	$.ajax("${ctx}/se/se!traceFileter.do",
		{
			data:{msg:k},
			type:"POST",
			success:function(re){
				eval("var r = " + re);
				if(r.length > 0){
					for(var i = 0 , j = r.length ; i < j ; i++){
						var node =t.tree('find', r[i].traceId);
						if(node){
							//console.log(node)
							t.tree('update', {
								target:node.target,
								text: "<span style='color:red'>" + r[i].traceName + "</span>"  
							});
							t.tree('expandTo',  node.target);
						}
					}
				}
			}
		}
	)*/
	
	
	
	
	
			
	//var node =t.tree('find', '2c9a40dd5b1cb443015b1cde12550020');
	//t.tree('expandTo',  node.target);
	//t.tree('select', node.target);

	
}
function reloadTraceTree(){
	t.tree('reload');
}

function expendAllTree(){
	t.tree('expandAll');
}
</script>
	</head>

<body style="padding:0px;margin:0px;">

<div id="p" class="easyui-panel" title="Requirement Trace Tree" >
	<input type="text" class="easyui-textbox" style="width:100px;" id="kw"/>
	<a href="#" class="easyui-linkbutton"  data-options="iconCls:'icon-filter'" onclick="filterTrace();" ></a>
	<a href="#" class="easyui-linkbutton" title="清除搜索结果"  data-options="iconCls:'icon-clear'" onclick="reloadTraceTree();" ></a>
	<a href="#" class="easyui-linkbutton" title="全部展开"  data-options="iconCls:'icon-pin-red'" onclick="expendAllTree();" ></a>
		
	<ul id="tree" class="easyui-tree"></ul>
	<div style="text-align:center">
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-right1'" onclick="getSelected()">OK</a>
	</div>
</div>
	
</body>
</html>
