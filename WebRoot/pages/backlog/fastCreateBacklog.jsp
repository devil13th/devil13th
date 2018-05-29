<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>快速创建遗留备忘</title>
<meta charset="utf-8" />
<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
<style>
.hand{cursor:pointer;}
</style>
<script>
var validationTool;

function showMsg(msg,tit){
	var t = tit ? tit : "Message";
	$.alert({
	    title:t,
	    content:msg,
	    icon: 'fa fa-cogs'
	});
}
$(function(){
	
	$(".select2").select2({
		//默认文本
		placeholder: 'Select an option',
		allowClear: true,
		width:"100%"
	});
	
	$('#blSys').on('change', function (evt) {
		  //alert($(this).val() + "|" + $("option:selected",$(this)).html());
		  var projectId = $(this).val();
		  //alert(projectId);
		  $.ajax({
			  dataType: "json",
			  method : "post",
			  async:false,
			  url:'${ctx}/se/se!queryUserOfprojectForBootstrap.do',
			  data:{projectId:projectId},
			  success: function(data){
				  console.log(data);
				  
				  if(data){
					  $('#blExeUser').html("");
					  $('#blIssueUser').html("");
					  
					  var optStr = "";
					  for(var i = 0 , j = data.length ; i < j ; i++){
						  var opt1 = $("<option></option>");
						  opt1.val(data[i].value);
						  opt1.html(data[i].text);
						  
						  var opt2 = $("<option></option>");
						  opt2.val(data[i].value);
						  opt2.html(data[i].text);
						  
						  $('#blExeUser').append(opt1);
						  $('#blIssueUser').append(opt2);
					  }
					  $('#blExeUser').trigger("change");
					  $('#blIssueUser').trigger("change");
				  }
				  
			  }
		  })
	});
	
	validationTool = $('#defaultForm').formValidation({
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
        	
        	"blIssueUser": {
            	row:'.form-group',//变红色字体的范围容器
                validators: {
                    stringLength: {
                        max: 64,
                        message: '长度64以内'
                    },
                    notEmpty: {
                        message: 'The first name is required'
                    }
                }
            },
            
            
            "blExeUser": {
            	row:'.form-group',//变红色字体的范围容器
                validators: {
                    stringLength: {
                        max: 64,
                        message: '长度64以内'
                    },
                    notEmpty: {
                        message: 'The first name is required'
                    }
                }
            },
            
            "blSys": {
            	row:'.form-group',//变红色字体的范围容器
                validators: {
                    notEmpty: {
                    	 message: 'The first name is required'
                    }
                }
            },
            
            
            "blContent" : {
            	row:'.form-group',//变红色字体的范围容器
            	validators: {
            		notEmpty: {
            			 message: 'The first name is required'
	                }
                }
            }
        }
    });
	
	
	$('#startDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd hh:ii',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 1,
		forceParse: 0
	});
	$('#fnshDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd hh:ii',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 1,
		forceParse: 0
	});
	$('#expireDate').datetimepicker({
	    language:'zh-CN',
		format:'yyyy-mm-dd 23:59',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	});
	
	 $(".submitButton").click(function(){
	    	validationTool.data("formValidation").validate();
	    	var validateResult = validationTool.data("formValidation").isValid();
	    	if(validateResult){
	    		var formData = $("#defaultForm").serializeArray();
	    		//console.log(formToJson(formData));
	    		var acceptJson = JSON.stringify(formToJson(formData));
	    		console.log(acceptJson);
	    		$.ajax({
						type: "POST",
						url: "${ctx}/backlog/backlog!fastCreateBacklogSave.do",
						data: {"acceptJson":acceptJson},
						success:function(data){
							if(data.status != 'success'){
								showMsg("操作失败:" + data);
							}else{
								showMsg("已保存");
								try{
									parent.loadData("reload"); 
								}catch(e){
								}
							}
						},
						dataType:"json"
				}); 
	    		
	    		
	    	}
	})
	

})

function setV(id,v){
	$("#"+id).val(v);
}
</script>
</head>
<body>

<h1>Create Backlog Info</h1>
<div class="container-fluid">

<div class="row">
<div class="col-md-1"></div>
<div class="col-md-10">
<!-- BEGIN VALIDATION STATES-->
<div class="portlet-body form">
   <form class="form-horizontal" id="defaultForm"  role="form">
       <div class="form-body">
           <div class="row">
               <div class="col-md-offset-3 col-md-9">
                   <button  id="submitButton" class="submitButton btn green">Submit</button>
               </div>
           </div>
           <hr/>
           
       		<div class="form-group">
               <label class="col-md-3 control-label">Belong System</label>
               <div class="col-md-9">
                   		<s:select id="blSys" 
						 name="blSys"  
						 cssClass="select2 form-control"  
						 list="#request.projectList"  listKey="projectId" listValue="projectName" headerKey="" headerValue="请选择"></s:select> 
						 
                  <!-- <div class="input-inline input-medium">
                   
						 
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-gears"></i>
                           </span>
                           <input id="blSys" name="blSys" class="form-control" placeholder="所属系统"/> 
                        </div>
                   </div>
                   <span class="help-inline"> 
                   <c:forEach items="${blSys }" var="aBlSys" >
                   	<span class="label label-primary hand" onclick="setV('blSys','<c:out value="${aBlSys.value}"></c:out>')">${aBlSys.text }</span> &nbsp;
                   </c:forEach>
                   </span>
                    --> 
               </div>
           </div>
			<div class="form-group">
               <label class="col-md-3 control-label">ISSUE USER</label>
               <div class="col-md-9">
               		 <s:select id="blIssueUser" 
							 name="blIssueUser"  
							 cssClass="select2"  
							 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
							 
							 
							 <!-- 
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-user"></i>
                           </span>
                           <input id="blIssueUser" name="blIssueUser" class="form-control" placeholder="签发人"/> </div>
                   </div>
                   <span class="help-inline"> 
                   <c:forEach items="${userList }" var="user" >
                   	<span class="label label-primary hand" onclick="setV('blIssueUser','<c:out value="${user.value}"></c:out>')">${user.text }</span> &nbsp;
                   </c:forEach>
				   </span> -->
               </div>
           </div>
           <div class="form-group">
               <label class="col-md-3 control-label">EXEC USER</label>
               <div class="col-md-9">
               		 <s:select id="blExeUser" 
							 name="blExeUser"  
							 cssClass="select2"  
							 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
							 
							 
						<!--  
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-user"></i>
                           </span>
                           <input id="blExeUser" name="blExeUser" class="form-control" placeholder="执行人"/> </div>
                   </div>
                   <span class="help-inline">  
                   	<c:forEach items="${userList }" var="user" >
                   	<span class="label label-primary hand" onclick="setV('blExeUser','<c:out value="${user.value}"></c:out>')">${user.text }</span> &nbsp;
                   </c:forEach>
				   </span>
				    -->	
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Block Log</label>
               <div class="col-md-9">
                   <input id="blContent" name="blContent" class="form-control" placeholder="工作内容"/>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Expire Date</label>
               <div class="col-md-9">
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                           </span>
                           <input id="expireDate" name="expireDate" value="<fmt:formatDate value="${bli.expireDate}" pattern="yyyy-MM-dd HH:mm"/>" class="form-control" placeholder="预警日期"/> </div>
                   </div>
                   <span class="help-inline">  Expire Date </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Alarm Days</label>
               <div class="col-md-9">
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-info"></i>
                           </span>
                           <input id="alarmDays" name="alarmDays" value="1" class="form-control" placeholder="预警期"/> </div>
                   </div>
                   <span class="help-inline">  Alarm Days </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Start Date</label>
               <div class="col-md-9">
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-calendar"></i>
                           </span>
                           <input id="startDate" name="startDate" class="form-control" value="<fmt:formatDate value="${bli.startDate}" pattern="yyyy-MM-dd HH:mm"/>" placeholder="开始日期"/> </div>
                   </div>
                   <span class="help-inline">  Start Date </span>
               </div>
           </div>
           
            <div class="form-group">
               <label class="col-md-3 control-label">Finish Date</label>
               <div class="col-md-9">
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-calendar"></i>
                           </span>
                           <input id="fnshDate" name="fnshDate" class="form-control" value="<fmt:formatDate value="${bli.fnshDate}" pattern="yyyy-MM-dd HH:mm"/>" placeholder="完成日期"/> </div>
                   </div>
                   <span class="help-inline">  Finish Date </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Level</label>
               <div class="col-md-9">
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-star"></i>
                           </span>
                           <input id="blLevel" name="blLevel"  value="${bli.blLevel }" class="form-control" placeholder="紧急程度"/> </div>
                   </div>
                   <span class="help-inline"> 
                   <span class="label label-danger hand" onclick="setV('blLevel','5')">非常紧急</span> 
                   <span class="label label-warning hand" onclick="setV('blLevel','4')">紧急</span> 
                   <span class="label label-info hand" onclick="setV('blLevel','3')">正常</span> 
                   <span class="label label-success hand" onclick="setV('blLevel','2')">不紧急</span> 
                   <span class="label label-default hand" onclick="setV('blLevel','1')">无视</span> 
                   </span>
               </div>
           </div>
           
           <div class="form-group">
               <label class="col-md-3 control-label">Classify </label>
               <div class="col-md-9">
                   <div class="input-inline input-medium">
                       <div class="input-group">
                           <span class="input-group-addon">
                               <i class="fa fa-tags"></i>
                           </span>
                           <input id="blClassify" name="blClassify" value="${bli.blClassify }"  class="form-control" placeholder="分类"/> </div>
                   </div>
                   <span class="help-inline"> 
						<c:forEach items="${blType }" var="aBlType" >
							<span class="label label-primary" onclick="setV('blClassify','<c:out value="${aBlType.value}"></c:out>')">${aBlType.text }</span> &nbsp;
						</c:forEach>
				   </span>
               </div>
           </div>
           
           
           <div class="form-actions">
           <div class="row">
               <div class="col-md-offset-3 col-md-9">
                   <button type="button" class="submitButton btn green">Submit</button>
                   <button type="button" class="btn default">Cancel</button>
               </div>
           </div>
           </div>
           
           
           
   </form>
</div>                  
<!-- END VALIDATION STATES-->
</div>

</div>
</div>
</body>
</html>