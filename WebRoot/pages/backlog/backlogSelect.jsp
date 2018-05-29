<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
	<head>
		<title>待办管理</title>
		<meta charset="utf-8" />
		<%@ include file="../../pub/pubCssJs.jsp"%>
		<script src="${ctx}/js/ckeditor/ckeditor.js"></script>
		<script src="${ctx}/js/ckeditor/adapters/jquery.js"></script>
		<style>
#searchForm * {
	font-size: 12px;
}

#searchForm {
	margin: 0px;
	padding: 0px;
}
</style>
<script>
//$(function () {
	//default black bootstrap gray metro
	//var cookieTheme = "default";//这里呢 我们可以将想要更换的主题名称存到cookie中，每次加载时JS操作读取下，这样就可以达到个性化更换主题的目的了，这里我就不详细阐述了
	//var href = "${ctx}/js/easyui/themes/" + cookieTheme + "/easyui.css";
	//$("#easyuiTheme").attr("href", href);
//});


function setSkin(sk){
	//alert(sk);
	var cookieTheme = "";//这里呢 我们可以将想要更换的主题名称存到cookie中，每次加载时JS操作读取下，这样就可以达到个性化更换主题的目的了，这里我就不详细阐述了
	if(sk){
		cookieTheme = sk;
	}else{
		if( $.cookie('skin')){
			cookieTheme= $.cookie('skin')
			$('#skinSelector').combobox("setValue",cookieTheme); 
		}
	}
	if(cookieTheme == ""){
		cookieTheme = "default";
	}
	$.cookie('skin',cookieTheme);
	var href = "${ctx}/js/easyui/themes/" + cookieTheme + "/easyui.css";
	$("#easyuiTheme").attr("href", href);
}


		
		
var lastEditIndex ;
var tab;
var dealDateWin;
//排序字段
var order;
//排序规则  desc asc
var asc;

var dic_bl_status = [ 
	{dicValue:'-1',dicName:'删除'},
	{dicValue:'0',dicName:'已处理'},
	{dicValue:'1',dicName:'未处理'}
];

var dic_bl_classify = [ 
   	{dicValue:'todo',dicName:'待办'},
   	{dicValue:'note',dicName:'记事'},
   	{dicValue:'log',dicName:'日志'}
];

var dic_bl_level = [
	{dicValue:'5',dicName:"非常紧急"},
	{dicValue:'4',dicName:"紧急"},
	{dicValue:'3',dicName:"正常"},
	{dicValue:'2',dicName:"不紧急"},
	{dicValue:'1',dicName:"无视"}
];

var dic_bl_level_d = [
	{dicValue:'5',dicName:"<span style='color:red;'>非常紧急</span>"},
	{dicValue:'4',dicName:"<span style='color:#cc6600;'>紧急</span>"},
	{dicValue:'3',dicName:"<span style='color:green;'>正常</span>"},
	{dicValue:'2',dicName:"<span style='color:#999933;'>不紧急</span>"},
	{dicValue:'1',dicName:"<span style='color:gray;'>无视</span>"}
];


function bl_status_formatter(value,row,index){
	for(var i = 0 , j = dic_bl_status.length ; i < j ; i++){
		if(row.blStatus == dic_bl_status[i].dicValue){
			return dic_bl_status[i].dicName;
		}
	}
}

function bl_classify_formatter(value,row,index){
	for(var i = 0 , j = dic_bl_classify.length ; i < j ; i++){
		if(row.blClassify == dic_bl_classify[i].dicValue){
			return dic_bl_classify[i].dicName;
		}
	}
}



function bl_level_formatter(value,row,index){
	for(var i = 0 , j = dic_bl_level_d.length ; i < j ; i++){
		if(row.blLevel == dic_bl_level_d[i].dicValue){
			return dic_bl_level_d[i].dicName;
		}
	}
}


function expire_status_formatter(value,row,index){
	if(value == '过期'){
		return " <span style='color:red'>过期</span>";
	}
	if(value == '预警'){
		return " <span style='color:#993300'>预警</span>";
	}
	if(value == '正常'){
		return " <span style='color:green'>正常</span>";
	}
	if(value == '完成'){
		return " <span style='color:blue'>完成</span>";
	}
	if(value == '删除'){
		return " <span style='color:gray'>删除</span>";
	}
} 		

function showMsg(tit,msg){
	
	$.messager.show({
		title:tit,
		msg:msg,
		timeout:2000,
		showType:'slide'
	});	
}	
$(function(){
	
/*
	$('#tab3').tabs({   
		border:true,   
		fit:true  
	});   
*/
	 
	 
	$('#blFnshMin').datebox({
	    onSelect: function(date){
			$('#blFnshMax').datebox("setValue",date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
		}
	});
	$('#dealMin').datebox({
	    onSelect: function(date){
			$('#dealMax').datebox("setValue",date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
		}
	});
	$('#blExpireMin').datebox({
	    onSelect: function(date){
			$('#blExpireMax').datebox("setValue",date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
		}
	});
	$('#createMin').datebox({
	    onSelect: function(date){
			$('#createMax').datebox("setValue",date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
		}
	});
	
	
	
	$("#skinSelector").combobox({
		onSelect:function(v){
			//alert(v.text + "||" + v.value);
			setSkin(v.value);
		}
	});
	setSkin();

	$('#editor1').ckeditor( {
		height:100 ,
		toolbar: [
			{ name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source','PasteFromWord', 'Undo', 'Redo','Link', 'Unlink', 'Image',  'Table','ShowBlocks','NumberedList', 'BulletedList', 'Outdent', 'Indent', 'Blockquote',  'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock','RemoveFormat', 'Maximize' , 'FontSize', 'TextColor', 'BGColor','Bold', 'Italic'] }
		]
	});
	
	
	
	
	
	
	
	tab = $('#datagridtab').datagrid({ 
		title:'待办列表',
		iconCls:'icon-ok',
		//数据来源
		url:'${ctx}/backlog/backlog!backlogGetDate.do?_r=' + Math.random(), 
		//斑马纹
		striped:true,
		//主键字段
		idField:'blId',
		//表单提交方式
		method:"post", 
		//是否只能选择一行
		singleSelect:true,
		checkOnSelect:false,
		selectOnCheck:false,
		//自动宽度
		fit:true,
		
		//fitColumns:true,  
		//高度 
		//height:350,
		//宽度
		//width:900, 
		//是否分页
		pagination:true,
		//分页信息
		pageSize:10, 
		//每页显示条目下拉菜单
		pageList:[5,10,15,20,100],
		
		pageNumber:1,
		rownumbers:true,//行号 
		//分页工具所在位置
		pagePosition:"bottom",
		
		loadMsg:"正在加载数据,请稍后",
		frozenColumns:[[
			{field : 'blId',title : '记录id',checkbox : true,align : 'center'},
			{field:'blClassify',title:'分类',width:80,editor:'validatebox',editor:{type:'combobox',options:{valueField:'dicValue',textField:'dicName',data:dic_bl_classify}},sortable:true,formatter:bl_classify_formatter},
			{field:'expireStatus',title:'期限状态',width:60,formatter:expire_status_formatter},
			{field:'blLevel',title:'级别',width:90,sortable:true,editor:{type:'combobox',options:{valueField:'dicValue',textField:'dicName',data:dic_bl_level}},formatter:bl_level_formatter},
			{field:'blStatus',title:'状态',width:80,editor:'validatebox',editor:{type:'combobox',options:{valueField:'dicValue',textField:'dicName',data:dic_bl_status}},sortable:true,formatter:bl_status_formatter},
			{field:'blContent',title:'简述',width:300,editor:{type:'validatebox',options:{required:true}}},
			
		]],
		//不冻结的列
		columns:[[
			{field:'expireDays',width:80,title:'到期天数',type:"date"},
			{field:'expireDate',width:100,title:'期限',sortable:true,editor:'datebox'},
			{field:'alarmDate',width:80,title:'预警日期',type:"date"},
			{field:'blIssueUser',width:100,title:'签发',editor:'text'},
			{field:'blExeUser',width:100,title:'执行',editor:'text'},
			{field:'alarmDays',width:45,title:'预警期',editor:'numberbox'},
			{field:'startDate',width:100,title:'开始',sortable:true,editor:'datebox'},
			{field:'fnshDate',width:100,title:'结束',sortable:true,editor:'datebox'},
			{field:'createDate',width:80,title:'创建',sortable:true,type:"date"}
			
			
		]],
		//onBeforeEdit:function(index,data){ 
		//	lastEditIndex = index;
		//},
		//onDblClickRow:function(index,data){
			//tab.datagrid('endEdit', lastEditIndex);
			//tab.datagrid('beginEdit', index);
		//},
		
		onClickRow:function(index,data){
			loadNote( data.blId)
				
			/*		
			var tab = $('#tab3').tabs('getTab',0);  // 取得第一个tab
	        $('#tab3').tabs('update', {
	            tab: tab,
	            options: {
	                title: data.blId
	            }
	        });*/
			
		},
		
		
		//工具条
		toolbar:
		[  
			
			
			
			
			/*{
				text:'删除所有内容',
				iconCls:'icon-remove',
				handler:function(){
					
					$.getJSON( "${ctx}/backlog/backlog!removeAll.do?_r=" + Math.random(), function(data) {
						if(data.status == 'success'){
							$.messager.alert('MESSAGE',' REMOVE ALL SUSCESS'  ,'info');
							loadData();
						}else{
							$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
						}
					});
					
				}
			},*/
			
			
			{
				text:'未处理',
				iconCls:'icon-search',
				handler:function(){
					clearForm();
					$('#blStatus').combobox("setValue","1");
					loadData();
				}
			},
			'-',
			{
				text:'今日创建',
				iconCls:'icon-tip',
				handler:function(){
					clearForm();
					var d = new Date();
					var vYear = d.getFullYear();
					var vMon = d.getMonth() + 1;
					var vDay = d.getDate();
					s=vYear+"-"+(vMon<10 ? "0" + vMon : vMon)+"-"+(vDay<10 ? "0"+ vDay : vDay);
					$('#createMin').datebox("setValue",s);
					$('#createMax').datebox("setValue",s);
					loadData(); 
				}
			},
			'-',
			{
				text:'重置',
				iconCls:'icon-clear',
				handler:function(){
					rst();
				}
			}
		]
	})
	
})

var adviceSearchDivClose=true;

function menuEdit(){
	var row = tab.datagrid("getSelected");
	var index = tab.datagrid('getRowIndex',row.blId);
	tab.datagrid('beginEdit', index);
}

function menuDelete(){
	var row = tab.datagrid("getSelected");
	//alert(row.blId);
	
	$.messager.confirm('Confirm','确认删除该条待办么?',function(r){   
	    if (r){   
			$.ajax({
				type: "POST",
				url: "${ctx}/backlog/backlog!deleteBacklog.do?_r= " + Math.random(),
				data: {blNo:row.blId},
				success: function(data) {
					if(data.status != 'success'){
						//alert(data.errMsg);
						showMsg("提示",data.errMsg);
					}else{
						loadData("reload");
					}
				},
				dataType: "json"
			}); 
	    }   
	});  
}

function fnshOver(){
	var row = tab.datagrid("getSelected");
	$.ajax({
		type: "POST",
		url: "${ctx}/backlog/backlog!fnshOver.do?_r= " + Math.random(),
		data: {blNo:row.blId},
		success: function(data) {
			if(data.status != 'success'){
				//alert(data.errMsg);
				showMsg("提示",data.errMsg);
			}else{
				loadData("reload");
			}
		},
		dataType: "json"
	}); 
}

function delayOneDay(){
	var row = tab.datagrid("getSelected");
	$.ajax({
		type: "POST",
		url: "${ctx}/backlog/backlog!delayOneDay.do?_r= " + Math.random(),
		data: {blNo:row.blId},
		success: function(data) {
			if(data.status != 'success'){
				//alert(data.errMsg);
				showMsg("提示",data.errMsg);
			}else{
				loadData("reload");
			}
		},
		dataType: "json"
	}); 
}

function loadData(tp){
	var paramsObj = $("#searchForm").serializeArray()
	var queryObj = {a:Math.random()};
	var str = "";
	for(var i = 0 , j = paramsObj.length ; i < j ; i++){
		queryObj[paramsObj[i].name] = paramsObj[i].value;
		str += (paramsObj[i].name+":" + paramsObj[i].value + "\n")
	}
	if(tp!=null && tp=="reload"){
		tab.datagrid("reload",queryObj);
	}else{
		tab.datagrid("load",queryObj);
	}
}

function clearForm(){
	$("#blContent").textbox("setValue","");
	$("#blStatus").combobox("setValue","");
	$("#blExpireMin").datebox("setValue","");
	$("#blExpireMax").datebox("setValue","");
	$("#blStartMin").datebox("setValue","");
	$("#blStartMax").datebox("setValue","");
	$("#blFnshMin").datebox("setValue","");
	$("#blFnshMax").datebox("setValue","");
	$("#createMin").datebox("setValue","");
	$("#createMax").datebox("setValue","");
	$("#dealMin").datebox("setValue","");
	$("#dealMax").datebox("setValue","");
	$("#executer").textbox("setValue","");
	$("#issuer").textbox("setValue","");
	$("#blId").textbox("setValue","");
}

function rst(){
	clearForm();
	loadData();
}

function loadNote(blId){
	$.getJSON( "${ctx}/backlog/backlog!queryNote.do?&blNo=" + blId + "&_r= " + Math.random(), function(data) {
		if(data.status == 'success'){
			//$("#note").textbox("setValue",data.errMsg);
			//$("#blNo").textbox("setValue",blId);	
			var editor = CKEDITOR.instances.editor1;
			if ( editor.mode == 'wysiwyg' ){
				editor.setData( data.errMsg );
			}
			else{
				alert( 'You must be in WYSIWYG mode!' );
			}
		}else{
			//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
			showMsg("错误信息",data.errMsg);
				
		}
	});
}

function saveNote(){
	var row = tab.datagrid("getSelected");
	
	var editor = CKEDITOR.instances.editor1;
	var noteStr =  editor.getData();
	//var noteStr = $("#note").textbox("getValue");
	//alert(blNo+"|" + note);
	$.ajax({
		type: "POST",
		url: "${ctx}/backlog/backlog!saveOrUpdateNote.do?_r=" + Math.random(),
		data: {blNo:row.blId,note:noteStr},
		success:function(data){
			if(data.status != 'success'){
				//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
				showMsg("错误信息",data.errMsg);
			}else{
				//$.messager.alert('Info','保存成功','info');
				showMsg("提示",'保存成功');
			}
		},
		dataType:"json"
	}); 
}

function todayDeal(s){
	var row = tab.datagrid("getSelected");
	$.ajax({
		type: "POST",
		url: "${ctx}/backlog/backlog!dealDate.do?_r=" + Math.random(),
		data: {"blNo":row.blId,"bli.blStatus":s},
		success:function(data){
			if(data.status != 'success'){
				//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
				showMsg("错误信息",'data.errMsg');
			}else{
				/*$.messager.show({
					title:'提示',
					msg:'操作成功',
					timeout:2000,
					showType:'slide'
				});*/
				showMsg("提示",'操作成功');
				loadData("reload"); 
			}
		},
		dataType:"json"
	}); 
}

function getCheckedIds(){
	var data = tab.datagrid("getChecked");
	var str = ""
	for(var i = 0 , j = data.length ; i < j ; i++){
		//alert(data[i].RECORD_ID);
		str += (data[i].blId + ",");
	};
	if(str != ""){
		str = str.substring(0,str.length - 1);
		return str;
	}else{
		return "";
	}
	
}

function toDeal(){
	var row = tab.datagrid("getSelected");
	$("#toDealDate").datebox("setValue","");
	dealDateWin.dialog('open');
}
</script>
	</head>
	<body>

		



		<div class="easyui-layout" data-options="fit:true"
			style="padding: 2px; margin: 2px;">

			<div class="easyui-layout" id="searchDiv" data-options="fit:true">
				<div data-options="region:'north',split:true,height:72" style="padding:1px;overflow:hidden;">
					<form id="searchForm" style="background:#eee;">
						<table>
							<tr>
								<td>
									简述：
								</td>
								<td>
									<input class="easyui-textbox" type="text" id="blContent" name="blContent"
										style="width: 200px;" />
								</td>
								<td>
									分类：
								</td>
								<td>
									<select id="blClassify" class="easyui-combobox" name="blClassify" style="width:80px;">
									    <option value="">全部</option>
									    <option value="todo">待办</option>
									    <option value="note">记事</option>
									    <option value="log">日志</option>
									</select>
								</td>
								<td>
									状态：
								</td>
								<td>
									<select id="blStatus" class="easyui-combobox" name="blStatus" style="width:80px;">
									    <option value="">全部</option>
									    <option value="1">未处理</option>
									    <option value="0">已处理</option>
									    <option value="-1">删除</option>
									</select>
								</td>
								<td>
									<a href="#" class="easyui-linkbutton"
										data-options="iconCls:'icon-search'" onclick="loadData()">检索</a>
									<a href="#" class="easyui-linkbutton"
										data-options="iconCls:'icon-clear'" onclick="rst()">重置</a>
									<select id="skinSelector" name="skinSelector" style="width:100px;">
									    <option value="default">default</option>
									    <option value="black">black</option>
									    <option value="gray">gray</option>
									    <option value="bootstrap">bootstrap</option>
									    <option value="metro">metro</option>
									</select>
								</td>
							</tr>
						</table>

						

						<div id="searchAdvice"  class="easyui-panel" title="高级检索"
							style="height:56px;margin:1px;border:0px;"
							data-options="noheader:true,iconCls:'icon-search',collapsible:true,style:{borderWidth:0},fit:true">
							<div style="margin:0px;padding:0px;border-top:1px solid #999;border-bottom:1px solid #ccc;"></div>
							<table>
								<tr height="25">
									
									<td>
										创建日期：
									</td>
									<td>
										<input class="easyui-datebox" type="text" name="createMin" id="createMin"
											style="width: 120px;" />
										<input class="easyui-datebox" type="text" name="createMax" id="createMax"
											style="width: 120px;" />
									</td>
								</tr>
								
							</table>
						</div>

					</form>
				</div>

				<div data-options="region:'center',split:true,border:false">
					<table  id="datagridtab"></table>
				</div>

				
	            <div data-options="region:'south',split:true,border:false,height:225">
	            	<div class="easyui-panel" id="blNotePanel" style="padding:1px;" data-options="fit:true" >
						<textarea class="ckeditor" cols="80" id="editor1" name="editor1" rows="15">
						</textarea>
						<div style="text-align:center;margin-top:5px;">
		            		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="alert(getCheckedIds())">确定</a>
		            	</div>
	            	</div>
	            </div>
			
			</div>
		</div>
	</body>
</html>