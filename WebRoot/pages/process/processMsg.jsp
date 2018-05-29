<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../../../pub/TagLib.jsp"%>

<!-- Modal 流程扭转信息提示 -->
<div class="modal fade" id="processMsgModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">流程扭转信息提示</h4>
      </div>
      <div class="modal-body" id="processMsgModalMsg">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
function showProcessMsg(msg){
	$('#processMsgModal').modal('show')
	$("#processMsgModalMsg").html(  msg + "<br/>" + $("#processMsgModalMsg").html());
}

function clearProcessMsg(){
	$("#processMsgModalMsg").html("");
}

$(function(){
	$('#processMsgModal').on('hidden.bs.modal', function (e) {
		clearProcessMsg()
	})
})
</script>
