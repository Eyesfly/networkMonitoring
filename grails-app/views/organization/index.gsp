
<!DOCTYPE html>
<html>
<head>
	<g:if test="${!request.xhr}">
		<meta name="layout" content="main">
	</g:if>
	<g:include action="js"/>
	<title>机构管理</title>
</head>
<body>
<div class="panel panel-primary">
	<div class="panel-heading">机构管理</div>
	<div class="panel-body">
		<div id="orgTreeDiv" style="margin-top: 10px;max-height: 450px;overflow-y: scroll;"></div>
	</div>
</div>
</body>
</html>
