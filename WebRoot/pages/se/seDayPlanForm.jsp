
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>
		
		<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>

		<title><s:text name="title.applyName"></s:text>
		</title>
	
<style type="text/css">
.select2-selection--single{border-top-left-radius:0px !important;border-bottom-left-radius:0px !important;}
</style>
<script>

var theSeDayPlanForm;
var userSelect;
var dayPlanValidateTool;

$(function(){
	
	
	userSelect = $("#userId").select2({
		//默认文本
		placeholder: 'Select an option',
		allowClear: true,
		width:200
	 });
	
	$("#status").select2({
		//默认文本
		placeholder: 'Select an option',
		allowClear: true,
		width:200
	 });
	 
	 $('#planDate').datetimepicker({
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
		dayPlanValidateTool.data("formValidation").revalidateField("seDayPlan.planDate");
	});
	 
	 
	 
	 
	 dayPlanValidateTool = $('#theSeDayPlanForm').formValidation({
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
	        	
	        	"seDayPlan.planContent": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    stringLength: {
	                        max: 128,
	                        message: '长度128以内'
	                    },
	                    notEmpty: {
	                        message: 'The first name is required'
	                    }
	                }
	            },
	            "seDayPlan.planDate": {
	            	row:'.form-group',//变红色字体的范围容器
	                validators: {
	                    notEmpty: {
	                        message: 'The first name is required'
	                    }
	                }
	            }
	        }
	    });
})

function resetSeDayPlanForm(){
	theSeDayPlanForm.form("clear");
	loadDg();
}

function submitForm(){
	dayPlanValidateTool.data("formValidation").validate();
	var validateResult = dayPlanValidateTool.data("formValidation").isValid();
	if(validateResult){
		//document.getElementById("theSeDayPlanForm").submit();
		
		submitDayPlanForm();
		
	};
	
}

function submitDayPlanForm(){
	var formData = $("#theSeDayPlanForm").serialize();
	$.ajax("${ctx}/se/se!seDayPlanFormSubmit.do",
		{
			type:"post",
			async:false,
			data:formData,
			success:function(r){
				var str = $.trim(r);
				//alert(str);
				if(str == "SUCCESS"){
					layer.alert(
						'保存成功', 
						{
							skin: 'layui-layer-molv',//样式类名
							closeBtn: 0
						}, 
						function(){
							try{
								getParent().refreshDayPlanTable();
								window.close();
							}catch(e){
								try{
									//getParent().reloadSeDayPlanDg();window.close()
									getParent().reloadSeDayPlanDg();
									window.close();
									//parent.closeLayer(1);
								}catch(e){
									alert(e)
									//window.close();
								}
							}
						}
					);
					
				}else{
					alert("保存失败");
				};
			}
		}
	)
}
function cw(){
	top.closeWin();
}


</script>
	</head>

	<body>
		
		<div id="pbody">
			<h3>Day Plan</h3>
			<hr/>
			
			<div class="container-fluid">
			<div class="row">
			<s:form action="se!seDayPlanFormSubmit"  cssClass="form-horizontal" namespace="/se" method="post" id="theSeDayPlanForm">
					<div class="col-xs-10">	
						<div style="display: none;">
							操作种类 save为保存 update为更新：<input type="text" name="operate" value="${operate}"/>
							主键<input 
									class="easyui-textbox" 
									name="seDayPlan.dayPlanId"
									id="dayPlanId" 
									type="text"
									value="${seDayPlan.dayPlanId}" /><br/>
							是否删除<input 
									class="easyui-textbox" 
									name="seDayPlan.isDelete"
									id="isDelete" 
									type="text"
									value="${seDayPlan.isDelete}" />
						</div>
					
					
						
					
						<div class="form-group">
							<label class="col-xs-3 control-label">日计划内容</label>
							<div class="col-xs-9">
								<div class="input-inline ">
									<div class="input-group">
										<span class="input-group-addon">
										<i class="fa fa-gears"></i>
										</span>
										<input 
										class="form-control" 
										placeholder="日计划内容"
										name="seDayPlan.planContent"
										id="planContent" 
										type="text"
										value="${seDayPlan.planContent}"/>
									</div>
								</div>
								<span class="help-inline"> 
								</span>
							</div>
						</div>
						
						
						<div class="form-group">
							<label class="col-xs-3 control-label">所属人员</label>
							<div class="col-xs-9">
								<div class="input-inline ">
									<div class="input-group">
										<span class="input-group-addon">
										<i class="fa fa-gears"></i>
										</span>
										
										
										<s:select id="userId"   name="seDayPlan.userId"  cssClass="select2"  
								list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
									</div>
								</div>
								<span class="help-inline"> 
								</span>
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-xs-3 control-label">状态</label>
							<div class="col-xs-9">
								<div class="input-inline ">
									<div class="input-group">
										<span class="input-group-addon">
										<i class="fa fa-gears"></i>
										</span>
										
										
										<s:select id="status" name="seDayPlan.status"  cssClass="select2"  
								list="#request.statusList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
									</div>
								</div>
								<span class="help-inline"> 
								</span>
							</div>
						</div>
	           			
	           			<div class="form-group">
							<label class="col-xs-3 control-label">所属日期</label>
							<div class="col-xs-9">
								<div class="input-inline ">
									<div class="input-group">
										<span class="input-group-addon">
										<i class="fa fa-gears"></i>
										</span>
										                 
										 <input 
										class="form-control" 
										placeholder="所属日期"
										name="seDayPlan.planDate"
										id="planDate" 
										type="text"
										value="<fmt:formatDate value="${seDayPlan.planDate}" pattern="yyyy-MM-dd"/>"/>
									</div>
								</div>
								<span class="help-inline"> 
								</span>
							</div>
						</div>
						
						
						
						<div class="form-group">
			               <label class="col-xs-3 control-label">备注</label>
			               <div class="col-xs-9">
			                   <textarea name="seDayPlan.planRemark" id="planRemark">${seDayPlan.planRemark}</textarea>
			               </div>
			           </div>
			           
           
           				<!--  
						<div class="form-group">
							<label class="col-xs-3 control-label">备注</label>
							<div class="col-xs-9">
								<div class="input-inline ">
									<div class="input-group">
										<span class="input-group-addon">
										<i class="fa fa-gears"></i>
										</span>
										                 
										 <input 
										class="form-control" 
										placeholder="备注"
										name="seDayPlan.planRemark"
										id="planRemark" 
										type="text"
										value="${seDayPlan.planRemark}"/>
									</div>
								</div>
								<span class="help-inline"> 
								</span>
							</div>
						</div>
           				-->
						<div class="row">
							<div class="text-center">
							    <button type="button" id="submitButton" class="btn green" onclick="submitForm()">Submit</button>
							    <button type="button" class="btn default">Cancel</button>
							</div>
						</div>
					
					</div>
			
			</s:form>
			</div>
			</div>
		</div>
		
<script>
var ue;
ue = UE.getEditor('planRemark',{
	serverUrl: "${ctx}/se/se!uploadFile.do",
   	imageUrlPrefix:"",
   	imageActionName:'img',
   	imageFieldName:'imgFile',
   	imageAllowFiles:[".png", ".jpg", ".jpeg", ".gif", ".bmp"],
   	initialFrameWidth:500,   //初始化编辑器宽度,默认1000 
    initialFrameHeight:220,  //初始化编辑器高度,默认320
   	fileActionName: "uploadfile", /* controller里,执行上传视频的action名称 */
    fileFieldName: "imgFile", /* 提交的文件表单名称 */
    fileUrlPrefix: "", /* 文件访问路径前缀 */
    fileMaxSize: 51200000, /* 上传大小限制，单位B，默认50MB */
    initialFrameWidth:'100%',   //初始化编辑器宽度,默认1000 
    initialFrameHeight:320,  //初始化编辑器高度,默认320
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

});
</script>
	</body>
</html>
