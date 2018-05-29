<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="../../../pub/pubCssJsForBootstrap.jsp"%>
<script src="${ctx}/js/bootstrap/js/portlet-draggable.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>

<script src="${ctx}/js/intro/intro.js" type="text/javascript"></script>
<script src="${ctx}/js/vue/vue.js" type="text/javascript"></script>
<link rel="stylesheet" href="${ctx}/js/intro/introjs.css" type="text/css"/>
<style>
.navbar-default{background:#578EBE;}
/*
.navbar-header *{color:#67809F !important}
.navbar-default .navbar-nav>li>a{color:#67809F !important}
.dropdown-menu > li > a{color:#67809F !important}
.dropdown .fa,.dropdown .glyphicon{color:#67809F !important;}
#menu *{color:#67809F !important;}
#menu .dropdown a,#menu .dropdown-menu a{color:#67809F !important;}*/
.navbar-header *{color:#fff !important}
.navbar-default .navbar-nav>li>a{color:#fff !important}
.dropdown-menu > li > a{color:#fff !important}
.dropdown .fa,.dropdown .glyphicon{color:#fff !important;}
#menu *{color:#fff !important;}
#menu .dropdown a,#menu .dropdown-menu a{color:#fff !important;}

.dropdown-menu > li > a{background:#5C9BD1;}
.navbar-default .navbar-nav>.open>a, .navbar-default .navbar-nav>.open>a:focus, .navbar-default .navbar-nav>.open>a:hover{background:#67809F;}
.dropdown-menu > li:hover > a, .dropdown-menu > li.active > a, .dropdown-menu > li.active:hover > a {background:#67809F}

.portlet-body-self{background:#fafafa !important;}

</style>
<title><s:text name="common.sysName"></s:text></title>


<script>

$(function(){
	/*
	$('body').slimScroll({
		height:'100%',
		width:'auto'
	});*/
	//showHelp();
	
})
function showHelp(){
	introJs().start();
}
function openLayer(title,url){
	layer.open({
		  type: 2,
		  shadeClose: false,
		  shade: 0.3,
		  title: false, //不显示标题
		  content: url, //捕获的元素
		  area: ['95%', '95%']
		});

}
function closeLayer(){
	layer.closeAll();
}
function showModal(url,title){
	$("#myModalWinLabel").html(title);
	$("#myModalFrame").attr("src",url);
	$('#myModalWin').modal("show");
}
function closeModal(){
	$('#myModalWin').modal("hide");
}

function showThis(o){
	
	var menuUrl = "";
	if(o.href.indexOf("?") == -1 ){
		menuUrl  = o.href + "?";
	}else{
		menuUrl  = o.href ;
	}
	menuUrl += "&projectId=${projectId}"
	openWindow({
		//url:o.href,
		url:menuUrl,
		height:window.screen.height*0.8,
		width:window.screen.width*0.95
	});
	
	/*layer.open({
	  type: 2,
	  shadeClose: true,
	  shade: 0.8,
	  area: ['100%', '100%'],
	  content: o.href
	});*/
}


function savePassword(){
	var pwd = $("#pwd").val();
	var uId = "${loginUserInfo.seUser.userId}";
	//alert(uId);
	if($.trim(uId) == ""){
		alert("未登录");
		return false;
	}
	$.ajax({
		type: "POST",
		url: "${ctx}/common/common!updatePwd.do",
		data: {
			'seUser.userAccount':uId,
			'seUser.userPassword':pwd
		},
		success: function(msg){
			//alert(msg);
			if($.trim(msg)=="<%=StaticVar.STATUS_SUCCESS%>"){
				showMessage("操作成功");
				
			}else{
				showMessage("操作失败");
				return false;
			}
			$("#pwd").val("");
			$('#myModal').modal("hide");
		},
		failure : function(msg){
			showMessage("操作失败");
			$('#myModal').modal("hide");
		}
	});
}

function showMessage(msg){
	layer.alert(msg, 
		{
			skin: 'layui-layer-lan',
			shade: 0.3,
			shadeClose: false, //关闭遮罩关闭
			shift: 1 //动画类型
		}
	);
}
</script>
</head>

<body style="padding-top:70px !important;background:#fff">
<div class="container-fluid">
	<nav class="navbar navbar-default navbar-fixed-top">
	  <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand glyphicon glyphicon-fire" href="#" title="项目管理系统 Project Management System"> <b><s:text name="common.sysName"></s:text></b></a>
	    </div>
	
	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	    
	    
	      <ul class="nav navbar-nav">
	      	<!--  
	        <li class="active"><a href="#">Link <span class="sr-only">(current)</span></a></li>
	        <li><a href="#">Link</a></li>
	        -->
	        
	        
	        
	        
	        <c:forEach items="${menuList}" var="menu">
	        	<li class="dropdown">
	        		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> 
		        		<i class="${menu.ico}"></i> 
		        		<c:if test="${WW_TRANS_I18N_LOCALE == 'en_US' }">
							${menu.nameEn}
						</c:if>
						<c:if test="${WW_TRANS_I18N_LOCALE != 'en_US' }">
							${menu.name}
						</c:if>
		        		<span class="caret"></span>
	        		</a>
	        		 <ul class="dropdown-menu">
	        		 	<c:forEach items="${menu.childs}" var="smenu">
	        		 		<li>
	        		 		<a href ="${ctx}${smenu.url}" onclick="showThis(this);return false"> 
	        		 		<i class="${smenu.ico}"></i> 
	        		 		<c:if test="${WW_TRANS_I18N_LOCALE == 'en_US' }">
								${smenu.nameEn}
							</c:if>
							<c:if test="${WW_TRANS_I18N_LOCALE != 'en_US' }">
								${smenu.name}
							</c:if>
	        		 		</a>
	        		 		</li> 
	        		 	</c:forEach>
			          </ul>
	        	</li>
	        </c:forEach>
	        
	        
	        
	        <%--
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">日常功能<span class="caret"></span></a>
	          <ul class="dropdown-menu">
	             <li><a href ="${ctx}/backlog/backlog!backlog.do" onclick="showThis(this);return false"> <i class="fa fa-bell"></i> backlog</a></li> 
				 <li><a href ="${ctx}/checklist/checklist!checklistTree.do" onclick="showThis(this);return false"> <i class="fa fa-calendar-check-o"></i> 检查项目表实施</a></li>   
				 <li><a href ="${ctx}/se/seRequirementTrace!seRequirementTraceIndex.do?seRequirementTrace.projectId=SSMIS-A6" onclick="showThis(this);return false"> <i class="fa fa-tag"></i> 需求矩阵</a></li> 
				 <li><a href ="${ctx}/se/se!seUserLog.do" onclick="showThis(this);return false"><i class="fa fa-space-shuttle"></i> 日志</a></li>  
				 <li><a href ="${ctx}/se/se!sePubModuleList.do" onclick="showThis(this);return false"><i class="fa fa-jsfiddle"></i> 公共方法</a></li>  
				 <li><a href ="${ctx}/seProcess/seProcess!startProcess.do" onclick="showThis(this);return false"><i class="fa fa-lastfm"></i> 流程</a></li>  
				 <li><a href ="${ctx}/seProcess/seProcess!todoList.do" onclick="showThis(this);return false"><i class="glyphicon glyphicon-list-alt"></i> 待办</a></li>  
	          </ul>
	        </li>
	        <!--  
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">统计分析<span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href ="${ctx}/se/se!seUserView.do" onclick="showThis(this);return false">人员视图</a></li>
				<li><a href ="${ctx}/se/se!seCountView.do" onclick="showThis(this);return false">统计视图</a></li> 
				<li><a href ="${ctx}/login/login!login.do" onclick="showThis(this);return false">系统登录</a></li> 
	          </ul>
	        </li>
	        -->
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">后台管理<span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href ="${ctx}/checklist/checklist!index.do" onclick="showThis(this);return false"><i class="fa fa-search-plus"></i> checklist</a></li> 
				<li><a href ="${ctx}/se/se!seMeetingRecordList.do" onclick="showThis(this);return false"><i class="fa fa-pencil-square-o"></i> 纪要记录</a></li>  
				<li><a href ="${ctx}/se/se!seDayNoteList.do" onclick="showThis(this);return false"><i class="fa fa-paint-brush"></i> 项目大事记</a></li> 
				<li><a href ="${ctx}/se/se!seRiskList.do" onclick="showThis(this);return false"><i class="fa fa-bolt"></i> 项目风险</a></li>  
				<li><a href ="${ctx}/common/common!userSelector.do?seMapUser.relaTab=tab&seMapUser.tabKeyValue=1" onclick="showThis(this);return false">公共人员选择器</a></li>  
				<li><a href ="${ctx}/se/se!seUserRewardAmerceList.do" onclick="showThis(this);return false">奖惩记录</a></li> 
	          </ul>
	        </li>
	        
	        
	        <c:if test="${ session.loginUserInfo.canReadCost == '1' }">
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">重要信息<span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            <li><a href ="${ctx}/se/se!seProjectInfoList.do" onclick="showThis(this);return false"> <i class="fa fa-info-circle"></i> 项目信息</a></li>  
		            <li><a href="${ctx}/common/common!sysDicPubList.do" onclick="showThis(this);return false"> <i class="fa fa-book"></i> 字典定义</a></li>
		            <li><a href="${ctx}/common/common!sysDayList.do" onclick="showThis(this);return false"> <i class="fa fa-calendar"></i> 工作日管理</a></li>
		            <li><a href ="${ctx}/se/se!seUserList.do" onclick="showThis(this);return false"> <i class="fa fa-user"></i> 用户管理</a></li>  
		            <li><a href ="${ctx}/se/se!seRoleList.do" onclick="showThis(this);return false"> <i class="fa fa-gavel"></i> 角色管理</a></li>  
		           
					<li><a href ="${ctx}/se/se!seUserView.do" onclick="showThis(this);return false"> <i class="fa fa-street-view"></i> 人员视图</a></li>
					<li><a href ="${ctx}/se/se!seCountView.do" onclick="showThis(this);return false"> <i class="fa fa-bar-chart "></i> 统计视图</a></li> 
					<li><a href ="${ctx}/backlog/backlog!backlogForUser.do" onclick="showThis(this);return false"> <i class="fa fa-flag"></i> backlog for user</a></li> 
					<li><a href ="${ctx}/backlog/backlog!fastCreateBacklog.do" onclick="showThis(this);return false"> <i class="fa fa-pencil"></i> Fast Create Backlog</a></li>
		          	<li><a href ="${ctx}/plan/plan!planList.do" onclick="showThis(this);return false"> <i class="fa fa-plane"></i> 计划列表</a></li>
		          	<li><a href ="${ctx}/common/common!sysTimerListList.do" onclick="showThis(this);return false"> <i class="fa fa-clock-o"></i> 定时器管理 </a></li>
		          	<li><a href ="${ctx}/se/se!seAuthList.do" onclick="showThis(this);return false"> <i class="fa fa-info-circle"></i> 权限字典 </a></li>  
		            <li><a href="${ctx}/se/se!seMenuList.do" onclick="showThis(this);return false"> <i class="fa fa-book"></i> 菜单管理 </a></li>
		          </ul>
		        </li>
	        </c:if>
	        
	        <c:if test="${ session.loginUserInfo.canReadCost == '1' }">
		        <li class="dropdown">
		          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">正在建设<span class="caret"></span></a>
		          <ul class="dropdown-menu">
		            
		          </ul>
		        </li>
	        </c:if>
	        
	         --%>
	      </ul>
			
		  
	      <ul id="menu" class="nav navbar-nav navbar-right">
	      	<li ><a href ="#" title="网站新功能介绍" onclick="showHelp()"><i class="fa fa-info fa-spin"></i>Read Me </a></li>
	        <c:if test="${loginUserInfo == null }">
				<li><a href ="${ctx}/login/login!login.do" title="系统登录"><i class="fa fa-key"></i> 登录</a></li>
			</c:if>
			<c:if test="${loginUserInfo != null }">
				<li class="dropdown" >
					<a   href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						<i class="fa fa-ellipsis-v"></i>
						<c:if test="${project != null }">
						${project.proName}
						</c:if>
						<c:if test="${project == null }">
							<s:text name="common.allProjects"></s:text>
						</c:if>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu" >
						<li><a href="${ctx}/index/index!index.do"><s:text name="common.allProjects"></s:text></a></li>
						<c:forEach items="${projectList}" var="pro">
							<li <c:if test="${projectId == pro.projectId}">class="active"</c:if>><a href="${ctx}/index/index!index.do?projectId=${pro.projectId}">${pro.projectName}</a></li>
						</c:forEach>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="glyphicon glyphicon-user"></i>${loginUserInfo.seUser.userName }<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li ><a href="#">工作 <span class="badge">42</span></a></li>
						<li><a href="#" data-toggle="modal" data-target="#myModal"><i class="fa fa-key" ></i> <s:text name="index.modifyPassword"></s:text></a></li>
						<li><a href ="#" title="个性化定制"><i class="glyphicon glyphicon-cog" ></i> <s:text name="index.customized"></s:text> </a></li>
					</ul>
				</li>
				
				
				<c:if test="${WW_TRANS_I18N_LOCALE == 'en_US' }">
					<li><a href ="${ctx}/index/index!lang.do?lan=2"  title="<s:text name="index.changeLanguage"></s:text>"><i class="glyphicon glyphicon-usd"></i></a></li>
				</c:if>
				<c:if test="${WW_TRANS_I18N_LOCALE != 'en_US' }">
					<li><a href ="${ctx}/index/index!lang.do?lan=1"  title="<s:text name="index.changeLanguage"></s:text>"><i class="glyphicon glyphicon-yen"></i></a></li>
				</c:if>
				
				<li><a href ="${ctx}/login/login!logout.do"  title="<s:text name="common.logout"></s:text>"><i class="glyphicon glyphicon-off"></i></a></li> 
			</c:if>
		 </ul>
	      	
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	
	
	
	
	
	
	
	
	
	
	
	<div class="row" id="sortable_portlets">
		
	
		<div class="col-md-4 column sortable">
			<s:action name="index!plugInDayPlan" namespace="/index" executeResult="true">
			</s:action>
			
			<s:action name="index!plugInTraceDefect" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			
			<s:action name="index!plugInTraceNote" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			
			
			<s:action name="index!plugInMeeting" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			
			<s:action name="index!plugInRisk" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			
			<s:action name="index!plugInBacklog" namespace="/index" executeResult="true">
				<s:param name="blSys" value="#attr.projectId"></s:param>
			</s:action>
			
			
			
			<!-- empty sortable porlet required for each columns! -->
			<div class="portlet portlet-sortable-empty"> </div>
		</div>
		
		<div class="col-md-4 column sortable">
			
			<s:action name="index!plugInMyTodo" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			<s:action name="index!plugInPlanList" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			<s:action name="index!plugInDayNote" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			<s:action name="index!plugInPubModule" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			
			
			<!-- empty sortable porlet required for each columns! -->
			<div class="portlet portlet-sortable-empty"> </div>
		</div>
		<div class="col-md-4 column sortable">
			<s:action name="index!plugInProjectPortal" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			
			
			<s:action name="index!plugInStartProcess" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			
			<s:action name="index!plugInLoginUserInfo" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			<!-- 
			<s:action name="index!plugInMyProject" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			<s:action name="index!plugInProjectPlan" namespace="/index" executeResult="true">
				<s:param name="projectId" value="#attr.projectId"></s:param>
			</s:action>
			 -->
			<!-- empty sortable porlet required for each columns! -->
			<div class="portlet portlet-sortable-empty"> </div>
		</div>
		
		
		<div class="col-md-12 column sortable">
			
			
			
			
			<div class="portlet portlet-sortable box blue-hoki"  data-intro="系统技术点">
				<div class="portlet-title">
					<div class="caption">
						<i class="glyphicon glyphicon-list-alt"></i> Technology </div>
					<div class="actions">
					</div>
				</div>
				<div class="portlet-body">
					<table class="table">
						<thead>
							<tr>
								<td>名称</td>
								<td>入口</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>JAVA生成PDF</td>
								<td>RtfTemplateUtil.java</td>
							</tr>
							<tr>
								<td>启动WEB项目运行</td>
								<td>BiInitServlet.java|web.xml</td>
							</tr>
							<tr>
								<td>EasyUi</td>
								<td>*.jsp</td>
							</tr>
							<tr>
								<td>Bootstrap</td>
								<td>*.jsp</td>
							</tr>
							<tr>
								<td>定时器</td>
								<td>TimerInitServlet.java</td>
							</tr>
							<tr>
								<td>Activiti流程引擎</td>
								<td>MyActivitiUtils.java</td>
							</tr>
							<tr>
								<td>treegrid差删改查</td>
								<td><a href="${ctx}/se/se!seMenuList.do">菜单管理</a></td>
							</tr>
							<tr>
								<td>顶部固定导航</td>
								<td><a href="${ctx}/index/index!index.do">首页导航</a></td>
							</tr>
							<tr>
								<td>底部固定按钮</td>
								<td><a href="${ctx}/se/se!seMeetingForm.do">会议管理新增界面</a></td>
							</tr>
							<tr>
								<td>拖拽上传</td>
								<td><a href="${ctx}/se/se!seMeetingForm.do">会议管理新增界面</a></td>
							</tr>
							<tr>
								<td>jquery获取FORM数据,AJAX提交表单数据</td>
								<td><a href="${ctx}/se/se!seDayNoteForm.do">项目记事新增界面</a>
								<a href="${ctx}/se/se!seMeetingForm.do">新增会议界面</a>
								</td>
							</tr>
							<tr>
								<td>语言切换</td>
								<td><a href="#">首页右上角切换语言</a></td>
							</tr>
							<tr>
								<td>Select2 联动</td>
								<td><a href="${ctx}/se/se!seRiskForm.do">风险新增界面(项目和责任人)</a></td>
							</tr>
							<tr>
								<td>挂起、激活流程;重新指派待办的候选人;流程历史步骤、当前步骤查询、查看流程图</td>
								<td><a href="${ctx}/seProcess/seProcess!processList.do">流程管理</a></td>
							</tr>
							<tr>
								<td>加载静态字典</td>
								<td>FixedDicInitServlet.java</td>
							</tr>
							<tr>
								<td>RTF模板生成PDF</td>
								<td>项目计划</td>
							</tr>
							<tr>
								<td>treeGrid及搜索</td>
								<td><a href="${ctx }/se/seRequirementTrace!seRequirementTraceTaskUnion.do?projectId=SSMIS-A4">矩阵任务视图</a></td>
							</tr>
							<tr>
								<td>VUE例子</td>
								<td>首页&quot;天计划&quot;模块      <a href="${ctx }/pmp/pmp!pmp.do">PMP模块</a></td>
							</tr>
							<tr>
								<td>Layer.comfirm</td>
								<td>首页&quot;天计划&quot;模块</td>
							</tr>
							
							
						</tbody>
					</table>
				</div>
			</div>


			<div class="portlet portlet-sortable-empty"> </div>
		</div>
	</div>
</div>








<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Input New Password Please</h4>
      </div>
      <div class="modal-body">
        <input type="text" class="form-control" id="pwd"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="savePassword()">Save changes</button>
      </div>
    </div>
  </div>
</div>




<div class="modal fade bs-example-modal-lg" id="myModalWin" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg" role="document" >
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalWinLabel">Input New Password Please</h4>
      </div>
      <div class="modal-body" >
        <iframe width="100%" frameborder="0" height="400" id="myModalFrame"></iframe>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>





</body>


</html>