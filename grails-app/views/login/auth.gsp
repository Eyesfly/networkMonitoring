<html>
<head>
	%{--<meta name='layout' content='main'/>--}%
	<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
	<title>区域工业环境大数据在线监测系统</title>

	<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/bootstrap-3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${request.contextPath}/js/bootstrap-3.3.7/css/font-awesome.min.css">
	<style type='text/css' media='screen'>
	.login-panel {
		margin-top: 25%;
	}
	.btn-lg {
		padding: 10px 16px;
		font-size: 18px;
		line-height: 1.3333333;
		border-radius: 6px;
	}
	</style>
</head>

<body>
<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">请登录</h3>
				</div>
				<div class="panel-body">
					<form id="loginForm" action='${postUrl}' method="post" role="form" class="form-horizontal ng-pristine ng-valid">
						<div class="form-group" style="margin-left:0;margin-right:0">
							<input type='text' autocomplete="off" class="form-control ng-pristine ng-valid ng-touched" placeholder="请输入用户名" name='j_username' id='username'/>
						</div>
						<div class="form-group" style="margin-left:0;margin-right:0">
							<input type='password' autocomplete="off" value="" class="form-control ng-pristine ng-valid ng-touched" placeholder="请输入密码" name='j_password' id='password'/>
						</div>
						<input type='submit' id="login" class="btn btn-lg btn-primary btn-block" value='登录'/>
					</form>
				</div>
			</div>
			%{--alert-info--}%
			<div id="message">
				<g:if test='${flash.message}'>
					<div class="alert alert-dismissible ng-binding alert-danger" role="alert">
						${flash.message}
					</div>
				</g:if>
			</div>


		</div>
	</div>
</div>
<script type='text/javascript'>
(function() {
	document.forms['loginForm'].elements['j_username'].focus();
})();
</script>
</body>
</html>
