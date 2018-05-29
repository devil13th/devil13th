<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<style>
.paginate_button {margin:0px !important;padding:0px !important;}
</style>
<div class="portlet portlet-sortable light bordered " data-step="4" data-intro="新增功能，开启任务流程后与登录人相关的的待办列表">
	<div class="portlet-title">
		<div class="caption">
			<i class="glyphicon glyphicon-list-alt"></i> <s:text name="common.processTask"></s:text> </div>
		<div class="actions">
			<div class="btn-group">
				<a class="btn btn-sm btn-default" href="javascript:;" data-toggle="dropdown">
					<i class="fa fa-user"></i> <span id="planListType" >我的待办</span>
					<i class="fa fa-angle-down"></i>
				</a>
				<ul class="dropdown-menu pull-right">
						<li>
							<a href="javascript:;"  onclick="changeTodoType('ASSIGN','我派工的工作')">
								<i class="fa fa-pencil"></i> 我派工的工作
							</a>
						</li>
						<li>
							<a href="javascript:;" onclick="changeTodoType('','我的待办')">
								<i class="fa fa-pencil" ></i> 我的待办
							</a>
						</li>
				</ul>
			</div>
			<a href="#" class="btn btn-default btn-sm" onclick="reloadMyTodoTab();return false;">
			<i class="glyphicon glyphicon-refresh"></i> Refresh </a>
		</div>
	</div>
	<div class="portlet-body portlet-body-self">
		<input type="hidden" id="todoType" name="todoType" value=""/>
		<table id="myTodoTab" class="display compact" cellspacing="0" width="100%">
		</table>
	</div>
</div>


<script>
var myTodoTab;

function changeTodoType(tp,tit){
	$("#todoType").val(tp);
	$("#planListType").html(tit);
	reloadMyTodoTab();
}
$(function(){
	myTodoTab =  $('#myTodoTab').DataTable( {
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
	    rowId:"TASKID",
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
	        url:"${ctx}/index/index!plugInMyTodoGetData.do",
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
	        	d.projectId = "${projectId}";
	        	d.todoType = $("#todoType").val();
	            return d;
	        },
	        //错误处理
	        error:function(xhr, textStatus, error){
				alert('获取数据失败');
	        }
	      },
		//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
	        columns: [
	            {name:"WORK NAME",title:"WORK", data: "WORKNAME" ,defaultContent:"",orderable:false },
	            {name:"TASK NAME",title:"STEP",data: "TASKNAME",defaultContent:"" ,orderable:false}
	        ]
	});
	
	$('#myTodoTab tbody').on('click', 'td', function(){
		var data = myTodoTab.row(this).data();
		console.log(data);
		//var url = "${ctx}/"+data.FORMKEY+"?jobno=" + data.BUSSINESSKEY  + "&stepCode=" + data.STEPCODE + "&taskId=" + data.TASKID + "&procInsId=" + data.PROCINSID;
		var url = "${ctx}/"+data.FORMKEY+"?jobno=" + data.BUSSINESSKEY + "&stepCode=" + data.STEPCODE ;
		openLayer(data.WORKNAME,url);
	});
	
})

//刷新
function reloadMyTodoTab(){
	
		/*	
		table.ajax.reload api:
		参数：
		Name:	callback	
		Type:function  Yes - default:null
		Optional: Function which is executed when the data as been reloaded and the table fully redrawn. The function is given a single parameter - the JSON data returned by the server, and expects no return.
		
		Name:	resetPaging	 是否重置分页(从第一页查询)
		Type:boolean Yes - default:true
		Optional:Reset (default action or true) or hold the current paging position (false). A full re-sort and re-filter is performed when this method is called, which is why the pagination reset is the default action.
		*/
	myTodoTab.ajax.reload(null,false);
}


</script>