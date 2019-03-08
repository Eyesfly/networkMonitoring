
<%@ page import="com.eyesfly.core.BaseRole" %>
<!DOCTYPE html>
<html>
	<head>
		<g:if test="${!request.xhr}">
			<meta name="layout" content="main">
		</g:if>
		<g:include action="js"/>
		<title>用户管理</title>
	</head>
	<body>
	<div class="searchBox mt15">
		<form action="" class="inline-form fl">
			<div class="form-group mr0">
				<input type="text" id="keywords" placeholder="请输入关键字" class="input">
			</div>
			<button type="button" class="btn btn-blue" onclick="doSearch();">搜索</button>
			%{--<button type="button" class="btn btn-blue" onclick="showImportModal();">导入</button>
			<button type="button" class="btn btn-blue" onclick="exportUser();">导出</button>--}%
		</form>
		<div class="fr">
			<div class="btn btn-added" onclick="newUser();">新增用户</div>　
			%{--<div class="btn btn-delete" onclick="delAll();">删 除</div>--}%
		</div>
		<div class="clear"></div>
	</div>
	<div class="mt15">
		<table id="baseUserTable" data-toggle="table" data-url="${request.contextPath}/baseUser/json" data-pagination="true"
			   data-id-field="id"  data-unique-id="id" data-sort-order="desc" data-show-columns="false"
			   class="table table-hover table-no-bordered bootstrapTable" data-striped="true" data-side-pagination="server" data-cache="false"
			   data-query-params="queryParams">
			<thead>
			<tr>
				<th data-checkbox="true">全选</th>
				%{--<th data-field="id" data-formatter="indexFormatter">序号</th>--}%
				<th data-field="username">账号</th>
				<th data-field="realName">姓名</th>
				%{--<th data-field="ascripteOrg">归属机构</th>--}%
				<th data-field="organization">所属单位</th>
				<th data-field="dateCreated">创建时间</th>
				<th data-field="mobile">联系方式</th>
				<th data-field="id" data-formatter="operateFormatter">操作</th>
			</tr>
			</thead>
		</table>
	</div>

		<div class="modal" id="importModal" tabindex="-1" role="dialog" aria-labelledby="importModalHead" aria-hidden="true" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog">
				<div class="modal-content">

						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
							<h4 class="modal-title">导入用户</h4>
						</div>
						<div class="modal-body">
							<form id="uploadForm1" method="post" enctype="multipart/form-data">
								<div >
									<span>检察人员导入</span><a style="font-size: 13px;" href="${request.contextPath}/baseUser/downTemplate/1">下载模板（检察人员）</a><br/>
									<input style="display: inline;" type="file" name="userData" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
									<button class="btn btn-blue margin" type="button" onclick="importExcel('1');" style="margin-top: 5px;">导入检察人员</button>
								</div>
							</form>

							<form id="uploadForm2" method="post" enctype="multipart/form-data">
								<div style="margin-top: 20px;border-top: 1px solid #E5E5E5;">
									<span>专家导入</span><a style="font-size: 13px;" href="${request.contextPath}/baseUser/downTemplate/2">下载模板（专家）</a><br/>
									<input style="display: inline;" type="file" name="userData" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
									<button class="btn btn-blue margin" type="button" onclick="importExcel('2');" style="margin-top: 5px;">导入专家</button>
								</div>
							</form>
							<div style="line-height: 34px;padding-left: 0;color:#aaa;">
								仅允许导入“xls”或“xlsx”格式文件！
							</div>

						</div>
						<div class="modal-footer">
							<button class="btn btn-blue margin" type="button" class="close" data-dismiss="modal">关闭</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<div class="modal fade" id="operateModal" tabindex="-1" role="dialog" aria-labelledby="operateModalHead" aria-hidden="true" >
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
						<h4 class="modal-title">信息提示</h4>
					</div>
					<div class="modal-body" id="operateModalBody" style="height: 100px;max-height: 400px;overflow-y: scroll;">

					</div>

					<div class="modal-footer">
						<button class="btn btn-blue margin" data-dismiss="modal" type="button">
							<span class="glyphicon glyphicon-remove"></span>
							关闭
						</button>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
