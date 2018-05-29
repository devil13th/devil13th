<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<style type="text/css">
#dividPage{height:20px;line-height:20px;text-align:right;margin-top:5px;}
#pages a{display:inline-block;border-bottom:2px solid #ccc;text-decoration:none;margin-right:5px;height:12px;line-height:12px;padding:0px 2px;}
#pages a.current{border-bottom:0px;font-weight:bold;}
#pages a:link{color:#aaa;}
#pages a:visited{color:#aaa;}
#pages a:hover{color:#aaa;}
#pages a:active{color:#aaa;}
#pages a:link.current{color:#333;}
#pages a:visited.current{color:#333;}
#pages a:hover.current{color:#333;}
#pages a:active.current{color:#333;}
</style>
<div id="dividPage">
共<span id="listSize"></span>条记录

<!-- 
<input type="hidden" name="page.currentPage" value="${page.currentPage}" id="cp"/>
 -->
每页显示<form:input path="page.pageSize" style="width:20px"/>条
<form:hidden path="page.currentPage"  id="cp"/>
<span id="pages">
</span>
共<span id="maxPage"></span>页
当前第<span id="currentPage"></span>页
</div>

<script type="text/javascript">

var maxPage = ${page.maxPage};
var listSize = ${page.listSize};
var currentPage = ${page.currentPage};



var formId = "<%= request.getParameter("formId") %>";
document.getElementById("maxPage").innerHTML = maxPage;
document.getElementById("listSize").innerHTML = listSize;
document.getElementById("currentPage").innerHTML = currentPage;
function formSMT(cp){
	document.getElementById("cp").value = cp;
	document.getElementById(formId).submit();
}
for(var i = 1 ; i <= maxPage ; i++){
	var lk = document.createElement("a");
	lk.setAttribute("cp",i);
	lk.innerHTML = i;
	lk.href = "#";
	document.getElementById("pages").appendChild(lk);
	if (i == currentPage){
		lk.className = "current";
		lk.onclick = function(){
			formSMT(this.getAttribute("cp"));
		}
	}else{
		lk.onclick = function(){
			formSMT(this.getAttribute("cp"));
		}
	}
}
</script>
