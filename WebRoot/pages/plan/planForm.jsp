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

<!-- 
<link href="mybootstrap/css/mybootstrap.css" rel="stylesheet" type="text/css" />
-->
<link href="${ctx}/js/mybootstrap/css/components.min.css" rel="stylesheet" type="text/css" /></head>
<body>

<h1>Form</h1>
<div class="container-fluid">

<div class="row">
<div class="col-md-2"></div>
<div class="col-md-6">


<h4 class="text-primary"><b>本次执行信息</b></h4>
		
		<form  id="defaultForm" class="form-horizontal">
			<div class="form-group form-md-line-input ">
					<label class="col-xs-6 control-label" for="planProgress">计划百分比</label>
					<div class="col-xs-6">
						<input type="text" class="form-control" name="planProgress" id="planProgress" placeholder="">
						<div class="form-control-focus"> </div>
						<span class="help-block">xx</span>
				</div>
			</div>			
			
			<div class="form-group form-md-line-input row">
					<label class="col-xs-6 control-label" for="finishProgress">实际百分比</label>
					<div class="col-xs-6">
						<input type="text" class="form-control" name="finishProgress" id="finishProgress" placeholder="">
						<div class="form-control-focus"> </div>
						<span class="help-block">xx</span>
					</div>
			</div>
			
			<div class="form-group form-md-line-input row">
				<div class="row">
					<label class="col-xs-6 control-label" for="planNote">备注</label>
					<div class="col-xs-6">
						<input type="text" class="form-control" name="planNote" id="planNote" placeholder="">
						<div class="form-control-focus"> </div>
						<span class="help-block">xx</span>
					</div>
				</div>
			</div>	
					
		</form>
		
		
		
		
		
		
		
		
		
		
		
		
                            <!-- BEGIN VALIDATION STATES-->
                            <div class="portlet light portlet-fit portlet-form bordered">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class=" icon-layers font-green"></i>
                                        <span class="caption-subject font-green sbold uppercase">Validation States</span>
                                    </div>
                                    <div class="actions">
                                        <a class="btn btn-circle btn-icon-only btn-default" href="javascript:;">
                                            <i class="icon-cloud-upload"></i>
                                        </a>
                                        <a class="btn btn-circle btn-icon-only btn-default" href="javascript:;">
                                            <i class="icon-wrench"></i>
                                        </a>
                                        <a class="btn btn-circle btn-icon-only btn-default" href="javascript:;">
                                            <i class="icon-trash"></i>
                                        </a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- BEGIN FORM-->
                                    <form action="#" class="form-horizontal">
                                        <div class="form-body">
											 <div class="form-group form-md-line-input has-success">
                                                <label class="col-md-3 control-label" for="form_control_1">Month</label>
                                                <div class="col-md-9">
                                                    <select class="form-control" name="">
                                                        <option value="">Option 1</option>
                                                        <option value="">Option 2</option>
                                                        <option value="">Option 3</option>
                                                    </select>
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>
											<div class="form-group form-md-line-input has-success">
                                                <label class="col-md-3 control-label" for="form_control_1">Week</label>
                                                <div class="col-md-9">
                                                    <select class="form-control" name="">
                                                        <option value="">Option 1</option>
                                                        <option value="">Option 2</option>
                                                        <option value="">Option 3</option>
                                                    </select>
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>
											<div class="form-group form-md-line-input has-error">
                                                <label class="col-md-3 control-label" for="form_control_1">Textarea</label>
                                                <div class="col-md-9">
                                                    <textarea class="form-control" name="" rows="3"></textarea>
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>


                                            <div class="form-group form-md-line-input">
                                                <label class="col-md-3 control-label" for="form_control_1">Default State</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" placeholder="">
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-error">
                                                <label class="col-md-3 control-label" for="form_control_1">Error State</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" placeholder="">
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-warning">
                                                <label class="col-md-3 control-label" for="form_control_1">Warning State</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" placeholder="">
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-success">
                                                <label class="col-md-3 control-label" for="form_control_1">Success State</label>
                                                <div class="col-md-9">
                                                    <input type="text" class="form-control" placeholder="">
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-error">
                                                <label class="col-md-3 control-label" for="form_control_1">Left icon</label>
                                                <div class="col-md-9">
                                                    <div class="input-icon">
                                                        <input type="text" class="form-control" placeholder="Left icon">
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">Some help goes here...</span>
                                                        <i class="fa fa-bell-o"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-success">
                                                <label class="col-md-3 control-label" for="form_control_1">Right icon</label>
                                                <div class="col-md-9">
                                                    <div class="input-icon right">
                                                        <input type="text" class="form-control" placeholder="Right icon">
                                                        <div class="form-control-focus"> </div>
                                                        <span class="help-block">Some help goes here...</span>
                                                        <i class="icon-user"></i>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-warning">
                                                <label class="col-md-3 control-label" for="form_control_1">Input Group</label>
                                                <div class="col-md-9">
                                                    <div class="input-group has-success">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-envelope"></i>
                                                        </span>
                                                        <input type="text" class="form-control" placeholder="Email Address">
                                                        <div class="form-control-focus"> </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-success">
                                                <label class="col-md-3 control-label" for="form_control_1">Input Group</label>
                                                <div class="col-md-9">
                                                    <div class="input-group has-success">
                                                        <input type="text" class="form-control" placeholder="Email Address">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-envelope"></i>
                                                        </span>
                                                        <div class="form-control-focus"> </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-error">
                                                <label class="col-md-3 control-label" for="form_control_1">Input Group</label>
                                                <div class="col-md-9">
                                                    <div class="input-group">
                                                        <div class="input-group-control">
                                                            <input type="text" class="form-control" placeholder="Placeholder"> </div>
                                                        <span class="input-group-btn btn-right">
                                                            <button type="button" class="btn green-haze dropdown-toggle" data-toggle="dropdown" aria-expanded="false"> Action
                                                                <i class="fa fa-angle-down"></i>
                                                            </button>
                                                            <ul class="dropdown-menu pull-right" role="menu">
                                                                <li>
                                                                    <a href="javascript:;">Action</a>
                                                                </li>
                                                                <li>
                                                                    <a href="javascript:;">Another action</a>
                                                                </li>
                                                                <li>
                                                                    <a href="javascript:;">Something else here</a>
                                                                </li>
                                                                <li class="divider"> </li>
                                                                <li>
                                                                    <a href="javascript:;">Separated link</a>
                                                                </li>
                                                            </ul>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-error">
                                                <label class="col-md-3 control-label" for="form_control_1">Input Group</label>
                                                <div class="col-md-9">
                                                    <div class="input-group input-group-sm">
                                                        <span class="input-group-btn btn-left">
                                                            <button class="btn red-intense" type="button">Go!</button>
                                                        </span>
                                                        <div class="input-group-control">
                                                            <input type="text" class="form-control input-sm" placeholder=".input-sm"> </div>
                                                        <span class="input-group-btn btn-right">
                                                            <button class="btn green-haze" type="button">Go!</button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-success">
                                                <label class="col-md-3 control-label" for="form_control_1">Dropdown</label>
                                                <div class="col-md-9">
                                                    <select class="form-control" name="">
                                                        <option value="">Option 1</option>
                                                        <option value="">Option 2</option>
                                                        <option value="">Option 3</option>
                                                    </select>
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-line-input has-error">
                                                <label class="col-md-3 control-label" for="form_control_1">Dropdown</label>
                                                <div class="col-md-9">
                                                    <select class="form-control" name="">
                                                        <option value="">Option 1</option>
                                                        <option value="">Option 2</option>
                                                        <option value="">Option 3</option>
                                                    </select>
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group form-md-line-input has-success">
                                                <label class="col-md-3 control-label" for="form_control_1">Textarea</label>
                                                <div class="col-md-9">
                                                    <textarea class="form-control" name="" rows="3"></textarea>
                                                    <div class="form-control-focus"> </div>
                                                    <span class="help-block">Some help goes here...</span>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-checkboxes">
                                                <label class="col-md-3 control-label" for="form_control_1">Checkboxes</label>
                                                <div class="col-md-9">
                                                    <div class="md-checkbox-list">
                                                        <div class="md-checkbox">
                                                            <input type="checkbox" id="checkbox1_1" class="md-check">
                                                            <label for="checkbox1_1">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 1 </label>
                                                        </div>
                                                        <div class="md-checkbox">
                                                            <input type="checkbox" id="checkbox1_2" class="md-check">
                                                            <label for="checkbox1_2">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 2 </label>
                                                        </div>
                                                        <div class="md-checkbox">
                                                            <input type="checkbox" id="checkbox1_211" class="md-check">
                                                            <label for="checkbox1_211">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 3 </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-checkboxes has-error">
                                                <label class="col-md-3 control-label" for="form_control_1">Checkboxes(error)</label>
                                                <div class="col-md-9">
                                                    <div class="md-checkbox-inline">
                                                        <div class="md-checkbox">
                                                            <input type="checkbox" id="checkbox1_3" class="md-check">
                                                            <label for="checkbox1_3">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 1 </label>
                                                        </div>
                                                        <div class="md-checkbox">
                                                            <input type="checkbox" id="checkbox1_4" class="md-check" checked="">
                                                            <label for="checkbox1_4">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 2 </label>
                                                        </div>
                                                        <div class="md-checkbox">
                                                            <input type="checkbox" id="checkbox1_5" class="md-check">
                                                            <label for="checkbox1_5">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 3 </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-radios has-success">
                                                <label class="col-md-3 control-label" for="form_control_1">Radios(success)</label>
                                                <div class="col-md-9">
                                                    <div class="md-radio-list">
                                                        <div class="md-radio">
                                                            <input type="radio" id="checkbox1_6" name="radio211" class="md-radiobtn">
                                                            <label for="checkbox1_6">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 1 </label>
                                                        </div>
                                                        <div class="md-radio">
                                                            <input type="radio" id="checkbox1_7" name="radio211" class="md-radiobtn" checked="">
                                                            <label for="checkbox1_6">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 2 </label>
                                                        </div>
                                                        <div class="md-radio">
                                                            <input type="radio" id="checkbox1_611" name="radio211" class="md-radiobtn" checked="">
                                                            <label for="checkbox1_611">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 3 </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group form-md-radios has-warning">
                                                <label class="col-md-3 control-label" for="form_control_1">Radios(warning)</label>
                                                <div class="col-md-9">
                                                    <div class="md-radio-inline">
                                                        <div class="md-radio">
                                                            <input type="radio" id="checkbox1_8" name="radio2" class="md-radiobtn">
                                                            <label for="checkbox1_8">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 1 </label>
                                                        </div>
                                                        <div class="md-radio">
                                                            <input type="radio" id="checkbox1_9" name="radio2" class="md-radiobtn" checked="">
                                                            <label for="checkbox1_9">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 2 </label>
                                                        </div>
                                                        <div class="md-radio">
                                                            <input type="radio" id="checkbox1_10" name="radio2" class="md-radiobtn">
                                                            <label for="checkbox1_10">
                                                                <span></span>
                                                                <span class="check"></span>
                                                                <span class="box"></span> Option 3 </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <a href="javascript:;" class="btn green">Submit</a>
                                                    <a href="javascript:;" class="btn default">Cancel</a>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <!-- END FORM-->
                                </div>
                            </div>
                            <!-- END VALIDATION STATES-->
                        </div>
<div class="col-md-6"></div>
</div>
</div>
</body>
</html>