
<%@ page import="com.eyesfly.core.BaseRole" %>
<!DOCTYPE html>
<html>
	<head>
		<g:if test="${!request.xhr}">
			<meta name="layout" content="main">
		</g:if>
		<g:include action="js"/>
		<title>角色管理</title>
	</head>
	<body>
	<div class="searchBox mt15">
		<form action="" class="inline-form fl">
			<div class="form-group mr0">
				<input type="text" id="keywords" placeholder="请输入关键字" class="input">
			</div>
			<button type="button" class="btn btn-blue" onclick="doSearch();">搜索</button>
		</form>
		<div class="fr">
			<div class="btn btn-added" onclick="newRole();">新增角色</div>　
		</div>
		<div class="clear"></div>
	</div>
	<div class="mt15">
		<table id="baseRoleTable" data-toggle="table" data-url="${request.contextPath}/baseRole/json" data-pagination="true"
			   data-id-field="id"  data-unique-id="id" data-sort-order="desc" data-show-columns="false"
			   class="table table-striped table-hover bootstrapTable" data-side-pagination="server" data-cache="false"
			   data-query-params="queryParams">
			<thead>
			<tr>
				%{--<th data-field="id" data-formatter="indexFormatter">序号</th>--}%
				<th data-field="name">角色名称</th>
				<th data-field="description">角色描述</th>
				%{--<th data-field="organization.title">机构名称</th>
				<th data-field="serviceCategory.title">板块名称</th>--}%
				<th data-field="id" data-formatter="operateFormatter">操作</th>
			</tr>
			</thead>
		</table>
	</div>
	<div class="modal" id="treeModal" tabindex="-1" role="dialog" aria-labelledby="passModalHead" aria-hidden="true" data-backdrop="static" data-keyboard="false">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title">关联功能</h4>
				</div>
				<div class="modal-body" id="treeModalBody">

				</div>
				<div class="modal-footer">
					<button class="btn btn-blue margin" type="button" onclick="saveConfigure();" >保存</button>
					<button class="btn btn-blue margin" type="button" class="close" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>
