<html>
<head>
	%{--<meta name='layout' content='main'/>--}%
	<title><g:message code="springSecurity.login.title"/></title>
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
					<form id="loginForm" action='${postUrl}' method="post" role="form" onsubmit="return checkFormAndSubmit();" class="form-horizontal ng-pristine ng-valid">
						<div class="form-group" style="margin-left:0;margin-right:0">
							<input type='text' autocomplete="off" class="form-control ng-pristine ng-valid ng-touched" onblur="getVerifyCode()" onpropertychange="loginButton()"  oninput="loginButton()" placeholder="请输入用户名" name='j_username' id='username'/>
						</div>
						<div class="form-group" style="margin-left:0;margin-right:0">
							<input type='password' autocomplete="off" value="" class="form-control ng-pristine ng-valid ng-touched" onpropertychange="loginButton()" oninput="loginButton()" placeholder="请输入密码" name='j_password' id='password'/>
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
%{--<div id='login'>
	<div class='inner'>
		<div class='fheader'>登录</div>

		<g:if test='${flash.message}'>
			<div class='login_message'>${flash.message}</div>
		</g:if>

		<form action='${postUrl}' method='POST' id='loginForm' class='cssform' autocomplete='off'>
			<p>
				<label for='username'>用户名:</label>
				<input type='text' class='text_' name='j_username' id='username'/>
			</p>

			<p>
				<label for='password'>密码:</label>
				<input type='password' class='text_' name='j_password' id='password'/>
			</p>

			<p>
				<input type='submit' id="submit" value='登录'/>
			</p>
		</form>
	</div>
</div>--}%
<script type='text/javascript'>
(function() {
	document.forms['loginForm'].elements['j_username'].focus();
})();
</script>
</body>
</html>
