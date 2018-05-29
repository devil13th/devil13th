<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../pub/TagLib.jsp"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap Login Form Template</title>

        <!-- CSS -->
        <link rel="stylesheet" href="${ctx}/js/bootstrap/css/bootstrap.min.css" type="text/css"/>
        <link rel="stylesheet" href="${ctx}/js/font-awesome/css/font-awesome.css" type="text/css"/>
		<link rel="stylesheet" href="${ctx}/css/pages/form-elements.css">
        <link rel="stylesheet" href="${ctx}/css/pages/style.css">


	<script>
	<c:if test="${msg != null && msg != '' }">
	var str = "${msg}";
	alert(str);
	</c:if>
	</script>
    </head>

    <body>

        <!-- Top content -->
        <div class="top-content">
        	
            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <h1><strong>Devil13th</strong> Login In</h1>
                            <div class="description">
                            	<p>
	                            	Project Management System
                            	</p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>Login to our site</h3>
                            		<p>Enter your username and password to log on:</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-lock"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="${ctx}/login/login!loginSubmit.do" method="post" class="login-form">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="username">Username</label>
			                        	<input type="text" name="username" placeholder="Username..." class="form-username form-control" id="form-username">
			                        </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="password">Password</label>
			                        	<input type="password" name="password" placeholder="Password..." class="form-password form-control" id="form-password">
			                        </div>
			                        <button type="submit" class="btn">Sign in!</button>
			                    </form>
		                    </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 social-login">
                        	<h3>...or login with:</h3>
                        	<div class="social-login-buttons">
	                        	<a class="btn btn-link-2" href="#">
	                        		<i class="fa fa-facebook"></i> Facebook
	                        	</a>
	                        	<a class="btn btn-link-2" href="#">
	                        		<i class="fa fa-twitter"></i> Twitter
	                        	</a>
	                        	<a class="btn btn-link-2" href="#">
	                        		<i class="fa fa-google-plus"></i> Google Plus
	                        	</a>
                        	</div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>


        <!-- Javascript -->
        <script src="${ctx}/js/jquery/jquery-1.11.1.min.js"></script>
        <script  src="${ctx}/js/bootstrap/js/bootstrap.js"></script>
        <script src="${ctx}/js/jquery/jquery.backstretch.js"></script>
        <script src="${ctx}/js/jquery/scripts.js"></script>
        <script src="${ctx}/js/formvalidation/js/formValidation.min.js"></script>
        <!--[if lt IE 10]>
            <script src="${ctx}/js/jquery/placeholder.js"></script>
        <![endif]-->

    </body>

</html>