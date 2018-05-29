<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>


<style>
.paginate_button {margin:0px !important;padding:0px !important;}
</style>
<div class="portlet portlet-sortable box blue-hoki" data-step="13" data-intro="天计划">
<div class="portlet-title">
		<div class="caption">
			<i class="glyphicon glyphicon-list-alt"></i> 天计划 </div>
		<div class="actions">
			
			
			<a href="javascript:;" class="btn btn-default btn-sm" onclick="moreDayPlan()">
				<i class="glyphicon glyphicon-th-list" ></i> More List
			</a>
			<a href="javascript:;"  class="btn btn-default btn-sm" onclick="addNewAdyPlan()">
				<i class="glyphicon glyphicon-plus" ></i> Add 
			</a>
			
			<a href="javascript:;" class="btn btn-default btn-sm" onclick="refreshDayPlanTable()">
				<i class="glyphicon glyphicon-refresh"></i> Refresh 
			</a>

		</div>
	</div>
	<div class="portlet-body portlet-body-self" id="dayPlanPortal">
		<div class="row">
			<div class="col-sm-8">
				<form class="form-inline">
				<button type="button" class="btn btn-info glyphicon glyphicon-chevron-left" onclick="computedDayPlanDate(-1)" title="减一天"></button>
				<input type="text" class="form-control" style="width:100px;" id="dayPlanDate" value="${currentDate}"/>
				<button type="button" class="btn btn-info glyphicon glyphicon-chevron-right" onclick="computedDayPlanDate(1)" title="加一天"></button>
				|
				<button type="button" class="btn btn-info glyphicon glyphicon-remove" onclick="$('#dayPlanDate').val('');refreshDayPlanTable()" title="清空"></button>
				</form>
			</div>
			<div class="col-sm-4">
				<div class="text-right">
					<button type="button" class="btn btn-info glyphicon glyphicon-plus" v-on:click="addSimpleDayPlan()" title="快速添加"></button>
				</div>
			</div>
		</div>
		
		
		<table class="table table-striped table-hover table-condensed">
			<thead>
				<tr>
					<th width="80%">计划内容</th>
					<th width="205%">操作</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="dayPlan in data" >
					
					<td v-if=" '1'!= dayPlan.EDITSTATUS"> <i class="glyphicon glyphicon-info-sign" style="cursor:pointer;" title="详细信息" v-on:click="dayPlanInfo(dayPlan)"></i>  {{ dayPlan.PLAN_CONTENT }}</td>
					<td v-else>
						<input type="text" v-model="dayPlan.PLAN_CONTENT" class="form-control" >
					</td>
					
					<td v-if="'1' != dayPlan.EDITSTATUS"><!-- {{ dayPlan.STATUS }}  -->
						<div  v-if=" '<%=cn.thd.bean.StaticVar.STATUS_UNFINISH%>'== dayPlan.STATUS">
							<i class="glyphicon glyphicon-time" title="置为完成状态" style="cursor:pointer" v-on:click="closesSeDayPlan(dayPlan)"></i>
							<i class="glyphicon glyphicon-pencil" title="编辑" style="cursor:pointer" v-on:click="editSimpleDayPlan(dayPlan)"></i>
							<i class="glyphicon glyphicon-trash" style="cursor:pointer;" title="删除" v-on:click="deleteSeDayPlan(dayPlan)"></i>
						</div>
						
						<div  v-if=" '<%=cn.thd.bean.StaticVar.STATUS_UNFINISH%>'!= dayPlan.STATUS">
							已完成
						</div>
					</td>
					<td v-else>
						<button type="button" class="btn btn-sm btn-info glyphicon glyphicon-ok" v-on:click="saveSimpleDayPlan(dayPlan)" title="保存"></button>
						<button type="button" class="btn btn-sm btn-info glyphicon glyphicon-remove" v-on:click="canelEdit(dayPlan)" title="取消"></button>
					</td>

				</tr>
			</tbody>
		</table>
		
		
		
	</div>
</div>




<script>
$(function(){
	$('#dayPlanDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: "month",
		minView: "month",
		forceParse: 0
	}).on("changeDate", function(e) {
	});
	
	
	
})

$.ajax({
	url:"${ctx}/index/index!plugInDayPlanGetData.do",//请求地址
	method:"post",//提交方式
	async:false,//是否异步
	cache:false,//是否缓存
	data:{USER_ID:"${lui.userId}",PLAN_DATE:"${currentDate}"},
	dataType:"json",//返回数据的格式 xml, json, script, or html
	success:function(d){//回调函数
		initDayPlanTable(d);
	}
})
function refreshDayPlanTable(){
	$.ajax({
		url:"${ctx}/index/index!plugInDayPlanGetData.do",//请求地址
		method:"post",//提交方式
		async:false,//是否异步
		cache:false,//是否缓存
		data:{USER_ID:"${lui.userId}",PLAN_DATE:$("#dayPlanDate").val()},
		dataType:"json",//返回数据的格式 xml, json, script, or html
		success:function(d){//回调函数
			vueModel.data = d.data;
		}
	})
}

var vueModel;

function initDayPlanTable(data){
	vueModel = new Vue({
		el: '#dayPlanPortal',
		data: data,
		methods:{
			addSimpleDayPlan : function(){
				this.data.push({DAY_PLAN_ID:'',PLAN_CONTENT:'',STATUS:'',EDITSTATUS:"1"});
			},
			saveSimpleDayPlan : function(simpleDayPlan){
				//console.log(this.data);
				remoteSaveSimpleDayPlan(simpleDayPlan);
			},
			canelEdit : function(simpleDayPlan){
				simpleDayPlan.EDITSTATUS = '0';
			},
			/*removeSaveSimpleDayPlan : function(id){
				for(var i = 0 , j = this.data.length ; i < j ; i++){
					var simpleDayPlan = this.data[i];
					if(simpleDayPlan.DAY_PLAN_ID == id){
						this.data.splice(i,1);
					}
				}
			},*/
			editSimpleDayPlan : function(simpleDayPlan){
				for(var i = 0 , j = this.data.length ; i < j ; i++){
					var temp = this.data[i];
					if(temp.DAY_PLAN_ID == simpleDayPlan.DAY_PLAN_ID){
						temp.EDITSTATUS = "1";
						return ;
					}
				}
			},
			closesSeDayPlan : function(simpleDayPlan){
				layer.confirm(
					'确认已完成么',
					{
						btn: ['确定','取消'] //按钮
					}, 
					function(index){
						remoteClosesSeDayPlanById(simpleDayPlan)
						layer.close(index);
						
					}, 
					function(){
						
					}
				);
				
			},
			deleteSeDayPlan : function(simpleDayPlan){
				var _this = this;
				layer.confirm(
					'确认删除吗',
					{
						btn: ['删除','取消'] //按钮
					}, 
					function(index){
						
						var dataOrder = -1;
						
						for(var i = 0 , j = _this.data.length ; i < j ; i++){
							var temp = _this.data[i];
							//alert(temp.DAY_PLAN_ID + "|"+  simpleDayPlan.DAY_PLAN_ID);
							if(temp.DAY_PLAN_ID == simpleDayPlan.DAY_PLAN_ID){
								dataOrder = i;
							}
						}
						
						remoteDeleteSeDayPlan(simpleDayPlan);
						//界面移除
						_this.data.splice(dataOrder,1);
						layer.close(index);
						
					}, 
					function(){
						
					}
				);
			},
			dayPlanInfo : function(simpleDayPlan){
				showWin("${ctx}/se/se!seDayPlanForm.do?seDayPlan.dayPlanId=" + simpleDayPlan.DAY_PLAN_ID);
			}
		}
	})
}

function remoteSaveSimpleDayPlan(simpleDayPlan){
	$.ajax({
		url:"${ctx}/se/se!saveSimpleSeDayPlan.do",//请求地址
		method:"post",//提交方式
		async:false,//是否异步
		cache:false,//是否缓存
		data:{"seDayPlan.planContent":simpleDayPlan.PLAN_CONTENT,"seDayPlan.dayPlanId":simpleDayPlan.DAY_PLAN_ID ? simpleDayPlan.DAY_PLAN_ID :""},//可以是字符串也可以是json对象，字符串类似本例子中的内容
		dataType:"json",//返回数据的格式 xml, json, script, or html
		success:function(d){//回调函数
			//alert(d.status);
			simpleDayPlan.EDITSTATUS = '0';
			simpleDayPlan.STATUS = "<%=cn.thd.bean.StaticVar.STATUS_UNFINISH%>"
			simpleDayPlan.DAY_PLAN_ID = d.message;
		}
	})
}


function remoteClosesSeDayPlanById(simpleDayPlan){
	$.ajax({
		url:"${ctx}/se/se!closesSeDayPlanById.do",//请求地址
		method:"post",//提交方式
		async:false,//是否异步
		cache:false,//是否缓存
		data:{"seDayPlan.dayPlanId":simpleDayPlan.DAY_PLAN_ID},//可以是字符串也可以是json对象，字符串类似本例子中的内容
		dataType:"json",//返回数据的格式 xml, json, script, or html
		success:function(d){//回调函数
			simpleDayPlan.EDITSTATUS = '0';
			simpleDayPlan.STATUS = "<%=cn.thd.bean.StaticVar.STATUS_FINISHED%>"
		}
	})
}

function remoteDeleteSeDayPlan(simpleDayPlan){
	$.ajax({
		url:"${ctx}/se/se!deleteSeDayPlanById.do",//请求地址
		method:"post",//提交方式
		async:false,//是否异步
		cache:false,//是否缓存
		data:{"seDayPlan.dayPlanId":simpleDayPlan.DAY_PLAN_ID},//可以是字符串也可以是json对象，字符串类似本例子中的内容
		dataType:"text",//返回数据的格式 xml, json, script, or html
		success:function(d){//回调函数
			
		}
	})
}


function moreDayPlan(){
	showWin("${ctx}/se/se!seDayPlanList.do");
}

function addNewAdyPlan(){
	showWin("${ctx}/se/se!seDayPlanForm.do");
}

Date.prototype.Format = function(fmt){  
    var o = {  
        "M+": this.getMonth() + 1, //月份   
        "d+": this.getDate(), //日   
        "h+": this.getHours(), //小时   
        "m+": this.getMinutes(), //分   
        "s+": this.getSeconds(), //秒   
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
        "S": this.getMilliseconds() //毫秒   
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    for (var k in o)  
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
    return fmt;  
}  

//var date= new Date().Format("yyyy-MM-dd");//Format("输入你想要的时间格式:yyyy-MM-dd,yyyyMMdd")

function computedDayPlanDate(i){
	var dayStr = $("#dayPlanDate").val();
	dayStr = $.trim(dayStr) == "" ? "${currentDate}" : dayStr;
	$("#dayPlanDate").val(dayAdd(dayStr,i));
	refreshDayPlanTable();
} 


//alert(daysJian("2017-01-01"))
</script>