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

var logs= ${logs};
alert(logs)

function initData(logs){
	
};
$(function(){
	initData(logs);
	$(".select2").select2({
		placeholder: 'Select an option',
		allowClear: true
	})
	  
	  
	  /*
	$("#logDate").datetimepicker({
		minView: "year", //选择日期后，不会再跳转去选择时分秒 
		format : 'yyyy-mm-dd',
		autoclose : true,
		orientation : 'right',
		language: "zh-CN",
		startDate: "1900-01-01",
		endDate: "2090-01-01",
		startView: 'month',
		minView: 'month'
	});*/
	
	
	 $('input').each(function(){
	    var self = $(this),
	      label = self.next(),
	      label_text = label.text();

	    label.remove();
	    self.iCheck({
	      checkboxClass: 'icheckbox_line-blue',
	      radioClass: 'iradio_line-blue',
	      insert: '<div class="icheck_line-icon"></div>' + label_text
	    });
	  });
	 
	 
	 $('#logDate').datetimepicker({
			minView: "year", //选择日期后，不会再跳转去选择时分秒 
			format : 'yyyy-mm-dd',
			autoclose : true,
			orientation : 'right',
			language: "zh-CN",
			startDate: "1900-01-01",
			endDate: "2090-01-01",
			startView: 'month',
			minView: 'month'
		});
})



</script>
</head>
<body>


<div class="container-fluid">
<h1>User Log</h1>
<div class="row">
<div class="row">
        		
		<div class="form-group">
              <label class="col-md-4 text-right">Project</label>
              <div class="col-md-8">
                  <select id="projectList" class="select2">
					<option value="SSMIS-A1">SSMIS-A1</option>
					<option value="SSMIS-EFORM">SSMIS-EFORM</option>
                  </select>
              </div>
          </div>
               
		<div class="form-group">
                  <div class="input-inline input-medium">
                      <div class="input-append date" id="logDate" data-date="2012-02-02" data-date-format="dd-mm-yyyy">
					    <input size="16" type="hidden" value="2012-02-02" readonly >
					    <span class="add-on"><i class="icon-th"></i></span>
					</div>
                  </div>
         </div>
	</div>
	
</div>
<div class="row">



<!-- BEGIN VALIDATION STATES-->
<div class="portlet-body form">
   <form class="form-horizontal" id="defaultForm"  role="form">
       <div class="form-body">
          
           <hr/>
       		<div class="row">
               <label class="col-md-1">
                 <select id="user_xx" class="select2" style="width:100%;">
					<option value="张三三">张三三</option>
					<option value="李四">李四</option>
                  </select> 
               </label>
               <div class="col-md-1">
					<input type="checkbox" checked="checked">
					<label>在岗</label>
               </div>
               <div class="col-md-2">
					<div class="input-inline input-medium">
						<div class="input-group">
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
							<input id="blIssueUser" name="blIssueUser" class="form-control" style="width:70px;"  placeholder="工时"/> 
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
						</div>
					</div>
               </div>
              
				<div class="col-md-8">
					<div class="input-group">
						<span class="input-group-addon">
							<i class="fa fa-clock-o"></i>
						</span>
						<input  name="userLog" class="form-control"   placeholder="日志"/> 
					</div>
				</div>
           </div>
           <div class="form-group">
               <label class="col-md-1">张三  </label>
               <div class="col-md-2">
					<input type="checkbox">
					<label>请假</label>
               </div>
               <div class="col-md-2">
					<div class="input-inline input-medium">
						<div class="input-group">
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
							<input id="blIssueUser" name="blIssueUser" class="form-control" style="width:70px;"  placeholder="工时"/> 
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
						</div>
					</div>
               </div>
				<div class="col-md-7">
					<div class="input-group">
						<span class="input-group-addon">
							<i class="fa fa-clock-o"></i>
						</span>
						<input  name="userLog" class="form-control"   placeholder="日志"/> 
					</div>
				</div>
           </div>
           
           <div class="form-group">
               <label class="col-md-1">张三  </label>
               <div class="col-md-2">
					<input type="checkbox">
					<label>请假</label>
               </div>
               <div class="col-md-2">
					<div class="input-inline input-medium">
						<div class="input-group">
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
							<input id="blIssueUser" name="blIssueUser" class="form-control" style="width:70px;"  placeholder="工时"/> 
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
						</div>
					</div>
               </div>
				<div class="col-md-7">
					<div class="input-group">
						<span class="input-group-addon">
							<i class="fa fa-clock-o"></i>
						</span>
						<input  name="userLog" class="form-control"   placeholder="日志"/> 
					</div>
				</div>
           </div>
           
           <div class="form-group">
               <label class="col-md-1">张三  </label>
               <div class="col-md-2">
					<input type="checkbox">
					<label>请假</label>
               </div>
               <div class="col-md-2">
					<div class="input-inline input-medium">
						<div class="input-group">
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
							<input id="blIssueUser" name="blIssueUser" class="form-control" style="width:70px;"  placeholder="工时"/> 
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
						</div>
					</div>
               </div>
				<div class="col-md-7">
					<div class="input-group">
						<span class="input-group-addon">
							<i class="fa fa-clock-o"></i>
						</span>
						<input  name="userLog" class="form-control"   placeholder="日志"/> 
					</div>
				</div>
           </div>
           
           <div class="form-group">
               <label class="col-md-1">张三  </label>
               <div class="col-md-2">
					<input type="checkbox">
					<label>请假</label>
               </div>
               <div class="col-md-2">
					<div class="input-inline input-medium">
						<div class="input-group">
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
							<input id="blIssueUser" name="blIssueUser" class="form-control" style="width:70px;"  placeholder="工时"/> 
							<span class="input-group-addon">
                               <i class="fa fa-clock-o"></i>
                            </span>
						</div>
					</div>
               </div>
				<div class="col-md-7">
					<div class="input-group">
						<span class="input-group-addon">
							<i class="fa fa-clock-o"></i>
						</span>
						<input  name="userLog" class="form-control"   placeholder="日志"/> 
					</div>
				</div>
           </div>
			
           
           
           <div class="form-actions">
           <div class="row">
               <div class="col-md-offset-3 col-md-9">
                   <button type="submit" class="btn green">Submit</button>
                   <button type="button" class="btn default">Cancel</button>
               </div>
           </div>
           </div>
           
           
           
   </form>
</div>                  
<!-- END VALIDATION STATES-->

</div>
</div>
</body>
</html>