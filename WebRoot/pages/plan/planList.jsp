<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!doctype>
<html>
<head>
<title>myBootStrap</title>
<meta charset="utf-8" />
<script src="${ctx}/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="${ctx}/js/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="${ctx}/js/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/js/font-awesome/css/font-awesome.css" rel="stylesheet" type="text/css" />
<!-- 
<link href="mybootstrap/css/mybootstrap.css" rel="stylesheet" type="text/css" />
-->
<link href="${ctx}/js/mybootstrap/css/components.min.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/js/mybootstrap/css/todo-2.css" rel="stylesheet" type="text/css" />





<script>
function goPlanView(planCode){
	//alert(planCode);
	document.location.href = '${ctx}/plan/plan!planView.do?planInfo.planCode=' + planCode + '&projectId=${projectId}';
}

function initPlanInfo(){
	$.ajax({
		  dataType: "text",
		  url: "${ctx}/plan/plan!initPlanInfo.do",
		  data : {
			year:${year}
		  },
		  success: function(data){
			document.location.href ='${ctx}/plan/plan!planList.do?year=${year}';
			document.getElementById("initButton").removeAttribute("disabled");
		  },
		  type:"post"
	});
}
</script>

</head>
<body>


<div class="container-fluid">
	<div class="row">
		<div class="col-xs-4" >
		</div>
		<div class="col-xs-4" >
			<h1 class="text-center">周月计划 - ${year}</h1>
		</div>
		<div class="col-xs-4" >
			<div style="padding-top:23px;" class="text-right">
				 <div class="btn-group btn-group-solid">
					<button type="button" class="btn green" onclick="this.disabled='disabled';initPlanInfo()" id="initButton"><i class="fa fa-plus"></i> 初始化整年计划数据 </button>
				 </div>
			</div>
		</div>
	</div>
<hr/>
<div class="row">
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat blue">
			<div class="visual">
				<i class="fa fa-comments"></i>
			</div>
			<div class="details">
				<div class="number">
					<span data-counter="counterup" data-value="1349">0</span>
				</div>
				<div class="desc"> Week Plan </div>
			</div>
			<a class="more" href="javascript:;"> View more
				<i class="m-icon-swapright m-icon-white"></i>
			</a>
		</div>
	</div>
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat red">
			<div class="visual">
				<i class="fa fa-bar-chart-o"></i>
			</div>
			<div class="details">
				<div class="number">
					<span data-counter="counterup" data-value="12,5">0</span>M$ </div>
				<div class="desc"> Month Plan </div>
			</div>
			<a class="more" href="javascript:;"> View more
				<i class="m-icon-swapright m-icon-white"></i>
			</a>
		</div>
	</div>
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat green">
			<div class="visual">
				<i class="fa fa-shopping-cart"></i>
			</div>
			<div class="details">
				<div class="number">
					<span data-counter="counterup" data-value="549">0</span>
				</div>
				<div class="desc"> Week Plan </div>
			</div>
			<a class="more" href="javascript:;"> View more
				<i class="m-icon-swapright m-icon-white"></i>
			</a>
		</div>
	</div>
	<div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="dashboard-stat purple">
			<div class="visual">
				<i class="fa fa-globe"></i>
			</div>
			<div class="details">
				<div class="number"> +
					<span data-counter="counterup" data-value="89"></span>% </div>
				<div class="desc"> Month Plan</div>
			</div>
			<a class="more" href="javascript:;"> View more
				<i class="m-icon-swapright m-icon-white"></i>
			</a>
		</div>
	</div>






	
</div>
</div>





<div class="container-fluid">

<div style="width:1100px;margin:0px auto;">
<div class="portlet-body">
	<div class="tiles">
		<hr/>
		<c:forEach items="${planList}" var="plan" varStatus="index">
			
			<c:if test="${'MONTH' eq plan.planClassify}">
				
				
				<div class="tile double
				<c:if test="${currentMonth > plan.planMonth}"> selected </c:if>
				<c:if test="${currentMonth != plan.planMonth}"> bg-green-turquoise </c:if>
				<c:if test="${currentMonth == plan.planMonth}"> bg-red-sunglo </c:if>
				" onclick="goPlanView('${plan.planCode}')">
				
				
					<div class="corner"> </div>
					<div class="check"> </div>
					<div class="tile-body">
						<h4> <i class="fa fa-calendar"></i> &nbsp; ${plan.planMonth}月 </h4>
						<p> &nbsp; </p>
						<p> <fmt:formatDate value="${plan.startDate}" pattern="MM.dd"/> - <fmt:formatDate value="${plan.finishDate}" pattern="MM.dd"/> </p>
					</div>
					<div class="tile-object">
						<div class="name">
							<!--<i class="fa fa-calendar"></i>-->
						</div>
						<div class="number"> 月 </div>
					</div>
				</div>
			</c:if>
			
			<c:if test="${'WEEK' eq plan.planClassify}">
				
				
				
				<div class="tile 
				<c:if test="${currentWeek > plan.planWeek}"> selected </c:if>
				<c:if test="${currentWeek != plan.planWeek}"> bg-blue-hoki </c:if>
				<c:if test="${currentWeek == plan.planWeek}"> bg-red-sunglo </c:if>
				<%--  
				<c:if test="${index.index % 4 == 0}">bg-green-turquoise</c:if>
				<c:if test="${index.index % 4 == 1}">bg-blue-hoki</c:if>
				<c:if test="${index.index % 4 == 2}">bg-yellow-saffron</c:if>
				<c:if test="${index.index % 4 == 3}">bg-purple-studio</c:if>
				--%>
					" onclick="goPlanView('${plan.planCode}')">
					
					<div class="corner"> </div>
					<div class="check"> </div>
					<div class="tile-body">
						<h4> <i class="fa fa-calendar"></i> &nbsp; ${plan.planMonth}月 </h4>
						 <i>${plan.planWeek}</i>
					</div>
					<div class="tile-object">
						<div class="name"><fmt:formatDate value="${plan.startDate}" pattern="MM.dd"/> - <fmt:formatDate value="${plan.finishDate}" pattern="MM.dd"/></div>
						<div class="number"> 周</div>
					</div>
			
			
				</div>
			</c:if>
		</c:forEach>

	</div>
</div>
</div>

</div>










</body>
</html>