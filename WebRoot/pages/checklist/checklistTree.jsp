<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
	<head>
		<title>检查项目实施</title>
		<meta charset="utf-8" />
		<%@ include file="../../pub/pubCssJs.jsp"%>
		<script src="${ctx}/js/ckeditor/ckeditor.js"></script>
		<script src="${ctx}/js/ckeditor/adapters/jquery.js"></script>
		<script src="${ctx}/js/jquery/jquery.hotkeys.js"></script>
		
		
   		<!-- 编辑器源码文件 -->
   		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
   		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
   		
   		
<style>

</style>
<script>
var tab;
var ue;
var theForm;
var pg;
var tg;
//刷新表格
function reloadDg() {
	tab.datagrid("reload");
}
//重新查询
function loadDg() {
	var jsonData = $("#theForm").serializeArray();
	var params = formToJson(jsonData);
	params.a = Math.random();
	//showObj(params);
	tab.datagrid("load", params);
}
//重置表单后查询
function resetForm(){
	theForm.form("clear");
	loadDg();
}

//弹出保存页面方法
function addObj(t) {
	showWin("${ctx}/checklist/checklist!checklistImplBatchForm.do", 900, 700);
}
//弹出编辑页面
function editData(id) {
	showWin("${ctx}/checklist/checklist!checklistImplBatchForm.do?checklistImplBatch.id=" + id,900, 700);
}
//弹出编辑页面
function editData2() {
	var data = tab.datagrid("getSelected");
	if(data){
		editData(data.ID);
	}else{
		showMsg("请选择数据");
	}
}


function deleteDatas(){
	var checkedIds = getCheckedIds();
	if(checkedIds == ""){
		showMsg("请勾选数据后再进行删除");
		return ;
	}
	if(confirm("确定删除勾选的数据么?")){
		$.ajax("${ctx}/checklist/checklist!deleteChecklistImplBatchByIds.do?ids=" + checkedIds + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						showMsg('操作成功');
						tab.datagrid("clearChecked");
						loadDg();
					}else{
						showMsg(str);
					};
				}
			}
		)
	}
	
}
//获取勾选的行
function getCheckedIds(){
	var data = tab.datagrid("getChecked");
	var str = ""
	for(var i = 0 , j = data.length ; i < j ; i++){
		//alert(data[i].ID);
		str += (data[i].ID + ",");
	};
	if(str != ""){
		str = str.substring(0,str.length - 1);
		return str;
	}else{
		return "";
	}
	
}
//删除操作
function deleteData(id){
	if(confirm("确定删除此条记录么?")){
		$.ajax("${ctx}/checklist/checklist!deleteChecklistImplBatchById.do?checklistImplBatch.id=" + id + "&_r="+Math.random,
			{
				type:"GET",
				success:function(r){
					var str = $.trim(r);
					if(str == "success"){
						showMsg('操作成功');
						loadDg();
					}else{
						showMsg(str);
					};
				}
			}
		)
	}
}


$(function(){
	tg = $('#tg').treegrid({
	    url: "${ctx}/checklist/checklist!checklistTreeGetData.do",
		method: 'post',
		rownumbers: true,
		title:"Check List",
		idField: 'id',
		fit:true,
		treeField: 'name',
	    columns:[[
			{field:'name',title:'Check List Item',fit:true,align:'left'},
			{field:'ck',title:'Check',fit:true,formatter:ckFormat,align:'center'}
	    ]],
	    toolbar:
			[  
				{
					text:'加载批次',
					title:'加载批次',
					iconCls:'icon-save',
					handler:function(){
						$("#w").window("open");
						$("#w").window("expand");
					}
				}
			],
		onDblClickRow:function(data){
			if(data.leaf == '1'){
				checkCk(data.id);
			}
		},
		onClickRow:function(data){
			treeGridClickRow(data);
		},
		onLoadSuccess:function(){
		}
		
	});
	
	
	function treeGridClickRow(data){
		$.ajax({
			  dataType: "json",
			  url: "${ctx}/checklist/checklist!queryChecklistInfoForJson.do?checklist.id=" + data.id,
			  success: function(data){
				 //alert(data.cklistDesc);
				 $("#checklistDescDiv").html(data.cklistContent);
			  },
			  type:"post",
			  async:false
		});
		
		var batchId = tab.datagrid("getSelected").ID;
		$.ajax({
			  dataType: "text",
			  url: "${ctx}/checklist/checklist!queryCheckDesc.do",
			  success: function(data){
				 ue.setContent(data, false);
			  },
			  data : {
					"checklistImplResult.checklistId":data.id,
					"checklistImplResult.checkBatch":batchId
			  },
			  type:"post",
			  async:false
		});
		
		
	}
	
	tab = $('#dataTable').datagrid({
		//title:'数据列表',
		iconCls : 'icon-ok',
		//数据来源
		url : '${ctx}/checklist/checklist!checklistImplBatchListGetDate.do?r=' + Math.random(),
		//斑马纹
		striped : true,
		//主键字段
		idField : "ID",
		//宽度自适应
		//fitColumns: true,
		//表单提交方式
		method : "post",
		//是否只能选择一行
		singleSelect : true,
		nowrap : false,
		fit:true,
		border:false,
		//高度
		//height:450,
		//宽度
		//width:860,
		//是否分页
		pagination : true,
		//分页信息
		pageSize : 10,
		//每页显示条目下拉菜单
		pageList : [ 5, 10, 20, 50, 100 ],
		//排序的列
		sortName : 'ID',
		//排序方式
		sortOrder : "desc",
		//pageNumber:5,s
		rownumbers : true,//行号 
		//分页工具所在位置
		pagePosition : "bottom",
		checkOnSelect:false,
		selectOnCheck:false,
		//冻结的列
		frozenColumns : [ [
		//选择框		
				/*{
					field : 'ID',
					title : 'fid',
					checkbox : true,
					align : 'center'
				},*/
				{
					field : 'ID',
					title : '主键',
					checkbox : true,
					align : 'center'
				}
				] ],
		columns : [ [
				{
					field : 'CHECK_USER',
					title : '检查人',
					width : 100,
					sortable : true
				},
				{
					field : 'CHECK_MODULE',
					title : '检查模块',
					width : 200,
					sortable : true
				},
				{
					field : 'CKLISTNAME',
					title : '检验项目表根目录',
					width : 150,
					sortable : true
				},
				{
					field : 'CHECK_TIME',
					title : '检查时间',
					width : 150,
					sortable : true
				},
				{
					field : 'OPER',
					title : '操作',
					width : 80,
					align : 'center',
					formatter : function(value, row, index) {
						var editStr =  '<a  href="#" title="编辑" onclick="editData(\'' + row.ID + '\')" >编辑</a>'
						var deleteStr = '<a  href="#" title="删除" onclick="deleteData(\'' + row.ID + '\')" >删除</a>';
						return editStr +"&nbsp;"+ deleteStr;
					}
				} 
				] ]

		,
		toolbar :[{
			text:'添加批次',
			iconCls:'icon-add',
			handler:function(){addObj()} 
		},{
			text:'编辑',
			iconCls:'icon-edit',
			handler:function(){editData2()}
		},'-',{
			text:'删除',
			iconCls:'icon-remove',
			handler:function(){deleteDatas()}
		}],
		//在用户排序一列的时候触发参数包括：sort：排序列字段名称。order：排序列的顺序(ASC或DESC)
		onSortColumn : function(sort, order) {
			$('#sort').val(sort);
			$('#order').val(order);
		}
		,
		
		onDblClickRow : function(rowIndex, rowData) {
			//不能选中条件中的行
			//editData(rowData.ID);
			$("#w").window("collapse");
		},
		onClickRow:function(index,data){
			//document.getElementById("checkInfoFrame").src = "${ctx}/checklist/checklist!checklistImplBatchForm.do?checklistImplBatch.id=" + data.ID
			pg.propertygrid("load",{
				'checklistImplBatch.id':data.ID,
				'r':Math.random()
			});
			
			tg.treegrid('load', {
				//'checklist.id':data.CKLISTID,
				'checklist.id':data.ID,
			});
		}
				
	})
	
	
	pg = $('#pg').propertygrid({
	    url: '${ctx}/checklist/checklist!queryChecklistImplBatchInfo.do',
	    fit:true,
	    showGroup: true,
	    scrollbarSize: 0,
	    loadMsg:"正在加载数据,请稍后"
		/*,toolbar :[{
			text:'保存',
			iconCls:'icon-save',
			handler:function(){addObj()} 
		}]*/
	});

	

	
	ue = UE.getEditor('container',{
    	serverUrl: "${ctx}/se/se!uploadFile.do",
	   	imageUrlPrefix:"",
	   	imageActionName:'img',
	   	imageFieldName:'imgFile',
	   	imageAllowFiles:[".png", ".jpg", ".jpeg", ".gif", ".bmp"],
		
	   	fileActionName: "uploadfile", /* controller里,执行上传视频的action名称 */
	    fileFieldName: "imgFile", /* 提交的文件表单名称 */
	    fileUrlPrefix: "", /* 文件访问路径前缀 */
	    fileMaxSize: 51200000, /* 上传大小限制，单位B，默认50MB */
	    fileAllowFiles: [
	        ".png", ".jpg", ".jpeg", ".gif", ".bmp",
	        ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
	        ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid",
	        ".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso",
	        ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"
	    ],
	    initialFrameWidth:'100%' , //初始化编辑器宽度,默认1000
        initialFrameHeight:'100%'  ,//初始化编辑器高度,默认320
	    videoActionName: "uploadvideo", /* 执行上传视频的action名称 */
	    videoFieldName: "imgFile", /* 提交的视频表单名称 */
	    videoMaxSize: 102400000, /* 上传大小限制，单位B，默认100MB */
	    videoAllowFiles: [
	        ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
	        ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"], /* 上传视频格式显示 */
	
	});
	
	
	$('#p').panel({    
		  width:500,    
		  height:150,    
		  title: 'My Panel',  
		  fit:true,
		  tools: [{    
		    iconCls:'icon-save',    
		    handler:function(){saveCheckDesc()}    
		  }]    
	});   
	
	initInfoWin();
	
})
function checkCk(id){
	var ck = document.getElementById("ck_" + id);
	if(ck.checked){
		ck.checked = false;
	}else{
		ck.checked = true;
	}
	
}
function ckFormat(value,row){
	console.log(row)
	if(row.leaf == '1'){
		var v = "";
		if(value){
			v = value;
		}
		var ck = "<input type='text' onclick='ccsck(this,\""+ row.id +"\")' value='" + v + "'  readonly='readonly' style='width:20px;height:20px;padding:0px;margin:0px;line-height:20px;text-align:center;'/>";
		return ck;
	}else{
		return "";
	}
}


function initInfoWin(){
	$("#w").window({
		minimizable:false,
		modal:false,
		closable:false,
		iconCls:'icon-005'
	})
	
	$("#w").window("move",{
		left:430,
		top:140
	});
	
	
}

function ccsck(o,id){
	 var arr = ["x","-","o",""];
	 if($.trim($(o).val()) != ''){
		var loc = findLocInArr(arr, $(o).val()); //查询当前值在元素中的位置
		if (loc == (arr.length -1)) { //为数组最后一个元素
			$(o).val(arr[0]);
		} else { 
			$(o).val(arr[loc + 1]); 
		}
	} else{
		$(o).val(arr[0]);
	}
	$(this).blur();
	
	console.log(tab.datagrid("getSelected"));
	var batchId = tab.datagrid("getSelected").ID;
	//alert(1);
	$.ajax("${ctx}/checklist/checklist!saveCheckResult.do?checklist.id=" + id + "&checklistImplBatch.id=" + batchId + "&checklistImplBatch.checkDesc=" + $(o).val() + "&_r="+Math.random,
		{
			type:"POST",
			success:function(r){
				var str = $.trim(r);
				if(str == "success"){
					showMsg("操作成功");
				}else{
					showMsg("操作失败");
				}
			},
			dataType:"text"
		}
	)
	
}
function showMsg(msg){
	$.messager.show({
		title:"操作提示",
		msg:msg,
		timeout:2000,
		showType:'slide'
	});	
}	

function saveCheckDesc(){
	var batchId = tab.datagrid("getSelected").ID;
	var checkListId = tg.datagrid("getSelected").id;
	//alert(batchId + "|" + checkListId);
	var content =  ue.getContent();
	
	//$.ajax("${ctx}/checklist/checklist!saveCheckDesc.do?checklist.id=" + row.id + "&checklistImplBatch.id=" + batchId + "&_r="+Math.random,
	$.ajax("${ctx}/checklist/checklist!saveCheckDesc.do",
		{
			async:false,
			type:"post",
			data : {
				"checklistImplResult.checklistId":checkListId,
				"checklistImplResult.checkBatch":batchId,
				"checklistImplResult.checkDesc":content
			},
			success:function(r){
				var str = $.trim(r);
				if(str == "success"){
					showMsg("操作成功");
				}else{
					showMsg("操作失败");
				}
			},
			dataType:"text"
		}
	)
}
//查找一个元素在数组中的位置
function findLocInArr(arr, item) {
   if (arr) {
	 var length = arr.length;
	 for (var i = 0; i < length; i++) {
		   if (arr[i] == item) {
			     return i;
			   }
		 }    
   }	 
   return -1;
}
jQuery.fn.extend({  
    ccsck : function(arr){
        if (!arr) {
	        arr = ["x","-","o",""];
        }
    	$(this).attr("readonly","readonly");
        $(this).click(function(){
			if($.trim($(this).val()) != ''){
				var loc = findLocInArr(arr, $(this).val()); //查询当前值在元素中的位置
				if (loc == (arr.length -1)) { //为数组最后一个元素
					$(this).val(arr[0]);
				} else { 
					$(this).val(arr[loc + 1]); 
				}
			} else{
				$(this).val(arr[0]);
			}
		});
		$(this).focus(function(){
			$(this).blur();
		});
    }
});

</script>
	</head>
	<body class="easyui-layout">
		
		
		<div data-options="region:'west',split:true,border:false,width:369" style="padding:1px;overflow:hidden;">
			<table  class="easyui-treegrid" id="tg"></table>
		</div>
		
		<div data-options="region:'center',split:true,border:false" style="padding:1px;">
			<div class="easyui-layout" data-options="fit:true">
				<div data-options="region:'north',height:150,title:'检查项目备注',split:true,border:true" style="padding:1px;">
						<div id="checklistDescDiv">
						</div>
				</div>
				<div data-options="region:'center',split:true,border:false" style="padding:1px;">
					<div id="p" class="easyui-panel" style="background:#fafafa;width:100%;padding:4px;" >   
						<s:textarea name="checklist.cklistContent" id="container"></s:textarea>
					</div>
				</div>
			</div>
		</div>
		
		
		
		<div data-options="region:'east',split:true,width:230,title:'检查批次信息',border:true" style="padding:1px;overflow:hidden;">
			<table id="pg" ></table>
					<!-- 
					<iframe width="100%" height="100%" frameborder="0" id="checkInfoFrame"></iframe>
					 -->
		</div>
		
		
		
		
		<div id="w"  title="检查批次"    style="padding:1px;width:500px;height:500px;overflow:hidden;background:#fff;">
						<table id="dataTable"></table>
					
		</div>
	</body>
</html>