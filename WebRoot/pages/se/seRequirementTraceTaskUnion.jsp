
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<%@ include file="../../../pub/pubCssJs.jsp"%>
		<title>
			TraceTree
		</title>
	
<style>

</style>

<script>
var tab ;

var editId = null;



$(function(){
	tab = $('#treegrid').treegrid({
		title:'矩阵任务视图',
		iconCls:'icon-ok',
		//数据来源
		url:'${ctx}/se/seRequirementTrace!seRequirementTraceTaskUnionGetData.do', 
		//默认参数
		queryParams:{'projectId':'${projectId}'},
		//斑马纹
		//striped:true,
		//主键字段
		idField:'id',
		treeField:'name',
		//表单提交方式
		method:"post", 
		//是否只能选择一行
		singleSelect:true,
		//自动宽度
		fit:true,
		fitColumns:false,
		//高度
		height:350,
		//宽度
		//width:900, 
		//是否分页
		pagination:true,
		//分页信息
		pageSize:5, 
		//每页显示条目下拉菜单
		pageList:[5,10,15,20,100],
		
		//pageNumber:5,
		//rownumbers:true,//行号 
		//分页工具所在位置
		//pagePosition:"both",
		
		loadMsg:"正在加载数据,请稍后",
		//冻结的列
		frozenColumns:[[
			//{field:'id',title:'ID',sortable:true,width:400},
			{field:'name',title:'Name',sortable:true,width:400},
		]],
		//不冻结的列
		columns:[[
			{field:'beginDate',width:100,title:'PLANSTART',editor:'datebox'}, 
			{field:'finishDate',width:100,title:'PLANFINISH',editor:'datebox'}, 
			{field:'actBeginDate',width:100,title:'ACTSTART',editor:'datebox'}, 
			{field:'actFinishDate',width:100,title:'ACTFINISH',editor:'datebox'}, 
			{field:'currentProcess',width:100,title:'AC',align:'right',editor:'numberbox'}, 
			{field:'execNote',width:300,title:'执行备注',editor:'textbox'}, 
			{field:'dataType',width:100,title:'DATATYPE',sortable:true}
		]],
		toolbar: "#tb",
		onDblClickRow:function(data){
			
			if(editId){
				tab.treegrid('endEdit', editId);
			}
			
			if(data.dataType == 'task'){
				tab.treegrid('beginEdit', data.id);
				editId = data.id;
			}
			
		},
		onSelect:function(data){
			if(editId){
				tab.treegrid('endEdit', editId);
			}
		},
		onContextMenu:function(e,data){
			e.preventDefault();
			tab.treegrid('selectRow',data.id);
			if(data.dataType == 'task'){
				$('#mm').menu('show',{
					left: e.pageX-5,
					top: e.pageY-5
				});
			}
		},
		onAfterEdit:function(row,changes){
			//console.log(row);
			console.log(changes);
			if(changes){
				saveChange(row);
			}
		}
	})
})

function menuEdit(){
	var data = tab.treegrid('getSelected');
	
	if(editId){
		tab.treegrid('endEdit', editId);
	}
	
	if(data.dataType == 'task'){
		tab.treegrid('beginEdit', data.id);
		editId = data.id;
	}
	
	
}

function doSearch(v){
	
	if($.trim(v) == ''){
		alert("请输入关键字");
		return;
	}
	
	$.ajax({
		url:"${ctx}/se/seRequirementTrace!seRequirementTraceTaskUnionSearch.do",//请求地址
		method:"post",//提交方式
		async:false,//是否异步
		cache:false,//是否缓存
		data:{id:v,projectId:"${projectId}"},//可以是字符串也可以是json对象，字符串类似本例子中的内容
		dataType:"json",//返回数据的格式 xml, json, script, or html
		success:function(r){//回调函数
			if(r && r.length > 0){
				tab.treegrid("collapseAll");
				for(var i = 0 , j = r.length ; i < j ; i++){
					var nid = r[i].id
					//alert(nid);
					tab.treegrid("expandTo",nid);
					tab.treegrid("select",nid);
				}
			}else{
				alert("no data");
			}
			
		}
	})
}

function showMsg(tit,msg){
	$.messager.show({
		title:tit,
		msg:msg,
		timeout:2000,
		showType:'slide'
	});	
}



function saveChange(data){
	
	
	if(!data.beginDate){
		data.beginDate = null;
	}
	if(!data.finishDate){
		data.finishDate = null;
	}
	if(!data.actBeginDate){
		data.actBeginDate = null;
	}
	if(!data.actFinishDate){
		data.actFinishDate = null;
	}
	if(!data.currentProcess){
		data.currentProcess = null;
	}
	
	
	$.ajax({
		type: "POST",
		url: "${ctx}/se/se!seTraceTaskFormSubmitForAjax.do?_r= " + Math.random(),
		data: { acceptJson: JSON.stringify(data),id:data.id},
		success: function(data) {
			if($.trim(data) != '<%=StaticVar.STATUS_SUCCESS%>'){
				showMsg("错误信息","Err Info: NOT BE SAVED SUCCESS");
			}else{
				tab.treegrid('reload');
				showMsg("提示",'保存成功');
			}
		},
		dataType: "text"
	});
		
}
</script>
	</head>
<body>
<table id="treegrid"></table>

<div id="tb">
<input class="easyui-searchbox" data-options="prompt:'Please Input Value',searcher:doSearch" style="width:150px"/>
<a href="#" class="easyui-linkbutton"  data-options="plain:true,iconCls:'icon-refresh'" onclick="tab.treegrid('reload')">刷新</a> 
<a href="#" class="easyui-linkbutton"  data-options="plain:true,iconCls:'icon-folder-close'" onclick="tab.treegrid('collapseAll')">全部关闭</a> 
<a href="#" class="easyui-linkbutton"  data-options="plain:true,iconCls:'icon-folder-open'" onclick="tab.treegrid('expandAll')">全部展开</a>
<!-- 
<a href="#" class="easyui-linkbutton"  data-options="plain:true,iconCls:'icon-save'" onclick="saveChange()">保存</a> 
 --> 
<i style="float:right;padding-top:5px;padding-right:15px;">注：双击任务进行编辑</i>
</div>

<div id="mm" class="easyui-menu" style="width: 120px;">
	<div data-options="iconCls:'icon-edit'" onclick="menuEdit()">
		编辑
	</div>
	<div class="menu-sep"></div>
	<div data-options="iconCls:'icon-folder-open'" onclick="tab.treegrid('expandAll')">
		全部展开
	</div>
	<div data-options="iconCls:'icon-folder-close'" onclick="tab.treegrid('collapseAll')">
		全部关闭
	</div>
</div>
		
		
</body>
</html>
