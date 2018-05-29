<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Plan Information</title>
<meta charset="utf-8" />
<%@ include file="../../../pub/pubCssJsForBootstrap.jsp"%>



<style>
/* 点击变颜色 用于bootstrap样式的datatable */
table.table tbody tr.selected {
	background:#32c5d2 !important;
}

.pointer{cursor:pointer;}

/* 第一列的加号图片  */
td.details-control {
	background: url('${ctx}/js/mybootstrap/images/details_open.png') no-repeat center center;
	cursor: pointer;
}
tr.shown td.details-control {
	background: url('${ctx}/js/mybootstrap/images/details_close.png') no-repeat center center;
}

.select2-dropdown {
  background-color: white;
  border: 1px solid #aaa;
  border-radius: 4px;
  box-sizing: border-box;
  display: block;
  position: absolute;
  left: -100000px;
  width: 100%;
  z-index: 999051; }

</style>
<script>
var table;
var prevPlanTab;
var validationTool;
var backlogTab;
var traceTaskTab;
var userWorkLoadTab;
var riskTab;




function riskStatusFormatter(data, type, full, meta){
	if(data == '1'){
		return '已关闭';
	}else{
		return '未关闭';
	}
}

$(function(){
	
	$(".select2").select2({
		//默认文本
		allowClear: true,
		width:"100%"
	});
	
	$('#planStartDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: "month",
		minView: "month",
		forceParse: 0
	});
	
	$('#planFinishDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: "month",
		minView: "month",
		forceParse: 0
	});
	
	$('#blQueryStartDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: "month",
		minView: "month",
		forceParse: 0
	});
	$('#blQueryFinishDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: "month",
		minView: "month",
		forceParse: 0
	});
	
	table =  $('#planList').DataTable( {
		//分页数量
		//lengthMenu: [[11, 25, 50, -1], [11, 25, 50, "All"]],
		//是否排序
	    ordering:  false,
	    //设置水平滚动 (必须设置样式 div.dataTables_wrapper{width:...px;})
	    scrollX:true,
	    //设置垂直滚动
	    //scrollY:"500px",
        scrollCollapse: true,
        //是否自适应宽度
	    //autoWidth:true,
        //默认排序
        //order: [[1, 'asc'],[2, 'desc']],
	    //是否打开左下角信息
	    info:false,
	    //指定行的ID属性
	    rowId:"executionId",
	    //是否允许用户改变表格每页显示的记录数
	    lengthChange:false,
	    //是否开启本地分页
	   //paging:false,
	    //bLengthChange: true, //开关，是否显示一个每页长度的选择条（需要分页器支持）
	    //是否显示处理状态(排序的时候，数据很多耗费时间长的话，也会显示这个)
	    processing:true,
	    //开发服务端模式  服务端模式下如：过滤、分页、排序的处理都放在服务器端进行，否则都在客户端进行
	    serverSide:true,
	    //是否支持当前数据查询
	    searching: false, 
	    paging:false, 
	    //数据ajax请求
	    ajax: {
	    	//后台获取数据地址
	        url:"${ctx}/plan/plan!planListGetData.do",
	        //请求类型
	        type: "POST",
	        data:function(d){
	        	d = {
	        			"planInfo.planCode" : "${planInfo.planCode}",
	        			"projectId":"${projectId}"
	        	}
                return d;
             }
	      },
	    
		//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
        columns: [
            {
	             className:'details-control',
	             data:           null,
	             defaultContent: ''
     	    },
			//{title:"Task Name",width:"60%",name:"taskTitle",data:"taskTitle",defaultContent:"",orderable :false},
            {title:"Task Name",width:"60%",name:"workName",data:"workName",defaultContent:"",orderable :false},
			{title:"Operator",width:"19%",name:"exeUser",data: "exeUser",defaultContent:"" ,orderable :false},
			{title:"Task",width:"7%",name:"currentProcess", data: "currentProcess" ,defaultContent:"" ,orderable :false},
 			{title:"PC",width:"7%",name:"currentProcess", data: "planProgress" ,defaultContent:"" ,orderable :false},
			{title:"AC",width:"7%",name:"currentProcess", data: "finishProgress" ,defaultContent:"" ,orderable :false}
        ]
	 
    } );
	
	
	$('#planList tbody').on('click', 'tr', function () {
		//单选
		if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
        }
	} );
	
	
	$('#planList tbody').on('click', 'td.details-control', function (e) {
	        var tr = $(this).closest('tr');
	        var row = table.row( tr );
	 
	        if ( row.child.isShown() ) {
	            row.child.hide();
	            tr.removeClass('shown');
	        }
	        else {
	        	
	        	var d = row.data();
	            row.child('<iframe src="${ctx}/plan/plan!planTaskDetail.do?id='+d.executionId + '" onload="this.height=this.contentWindow.document.body.scrollHeight;" width="100%" frameborder="0" height="100%"></iframe>').show();
	            tr.addClass('shown');
	        }
	    } );
	
	
	
	
	traceTaskTab =  $('#traceTaskTab').DataTable( {
		//分页数量
		//lengthMenu: [[11, 25, 50, -1], [11, 25, 50, "All"]],
		//是否排序
	    ordering:  false,
	    //设置水平滚动 (必须设置样式 div.dataTables_wrapper{width:...px;})
	    scrollX:true,
	    //设置垂直滚动
	    //scrollY:"500px",
        scrollCollapse: true,
        //是否自适应宽度
	    //autoWidth:true,
        //默认排序
        //order: [[1, 'asc'],[2, 'desc']],
	    //是否打开左下角信息
	    info:false,
	    //指定行的ID属性
	    rowId:"taskId",
	    //是否允许用户改变表格每页显示的记录数
	    lengthChange:false,
	    //是否开启本地分页
	   //paging:false,
	    //bLengthChange: true, //开关，是否显示一个每页长度的选择条（需要分页器支持）
	    //是否显示处理状态(排序的时候，数据很多耗费时间长的话，也会显示这个)
	    processing:true,
	    //开发服务端模式  服务端模式下如：过滤、分页、排序的处理都放在服务器端进行，否则都在客户端进行
	    serverSide:true,
	    //是否支持当前数据查询
	    searching: false, 
	    paging:false, 
	    //数据ajax请求
	    ajax: {
	    	//后台获取数据地址
	        url:"${ctx}/plan/plan!queryTraceTask.do",
	        //请求类型
	        type: "POST",
	        data:function(d){
	        	d = {
	        			//"planInfo.planCode" : "${planInfo.planCode}"
	        			"blQueryStartDate":$("#blQueryStartDate").val(),
	        			"blQueryFinishDate":$("#blQueryFinishDate").val(),
	        			"projectId":"${projectId}"
	        	}
                return d;
             }
	      },
		
		//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
        columns: [
            {title:"模块名称",name:"traceName", data: "traceName" ,width:"50%",defaultContent:"",orderable :false},
            {title:"任务",name:"taskTitle", data: "taskTitle" ,width:"50%",defaultContent:"" ,orderable :false},
        ]
	 
    } );
	
	
	backlogTab =  $('#backlogTab').DataTable( {
		//分页数量
		//lengthMenu: [[11, 25, 50, -1], [11, 25, 50, "All"]],
		//是否排序
	    ordering:  false,
	    //设置水平滚动 (必须设置样式 div.dataTables_wrapper{width:...px;})
	    scrollX:true,
	    //设置垂直滚动
	    //scrollY:"500px",
        scrollCollapse: true,
        //是否自适应宽度
	    //autoWidth:true,
        //默认排序
        //order: [[1, 'asc'],[2, 'desc']],
	    //是否打开左下角信息
	    info:false,
	    //指定行的ID属性
	    rowId:"blId",
	    //是否允许用户改变表格每页显示的记录数
	    lengthChange:false,
	    //是否开启本地分页
	   //paging:false,
	    //bLengthChange: true, //开关，是否显示一个每页长度的选择条（需要分页器支持）
	    //是否显示处理状态(排序的时候，数据很多耗费时间长的话，也会显示这个)
	    processing:true,
	    //开发服务端模式  服务端模式下如：过滤、分页、排序的处理都放在服务器端进行，否则都在客户端进行
	    serverSide:true,
	    //是否支持当前数据查询
	    searching: false, 
	    paging:false, 
	    //数据ajax请求
	    ajax: {
	    	//后台获取数据地址
	        url:"${ctx}/plan/plan!queryBacklog.do",
	        //请求类型
	        type: "POST",
	        data:function(d){
	        	d = {
	        			//"planInfo.planCode" : "${planInfo.planCode}"
	        			"blQueryStartDate":$("#blQueryStartDate").val(),
	        			"blQueryFinishDate":$("#blQueryFinishDate").val(),
	        			"projectId":"${projectId}"
	        	}
                return d;
             }
	      },
	    
		//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
        columns: [
			{title:"本${planClassifyStr}工作内容",name:"blContent",data:"blContent",defaultContent:"",width:"50%",orderable :false},
            {title:"人员",name:"blExeUser", data: "blExeUser" ,width:"25%",defaultContent:"",orderable :false},
            {title:"状态",name:"expireStatus", data: "expireStatus" ,width:"25%",defaultContent:"" ,orderable :false},
        ]
	 
    } );
	
	
	
	userWorkLoadTab =  $('#userWorkLoadTab').DataTable( {
		//分页数量
		//lengthMenu: [[11, 25, 50, -1], [11, 25, 50, "All"]],
		//是否排序
	    ordering:  false,
	    //设置水平滚动 (必须设置样式 div.dataTables_wrapper{width:...px;})
	    scrollX:true,
	    //设置垂直滚动
	    //scrollY:"500px",
        scrollCollapse: true,
        //是否自适应宽度
	    //autoWidth:true,
        //默认排序
        //order: [[1, 'asc'],[2, 'desc']],
	    //是否打开左下角信息
	    info:false,
	    //指定行的ID属性
	    rowId:"blId",
	    //是否允许用户改变表格每页显示的记录数
	    lengthChange:false,
	    //是否开启本地分页
	   //paging:false,
	    //bLengthChange: true, //开关，是否显示一个每页长度的选择条（需要分页器支持）
	    //是否显示处理状态(排序的时候，数据很多耗费时间长的话，也会显示这个)
	    processing:true,
	    //开发服务端模式  服务端模式下如：过滤、分页、排序的处理都放在服务器端进行，否则都在客户端进行
	    serverSide:true,
	    //是否支持当前数据查询
	    searching: false, 
	    paging:false, 
	    //数据ajax请求
	    ajax: {
	    	//后台获取数据地址
	        url:"${ctx}/plan/plan!queryUserlog.do",
	        //请求类型
	        type: "POST",
	        data:function(d){
	        	d = {
	        			//"planInfo.planCode" : "${planInfo.planCode}"
	        			"blQueryStartDate":$("#blQueryStartDate").val(),
	        			"blQueryFinishDate":$("#blQueryFinishDate").val(),
	        			"projectId":"${projectId}"
	        	}
                return d;
             }
	      },
	    
	      
		//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
        columns: [
			{title:"人员",name:"userName",data:"userName",width:"50%",defaultContent:"",orderable :false},
            {title:"工时",name:"workLoad", data: "workLoad" ,width:"50%",defaultContent:"",orderable :false},
        ]
	 
    } );
	
	 
	
	riskTab =  $('#riskTab').DataTable( {
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
		dom:"trip",
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
	    rowId:"RISK_ID",
	    //是否允许用户改变表格每页显示的记录数
	    lengthChange:true,
	    //是否开启本地分页
	    paging:true,
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
	        url:"${ctx}/index/index!plugInRiskGetData.do",
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
	        	d.PROJECT_ID = "${projectId}";
	        	//d.RISK_CONTENT = $("#pluginRiskQueryKey").val();
	            return d;
	        },
	        //错误处理
	        error:function(xhr, textStatus, error){
				alert('获取数据失败');
	        }
	      },
		//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
	        columns: [
	            {name:"Risk",title:"Risk",data: "RISK_CONTENT",defaultContent:"" ,width:'80%',orderable:false},
				{name:"Status",title:"Status",data: "IS_CLOSE",defaultContent:"" ,width:'10%',orderable:false,render:riskStatusFormatter},
				{name:"Project",title:"Project",data: "PROJECT_ID",defaultContent:"" ,width:'10%',orderable:false}
	        ]
	      
	      
	});
	
	$('#riskTab tbody').on('click', 'td', function(){
		var data = riskTab.row(this).data();
		console.log(data);
		//var url = "${ctx}/"+data.FORMKEY+"?jobno=" + data.BUSSINESSKEY + "&taskId=" + data.TASKID + "&procInsId=" + data.PROCINSID;
		//openLayer(data.WORKNAME,url);
		openLayer("项目记事","${ctx}/se/se!seRiskForm.do?seRisk.riskId="+data.RISK_ID);
	});
	
	
	 //$("#prevPlanItemDiv").modal('show');
	 
	 //为防止datatables在未显示摸态窗口时百分比出问题的情况(模态窗口默认不显示的时候是100px，影响了datatable渲染时的宽度)，所以显示摸态窗口事件触发后显示
	 $('#prevPlanItemDiv').on('shown.bs.modal', function (e) {
		 if(!prevPlanTab){
			 prevPlanTab =  $('#prevPlanTab').DataTable( {
					//分页数量
					//lengthMenu: [[11, 25, 50, -1], [11, 25, 50, "All"]],
					//是否排序
				    ordering:  false,
				    //设置水平滚动 (必须设置样式 div.dataTables_wrapper{width:...px;})
				    scrollX:true,
				    //设置垂直滚动
				    //scrollY:"500px",
			        scrollCollapse: true,
			        //是否自适应宽度
				    //autoWidth:true,
			        //默认排序
			        //order: [[1, 'asc'],[2, 'desc']],
				    //是否打开左下角信息
				    info:false,
				    //指定行的ID属性
				    rowId:"executionId",
				    //是否允许用户改变表格每页显示的记录数
				    lengthChange:false,
				    //是否开启本地分页
				   //paging:false,
				    //bLengthChange: true, //开关，是否显示一个每页长度的选择条（需要分页器支持）
				    //是否显示处理状态(排序的时候，数据很多耗费时间长的话，也会显示这个)
				    processing:true,
				    //开发服务端模式  服务端模式下如：过滤、分页、排序的处理都放在服务器端进行，否则都在客户端进行
				    serverSide:true,
				    //是否支持当前数据查询
				    searching: false, 
				    paging:false, 
				    //数据ajax请求
				    ajax: {
				    	//后台获取数据地址
				        url:"${ctx}/plan/plan!planListGetData.do",
				        //请求类型
				        type: "POST",
				        data:function(d){
				        	d = {
				        			"planInfo.planCode" : "${prevPlanInfo.planCode}",
				        			"projectId":"${projectId}"
				        	}
			                return d;
			             }
				      },
				    
					//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
			        columns: [
			            {
				             className:'details-control',
				             data: null,
				             defaultContent: ''
			     	    },
			     	    
						
			     	 //{title:"Task Name",width:"60%",name:"taskTitle",data:"taskTitle",defaultContent:"" ,orderable :false},
			     	   {title:"Task Name",width:"60%",name:"workName",data:"workName",defaultContent:"" ,orderable :false},
			     	   {title:"Operator",width:"20%",name:"exeUser",data: "exeUser",defaultContent:"" ,orderable :false},
			     	   {title:"Percent Complete",width:"20%",name:"currentProcess", data: "currentProcess" ,defaultContent:"" ,orderable :false}
			        ]
			    } );
			 
			 
			 $('#prevPlanTab tbody').on('click', 'td.details-control', function () {
			        var tr = $(this).closest('tr');
			        var row = prevPlanTab.row( tr );
			        var d = row.data();
			        //alert(d.planItemId)
			        //console.log(d);
			  	
			        $.ajax({
					  dataType: "text",
					  url: "${ctx}/plan/plan!copyPlanExecutionToPlanInfo.do",
					  data : {"planExecution.id":d.executionId,"planExecution.planCode":"${planInfo.planCode}"},
					  success: function(data){
						 if($.trim(data)=="SUCCESS"){
							 reloadPrevPlanTable();
						     reloadTable();
						 }else{
							 alert($.trim(data));
						 }
						 
					  },
					  type:"post"
				});
			        
			       
			 });
		 }
	 })
	 
	 
	
	validationTool = $('#planExeItemInfo').formValidation({
        err: {
            container: ''
        },
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	planTitle : {
            	row:'.form-group',//变红色字体的范围容器
            	validators: {
            		notEmpty: {
	                	message: '请填写计划内容'
	                }
                }
            },
            
            
            planStartDate : {
            	row:'.form-group',//变红色字体的范围容器
            	 validators: {
	                    date: {
	                    	format:'YYYY-MM-DD',
	                    	message: '日期格式错误'
	                    }
	                }

            },
            planFinishDate : {
            	row:'.form-group',//变红色字体的范围容器
            	 validators: {
	                    date: {
	                    	format:'YYYY-MM-DD',
	                    	message: '日期格式错误'
	                    }
	                }

            },
            finishProcess : {
            	row:'.form-group',//变红色字体的范围容器
            	 validators: {
	                    lessThan: {
	                        value: 100,
	                        inclusive: true,
	                        message: 'The ages has to be less than 100'
	                    },
	                    greaterThan: {
	                        value: -1,
	                        inclusive: false,
	                        message: 'The ages has to be greater than or equals to 0'
	                    }
	                }

            },
            planProcess : {
             row:'.form-group',//变红色字体的范围容器
           	 validators: {
	                    lessThan: {
	                        value: 100,
	                        inclusive: true,
	                        message: 'The ages has to be less than 100'
	                    },
	                    greaterThan: {
	                        value: -1,
	                        inclusive: false,
	                        message: 'The ages has to be greater than or equals to 0'
	                    }
	                }

           }
            
        }
        
     });
	
	$("#savePlanRemarkResult").hide();
	$("#saveRemarkResult").hide();
	
}) 

function reloadTable(){
	table.ajax.reload(null,false);
}

function reloadPrevPlanTable(){
	prevPlanTab.ajax.reload(null,false);
}

function queryBl(){
	/*d = {
		"blQueryStartDate":$("#blQueryStartDate").val(),
		"blQueryFinishDate":$("#blQueryFinishDate").val()
	}*/
	backlogTab.ajax.reload();
	traceTaskTab.ajax.reload();
	userWorkLoadTab.ajax.reload();
	
}


function showMes(id,status,mess){
	/*$("#" + id).removeClass();
	if(status == "success"){
		$("#" + id).addClass("alert alert-success");
	}else if(status = "danger"){
		$("#" + id).addClass("alert alert-danger");
	}else{
		$("#" + id).addClass("alert alert-info");
	}
	$("#" + id).html(mess);
	$("#"+id).show();
	setTimeout(function(){
		$("#"+id).hide();
	},3000);*/
	
	
	var ico = (status == "success" ? "glyphicon glyphicon-ok-sign" : "glyphicon glyphicon-remove-sign");
	$('#msgDivContent').html("<i class='" + ico + "' ></i> &nbsp;" + mess);
	$('#msgDiv').modal("show");
}


function saveRemarkOfPlanInfo(){
	var planCode = "${planInfo.planCode}";
	//alert(planCode);
	var planRemark = $("#planRemark").val();
	var finishRemark = $("#finishRemark").val();
	var projectProgress = $("#projectProgress").val();
	$.ajax({
		  dataType: "text",
		  url: "${ctx}/plan/plan!saveRemarkOfPlanInfo.do",
		  data : {
			  	"planSummary.planCode":planCode,
			  	"planSummary.planSummary":finishRemark,
			  	"planSummary.planContent":planRemark,
			  	"planSummary.projectProgress":projectProgress,
			  	"projectId":"${projectId}"
		  },
		  success: function(data){
			if($.trim(data) == "SUCCESS"){
				showMes("saveRemarkResult","success","保存成功");
			}else{
				showMes("saveRemarkResult","danger",$.trim(data));
			}
			document.getElementById("saveRemarkBton").removeAttribute("disabled");
		  },
		  type:"post"
	});
}

function getSelected(){
	var data = table.rows('.selected').data();
	if(data.length > 0){
		return data[0];
	}else{
		return null;
	}
}
function setProgress(process){
	var d = getSelected();
	if(!d){
		alert("请选择一条数据");
	}
	$.ajax({
		  dataType: "text",
		  url: "${ctx}/plan/plan!updateProgressOfExecution.do",
		  data : {
			  	"planExecution.id":d.executionId,
			  	"planExecution.finishProgress":process
		  },
		  success: function(data){
			if($.trim(data) == "SUCCESS"){
				reloadTable();
			}else{
				alert(data);
			}
		  },
		  type:"post"
	});	
			
	/*var d = getSelected();
	if(!d){
		alert("请选择一条数据");
	}
	$.ajax({
		  dataType: "text",
		  url: "${ctx}/plan/plan!updatePlanItemProcess.do",
		  data : {
			  	"planExecution.planCode":"${planInfo.planCode}",
			  	"planExecution.planItemId":d.planItemId,
			  	"planExecution.finishProgress":process
		  },
		  success: function(data){
			if($.trim(data) == "SUCCESS"){
				reloadTable();
			}else{
				alert(data);
			}
		  },
		  type:"post"
	});*/
	
	
}

function removeTaskFromExecution(){
	layer.confirm(
		'确定删除吗 ? ',
		{
			btn: ['确定','取消'] //按钮
		}, 
		function(index){
			var d = getSelected();
			if(!d){
				alert("请选择一条数据");
			}
			$.ajax({
				  dataType: "text",
				  url: "${ctx}/plan/plan!removeTaskFromExecution.do",
				  data : {
					  	"planExecution.id":d.executionId,
				  },
				  success: function(data){
					if($.trim(data) == "SUCCESS"){
						reloadTable();
						layer.close(index);
					}else{
						alert(data);
						layer.close(index);
					}
				  },
				  type:"post"
			});	
		} 
		
	);
}


function setV(id,v){
	$("#"+id).val(v);
	validationTool.data("formValidation").revalidateField(id);
	//var validateResult = validationTool.data("formValidation").isValidField("planProcess");
}

function selectTask(){
	
	var url = "${ctx}/se/seRequirementTrace!seRequirementTraceTaskSelect.do?cb=getParent().selectTaskCb&seRequirementTrace.projectId=${projectId}";
	showWin(url);
}

function selectTaskBatch(){
	
	var url = "${ctx}/se/seRequirementTrace!seRequirementTraceTaskSelectBatch.do?cb=getParent().selectTaskBatchCb&seRequirementTrace.projectId=${projectId}";
	showWin(url);
}
	
function selectTaskCb(obj){
	//console.log(obj);
	$("#taskId").val(obj.TASK_ID);
	$("#planTitle").val(obj.TASK_TITLE);
}

function selectTaskBatchCb(rows){
	//console.log(rows);
	var taskIds = "";
	if(rows){
		for(var i = 0 , j = rows.length ; i < j ; i++){
			taskIds += ","+rows[i].TASK_ID;
		}
	}
	if(taskIds != ""){
		taskIds = taskIds.substring(1,taskIds.length);
	}
	//alert(taskIds);
	
	$.ajax({
		  dataType: "text",
		  url: "${ctx}/plan/plan!addTaskToPlan.do",
		  data : {
			  	"planExecution.planCode":"${planInfo.planCode}",
			  	"planExecution.taskId":taskIds
		  },
		  success: function(data){
			if($.trim(data) == "SUCCESS"){
				reloadTable();
			}else{
				alert(data);
			}
		  },
		  type:"post"
	});
	
}

function exportDoc(){
	var url = "plan/plan!createPlanDoc.do?planInfo.planCode=${planInfo.planCode}&projectId=${projectId}"
	window.open(url);
	
}

function startProcess(){
	var d = getSelected();
	
	if(d){
		if(d.taskId){
			var url = "${ctx}/seProcess/seProcess!startTraceTaskProcess.do?key=taskProcess&taskId=" + d.taskId;
			showWin(url);
		}else{
			alert("未找到任务标识");
		}
	}else{
		alert("未选择任务");
	}
}


function savePlanItem(){
	validationTool.data("formValidation").validate();
	var validateResult = validationTool.data("formValidation").isValid();
	if(validateResult){
		var formData = formToJson($("#planExeItemInfo").serializeArray());
		formData.planCode = "${planInfo.planCode}";
		//console.log(formToJson(formData));
		var acceptJson = JSON.stringify(formData);
		//console.log(acceptJson);
		$.ajax({
			  dataType: "text",
			  url: "${ctx}/plan/plan!createPlanItem.do",
			  data: {"acceptJson":acceptJson},
			  success: function(data){
				alert(data)
				document.getElementById("saveBton").removeAttribute("disabled");
				$('#addPlanItemDiv').modal('hide');
				reloadTable();
			  },
			  type:"post",
			  async:false
		});
	}
	document.getElementById("saveBton").removeAttribute("disabled");
}

function downloadDoc(attachId){
	var url = "${ctx}/common/common!commondownload.do?id=" + attachId;
	openWindow({url:url})
	
}
</script>
</head>
<body>
<div class="container-fluid">
<nav class="navbar navbar-default navbar-fixed-bottom" style="background:#5E738B;">
	<div class="row" style="padding:7px 10px 7px;">
		<div class="col-sm-4 text-left">
			
		</div>
		<div class="col-sm-4 text-center">
			<button type="button" class="btn red" onClick="this.disabled='disabled';saveRemarkOfPlanInfo()" id="saveRemarkBton"><i class="glyphicon glyphicon-saved"></i> 保存 </button>
			<button type="button" class="btn red" onclick="exportDoc()"><i class="glyphicon glyphicon-list-alt"></i> 生成计划报告 </button>
			<c:if test="${planSummary.docAttachId != null }">
				<button type="button" class="btn red" onclick="downloadDoc('${planSummary.docAttachId}')"><i class="glyphicon glyphicon-list-alt"></i> 周月报下载 </button>
			</c:if>
		</div>
		<div class="col-sm-4 text-right">
			<button type="button" class="btn green" onclick="document.location.href='${ctx}/plan/plan!planList.do?year=${planInfo.planYear}&projectId=${projectId}'"><i class="glyphicon glyphicon-menu-hamburger"></i> 计划列表</button> 
			<button type="button" class="btn green" onclick="document.location.href='${ctx}/plan/plan!planView.do?planInfo.planCode=${prevPlanInfo.planCode}&projectId=${projectId}'" title="上${planClassifyStr}计划"><i class="glyphicon glyphicon-menu-left"></i></button> 
			<button type="button" class="btn green" onclick="document.location.href='${ctx}/plan/plan!planView.do?planInfo.planCode=${nextPlanInfo.planCode}&projectId=${projectId}'" title="下${planClassifyStr}计划"><i class="glyphicon glyphicon-menu-right"></i></button> 
		</div>
		
	</div>
</nav>


  <div class="row">
    <div class="col-xs-1"></div>
    <div class="col-xs-10" style="padding-top:50px;">
    	<h1 class="text-right">
    	${project.proName }项目    ${planInfo.planYear}.${planInfo.planMonth} 月     <fmt:formatDate value="${planInfo.startDate}" pattern="MM.dd"/> - <fmt:formatDate value="${planInfo.finishDate}" pattern="MM.dd"/>
    	</h1>
      <div class="portlet  light bordered">
        <div class="portlet-title">
          <div class="caption font-green-sharp"> <i class="icon-speech font-green-sharp"></i> <span class="caption-subject bold uppercase"> 本${planClassifyStr }计划及完成情况</span> <span class="caption-helper"><fmt:formatDate value="${planInfo.startDate}" pattern="MM.dd"/> - <fmt:formatDate value="${planInfo.finishDate}" pattern="MM.dd"/></span> </div>
          <div class="actions"> 
          <a href="javascript:;" class="btn btn-circle btn-default btn-sm"  onclick="selectTaskBatch()"> <i class="fa fa-plus"></i> 从任务中批量创建 </a> 
          <!--  
          <a href="javascript:;" class="btn btn-circle btn-default btn-sm"  data-backdrop="true" data-toggle="modal" data-target="#addPlanItemDiv"> <i class="fa fa-plus"></i> 创建计划条目 </a> 
          -->
          <a href="javascript:;" class="btn btn-circle btn-default btn-sm" data-backdrop="true" data-show="true"  data-toggle="modal" data-target="#prevPlanItemDiv"><i class="fa fa-plus"></i> 添加上${planClassifyStr }计划条目 </a> 
          </div>
        </div>
        <div class="text-right">
			<span class="label label-info pointer" onClick="setProgress(25)">25%</span>
			<span class="label label-info pointer" onClick="setProgress(50)">50%</span>
			<span class="label label-info pointer" onClick="setProgress(75)">75%</span>
			<span class="label label-info pointer" onClick="setProgress(100)">100%</span>
			|
			<span class="label label-danger pointer" onClick="removeTaskFromExecution(100)">删除</span>
			|
			<span class="label label-success pointer" onClick="startProcess()">开启流程</span>
       
        </div>
        
        
          <div class="scroller"  data-rail-visible="1" data-rail-color="yellow" data-handle-color="#a1b2bd">
            <table id="planList" class="table table-striped table-hover" cellspacing="0" width="100%"></table>
           
          
          
          <div class="form-body" style="margin-top:20px;">
         	<div class="row">
				<div class="col-sm-6">
					<div class="note note-success">
						<h4><i class="glyphicon glyphicon-tags text-primary"> <b>计划概况</b></i></h4>
						<hr/>
						<div class="form-group form-md-line-input  has-info">
							<textarea class="form-control" rows="10" id="planRemark" ><c:out value="${planSummary.planContent}"></c:out></textarea>
							<label ><b></b></label>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="note note-success">
						<h4><i class="glyphicon glyphicon-tags text-primary"> <b>总结概况</b></i></h4>
						<hr/>
						<div class="form-group form-md-line-input  has-info">
							<textarea class="form-control" rows="10" id="finishRemark" ><c:out value="${planSummary.planSummary}"></c:out></textarea>
							<label ><b></b></label>
						</div>
					</div>
				</div>
			</div>
			
			<form class="form-inline text-right">
					  <div class="form-group">
					    <label class="sr-only " for="exampleInputAmount"></label>
					    <div class="input-group">
					      <div class="input-group-addon">项目整体进度：</div>
					       <input type="text" id="projectProgress" class="form-control" name="projectProgress" value="<c:out value="${planSummary.projectProgress}"></c:out>"/>
					      <div class="input-group-addon ">%</div>
					    </div>
					  </div>
			</form>
			
			<hr/>
			<div class="panel panel-primary">
				<div class="panel-heading">
					Risk
				</div>
				<div class="panel-body">
					<table id="riskTab" class="display compact" cellspacing="0" width="100%"></table>
				</div>
			</div>	

			
			
			<div class="row" style="margin-top:10px;">
				<div class="col-xs-12">
					<div class="alert alert-warning text-center"  id="saveRemarkResult">
					</div>
				</div>
			</div>
			
	        <div class="row">
				<form  class="form-horizontal form-group">  
			    	<div class="col-sm-6">
			    	</div>
			    	<div class="col-sm-5">
				    	<div class="input-group" >
				    	   <span class="input-group-addon">
	                            <i>开始日期</i>
	                        </span>
	                        <input id="blQueryStartDate" name="queryStarthDate" value="${blQueryStartDate }" class="form-control" placeholder="开始日期"/> 
	                        <span class="input-group-addon" style="border-left:0px;border-right:0px;">
	                            <i>结束日期</i>
	                        </span>
	                        <input id="blQueryFinishDate" name="queryFinishDate" value="${blQueryFinishDate }" class="form-control" placeholder="结束日期"/> 
	                    </div>
	                   </div>
	                   <div class="col-sm-1" >
	                   	<button type="button" class="btn blue" onclick="queryBl()">查询 </button>
					</div>
				</form>
			</div>
			<hr/>
			
			<div class="panel panel-primary">
				<div class="panel-heading">
					Trace Task
				</div>
				<div class="panel-body">
					<table id="traceTaskTab" class=" table" cellspacing="0" width="100%" style="width:100%"></table>
				</div>
			</div>
			
			<div class="panel panel-primary">
				<div class="panel-heading">
					Work Load
				</div>
				<div class="panel-body">
					 <table id="userWorkLoadTab" class=" table" cellspacing="0" width="100%" style="width:100%"></table>
				</div>
			</div>	
			
			<div class="panel panel-primary">
				<div class="panel-heading">
					Backlog
				</div>
				<div class="panel-body">
					<table id="backlogTab" class=" table" cellspacing="0" width="100%" style="width:100%"></table>
				</div>
			</div>	
				
	            
	           
	            
	            
	            
			</div>
      	</div>
        </div>
      </div>
      
      <!-- 
      <div class="text-center">
      	<button type="button" class="btn red" onclick="exportDoc()"><i class="fa fa-plus"></i> 生成计划报告 </button>
      </div>
       -->
    </div>
    
    
    
    <c:if test="${planSummary.id != null }">
<s:action name="common!commonFileList" namespace="/common" executeResult="true">
	<s:param name="seAttach.fid" value="#attr.planSummary.id"></s:param>
	<s:param name="seAttach.fkey">PLAN_SUMMARY</s:param>
</s:action>
</c:if>


</div>
 




<div class="modal fade" id="addPlanItemDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel2">计划信息</h4>
      </div>
      <div class="modal-body">
		<form  class="form-horizontal" id="planExeItemInfo">
				<!-- 
				<label class="col-md-3 control-label" for="form_control_1">计划内容</label>
				<div class="col-md-9">
					<input type="text" class="form-control" name="planTitle" id="planTitle" placeholder="">
					<div class="form-control-focus"> </div>
					<span class="help-block"></span>
				</div>
				-->
				<div style="display:none;">
					<input type="text" id="taskId" name="taskId"/>
			    </div>
			       <div class="form-body">
			         	
			       		<div class="form-group">
			               <label class="col-md-2 control-label">Plan Title</label>
			               <div class="col-md-9">
			                   <div class="input-inline">
			                       <div class="input-group">
			                           <input id="planTitle" name="planTitle" class="form-control" placeholder="计划内容"/> 
			                           <span class="input-group-btn">
											<button id="genpassword" class="btn btn-success" type="button" onclick="selectTask()">
											<i class="fa fa-arrow-left fa-fw" /></i> Select</button>
			                            </span>
			                       </div>
			                   </div>
			               </div>
			           </div>
			           
			            <div class="form-group">
			               <label class="col-md-2 control-label">Plan Begin</label>
			               <div class="col-md-9">
			                   <div class="input-inline input-medium">
			                       <div class="input-group">
			                           <input id="planStartDate" name="planStartDate" class="form-control" placeholder="计划开始日期"/> 
			                           <span class="input-group-addon">
			                               <i class="fa fa-calendar"></i>
			                           </span>
			                       </div>
			                   </div>
			                   <span class="help-inline"> 
			                   		计划开始日期
			                   </span>
			               </div>
			           </div>
			           
			           <div class="form-group">
			               <label class="col-md-2 control-label">Plan Finish</label>
			               <div class="col-md-9">
			                   <div class="input-inline input-medium">
			                       <div class="input-group">
			                           <input id="planFinishDate" name="planFinishDate" class="form-control" placeholder="计划完成日期"/> 
			                           <span class="input-group-addon">
			                               <i class="fa fa-calendar"></i>
			                           </span>
			                       </div>
			                   </div>
			                   <span class="help-inline"> 
			                   		计划完成日期
			                   </span>
			               </div>
			           </div>
			           
			           <div class="form-group">
			               <label class="col-md-2 control-label">Exec User</label>
			               <div class="col-md-9">
			                   <div >
			                       <s:select 
									id="exeUser" 
									name="exeUser"  
									multiple="true"
									cssClass="select2"
									list="#request.userList"  
									listKey="value" 
									listValue="text" 
									headerKey="" 
									headerValue="请选择"></s:select> 
			                   </div>
			                   <span class="help-inline"> 
			                   		
			                   </span>
			               </div>
			           </div>
			           <hr/>
					   <div class="form-group">
			               <label class="col-md-2 control-label">Plan %</label>
			               <div class="col-md-9">
			                   <div class="input-inline input-medium">
			                       <div class="input-group">
			                           <input id="planProcess" name="planProcess" class="form-control" placeholder="计划完成百分比"/> 
			                           <span class="input-group-addon">
			                               <i class="fa fa-tachometer"></i>
			                           </span>
			                       </div>
			                   </div>
			                   <span class="help-inline"> 
			                   <span class="label label-default hand" onClick="setV('planProcess','0')">0%</span> 
			                   <span class="label label-danger hand" onClick="setV('planProcess','25')">25%</span> 
			                   <span class="label label-warning hand" onClick="setV('planProcess','50')">50%</span> 
			                   <span class="label label-info hand" onClick="setV('planProcess','75')">75%</span> 
			                   <span class="label label-success hand" onClick="setV('planProcess','100')">100%</span> 
			                   </span>
			               </div>
			           </div>
			           
			           
			           <div class="form-group">
			               <label class="col-md-2 control-label">Act %</label>
			               <div class="col-md-9">
			                   <div class="input-inline input-medium">
			                       <div class="input-group">
			                           <input id="finishProcess" name="finishProcess" class="form-control" placeholder="实际完成百分比"/> 
			                           <span class="input-group-addon">
			                               <i class="fa fa-tachometer"></i>
			                           </span>
			                       </div>
			                   </div>
			                   <span class="help-inline"> 
			                   <span class="label label-default hand" onClick="setV('finishProcess','0')">0%</span> 
			                   <span class="label label-danger hand" onClick="setV('finishProcess','25')">25%</span> 
			                   <span class="label label-warning hand" onClick="setV('finishProcess','50')">50%</span> 
			                   <span class="label label-info hand" onClick="setV('finishProcess','75')">75%</span> 
			                   <span class="label label-success hand" onClick="setV('finishProcess','100')">100%</span> 
			                   </span>
			               </div>
			           </div>
			           
			           <div class="form-group">
			               <label class="col-md-2 control-label">Remark</label>
			               <div class="col-md-9">
			               		<div class="input-inline">
			                       <div class="input-group">
			                           <input id="remark" name="remark" class="form-control" placeholder="备注"/> 
			                           <span class="input-group-addon">
			                               <i class="fa fa-pencil"></i>
			                           </span>
			                       </div>
			                   </div>
			               </div>
			           </div>
			           
			          
			       </div>   
			           
			           
		</form>
			
      </div>
      <div class="modal-footer">
        
        <button type="button" class="btn btn-primary" id="saveBton" onClick="this.disabled='disabled';savePlanItem()" >Save</button>
        
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>






<!-- 上周计划 -->
<div class="modal fade bs-example-modal-lg" id="prevPlanItemDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel3">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel3">上${planClassifyStr}计划</h4>
      </div>
      <div class="modal-body">
	      	<div class="row">
	      	<div class="col-xs-12">
				<table id="prevPlanTab" class=" table" cellspacing="0" width="100%" style="width:100%">
	            </table>
			</div>
			</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div id="msgDiv" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">提示</h4>
      </div>
      <div class="modal-body">
        <p id="msgDivContent" id="msgDivContent" class="text-center" style="font-size:18px;color:#666;">
        	
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>

<div style="height:80px;">
</div>


</body>
</html>
