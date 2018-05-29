<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ include file="../../../pub/TagLib.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>缺陷信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%@ include file="../../pub/pubCssJsForBootstrap.jsp"%>

<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="${ctx}/js/ueditor/ueditor.all.js"></script>
<link rel="stylesheet" href="${ctx}/css/pages/todo-2.css" type="text/css" />

<style type="text/css">
.timeline-badge {
	width: 180px !important;
	padding: 0px !important;
	height: auto !important;
}

.timeline .timeline-body-arrow {
	top: 6px !important;
}

.bor_f {
	border: 3px solid #fff;
	position: absolute;
	top: 8px;
	left: 3px;
}

.timeline-body {
	padding-top: 10px !important;
	padding-bottom: 7px !important;
	margin-left:120px !important;
}

.select2-selection--single {
	border-top-left-radius: 0px !important;
	border-bottom-left-radius: 0px !important;
}
</style>
<script>
	var ue2
	function updateTraceDefect() {
		var _status = $("#operateStatus").val()
		var _user = $("#operateUser").val();
		var _desc = ue2.getContent();
		var _id = $("#defectId").val();
		//alert(_status)
		//console.log(_id+"|"+_user + "|" + _desc + "|" + _id);
		var obj = {
			'seTraceDefect.defectId' : _id,
			'seTraceDefect.developer' : _user,
			'seTraceDefect.defectStatus' : _status,
			'seTraceDefect.defectPic' : _desc
		}
		console.log(obj);
		$.ajax("${ctx}/se/se!updateTraceDefectStatus.do", {
			type : "post",
			data : obj,
			success : function(r) {
				if ("SUCCESS" == $.trim(r)) {
					alert("操作成功");
					//loadTraceNoteDg();
					
					try{
						parent.reloadSeTraceDefectDg();
						parent.clw();
					}catch(e){
						parent.reloadTraceDefectTab();
						parent.closeLayer(1);
					}
					
				}else{
					alert("操作失败");
				}
			}
		});
	}
	
	function setDefectStatus(s){
		$("#operateStatus").val(s);
	}
	
	function opw(msg){
		$("#win").html(msg);
		$('#win').window({})
		$('#win').window('open');// open a window
	}
	
	
$(function() {
	$(".select2").select2({
	  //默认文本
	  placeholder: 'Select an option',
	  allowClear: true,
	  width:200
	});
	
	ue2 = UE.getEditor('defectRepairContent',
	{
		serverUrl : "${ctx}/se/se!uploadFile.do",
		imageUrlPrefix : "",
		imageActionName : 'img',
		imageFieldName : 'imgFile',
		imageAllowFiles : [ ".png", ".jpg", ".jpeg",
				".gif", ".bmp" ],
		initialFrameWidth : '100%', //初始化编辑器宽度,默认1000 
		initialFrameHeight : 250, //初始化编辑器高度,默认320
		fileActionName : "uploadfile", /* controller里,执行上传视频的action名称 */
		fileFieldName : "imgFile", /* 提交的文件表单名称 */
		fileUrlPrefix : "", /* 文件访问路径前缀 */
		fileMaxSize : 51200000, /* 上传大小限制，单位B，默认50MB */
		fileAllowFiles : [ ".png", ".jpg", ".jpeg", ".gif",
				".bmp", ".flv", ".swf", ".mkv", ".avi",
				".rm", ".rmvb", ".mpeg", ".mpg", ".ogg",
				".ogv", ".mov", ".wmv", ".mp4", ".webm",
				".mp3", ".wav", ".mid", ".rar", ".zip",
				".tar", ".gz", ".7z", ".bz2", ".cab",
				".iso", ".doc", ".docx", ".xls", ".xlsx",
				".ppt", ".pptx", ".pdf", ".txt", ".md",
				".xml" ],
		videoActionName : "uploadvideo", /* 执行上传视频的action名称 */
		videoFieldName : "imgFile", /* 提交的视频表单名称 */
		videoMaxSize : 102400000, /* 上传大小限制，单位B，默认100MB */
		videoAllowFiles : [ ".flv", ".swf", ".mkv", ".avi",
				".rm", ".rmvb", ".mpeg", ".mpg", ".ogg",
				".ogv", ".mov", ".wmv", ".mp4", ".webm",
				".mp3", ".wav", ".mid" ], /* 上传视频格式显示 */
		enableAutoSave : false
	});
})

function showRemark(defectRepairId){
	$.ajax("${ctx}/se/se!queryDefectRepairRemark.do", {
		type : "post",
		data : {id:defectRepairId},
		success : function(r) {
			$("#defectRepairRemark").html(r);
		}
	});
}


</script>
</head>

<body>
         	
	
<div class="modal fade" id="win"  aria-labelledby="myModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
			  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			  <h4 class="modal-title" id="myModalLabel2">缺陷状态备注</h4>
			</div>
			<div class="modal-body" id="defectRepairRemark">
				
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>











	<div class="container-fluid">
			<div class="row">
				<dic class="col-xs-6">
				<h3>Trace Defect Info</h3>
				<hr />
				
					<input type="hidden" name="seTraceDefect.defectId" value="${seTraceDefect.defectId}" id="defectId"/>
					
					<!--<s:select id="operateUser" 
							 name="seTraceDefectRepair.operateUser"  
							 cssClass="select2"  
							 list="#request.userList"  listKey="value" listValue="text" headerKey="" headerValue="请选择"></s:select>  
					-->
					
				
				操作描述：
				<div style="margin-top:10px;">
					<textarea id="defectRepairContent" name="defectRepairContent"></textarea>
				</div>
				<div class="row" style="margin-top:10px;">
					<div class="col-sm-4">
						操作人：
						<input type="hidden" id="operateUser"  value="${loginUserInfo.userId}" name="updateDefectUserId"  />
						${loginUserInfo.userName}
					</div>
					<div class="col-sm-8 text-right">
						<c:if test="${authMap['REQUIRE-TRACE'] eq 'Y' }">
							置为
							<s:select id="operateStatus" 
								 name="seTraceDefectRepair.operateStatus"
								 cssClass="select2"  
								 list="#{'问题提出':'问题提出','已修改':'已修改','关闭':'关闭','重新打开':'重新打开','遗留问题':'遗留问题','非缺陷':'非缺陷'}" 
								headerKey="" headerValue="请选择"></s:select>  
								
								<!-- <select id="defectStatus2" class="select2">
									<option value="">请选择状态</option>
									<option value="问题提出">问题提出</option>
									<option value="已修改">已修改</option>
									<option value="关闭">关闭</option>
									<option value="重新打开">重新打开</option>
								</select> -->状态 
					
							<button type="button" id="submitButton" class="btn green" onclick="updateTraceDefect()">确认</button>
						</c:if>
						
						
						<c:if test="${authMap['REQUIRE-TRACE'] ne 'Y' }">
							<input type="hidden" name="seTraceDefectRepair.operateStatus" id="operateStatus"/>
							<c:forEach items="${targetStatusList}" var="target">
								<c:if test="${loginUserInfo.userId ==  seTraceDefect.developer}">
									<c:if test="${target eq '已修改' }">
										<button type="button" id="submitButton" class="btn green" onclick="setDefectStatus('${target}');updateTraceDefect()">${target}</button>
									</c:if>
									<c:if test="${target eq '非缺陷' }">
										<button type="button" id="submitButton" class="btn green" onclick="setDefectStatus('${target}');updateTraceDefect()">${target}</button>
									</c:if>
								</c:if>
								
								<c:if test="${loginUserInfo.userId ==  seTraceDefect.testUser}">
									<button type="button" id="submitButton" class="btn green" onclick="setDefectStatus('${target}');updateTraceDefect()">${target}</button>
								</c:if>
							</c:forEach>
						</c:if>
					
					
					
					</div>
				</div>
				
				
				
				
				
				
				
				</dic>
				<dic class="col-xs-6">
				<h3>状态历史</h3>
				<hr />

				<div class="portlet-body">
					<div class="timeline  white-bg " style="padding:20px;background: #eee;">
						<c:forEach items="${list}" var="l">
							<!-- TIMELINE ITEM -->
							<div class="timeline-item">
								<div class="timeline-badge">
									<span class="label label-danger bor_f"><i
										class="fa fa-clock-o"></i>${l.userName }  </span>
								</div>
								<div class="timeline-body">
									<div class="timeline-body-arrow"></div>
									<div class="timeline-body-head">
										<div class="timeline-body-head-caption">
										置为 
										<span class="timeline-body-title font-blue-madison">${l.operateStatus }</span> 
										状态
										<span class="timeline-body-time font-blue-madison"><fmt:formatDate value="${l.createTime }" pattern="yyyy-MM-dd hh:mm:ss"/></span>
										
										<!-- <span class="timeline-body-time font-grey-cascade">${l.operateStatus }</span> -->
										
										
										<a href="#" data-target="#win" data-backdrop="true" data-toggle="modal"  class="timeline-body-time font-grey-cascade" onclick="showRemark('${l.repairId}')">查看备注</a>
										
										
										</div>
									</div>
								</div>
							</div>
							<!-- TIMELINE ITEM END-->
						</c:forEach>
					</div>
				</div>
				</dic>
			</div>


	</div>
	


	
	
</body>
</html>
