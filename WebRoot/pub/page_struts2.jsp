<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
<span id="pages">
</span>



每页显示<span id="pageSize"></span>条&nbsp;
共<span id="maxPage"></span>页&nbsp;
当前第<s:textfield name="p.currentPage" id="cp" style="width:40px;"></s:textfield>页

<a href="#" onclick="formSMT(document.getElementById('cp').value)">go</a>
<br/>
</div>
<script type="text/javascript">
var maxPage = <s:property value="p.maxPage"/>;
var listSize = <s:property value="p.listSize"/>;
var currentPage = <s:property value="p.currentPage"/>;
var pageSize = <s:property value="p.pageSize"/>;
var formId = "<%= request.getParameter("formId") %>";
document.getElementById("maxPage").innerHTML = maxPage;
document.getElementById("listSize").innerHTML = listSize;
document.getElementById("pageSize").innerHTML = pageSize;
function formSMT(cp){
	document.getElementById("cp").value = cp;
	document.getElementById(formId).submit();
}

if(maxPage < 10){
	for(var i = 1 ; i <= maxPage ; i++){
		var lk = document.createElement("a");
		lk.setAttribute("cp",i);
		lk.innerHTML = i;
		lk.href = "#";
		document.getElementById("pages").appendChild(lk);
		if (i == currentPage){
			lk.className = "current";		
		}else{
			lk.onclick = function(){
				formSMT(this.getAttribute("cp"));
			}
		}
	}
}else{
	if(currentPage<=5){
		for(var i = 1 ; i <= 10 ; i++){
			var lk = document.createElement("a");
			lk.setAttribute("cp",i);
			lk.innerHTML = i;
			lk.href = "#";
			document.getElementById("pages").appendChild(lk);
			if (i == currentPage){
				lk.className = "current";		
			}else{
				lk.onclick = function(){
					formSMT(this.getAttribute("cp"));
				}
			}
		}
	}else{
		for(var i = currentPage-5,j=0 ; j < 10 && (i+j <= maxPage) ; j++){
			var lk = document.createElement("a");
			lk.setAttribute("cp",i+j);
			lk.innerHTML = i+j;
			lk.href = "#";
			document.getElementById("pages").appendChild(lk);
			if ( currentPage == i+j){
				lk.className = "current";		
			}else{
				lk.onclick = function(){
					formSMT(this.getAttribute("cp"));
				}
			}
		}
	}
}






</script>
