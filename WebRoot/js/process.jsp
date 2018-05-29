<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	String ctx = request.getContextPath();
	pageContext.setAttribute("ctx",ctx);
	String serverIp = request.getServerName();
	pageContext.setAttribute("serverIp",serverIp);
	int port = request.getServerPort();
	pageContext.setAttribute("port",port);
	String serverAddr = "http://" + serverIp + ":" + port +  ctx;
	pageContext.setAttribute("serverAddr",serverAddr);
	
%>

var actWorkFlowObj = {
	
	
	//门面函数 上一步
	prev : function(){
		clearProcessMsg();
		var obj = this.save();
		if(obj.status == "SUCCESS"){
			obj = this.saveCustomProcInstVar({k:"goto",v:"back"});
			if(obj.status == "SUCCESS"){
				obj = this.nextStep();
			}
		}
		return obj;
	},
	
	//门面函数 下一步
    next : function(){
    	clearProcessMsg();
    	var obj = this.save();
    	if(obj.status == "SUCCESS"){
    		obj = this.saveProcInstVar();
    		if(obj.status == "SUCCESS"){
	    		obj = this.saveCustomProcInstVar({k:"goto",v:"next"});
		    	if(obj.status == "SUCCESS"){
		    		obj = this.serverValidate();
		        	if(obj.status == "SUCCESS"){
		        		obj = this.nextStep();
		        	}
		    	}
	    	}
    	}
    	return obj;
	},
	
	//门面函数 关闭流程
	close : function(){
		var obj = this.save();
		if(obj.status == "SUCCESS"){
			obj = this.saveCustomProcInstVar({k:"goto",v:"next"});
			if(obj.status == "SUCCESS"){
				obj = this.closeProcess();
			}
		}
		return obj;
	},
	
	//门面函数 保存页面数据
	save : function(){
		var obj = this.pageValidate();
		if(obj.status == "SUCCESS"){
			var r = this.savePageData();
			return r;
		}else{
			return obj;
		}
	},
	
	
	
	//流程扭转 - 粒子操作
	nextStep : function(){
		var obj = {status:"SUCCESS"};
    	$.ajax({
    		url:"${ctx}/seProcess/seProcess!commonNextStep.do",//请求地址
    		method:"post",//提交方式
    		async:false,//是否异步
    		cache:false,//是否缓存
    		data:{
    			//taskId:pmbTaskId
    			jobno:pmbJobno,
    			stepCode:pmbStepCode
    		},//可以是字符串也可以是json对象，字符串类似本例子中的内容
    		dataType:"json",//返回数据的格式 xml, json, script, or html
    		success:function(r){//回调函数
    			obj = r;
    			//showProcessMsg("|" + r.status + "|");
    			if(r.status == "SUCCESS"){
    				showProcessMsg("[成功]流程扭转")
    			}else{
    				showProcessMsg("[失败]流程扭转:" + r.message);
    			};
    		}
    	})
    	return obj;
	},
	
	//流程扭转 - 粒子操作
	closeProcess : function(){
		var obj = {status:"SUCCESS"};
    	$.ajax({
    		url:"${ctx}/seProcess/seProcess!commonCloseProcess.do",//请求地址
    		method:"post",//提交方式
    		async:false,//是否异步
    		cache:false,//是否缓存
    		data:{
    			//taskId:pmbTaskId
    			jobno:pmbJobno,
    			stepCode:pmbStepCode
    		},//可以是字符串也可以是json对象，字符串类似本例子中的内容
    		dataType:"json",//返回数据的格式 xml, json, script, or html
    		success:function(r){//回调函数
    			obj = r;
    			//showProcessMsg("|" + r.status + "|");
    			if(r.status == "SUCCESS"){
    				showProcessMsg("[成功]关闭流程")
    			}else{
    				showProcessMsg("[失败]关闭流程:" + r.message);
    			};
    		}
    	})
    	return obj;
	},
	
	//保存页面数据 函数  - 粒子操作
	savePageData : function(){
		var obj = {status:"SUCCESS"};
    	return obj;
	},

	//前端验证函数  - 粒子操作
	pageValidate : function(){
		var obj = {status:"SUCCESS"};
    	return obj;
	},

	//保存流程变量  - 粒子操作
	saveProcInstVar : function(){
		var obj = {status:"SUCCESS"};
		$.ajax({
			url:"${ctx}/seProcess/seProcess!saveProcInstVar.do",//请求地址
			method:"post",//提交方式
			async:false,//是否异步
			cache:false,//是否缓存
			data:{
				//taskId:pmbTaskId
    			jobno:pmbJobno,
    			stepCode:pmbStepCode
			},//可以是字符串也可以是json对象，字符串类似本例子中的内容
			dataType:"json",//返回数据的格式 xml, json, script, or html
			success:function(r){//回调函数
				obj = r;
				//alert("|" + r.status + "|");
				if(r.status == "SUCCESS"){
					showProcessMsg("[成功]流程变量设置")
				}else{
					showProcessMsg("[失败]流程变量设置:" + r.message);
				};
			}
		})
    	return obj;
	},
	
	
	
	
	//后端验证  - 粒子操作
	serverValidate : function(){
		var obj = {status:"SUCCESS"};
    	$.ajax({
    		url:"${ctx}/seProcess/seProcess!serverValidate.do",//请求地址
    		method:"post",//提交方式
    		async:false,//是否异步
    		cache:false,//是否缓存
    		data:{
    			//taskId:pmbTaskId
    			jobno:pmbJobno,
    			stepCode:pmbStepCode
    		},//可以是字符串也可以是json对象，字符串类似本例子中的内容
    		dataType:"json",//返回数据的格式 xml, json, script, or html
    		success:function(r){//回调函数
    			obj = r;
    			//alert("|" + r.status + "|");
    			if(r.status == "SUCCESS"){
    				showProcessMsg("[成功]后端验证")
    			}else{
    				showProcessMsg("[失败]后端验证:" + r.message);
    			};
    		}
    	})
    	return obj;
	},
	
	//设置流程变量 - 工具方法
	saveCustomProcInstVar : function(varObj){
		var obj = {status:"SUCCESS"};
		$.ajax({
			url:"${ctx}/seProcess/seProcess!customSetProcessInstVar.do",//请求地址
			method:"post",//提交方式
			async:false,//是否异步
			cache:false,//是否缓存
			data:{
				procInsId:pmbProcessInstanceId,
				varKey : varObj.k,
				varValue : varObj.v
			},//可以是字符串也可以是json对象，字符串类似本例子中的内容
			dataType:"json",//返回数据的格式 xml, json, script, or html
			success:function(r){//回调函数
				obj = r;
				//alert("|" + r.status + "|");
				if(r.status == "SUCCESS"){
					showProcessMsg("[成功]流程变量设置")
				}else{
					showProcessMsg("[失败]流程变量设置:" + r.message);
				};
			}
		})
    	return obj;
	},
	
	

};