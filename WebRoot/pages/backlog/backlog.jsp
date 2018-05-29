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
		<script src="${ctx}/js/jquery/jquery.hotkeys.js"></script>
		
		
   		<!-- 编辑器源码文件 -->
   		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
   		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
   		
   		
		<style>
#searchForm * {
	font-size: 12px;
}

#searchForm {
	margin: 0px;
	padding: 0px;
}

#searchTab td{vertical-align:top}

th{text-align:right;}
</style>
<script>
//$(function () {
	//default black bootstrap gray metro
	//var cookieTheme = "default";//这里呢 我们可以将想要更换的主题名称存到cookie中，每次加载时JS操作读取下，这样就可以达到个性化更换主题的目的了，这里我就不详细阐述了
	//var href = "${ctx}/js/easyui/themes/" + cookieTheme + "/easyui.css";
	//$("#easyuiTheme").attr("href", href);
//});



var user_list_setting ={
		url:'${ctx}/common/common!queryUserListJsonStr.do',
		valueField:'USER_ID',
		textField:'USER_NAME'
};

//编辑器2定义
var ue ;

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
	$.cookie('skin',cookieTheme,{expires:30});
	var href = "${ctx}/js/easyui/themes/" + cookieTheme + "/easyui.css";
	//console.info(href);
	
	$("#easyuiTheme").attr("href", href);
}


function initInfo(){
	$("#w").window('open');
	$("#w").window('move',{left:10,top:460});
	$("#w").window('resize',{width:'98%',height:150});
	$("#w").window('expand');
}

function openDynaWin(src){
	$("#dynaWin").window("open");
	document.getElementById("dynaWinIframe").src = src;
}



var winStatus = "open";
function initInfoWin(){
	$("#w").window({
		minimizable:false,
		modal:false,
		iconCls:'icon-005',
		onExpand:function(){
			//alert("eve1:" + winStatus);
			winStatus = "open";
		},
		onCollapse:function(){
			//alert("eve2:" +  winStatus);
			winStatus = "close";
		}
	})
}
function ocWin(){
	//alert("ocWin " + winStatus);
	if(winStatus == "open"){
		$("#w").window('collapse');
	}else{
		initInfo();
		$("#w").window('expand');
	}
}
		
var lastEditIndex ;
var tab;
var dealDateWin;
var fnshDateWin;
//排序字段
var order;
//排序规则  desc asc
var asc;

var dic_bl_status = [ 
	{dicValue:'-1',dicName:'删除'},
	{dicValue:'0',dicName:'已处理'},
	{dicValue:'1',dicName:'未处理'}
];

var dic_bl_classify = {} /*[ 
   	{dicValue:'todo',dicName:'待办'},
   	{dicValue:'note',dicName:'记事'},
   	{dicValue:'log',dicName:'日志'},
   	{dicValue:'leaveover',dicName:'遗留备忘'},
   	{dicValue:'plan',dicName:'工作计划'}
];*/

$.ajax({
	  dataType: "json",
	  url: "${ctx}/common/common!getDicJsonStr.do?sysDicPub.dicClassify=backlog_type",
	  success: function(data){
		  dic_bl_classify = data;
	  },
	  async:false
});


var dic_bl_sys = {}
$.ajax({
	  dataType: "json",
	  url: "${ctx}/common/common!queryProjectListJsonStr.do",
	  success: function(data){
		  dic_bl_sys = data;
		  console.log(dic_bl_sys)
	  },
	  async:false
});




var dic_user_list = {}
$.ajax({
	  dataType: "json",
	  url:'${ctx}/common/common!queryUserListJsonStr.do',
	  success: function(data){
		  dic_user_list = data;
		  //console.log(dic_bl_sys)
	  },
	  async:false
});

function user_list_formatter(value,row,index){
	for(var i = 0 , j = dic_user_list.length ; i < j ; i++){
		if(value == dic_user_list[i].USER_ID){
			return dic_user_list[i].USER_NAME;
		}
	}
}

//alert(dic_bl_classify)

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
		if(row.blClassify == dic_bl_classify[i].dic_id){
			return dic_bl_classify[i].dic_name;
		}
	}
}

function bl_sys_formatter(value,row,index){
	for(var i = 0 , j = dic_bl_sys.length ; i < j ; i++){
		if(row.blSys == dic_bl_sys[i].value){
			return dic_bl_sys[i].text;
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


var dic_bl_classify_combobox_setting ={
	url:'${ctx}/common/common!getDicJsonStr.do?sysDicPub.dicClassify=backlog_type',
	valueField:'dic_id',
	textField:'dic_name'
};
/*
var dic_bl_sys_combobox_setting ={
	url:'${ctx}/common/common!getDicJsonStr.do?sysDicPub.dicClassify=backlog_sys',
	valueField:'dic_id',
	textField:'dic_name'
}*/

var dic_bl_sys_combobox_setting ={
		url:'${ctx}/common/common!queryProjectListJsonStr.do',
		valueField:'value',
		textField:'text'
};



	
$(function(){
	
/*
	$('#tab3').tabs({   
		border:true,   
		fit:true  
	});   
*/

	//分类下拉菜单tip
	$("#classify_tip").tooltip({
		content:'请到字典管理中设置分类的值,字典分类为backlog_type'
	});
	//分类下拉菜单tip
	$("#classify_tip2").tooltip({
		content:'请到字典管理中设置分类的值,字典分类为backlog_sys'
	});
    //分类下拉菜单初始化
	$("#blClassify").combobox(dic_bl_classify_combobox_setting);
	 //所属系统下拉菜单初始化
	$("#blSys").combobox(dic_bl_sys_combobox_setting);
	
	
	//快捷键
	$(document).bind('keydown', 'ctrl+0',function (evt){
		
		/*
		$.getJSON( "${ctx}/backlog/backlog!createBlankBacklog.do?_r=" + Math.random(), function(data) {
			if(data.status == 'success'){
				var row = tab.datagrid('appendRow',data.objJson);
				var index = tab.datagrid('getRowIndex',data.objJson.blId);
				//tab.datagrid('endEdit', lastEditIndex);
				tab.datagrid('beginEdit', index);
				tab.datagrid('selectRow', index);
			}else{
				
				//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
				showMsg("错误信息",data.errMsg);
			}
		});
	    return false;
	    */
	    ocWin();
		//initInfo();
	});
	
	$("#dynaWin").window({
		minimizable:false,
		iconCls:'icon-005',
		width:'95%',
		height:'95%'
	})
	
	$("#dynaWin").window("close");
	
	$('#blStartMin').datebox({
	    onSelect: function(date){
			$('#blStartMax').datebox("setValue",date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
		}
	});
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
	
	
	
	dealDateWin=$('#toDealWin').dialog({
	    title: '请选择参与日期',
	    width: 220,
	    height: 120,
	    closed: true,
	    modal: true ,
	    buttons:[{
			text:'确定',
			handler:function(){
				var d = $("#toDealDate").datebox("getValue");
				if($.trim(d) != ""){
					var row = tab.datagrid("getSelected");
					$.ajax({
						type: "POST",
						url: "${ctx}/backlog/backlog!dealDate.do?_r=" + Math.random(),
						data: {"blNo":row.blId,"bli.blMes":d,"bli.blStatus":1},
						success:function(data){
							if(data.status != 'success'){
								dealDateWin.dialog('close');
								showMsg("提示",data.msg);  
							}else{
								dealDateWin.dialog('close');
								showMsg("提示",'操作成功');  
								loadData("reload"); 
							}
						},
						dataType:"json"
					}); 
					
					
				}else{
					showMsg("提示",'请选择操作日期!');
				}
				
			}
		},{
			text:'取消',
			handler:function(){
				dealDateWin.dialog('close');
		  	}
		}]
	});
	
	
	fnshDateWin=$('#toFnshWin').dialog({
	    title: '请选择完成日期',
	    width: 220,
	    height: 120,
	    closed: true,
	    modal: true ,
	    buttons:[{
			text:'确定',
			handler:function(){
				var d = $("#toFnshDate").datebox("getValue");
				if($.trim(d) != ""){
					var row = tab.datagrid("getSelected");
					$.ajax({
						type: "POST",
						dataType:"json",
						url: "${ctx}/backlog/backlog!toFnshOver.do?_r=" + Math.random(),
						data: {"blNo":row.blId,"bli.blMes":d},
						success:function(data){
							if(data.status != 'success'){
								fnshDateWin.dialog('close');
								showMsg("提示",data.errMsg);  
							}else{
								fnshDateWin.dialog('close');
								showMsg("提示",'操作成功');  
								loadData("reload"); 
							}
						}
					}); 
				}else{
					showMsg("提示",'请选择操作日期!');
				}
				
			}
		},{
			text:'取消',
			handler:function(){
				dealDateWin.dialog('close');
		  	}
		}]
	});
	
	
	
	
	tab = $('#datagridtab').datagrid({ 
		title:'待办列表',
		iconCls:'icon-ok',
		//数据来源
		url:'${ctx}/backlog/backlog!backlogGetData.do?_r=' + Math.random(), 
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
		//行高固定
		nowrap:true,
		//fitColumns:true,  
		//高度 
		//height:350,
		//宽度
		//width:900, 
		//是否分页
		pagination:true,
		//分页信息
		pageSize:15, 
		//每页显示条目下拉菜单
		pageList:[5,10,15,20,100],
		
		pageNumber:1,
		rownumbers:true,//行号 
		//分页工具所在位置
		pagePosition:"bottom",
		
		loadMsg:"正在加载数据,请稍后",
		
		
		
		
		frozenColumns:[[
			{field:'blId',title:'编号',width:100},
			{field:'blSys',width:80,title:'系统',sortable:true,type:"date",editor:{type:'combobox',options:dic_bl_sys_combobox_setting},sortable:true,formatter:bl_sys_formatter},
			{field:'blContent',title:'简述',width:300,editor:{type:'textbox',options:{required:true}}},
			{field:'blClassify',title:'分类',width:80,editor:'validatebox',editor:{type:'combobox',options:dic_bl_classify_combobox_setting},sortable:true,formatter:bl_classify_formatter},
			{field:'expireStatus',title:'期限状态',width:60,formatter:expire_status_formatter},
			{field:'blLevel',title:'级别',width:90,sortable:true,editor:{type:'combobox',options:{valueField:'dicValue',textField:'dicName',data:dic_bl_level}},formatter:bl_level_formatter},
			{field:'blStatus',title:'状态',width:80,editor:{type:'combobox',options:{valueField:'dicValue',textField:'dicName',data:dic_bl_status}},sortable:true,formatter:bl_status_formatter}
		]],
		//不冻结的列
		columns:[[
		    //{field:'expireDate',width:100,title:'期限',sortable:true,editor:'datebox'},
			{field:'expireDate',width:100,title:'期限',sortable:true,editor:'datetimebox'},
			{field:'blIssueUser',width:100,title:'签发',formatter:user_list_formatter,editor:{type:'combobox',options:user_list_setting}},
			{field:'blExeUser',width:100,title:'执行',formatter:user_list_formatter,editor:{type:'combobox',options:user_list_setting}},
			{field:'expireDays',width:80,title:'到期天数',type:"date"},
			{field:'alarmDate',width:70,title:'预警日期',type:"date"},
			{field:'alarmDays',width:45,title:'预警期',editor:'numberbox'},
			{field:'startDate',width:100,title:'开始',sortable:true,editor:'datetimebox'},
			{field:'fnshDate',width:100,title:'结束',sortable:true,editor:'datetimebox'},
			{field:'createDate',width:80,title:'创建',sortable:true,type:"datetimebox"}
				
		]],
		//onBeforeEdit:function(index,data){ 
		//	lastEditIndex = index;
		//},
		//onDblClickRow:function(index,data){
			//tab.datagrid('endEdit', lastEditIndex);
			//tab.datagrid('beginEdit', index);
		//},
		onRowContextMenu:function(e,index,data){
			e.preventDefault();
			tab.datagrid('selectRow',index);
			
			$.ajax({
				type: "POST",
				dataType:"json",
				//url: "${ctx}/backlog/backlog!queryDealToday.do?_r= " + Math.random(),
				url: "${ctx}/backlog/backlog!queryBacklogInfo.do?_r= " + Math.random(),
				data: {blNo:data.blId}, 
				success: function(res) {
					//alert(res);
					//alert(res.blStatus+"|" + res.dealToday);
					if($.trim(res.dealToday)=="true"){
						$("#canelTodayDeal").show();
						$("#todayDeal").hide();
					}else{ 
						$("#todayDeal").show();
						$("#canelTodayDeal").hide();
					}
					
					if($.trim(res.blStatus)=="0"){
						$("#fnshToday").hide();
						$("#toFnsh").hide();
					}else{
						$("#fnshToday").show();
						$("#toFnsh").show();
					}
					$('#mm').menu('show',{
						left: e.pageX-5,
						top: e.pageY-5
					});
				}
			}); 
			
			
			
		},
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
			{
				text:'新增',
				title:'ctrl+a',
				iconCls:'icon-add',
				handler:function(){
					$.getJSON( "${ctx}/backlog/backlog!createBlankBacklog.do?_r=" + Math.random(), function(data) {
						if(data.status == 'success'){
							var row = tab.datagrid('appendRow',data.objJson);
							var index = tab.datagrid('getRowIndex',data.objJson.blId);
							//tab.datagrid('endEdit', lastEditIndex);
							tab.datagrid('beginEdit', index);
							tab.datagrid('selectRow', index);
						}else{
							
							//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
							showMsg("错误信息",data.errMsg);
						}
					});
				}
			},
			{
				text:'快速创建',
				title:'ctrl+t',
				iconCls:'icon-add',
				handler:function(){
					openDynaWin("${ctx}/backlog/backlog!fastCreateBacklog.do");
				}
			},
			
			{
				text:'保存',
				iconCls:'icon-save',
				handler:function(){
					
					var datas = tab.datagrid('getData');
					if(datas.rows.length > 0){
						for(var i = 0 , j = datas.rows.length ; i < j ; i++){
							var b = tab.datagrid('validateRow',i);
							if(!b){
								showMsg("错误信息","数据有误,请修改!");
								return false;
							};
							tab.datagrid('endEdit',i);
						}
					}
				
					var changes = tab.datagrid('getChanges');
					//alert(changes.length);
					if(changes.length >= 1){
						var r = "";
						var ct = 0;
						var res = ""; 
						
						for(var i = 0 , j = changes.length ; i < j ; i++){
							//alert(JSON.stringify(changes[i]));
							
							$.ajax({
							  type: "POST",
							  url: "${ctx}/backlog/backlog!savePerBackInfo.do?_r= " + Math.random(),
							  data: { acceptJson: JSON.stringify(changes[i]), blNo: changes[i].blId},
							  success: function(data) {
									if(data.status != 'success'){
										res += (data.errMsg + ",");
									}
									ct++;
									//alert(ct+"|" + changes.length);
									if(ct == changes.length){
										if(res == ""){
											loadData("reload");
											//$.messager.alert('MESSAGE',' SAVE SUCCESS '  ,'info');
											showMsg("提示",'保存成功');
										}else{
											//$.messager.alert('ERR!','Err Info:[' + res + ']  NOT BE SAVED SUCCESS'  ,'error');
											showMsg("错误信息","Err Info:[" + res + "]  NOT BE SAVED SUCCESS");
										}
									}
									
								},
							  dataType: "json"
							});


							/*$.getJSON( "${ctx}/backlog/backlog!savePerBackInfo.do?acceptJson="+JSON.stringify(changes[i])+ "&blNo=" + changes[i].blId + "&_r= " + Math.random(), function(data) {
								if(data.status != 'success'){
									res += (data.errMsg + ",");
								}
								ct++;
								//alert(ct+"|" + changes.length);
								if(ct == changes.length){
									if(res == ""){
										$.messager.alert('MESSAGE',' SAVE SUCCESS '  ,'info');
									}else{
										$.messager.alert('ERR!','Err Info:[' + res + ']  NOT BE SAVED SUCCESS'  ,'error');
									}
								}
								
							});
							*/
					
						}
						//alert("changed date:"+r);
					}else{
						
						//$.messager.alert('MESSAGE',' SAVE SUCCESS '  ,'info');
						showMsg("提示","保存成功");
					}
				}
			},
			'-',
			{
				text:'编辑模式',
				iconCls:'icon-edit',
				handler:function(){
					var datas = tab.datagrid('getData');
					if(datas.rows.length > 0){
						for(var i = 0 , j = datas.rows.length ; i < j ; i++){
							//var data = datas.rows[i];
							//alert(data.blId);
							tab.datagrid('beginEdit',i);
						}
					}
				}
			},
			{
				text:'查看模式',
				iconCls:'icon-lock',
				handler:function(){
					var datas = tab.datagrid('getData');
					if(datas.rows.length > 0){
						for(var i = 0 , j = datas.rows.length ; i < j ; i++){
							//var data = datas.rows[i];
							//alert(data.blId);
							tab.datagrid('cancelEdit',i);
						}
					}
					
				}
			},
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
			
			'-',
			{
				text:'过期待办',
				iconCls:'icon-err',
				handler:function(){
					clearForm();
					$('#blAlarmStatus').combobox("setValue","2");
					loadData();
				}
			},
			{
				text:'预警待办',
				iconCls:'icon-08',
				handler:function(){
					clearForm();
					$('#blAlarmStatus').combobox("setValue","1");
					loadData();
				}
			},
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
				text:'今日待办',
				iconCls:'icon-tip',
				handler:function(){
					clearForm();
					var d = new Date();
					var vYear = d.getFullYear();
					var vMon = d.getMonth() + 1;
					var vDay = d.getDate();
					s=vYear+"-"+(vMon<10 ? "0" + vMon : vMon)+"-"+(vDay<10 ? "0"+ vDay : vDay);
					$('#blExpireMin').datebox("setValue",s);
					$('#blExpireMax').datebox("setValue",s);
					$('#blStatus').combobox("setValue","1"); 
					loadData(); 
				}
			},
			{
				text:'今日完成',
				iconCls:'icon-05',
				handler:function(){
					clearForm();
					var d = new Date();
					var vYear = d.getFullYear();
					var vMon = d.getMonth() + 1;
					var vDay = d.getDate();
					s=vYear+"-"+(vMon<10 ? "0" + vMon : vMon)+"-"+(vDay<10 ? "0"+ vDay : vDay);
					$('#blFnshMin').datebox("setValue",s);
					$('#blFnshMax').datebox("setValue",s);
					$('#blStatus').combobox("setValue","0");
					loadData();
				}
			},
			{
				text:'今日参与',
				iconCls:'icon-04',
				handler:function(){
					clearForm();
					var d = new Date();
					var vYear = d.getFullYear();
					var vMon = d.getMonth() + 1;
					var vDay = d.getDate();
					s=vYear+"-"+(vMon<10 ? "0" + vMon : vMon)+"-"+(vDay<10 ? "0"+ vDay : vDay);
					$('#dealMin').datebox("setValue",s);
					$('#dealMax').datebox("setValue",s);
					loadData(); 
				}
			},
			'-',
			{
				text:'高级搜索',
				iconCls:'icon-search',
				handler:function(){
					initInfo();
				}
			},
			{
				text:'重置',
				iconCls:'icon-clear',
				handler:function(){
					rst();
				}
			}
		]
	})
	
	/*  编辑器1  已屏蔽 */
	/*
	$('#editor1').ckeditor( {
		height:100 ,
		toolbar: [
			{ name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source','PasteFromWord', 'Undo', 'Redo','Link', 'Unlink', 'Image',  'Table','ShowBlocks','NumberedList', 'BulletedList', 'Outdent', 'Indent', 'Blockquote',  'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock','RemoveFormat', 'Maximize' , 'FontSize', 'TextColor', 'BGColor','Bold', 'Italic'] }
		]
	});
	*/
	
	/* 编辑器2 */
	ue = UE.getEditor('editor2',{
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
        videoActionName: "uploadvideo", /* 执行上传视频的action名称 */
        videoFieldName: "imgFile", /* 提交的视频表单名称 */
        videoMaxSize: 102400000, /* 上传大小限制，单位B，默认100MB */
        videoAllowFiles: [
            ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg",
            ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"], /* 上传视频格式显示 */
        initialFrameWidth:"100%",   //初始化编辑器宽度,默认1000 
        initialFrameHeight:434,  //初始化编辑器高度,默认320
        toolbars: [[
                    'fullscreen', 'source', '|', 'undo', 'redo', '|',
                    'bold', 'italic', 'underline',  'strikethrough',  'removeformat',  'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|',
                    'fontfamily', 'fontsize', '|',
                    'indent', '|',
                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 
                    'link', 'unlink', '|',
                    'simpleupload', 'insertimage','attachment',  'insertframe', 'insertcode', 'template', '|',
                    'horizontal', 'date', 'time', 'spechars', 'snapscreen', 'wordimage', '|',
                    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|',
                    'preview', 'drafts'
                ]]
    });
	
	//皮肤初始化
	setSkin();
	//初始化窗口信息
	initInfoWin();
	//详细信息窗口初始化
	initInfo();
})


/* 编辑器1保存功能 */
/*function saveNote(){
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
}*/

/* 编辑器2 保存功能 */
function saveNote(){
	var row = tab.datagrid("getSelected");
	
	//var editor = CKEDITOR.instances.editor1;
	//var noteStr =  editor.getData();
	
	 var noteStr = ue.getContent();
	//alert(noteStr);
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
/* 编辑器1 加载内容 */
/*
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
*/
/* 编辑器2 加载内容  */
function loadNote(blId){
	$.getJSON( "${ctx}/backlog/backlog!queryNote.do?blNo=" + blId + "&_r= " + Math.random(), function(data) {
		if(data.status == 'success'){
			ue.setContent(data.errMsg, false);
		}else{
			//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
			showMsg("错误信息",data.errMsg);
		}
	});
}



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
	var paramsObj = $("#searchForm").serializeArray();
	console.log(paramsObj);
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

//导出excel
function exportExcel(){
	/*var paramsStr = $("#searchForm").serialize();
	alert(paramsStr);
	window.open("${ctx}/backlog/backlog!backlogGetData.do?_r=" + Math.random() + "&" + paramsStr + "&export=1");
	*/
	$("#searchForm").submit();
}

function clearForm(){
	$("#blContent").textbox("setValue","");
	$("#blLevel").combobox("setValue","");
	$("#blStatus").combobox("setValue","");
	$("#blSys").combobox("setValue","");
	$("#blAlarmStatus").combobox("setValue","");
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




function todayDeal(s){
	var row = tab.datagrid("getSelected");
	$.ajax({
		type: "POST",
		url: "${ctx}/backlog/backlog!dealDate.do?_r=" + Math.random(),
		data: {"blNo":row.blId,"bli.blStatus":s},
		success:function(data){
			if(data.status != 'success'){
				//$.messager.alert('ERR!','Err Info:' + data.errMsg ,'error');
				showMsg("错误信息",data.errMsg);
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

function toDeal(){
	var row = tab.datagrid("getSelected");
	$("#toDealDate").datebox("setValue","");
	dealDateWin.dialog('open');
}

function toFnsh(){
	var row = tab.datagrid("getSelected");
	$("#toFnshDate").datebox("setValue","");
	fnshDateWin.dialog('open');
}


function transfer(){
	var row = tab.datagrid("getSelected");
	$.ajax({
		  dataType: "text",
		  url: "${ctx}/plan/plan!transferBacklogToPlanItem.do",
		  data : {
			  	"ids":row.blId
		  },
		  success: function(data){
			  showMsg("提示",data);
		  },
		  type:"post"
	});
}


</script>
	</head>
	<body class="easyui-layout">
		
		
		
				
				
		<div id="mm" class="easyui-menu" style="width: 120px;">
			<div data-options="iconCls:'icon-edit'" onclick="menuEdit()">
				编辑
			</div>
			<div class="menu-sep"></div>
			<div data-options="iconCls:'icon-04'" id="todayDeal" onclick="todayDeal('1')">
				今日参与  
			</div>
			<div data-options="iconCls:'icon-clear'" id="canelTodayDeal" onclick="todayDeal('0')">
				取消今日参与
			</div>
			<div data-options="iconCls:'icon-05'" id="fnshToday" onclick="fnshOver()">
				今日完成
			</div>
			<div data-options="iconCls:'icon-clear'" id="toFnsh" onclick="toFnsh()">
				某日完成
			</div>
			<div data-options="iconCls:'icon-03'" id="toDeal" onclick="toDeal()"> 
				某日参与
			</div>
			<div class="menu-sep"></div>
			
			<div data-options="iconCls:'icon-redo'" onclick="delayOneDay()">
				展期一天
			</div>
			<div data-options="iconCls:'icon-01'" onclick="menuDelete()">
				删除
			</div>
			<div class="menu-sep"></div>
			<div data-options="iconCls:'icon-add'" onclick="transfer()">
				添加到本周计划
			</div>
		</div>
		<div data-options="region:'east',split:true,width:369,title:'详细信息'" style="padding:1px;overflow:hidden;">
			
						<!-- 编辑器1 -->
						<!-- <textarea class="ckeditor" cols="80" id="editor1" name="editor1" rows="15"></textarea>  -->
						
						<!-- 编辑器2 -->
						<div style=" padding:2px;text-align:right">
						<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveNote()">保存详细信息</a>
          			</div>
						<textarea name="editor2" id="editor2"></textarea>
					
		</div>
		<div data-options="region:'center',border:false">
			<table  id="datagridtab"></table>
		</div>
		
		<div id="toDealWin" style="padding:10px;">
			<input type="text" class="easyui-datebox" id="toDealDate" />
		</div>
		<div id="toFnshWin" style="padding:10px;">
			<input type="text" class="easyui-datetimebox" id="toFnshDate" />
		</div>
		
		
		<div id="dynaWin"  title="快速创建"  style="width:'95%';height:'95%';overflow:hidden;background:#fff;">
			<iframe src="" id="dynaWinIframe" height="100%" width="100%" frameborder="0"></iframe>
		</div>
		
		<div id="w"  title="高级搜索"  style="width:98%;height:150px;overflow:hidden;background:#fff;">
					<form id="searchForm" action="${ctx}/backlog/backlog!backlogGetData.do?export=1"  method="post" target="_blank">
						<table width="100%" id="searchTab">
							<tr>
								<th>
									简述：
								</th>
								<td>
									<input class="easyui-textbox" type="text" id="blContent" name="blContent"
										style="width:100px;" />
								</td>
								<th>
										编号：
									</th>
									<td>
										<input class="easyui-textbox" type="text" name="blId" id="blId"
											style="width: 100px;" />
									</td>
									<th>
										执行人：
									</th>
									<td>
										<input class="easyui-textbox" type="text" name="executer" id="executer"
											style="width: 100px;" />
									</td>
									<th>
										签发人：
									</th>
									<td>
										<input class="easyui-textbox" type="text" name="issuer" id="issuer"
											style="width: 100px;" />
									</td>
									<td colspan="2">
									
									</td>
						
								<th>
									系统：
								</th>
								<td>
									<input type="text"  id="blSys"  name="blSys" style="width:80px;">
									<a href="${ctx}/common/common!sysDicPubList.do" target="_blank"><img src="${ctx}/images/ico/335.gif" id="classify_tip2"/></a>
								</td>
								
								
							
								<th>
									分类：
								</th>
								<td>
									
								<!-- 
									<select id="blClassify" class="easyui-combobox" name="blClassify" style="width:80px;">
									    <option value="">全部</option>
									    <option value="todo">待办</option>
									    <option value="note">记事</option>
									    <option value="log">日志</option>
									</select> -->
									<input type="text"  id="blClassify"  name="blClassify" style="width:80px;">
									<a href="${ctx}/common/common!sysDicPubList.do" target="_blank"><img src="${ctx}/images/ico/335.gif" id="classify_tip"/></a>
								</td>
							
								<th>
									级别：
								</th>
								<td>
									<select id="blLevel" class="easyui-combobox" name="blLevel" style="width:80px;">
									    <option value="">全部</option>
									    <option value="5">非常紧急</option>
									    <option value="4">紧急</option>
									    <option value="3">一般</option>
									    <option value="2">不紧急</option>
									    <option value="1">可忽略</option>
									</select>
								</td>
							
								<th>
									状态：
								</th>
								<td>
									<select id="blStatus" class="easyui-combobox" name="blStatus" style="width:80px;" >
									    <option value="">全部</option>
									    <option value="1">未处理</option>
									    <option value="0">已处理</option>
									    <option value="-1">删除</option>
									</select>
								</td>
							
								<th>
									报警状态：
								</th>
								<td>
									<select id="blAlarmStatus" class="easyui-combobox" name="blAlarmStatus" style="width:80px;">
									    <option value="">无</option>
									    <option value="1">预警</option>
									    <option value="2">过期</option>
									</select>
									
								</td>
							
								
						</tr>
						</table>
						<table width="100%">
							<tr>
									<th width="3%">
										期限：
									</th>
									<td width="17%">
										<input class="easyui-datebox"  type="text" name="blExpireMin"
											id="blExpireMin" style="width: 100px;" />
										<input class="easyui-datebox" type="text" name="blExpireMax"
											id="blExpireMax" style="width: 100px;" />
									</td>
								
									<th width="3%">
										开始：
									</th>
									<td width="17%">
										<input class="easyui-datebox" type="text" name="blStartMin" id="blStartMin"
											style="width: 100px;" />
										<input class="easyui-datebox" type="text" name="blStartMax" id="blStartMax"
											style="width: 100px;" />
									</td>
									<th width="3%">
										结束：
									</th>
									<td width="17%">
										<input class="easyui-datebox" type="text" name="blFnshMin" id="blFnshMin"
											style="width: 100px;" />
										<input class="easyui-datebox" type="text" name="blFnshMax" id="blFnshMax"
											style="width: 100px;" />
									</td>
									<th width="3%">
										创建：
									</th>
									<td width="17%">
										<input class="easyui-datebox" type="text" name="createMin" id="createMin"
											style="width: 100px;" />
										<input class="easyui-datebox" type="text" name="createMax" id="createMax"
											style="width: 100px;" />
									</td>
									<th width="3%">
										参与：
									</th>
									<td width="17%">
										<input class="easyui-datebox" type="text" name="dealMin" id="dealMin"
											style="width: 100px;" />
										<input class="easyui-datebox" type="text" name="dealMax" id="dealMax"
											style="width: 100px;"/> 
									</td>
								</tr>
								<tr>
							
								<th>
									皮肤：
								</th>
								<td>
									<select id="skinSelector" name="skinSelector" style="width:100px;">
									    <option value="default">default</option>
									    <option value="black">black</option>
									    <option value="gray">gray</option>
									    <option value="bootstrap">bootstrap</option>
									    <option value="metro">metro</option>
									    <option value="metro-blue">metro-blue</option>
									    <option value="metro-gray">metro-gray</option>
									    <option value="metro-green">metro-green</option>
									    <option value="metro-orange">metro-orange</option>
									    <option value="metro-red">metro-red</option>
									    <option value="ui-cupertino">ui-cupertino</option>
									    <option value="ui-dark-hive">ui-dark-hive</option>
									    <option value="ui-pepper-grinder">ui-pepper-grinder</option>
									    <option value="ui-sunny">ui-sunny</option>
									</select>
								</td>
								<td colspan="2">
								<a href="#" class="easyui-linkbutton"
										data-options="iconCls:'icon-search'" onclick="loadData()">检索</a>
									<a href="#" class="easyui-linkbutton"
										data-options="iconCls:'icon-clear'" onclick="rst()">重置</a>
									
									<a href="#" class="easyui-linkbutton"
										data-options="iconCls:'icon-excel'" onclick="exportExcel()">导出查询结果</a>
										
									<a href="#" class="easyui-linkbutton"
										data-options="iconCls:'icon-335'" onclick="initInfo()" title="初始化详细信息尺寸"></a>
								</td>
							</tr>
							</table>
						

					</form>
					
				</div>
		
		
	</body>
</html>