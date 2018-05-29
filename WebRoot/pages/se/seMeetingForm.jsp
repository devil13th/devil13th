<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		<title>会议</title>
	
<style type="text/css">
/* 点击变颜色 用于bootstrap样式的datatable */
table.table tbody tr.selected {
	background:#32c5d2 !important;
}
.panel-body{background:#e4ecf3;}
.c_blue{color:#09C;}
.table{background:#fff;border:3px solid #fff;}

/* 点击变颜色 用于bootstrap样式的datatable */
table.table tbody tr.selected {
	background:#32c5d2 !important;
}

</style>
<script>
var validationSeMeetingTool;
var meetingItemTab;
var meetingTodoTab;
$(function(){

	$(".select2").select2({
		 //默认文本,placeholder才可以使用allowClear 否则JS报错
		placeholder: 'Select an option',
		allowClear: true,
		width:"100%"
	});

 $('#mettingTime').datetimepicker({
		    language:'zh-CN',
			format:'yyyy-mm-dd hh:ii:ss',
			weekStart: 1,
			todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: "month",
			minView: "hour",
			forceParse: 0
		}).on("changeDate", function(e) {
			 validationSeMeetingTool.data("formValidation").revalidateField("seMeeting.mettingTime");
	    });;


	    
    meetingItemTab =  $('#meetingItemTab').DataTable( {
		/*
		dom属性	字母含义
		
		l - Length changing
		f - Filtering input
		t - The Table!
		i - Information
		p - Pagination
		r - pRocessing
		< and > - div elements
		<"#id" and > - div with an id
		<"class" and > - div with a class
		<"#id.class" and > - div with an id and class
		
		例如
		<"wrapper"flipt>
		表示
		<div class="wrapper">
		    { filter } - 搜索
		    { length } - 每页长度
		    { info } - 总条目数，当前多少页信息
		    { paging } - 分页信息
		    { table } - 表格
		</div>
	
		再例如
		<lf<t>ip>
		表示
		<div>
		    { length }
		    { filter }
		    <div>
		        { table }
		    </div>
		    { info }
		    { paging }
		</div>
		*/
		//dom:"<t>",
		dom:"trp",
		//datables 默认的dom属性
		//dom:"<'row'<'col-sm-6'l><'col-sm-6'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",
		
		//国际化
		//language: {
			//url: "${ctx}/plugins/datatables/en_US.txt"
	    //},
		
		//分页数量
		lengthMenu: [[5, 25, 50, -1], [5, 25, 50, "All"]],
		//是否排序
	    ordering:  true,
	    //设置水平滚动 (必须设置样式 div.dataTables_wrapper{width:...px;})
	    scrollX:true,
	    //设置垂直滚动
	    //scrollY:"500px",
	    scrollCollapse: true,
	    //是否自适应宽度
	    //autoWidth:true,
	    //默认排序
	    order: [[0, 'asc']],
	    //分页样式
	    pagingType:"simple",
	    //是否打开左下角信息
	    info:true,
	    //指定行的ID属性
	    rowId:"ITEM_ID",
	    //是否允许用户改变表格每页显示的记录数
	    lengthChange:true,
	    //是否开启本地分页
	    paging:false,
	    //bLengthChange: true, //开关，是否显示一个每页长度的选择条（需要分页器支持）
	    //是否显示处理状态(排序的时候，数据很多耗费时间长的话，也会显示这个)
	    processing:true,
	    //开发服务端模式  服务端模式下如：过滤、分页、排序的处理都放在服务器端进行，否则都在客户端进行
	    serverSide:true,
	    //是否支持当前数据查询
	    searching: false, 
	    //数据ajax请求
	    ajax: {
	    	//后台获取数据地址
	        url:"${ctx}/se/se!seMeetingRecordForMeetingGetData.do",
	        //请求类型
	        type: "POST",
	        data:function(d){
	           //d这个参数已经加入了分页和排序内容，可在下面内容重新格式化该参数以便后台容易接收
	           
	           //设置查询参数
	        	//var jsonData = $("#theForm").serializeArray();
	        	//d = {};
	         	//设置排序信息
	   		    var columns = d.columns[d.order[0].column].data;
	   		    var dir = d.order[0].dir;
	        	d.orderColumn = columns;
	        	d.dir = dir;
	        	d["seMeetingRecord.itemClassify"] = "<%=StaticVar.MEETING_ITEM%>";
	        	d["seMeetingRecord.meetingCode"] = "${seMeeting.mettingCode}";
	            return d;
	        },
	        //错误处理
	        error:function(xhr, textStatus, error){
				alert('获取数据失败');
	        }
	      },
		//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
	        columns: [
	            {title:'ITEM DESC',name:"ITEM DESC", data: "ITEM_DESC" ,defaultContent:"",orderable:false },
	            {width:100,title:'ITEM ISSUERE',name:"ITEM ISSUERE",data: "ITEM_ISSUER",defaultContent:"" ,orderable:false}
	        ]
	});
    
    
    meetingTodoTab =  $('#meetingTodoTab').DataTable( {
		/*
		dom属性	字母含义
		
		l - Length changing
		f - Filtering input
		t - The Table!
		i - Information
		p - Pagination
		r - pRocessing
		< and > - div elements
		<"#id" and > - div with an id
		<"class" and > - div with a class
		<"#id.class" and > - div with an id and class
		
		例如
		<"wrapper"flipt>
		表示
		<div class="wrapper">
		    { filter } - 搜索
		    { length } - 每页长度
		    { info } - 总条目数，当前多少页信息
		    { paging } - 分页信息
		    { table } - 表格
		</div>
	
		再例如
		<lf<t>ip>
		表示
		<div>
		    { length }
		    { filter }
		    <div>
		        { table }
		    </div>
		    { info }
		    { paging }
		</div>
		*/
		//dom:"<t>",
		dom:"trp",
		//datables 默认的dom属性
		//dom:"<'row'<'col-sm-6'l><'col-sm-6'f>><'row'<'col-sm-12'tr>><'row'<'col-sm-5'i><'col-sm-7'p>>",
		
		//国际化
		//language: {
			//url: "${ctx}/plugins/datatables/en_US.txt"
	    //},
		
		//分页数量
		lengthMenu: [[5, 25, 50, -1], [5, 25, 50, "All"]],
		//是否排序
	    ordering:  true,
	    //设置水平滚动 (必须设置样式 div.dataTables_wrapper{width:...px;})
	    scrollX:true,
	    //设置垂直滚动
	    //scrollY:"500px",
	    scrollCollapse: true,
	    //是否自适应宽度
	    //autoWidth:true,
	    //默认排序
	    order: [[0, 'asc']],
	    //分页样式
	    pagingType:"simple",
	    //是否打开左下角信息
	    info:true,
	    //指定行的ID属性
	    rowId:"ITEM_ID",
	    //是否允许用户改变表格每页显示的记录数
	    lengthChange:true,
	    //是否开启本地分页
	    paging:false,
	    //bLengthChange: true, //开关，是否显示一个每页长度的选择条（需要分页器支持）
	    //是否显示处理状态(排序的时候，数据很多耗费时间长的话，也会显示这个)
	    processing:true,
	    //开发服务端模式  服务端模式下如：过滤、分页、排序的处理都放在服务器端进行，否则都在客户端进行
	    serverSide:true,
	    //是否支持当前数据查询
	    searching: false, 
	    //数据ajax请求
	    ajax: {
	    	//后台获取数据地址
	        url:"${ctx}/se/se!seMeetingRecordForMeetingGetData.do",
	        //请求类型
	        type: "POST",
	        data:function(d){
	           //d这个参数已经加入了分页和排序内容，可在下面内容重新格式化该参数以便后台容易接收
	           
	           //设置查询参数
	        	//var jsonData = $("#theForm").serializeArray();
	        	//d = {};
	         	//设置排序信息
	   		    var columns = d.columns[d.order[0].column].data;
	   		    var dir = d.order[0].dir;
	        	d.orderColumn = columns;
	        	d.dir = dir;
	        	d["seMeetingRecord.itemClassify"] = "<%=StaticVar.MEETING_TODO%>";
	        	d["seMeetingRecord.meetingCode"] = "${seMeeting.mettingCode}";
	            return d;
	        },
	        //错误处理
	        error:function(xhr, textStatus, error){
				alert('获取数据失败');
	        }
	      },
		//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
	        columns: [
	            {title:'ITEM DESC',name:"ITEM DESC", data: "ITEM_DESC" ,defaultContent:"",orderable:false },
	            {width:100,title:'ITEM ISSUERE',name:"ITEM ISSUERE",data: "ITEM_ISSUER",defaultContent:"" ,orderable:false}
	        ]
	});
    
    
    $('#meetingTodoTab tbody').on('dblclick', 'tr', function () {
    	var data = meetingTodoTab.row(this).data();
    	var id = data.ITEM_ID;
    	var url = "${ctx}/se/se!seMeetingRecordForm.do?seMeetingRecord.itemId=" + id ;
    	document.getElementById("addItemFrame").src = url;
    	$('#addItemDiv').modal('show');
    	
	});
    
    $('#meetingItemTab tbody').on('dblclick', 'tr', function () {
    	var data = meetingItemTab.row(this).data();
    	var id = data.ITEM_ID;
    	var url = "${ctx}/se/se!seMeetingRecordForm.do?seMeetingRecord.itemId=" + id ;
    	document.getElementById("addItemFrame").src = url;
    	$('#addItemDiv').modal('show');
    	
	} );
    
    
	    
	    
validationSeMeetingTool = $('#theSeMeetingForm').formValidation({
	err: {
	    container: ''
	   //container: 'popover'
	},
	icon: {
	    valid: 'glyphicon glyphicon-ok',
	    invalid: 'glyphicon glyphicon-remove',
	    validating: 'glyphicon glyphicon-refresh'
	},
	locale:"zh_CN", //国际化
	fields: {
		
		
		"seMeeting.mettingName": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		/*"seMeeting.mettingIntro": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
					    	  max:10000,
		                      message: '长度10000以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMeeting.mettingTime": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMeeting.mettingAddr": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 100,
	                        message: '长度100以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMeeting.mettingEmcee": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMeeting.mettingParticipant": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 200,
	                        message: '长度200以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMeeting.projectId": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 64,
	                        message: '长度64以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMeeting.mettingProcess": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
					    	  max:10000,
		                      message: '长度10000以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},
		"seMeeting.mettingSummary": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max:10000,
	                        message: '长度10000以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		},*/

		"seMeeting.mettingCode": {
			row:'.form-group',//变红色字体的范围容器
	                validators: {
			     stringLength: {
	                        max: 50,
	                        message: '长度50以内'
	                     },
			     notEmpty: {
	                        message: 'The field is required'
	                     }
	                }
		}
		
	}
});


	$("#submitButton").click(function(){
	    	validationSeMeetingTool.data("formValidation").validate();
	    	var validateResult = validationSeMeetingTool.data("formValidation").isValid();
	    	if(validateResult){
	    		//document.getElementById("theSeMeetingForm").submit();
	    		submitMeetingForm();
	    	};
	    	
		
	});
})

function addMeetingRecord(c){
	var url = "${ctx}/se/se!seMeetingRecordForm.do?seMeetingRecord.meetingCode=${seMeeting.mettingCode}&seMeetingRecord.itemClassify=" + c ;
	document.getElementById("addItemFrame").src = url;
}

function reloadMeetingItemTab(){
	meetingItemTab.ajax.reload(null,false);
	meetingTodoTab.ajax.reload(null,false);
}

function submitMeetingForm(){
	var formData = $("#theSeMeetingForm").serialize();
	$.ajax("${ctx}/se/se!seMeetingFormSubmit.do",
		{
			type:"post",
			async:false,
			data:formData,
			success:function(r){
				var str = $.trim(r);
				//alert(str);
				if(str == "SUCCESS"){
					try{
						getParent().reloadDg();
						//window.close();
					}catch(e){
						try{
							parent.reloadMeetingTab();
							//parent.closeLayer(1);
						}catch(e){
							//window.close();
						}
					}
					
					layer.alert(
						'保存成功', 
						{
							skin: 'layui-layer-molv',//样式类名
							closeBtn: 0
						}/*, 
						function(){
							try{
								getParent().reloadDg();
								//window.close();
							}catch(e){
								try{
									parent.reloadMeetingTab();
									//parent.closeLayer(1);
								}catch(e){
									//window.close();
								}
							}
						}*/
					);
				}else{
					alert("保存失败");
				};
				//ue1.setContent(str, false);
			}
		}
	)
	
}

</script>
	</head>

	<body>
<div class="container-fluid">
<h1 class="c_blue">Meeting Information</h1>
<hr/>



<s:form cssClass="form-horizontal" action="se!seMeetingFormSubmit" namespace="/se" method="post" id="theSeMeetingForm">



	<div style="display: none;">
		操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/><br/>
	</div>
	<div class="form-group"  style="display:none;">
		<label class="col-xs-3 control-label">是否删除</label>
		<div class="col-xs-9">
		   <div class="input-inline input-medium">
		       <div class="input-group">
			   <span class="input-group-addon">
			   			<i class="glyphicon glyphicon-console"></i>
			   </span>
			   <input 
				class="form-control" 
				name="seMeeting.isDelete"
				id="isDelete" 
				type="text"
				value="${seMeeting.isDelete}" /> 
			  
		       </div>
		   </div>
		   <span class="help-inline">
		   </span>
		</div>
	</div>
	<div class="form-group" style="display:none;">
		<label class="col-xs-3 control-label">会议CODE</label>
		<div class="col-xs-9">
		   <div class="input-inline input-medium">
		       <div class="input-group">
			   <span class="input-group-addon">
			   			<i class="glyphicon glyphicon-console"></i>
			   </span>
			   <input 
				id="mettingCode"  
				name="seMeeting.mettingCode"
				class="form-control" 
				placeholder="会议CODE"
				value="${seMeeting.mettingCode}"/> 
			</div>
		   </div>
			<span class="help-inline"> 
			</span>
		</div>
	</div>
	
	
	
	
		
<div class="panel panel-primary">
<div class="panel-heading">基本信息</div>
<div class="panel-body" >

  
	<div class="row">
		<div class="col-sm-12">
			<div class="form-group">
				<label class="col-xs-1 control-label">会议名称</label>
				<div class="col-xs-11">
				   <div class="input-inline ">
				       <div class="input-group">
					   <span class="input-group-addon">
					   			<i class="glyphicon glyphicon-console"></i>
					   </span>
					   <input 
				class="form-control" 
				placeholder="会议标题"
				name="seMeeting.mettingName"
				id="mettingName" 
				type="text"
				value="${seMeeting.mettingName}" /> 
					  
				       </div>
				   </div>
				   <span class="help-inline">
				   </span>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">会议时间</label>
				<div class="col-xs-10">
				   <div class="input-inline ">
				       <div class="input-group">
					   <span class="input-group-addon">
					   			<i class="glyphicon glyphicon-calendar"></i>
					   </span>
					   <input 
						class="form-control" 
						name="seMeeting.mettingTime"
						id="mettingTime" 
						type="text"
						value="<fmt:formatDate value="${seMeeting.mettingTime}"  pattern="yyyy-MM-dd HH:mm:ss"/>"  />
					  
				       </div>
				   </div>
				   <span class="help-inline">
				   </span>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">会议地点</label>
				<div class="col-xs-10">
				   <div class="input-inline ">
				       <div class="input-group">
					   <span class="input-group-addon">
					   			<i class="glyphicon glyphicon-console"></i>
					   </span>
					   <input 
						class="form-control" 
						name="seMeeting.mettingAddr"
						id="mettingAddr" 
						type="text"
						value="${seMeeting.mettingAddr}" /> 
				       </div>
				   </div>
				   <span class="help-inline">
				   </span>
				</div>
			</div>
		</div>
	
	</div>
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">会议类型</label>
				<div class="col-xs-10">
					
					<s:select id="mettingType" 
					 name="seMeeting.mettingType"  
					 cssClass="select2 form-control"  
					 list="#request.meetingTypeList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select> 
					 
					 
				</div>
			</div>
		</div>
		
		
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">所属项目</label>
				<div class="col-xs-10">
					
					<s:select id="projectId" 
					 name="seMeeting.projectId"  
					 cssClass="select2 form-control"  
					 list="#request.projectList"  listKey="projectId" listValue="projectName" headerKey="" headerValue="请选择"></s:select> 
					 
					 
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">
			<div class="form-group">
				<label class="col-xs-2 control-label">主持人</label>
				<div class="col-xs-10">
				   <div class="input-inline ">
				       <div class="input-group">
					   <span class="input-group-addon">
					   			<i class="glyphicon glyphicon-console"></i>
					   </span>
					   <input 
						class="form-control" 
						name="seMeeting.mettingEmcee"
						id="mettingEmcee" 
						type="text"
						value="${seMeeting.mettingEmcee}" /> 
					  
				       </div>
				   </div>
				   <span class="help-inline">
				   </span>
				</div>
			</div>
		</div>
		<div class="col-sm-6">
		</div>
	</div>	
	<div class="row">
		<div class="col-sm-12">
			<div class="form-group">
				<label class="col-xs-1 control-label">参会人员</label>
				<div class="col-xs-11">
				   <div class="input-inline ">
				       <div class="input-group">
					   <span class="input-group-addon">
					   			<i class="glyphicon glyphicon-console"></i>
					   </span>
					   <input 
						class="form-control" 
						name="seMeeting.mettingParticipant"
						id="mettingParticipant" 
						type="text"
						value="${seMeeting.mettingParticipant}" /> 
					  
				       </div>
				   </div>
				   <span class="help-inline">
				   </span>
				</div>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label class="col-xs-1 control-label">会议介绍</label>
		<div class="col-xs-11">
			   <textarea 
				class="form-control" 
				name="seMeeting.mettingIntro"
				id="mettingIntro" 
				rows="10"
				 >${seMeeting.mettingIntro}</textarea>
			  
		</div>
	</div>
	<div class="form-group">
		<label class="col-xs-1 control-label">会议议程</label>
		<div class="col-xs-11">
			    <textarea 
				class="form-control" 
				name="seMeeting.mettingProcess"
				id="mettingProcess" 
				rows="10"
				 >${seMeeting.mettingProcess}</textarea>
		</div>
	</div>
</div>
</div>


<div class="panel panel-primary">
<div class="panel-heading">纪要</div>
<div class="panel-body">
	<div class="form-group">
		<label class="col-xs-1 control-label">会议纪要</label>
		<div class="col-xs-11">
			   
			    <textarea 
				class="form-control" 
				name="seMeeting.mettingSummary"
				id="mettingSummary" 
				rows="20"
				 >${seMeeting.mettingSummary}</textarea>
				 
				 
		</div>
	</div>
	
	
	<c:if test="${operate=='update'}">
		<div class="text-right" style="margin-bottom:5px;">
			<a href="javascript:;" class="btn btn-circle btn-default btn-sm"  data-backdrop="true" data-toggle="modal" data-target="#addItemDiv" onclick="addMeetingRecord('<%=StaticVar.MEETING_ITEM%>')"> <i class="fa fa-plus"></i> 添加纪要条目 </a> 
		</div>
		<div class="row">
			<label class="col-xs-1 control-label">会议要点</label>
			<div class="col-xs-11">
				<table id="meetingItemTab" class="table table-condensed table-hover table-striped" cellspacing="0" width="100%"></table>
			</div>
		</div>
		<div class="text-right" style="margin-top:5px;margin-bottom:5px;">
			<input class="btn btn-primary btn-sm" type="button" value="已落实"/>
			<a href="javascript:;" class="btn btn-circle btn-default btn-sm"  data-backdrop="true" data-toggle="modal" data-target="#addItemDiv" onclick="addMeetingRecord('<%=StaticVar.MEETING_TODO%>')"> <i class="fa fa-plus"></i> 添加落实项 </a> 
		</div>
		<div class="row">
			<label class="col-xs-1 control-label">待落实项</label>
			<div class="col-xs-11">
				<table id="meetingTodoTab" class="table table-condensed table-hover table-striped" cellspacing="0" width="100%"></table>
			</div>
		</div>
	</c:if>	
</div>
</div>	
<nav class="navbar navbar-default navbar-fixed-bottom">
  <div class=" text-right container-fluid" style="padding-top:6px;background:#fff;">
		<button type="button" id="submitButton" class="btn btn-primary green-turquoise">Submit</button>
		<button type="button" id="closeButton" class="btn btn-default">Close</button>
  </div>
</nav>			
	

</s:form>

<%-- 
<c:if test="${seMeeting.mettingCode != null }">
<s:action name="common!commonFileList" namespace="/common" executeResult="true">
	<s:param name="seAttach.fid" value="#attr.seMeeting.mettingCode"></s:param>
	<s:param name="seAttach.fkey"><%=StaticVar.ATTACHKEY_SEMEETING%></s:param>
</s:action>
</c:if>
--%>

<c:if test="${seMeeting.mettingCode != null }">
<s:action name="common!commonFileList" namespace="/common" executeResult="true">
	<s:param name="seAttach.fid" value="#attr.seMeeting.mettingCode"></s:param>
	<s:param name="seAttach.fkey"><%=StaticVar.ATTACHKEY_SEMEETING%></s:param>
</s:action>
</c:if>


<!-- 
<div class="row">
	<div class="col-sm-9">
	</div>
	<div class="col-sm-3">
		
		<hr/>
		<h4 class="text-right">相关附件</h4>
		<div style="padding-left:10px;">
			<a href="${ctx}/common/common!commonUploaderBatch.do?seAttach.fid=${seMeeting.mettingCode}&seAttach.fkey=xx" target="_blank">添加</a>
			附件1
			附件2
			附件3
		</div>
	</div>
</div>
 -->

<div class="row" style="height:60px;"></div>


<div class="modal fade bs-example-modal-lg" id="addItemDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel3">创建条目</h4>
      </div>
      <div class="modal-body">
	      	<div class="row">
	      	<div class="col-xs-12">
				<iframe src="" id="addItemFrame" height="450" frameBorder="0" width="100%"></iframe>
			</div>
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

	</body>
</html>
