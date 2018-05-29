<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>人员分组任务列表</title>
<meta charset="utf-8" />
<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
<style>
.f12{font-size:12px;}
td.details-control {
    background: url('${ctx}/js/datatables/images/details_open.png') no-repeat center center;
    cursor: pointer;
}
tr.shown td.details-control {
    background: url('${ctx}/js/datatables/images/details_close.png') no-repeat center center;
}
</style>
<script>
$(function(){
	table =  $('#example').DataTable( {
			//dom:"<'row'<'col-sm-12'tr>><'col-sm-8'p><'col-sm-2'><'col-sm-2'i>",
			//datables 默认的dom属性
			dom:"<'row'<'col-sm-12't>><'row'<'col-sm-5'i><'col-sm-3'l><'col-sm-4'p>>",
			//分页数量
			lengthMenu: [[15, 20, 30], [15, 20, 30]],
			//是否排序
		    ordering:  false,
		    //设置水平滚动 (必须设置样式 div.dataTables_wrapper{width:...px;})
		    scrollX:false,
		    //设置垂直滚动
		    scrollY:false,
	        //scrollCollapse: true,
	        //是否自适应宽度
		    autoWidth:true,
	        //默认排序
	        //order: [[1, 'asc'],[2, 'desc']],
		    //分页样式
		    pagingType:"simple",
		    //是否打开左下角信息
		    //info:true,
		    //指定行的ID属性
		    rowId:"blId",
		    //是否允许用户改变表格每页显示的记录数
		    //lengthChange:true,
		    //是否开启本地分页
		   //paging:false,
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
		        url:"${ctx}/backlog/backlog!backlogForUserGetData.do",
		        //请求类型
		        type: "POST",
		        /* data:function(d){
		           //d这个参数已经加入了分页和排序内容，可在下面内容重新格式化该参数以便后台容易接收
		           
		           //设置查询参数
	            	var jsonData = $("#theForm").serializeArray();
	            	d = {};
	            	
		         	//设置排序信息
	       		    var columns = d.columns[d.order[0].column].data;
	       		    var dir = d.order[0].dir;
	            	d.orderColumn = columns;
	            	d.dir = dir;
	                return d;
	            },*/
		        //错误处理
		        error:ajaxErrHandler
		      },
		    
			//每列对应json数据属性  一定要加入上defaultContent:""配置处理返回的JSON某属性为空的情况
	        columns: [
	            {
		             className:'details-control',
		             orderable:false,
		             data:null,
		             defaultContent: ''
	     	    },
	     	   
	     	    {name:"blExeUser", title:'人员',data: "blExeUserName" ,orderable:false,defaultContent:"", className: "f12"},
	            {name:"Todo", title:'待办',data: "blContent" ,orderable:false,defaultContent:"", className: "f12",render:blContentFormatter},
				{name:"Expire Date", title:'期限',data: "expireDate" ,orderable:false,defaultContent:"" , className: "f12"},
				{name:"Expire", title:'到期',data: "expireDays" ,orderable:false,defaultContent:"" , className: "f12"},
				{name:"Status", title:'状态',data: "expireStatus" ,orderable:false,defaultContent:"" , className: "f12",render:statusFormatter}
				
	        ],
			
	    } );
	
	
	$('#example tbody').on('click', 'td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = table.row( tr );
 
        if ( row.child.isShown() ) {
            // This row is already open - close it
            row.child.hide();
            tr.removeClass('shown');
        }
        else {
            // Open this row
            row.child( formatAdditional(row.data()) ).show();
            tr.addClass('shown');
        }
    } );
	
	function formatAdditional ( d ) {
		var str = "";
		$.ajax({
			dataType: "text",
			url: "${ctx}/backlog/backlog!backlogForUserDetail.do",
			data:{
				"bli.blId":d.blId  
			},
			success: function(data){
				str = data
			},
			async:false
		});
        return  str;
    }
})

function blContentFormatter(data, type, full, meta){
	if("预警" == full.expireStatus){
		return "<i style='color:#F4D03F;' class='glyphicon glyphicon-time'></i> " + data;
	}else if("过期" == full.expireStatus){
		return "<i style='color:#D91E18;' class='glyphicon glyphicon-warning-sign'></i> " + data;
	}else{
		return  data;
	}
}

function statusFormatter( data, type, full, meta ){
	//alert(data);
	//alert(full.blContent)
	if("删除" == $.trim(data)){
		return '<span class="label label-default">' + data + '</span>';
	}
	if("完成" == $.trim(data)){
		return '<span class="label label-success">' + data + '</span>';
	}
	if("正常" == $.trim(data)){
		return '<span class="label label-primary">' + data + '</span>';
	}
	if("预警" == $.trim(data)){
		return '<span class="label label-warning">' + data + '</span>';
	}
	if("过期" == $.trim(data)){
		return '<span class="label label-danger">' + data + '</span>';
	}
}


function ajaxErrHandler( xhr, textStatus, error){
	alert('获取数据失败');
}
</script>
</head>
<body>

<div class="container-fluid">


<div class="panel panel-primary">
	<div class="panel-heading">Task List</div>
	<div class="panel-body">
		<table id="example" class=" table" cellspacing="0" width="100%">
	       
		</table>
	</div>
</div>

</div>
</body>
</html>