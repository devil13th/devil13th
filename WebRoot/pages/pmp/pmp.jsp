<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>PMP</title>
<meta charset="utf-8"/>
<script src="${ctx}/js/jquery/jquery-1.11.1.min.js"></script>
<script src="${ctx}/js/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

<script src="${ctx}/js/vue/vue.js" type="text/javascript"></script>
<script src="${ctx}/pmp/pmp!queryProcessGroup.do"></script>
<script src="${ctx}/pmp/pmp!queryProcess.do"></script>
<script src="${ctx}/pmp/pmp!queryKnowledgeArea.do"></script>
<script src="${ctx}/pmp/pmp!queryItto.do"></script>

<script src="${ctx}/pmp/pmp!queryProcessIttoRela.do"></script>

<link rel="stylesheet" href="${ctx}/js/bootstrap/css/bootstrap.min.css" type="text/css"/>


</head>
<body >

<div id="vue">
	<table width="100%" class="table">
		<thead>
			<tr>
				<th></th>
				<th v-for="pg in processGroup">{{pg.name}}</th>
			<tr>
		</thead>

		<tbody>
			<tr v-for="ka in knowledgeArea">
				<th>{{ka.name}}</th>
				<td v-for="pg in processGroup">
					<div  v-for=" p in processes(pg.id,ka.id)" >
						<i  class="glyphicon glyphicon-hand-right"></i> 
						<span v-html="p.name" style="cursor:pointer;" v-on:click="showProcessInfo(p.id)"></span>
					</div>
				</td>
			<tr>
		</tbody>
	</table>
</div>









<div class="modal fade" tabindex="-1" role="dialog" id="processInfo">
	<div class="modal-dialog modal-lg" role="document" style="width:90%">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">
					<span class="glyphicon glyphicon-link"></span>
					{{process.name}}
				</h4>
			</div>
			<div class="modal-body">


						
					
					<div class="row">
						<div  class="col-sm-12">
							<div class="panel panel-primary">
								<div class="panel-heading">管理过程</div>
								<div class="panel-body">
									Panel content
								</div>
							</div>
						</div>
					</div>


					<div class="row">
						<div class="col-sm-4">
							<div class="panel panel-primary">
								<div class="panel-heading">输入</div>
								<div class="panel-body">
									<div v-for="ipt in process.inputs" v-on:click="showIttoInfo(ipt.id)">
										{{ipt.name}}
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="panel panel-primary">
								<div class="panel-heading">工具与技术</div>
								<div class="panel-body">
									<div v-for="ipt in process.tools" v-on:click="showIttoInfo(ipt.id)">
										{{ipt.name}}
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="panel panel-primary">
								<div class="panel-heading">输出</div>
								<div class="panel-body">
									<div v-for="ipt in process.outputs" v-on:click="showIttoInfo(ipt.id)">
										{{ipt.name}}
									</div>
								</div>
							</div>
						</div>
					</div>


			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>








<div class="modal fade" tabindex="-1" role="dialog" id="ittoInfo">
	<div class="modal-dialog modal-lg" role="document" style="width:90%">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">
					<span class="glyphicon glyphicon-random"></span>
					{{itto.name}}
				</h4>
			</div>
			<div class="modal-body">
				

				
					<div class="row">
						<div class="col-sm-4">
							<div class="panel panel-primary">
								<div class="panel-heading">输出[{{itto.name}}]的管理过程</div>
								<div class="panel-body">
									<div v-for="ito in itto.outputs">
										{{ito.name}}
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="panel panel-primary">
								<div class="panel-heading">输入中带有[{{itto.name}}]的管理过程</div>
								<div class="panel-body">
									<div v-for="ito in itto.inputs">
										{{ito.name}}
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4">
							<div class="panel panel-primary">
								<div class="panel-heading">工具与技术中带有[{{itto.name}}]的管理过程</div>
								<div class="panel-body">
									<div v-for="ito in itto.tools">
										{{ito.name}}
									</div>
								</div>
							</div>
						</div>
					</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>










<script>


//pmp容器
var PmpObj = function(){
	this.processGroupMap = new Map();
	this.knowledgeAreaMap = new Map();
	this.processMap = new Map();
	this.ittoMap = new Map();
	this.pkMap = new Map();
}


//pmp服务
var PmpService = function(){
	this.pmpObj = new PmpObj();
}


PmpService.prototype = {
	add : function(obj){

		if(!obj.id){
			throw new Error("ID不能为空");
		}
		if(!obj.classify){
			throw new Error("CLASSIFY不能为空");
		}
	
		if(this.getPmpSubObj(obj.id)){
			return ;
		}
		
		if("Process" == obj.classify){
			this.addProcess(obj);
		}else if("ProcessGroup"  == obj.classify){
			this.addProcessGroup(obj);
		}else if("KnowledgeArea"  == obj.classify){
			this.addKnowledgeArea(obj);
		}else if("Itto"  == obj.classify){
			this.addItto(obj);
		}else{
			throw new Error("CLASSIFY值错误");
		}
	},
	addProcessGroup : function(processObj){
		var temp =  new ProcessGroup(processObj);
		this.pmpObj.processGroupMap.set(temp.id,temp);
	},
	addKnowledgeArea : function(processObj){
		var temp =  new KnowledgeArea(processObj);
		this.pmpObj.knowledgeAreaMap.set(temp.id,temp);
	},
	addProcess : function(processObj){
		var temp =  new Process(processObj);
		
		var pg =  this.getPmpSubObj(processObj.processGroupId);
		if(!pg){
			throw new Error("未找到过程组");
		}
		
		var ka = this.getPmpSubObj(processObj.knowledgeAreaId);
		if(!ka){
			throw new Error("未找到知识领域");
		}
		pg.processMap.set(temp.id,temp);
		ka.processMap.set(temp.id,temp);
		
		if(!this.pmpObj.pkMap.get(temp.processGroupId + "-" + temp.knowledgeAreaId)){
			this.pmpObj.pkMap.set(temp.processGroupId + "-" + temp.knowledgeAreaId,[]);
		}
		this.pmpObj.pkMap.get(temp.processGroupId + "-" + temp.knowledgeAreaId).push(temp);
		this.pmpObj.processMap.set(temp.id,temp);
	},
	addItto : function(processObj){
		var temp =  new Itto(processObj);
		this.pmpObj.ittoMap.set(temp.id,temp);
	},
	addProcessIttoRela : function(relaObj){
		var process = this.getPmpSubObj(relaObj.processId);
		var itto = this.getPmpSubObj(relaObj.ittoId);
		var type = relaObj.relaType;

		if(!process){
			throw new Error("未找到管理过程");
		}
		if(!itto){
			throw new Error("未找到输出输出工具或技术[" +  relaObj.ittoId + " | " + relaObj.id + "]");
		}
		if(!type){
			throw new Error("未设置type");
		}

		if("in" == type){
			itto.inputs.push(process);
			process.inputs.push(itto);
		}else if("out" == type){
			itto.outputs.push(process);
			process.outputs.push(itto);
		}else if("tool" == type){
			itto.tools.push(process);
			process.tools.push(itto);
		}else{
			throw new Error("错误的type");
		}
	},
	getPmpSubObj : function(id){
		if(this.pmpObj.processMap.get(id)){
			return this.pmpObj.processMap.get(id);
		}
		if(this.pmpObj.processGroupMap.get(id)){
			return this.pmpObj.processGroupMap.get(id);
		}
		if(this.pmpObj.knowledgeAreaMap.get(id)){
			return this.pmpObj.knowledgeAreaMap.get(id);
		}
		if(this.pmpObj.ittoMap.get(id)){
			return this.pmpObj.ittoMap.get(id);
		}
	}
}



//过程组
var ProcessGroup = function(obj){
	this.id = obj.id;
	this.name = obj.name;
	this.classify = "ProcessGroup";
	this.processMap = new Map();
}


//知识领域
var KnowledgeArea = function(obj){
	this.id = obj.id;
	this.name = obj.name;
	this.classify = "KnowledgeArea";
	this.processMap = new Map();
}

//管理过程
var Process = function(obj){
	this.id = obj.id;
	this.name = obj.name;
	this.classify = "Process";
	
	this.inputs =[];
	this.outputs = [];
	this.tools = [];
	
	this.knowledgeAreaId =  obj.knowledgeAreaId;
	this.processGroupId = obj.processGroupId;
}

//输出输出,工具与技术
var Itto = function(obj){
	this.id = obj.id;
	this.name = obj.name;
	this.classify = "itto";

	this.inputs = [];
	this.outputs = [];
	this.tools = [];
}


var service = new PmpService();

for(var i = 0 , j = processGroupData.length ; i < j ; i++){
	service.add(processGroupData[i]);

}
for(var i = 0 , j = knowledgeAreaData.length ; i < j ; i++){
	service.add(knowledgeAreaData[i]);
}
for(var i = 0 , j = processData.length ; i < j ; i++){
	service.add(processData[i]);
}
for(var i = 0 , j = ittoData.length ; i < j ; i++){
	service.add(ittoData[i]);
}

for(var i = 0 , j = processIttoRelaData.length ; i < j ; i++){
	service.addProcessIttoRela(processIttoRelaData[i]);
}








//alert(service)
//console.log(service.pmpObj.pkMap);
//alert(service.pmpObj.pkMap.get("Initiation-Integration").name);
var vue = new Vue({
	el : "#vue",
	data : {
		processGroup : processGroupData,
		knowledgeArea : knowledgeAreaData,
		process : processData,
		pmpObj : service.pmpObj
	},
	methods : {
		processes : function(pgid,kaid){
			return this.pmpObj.pkMap.get(pgid+"-"+kaid);
		},
		showProcessInfo : function(id){
			//layer.alert(id);


			processInfo.process = this.pmpObj.processMap.get(id);



			$('#processInfo').modal('show');


			//alert(1)
			//console.log(this.pmpObj.processMap.get(id));
			//捕获页
			/*layer.open({
				type: 1,
				shade: 0.5,
				area: ['80%', '80%'],
				title: false, //不显示标题
				content: $('#processInfo'), //捕获的元素
				cancel: function(index){
				
					layer.close(index);
					//this.content.show();
					//layer.msg('捕获就是从页面已经存在的元素上，包裹layer的结构', {time: 5000, icon:6});
				}
			});*/



		}
	}
})


var processInfo = new Vue({
	el:"#processInfo",
	data : {
		process : {
			id:"",
			name:"",
			classify:"",
			inputs:[],
			outputs:[],
			tools:[],
		},
		pmpObj : service.pmpObj
	},
	methods : {
		showIttoInfo : function(id){
			//alert(id);
			ittoInfo.itto  = this.pmpObj.ittoMap.get(id);

			$('#ittoInfo').modal('show');


			//捕获页
			/*layer.open({
				type: 1,
				shade: 0.5,
				area: ['60%', '60%'],
				title: false, //不显示标题
				content: $('#ittoInfo'), //捕获的元素
				cancel: function(index){
					
					layer.close(index);
					//this.content.show();
					//layer.msg('捕获就是从页面已经存在的元素上，包裹layer的结构', {time: 5000, icon:6});
				}
			});*/
		


		}
	}
})


var ittoInfo = new Vue({
	el:"#ittoInfo",
	data : {
		itto : {
			id:"",
			name:"",
			classify:"",
			inputs:[],
			outputs:[],
			tools:[],
		}
	}
	
})
</script>
</body>
</html>