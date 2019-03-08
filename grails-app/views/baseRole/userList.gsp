<!DOCTYPE html>
<html>
<head>
    <g:if test="${!request.xhr}">
        <meta name="layout" content="main">
    </g:if>
    <g:include action="js"/>
    <title>分配用户</title>
</head>
<body>
    <table style="width: 100%;">
        <tr>
            <td style="vertical-align: top;">
                <table class="col-md-12" style="margin-bottom: 15px;">
                    <tr>
                        <td width="30%">
                            <input type="hidden" id="roleId" value="${baseRole?.id}"/>
                            当前角色:<span style="font-weight: bold;">${baseRole?.name}</span>&emsp;&emsp;
                            <input type="text" id="keywords" placeholder="请输入关键字" class="input">&nbsp;
                            <button type="button" class="btn btn-blue" onclick="doSearch1();">搜索</button>&nbsp;&nbsp;
                            <button class="btn btn-primary" type="button" onclick="showOrgUserModal('${baseRole?.id}')">分配用户</button>&nbsp;&nbsp;
                            <button class="btn btn-primary" type="button" onclick="backRoleManager();">返回</button>&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
                <div class="mt15">
                    <table id="baseUserTable" data-toggle="table" data-url="${request.contextPath}/baseRole/userJson/${baseRole?.id}" data-pagination="true"
                           data-id-field="id"  data-unique-id="id" data-sort-order="desc" data-show-columns="false"
                           class="table table-striped table-hover bootstrapTable" data-side-pagination="server" data-cache="false"
                           data-query-params="queryUserParams">
                        <thead>
                        <tr>
                            <th data-field="id" data-formatter="indexFormatter">序号</th>
                            <th data-field="username">账号</th>
                            <th data-field="realName">姓名</th>
                            %{--<th data-field="ascripteOrg">归属机构</th>--}%
                            <th data-field="organization">所属单位</th>
                            <th data-field="mobile">联系方式</th>
                            <th data-field="id" data-formatter="userOperateFormatter">操作</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </td>
        </tr>
    </table>

    <div class="modal" id="orgUserModal" tabindex="-1" role="dialog" aria-labelledby="orgUserModalHead" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content" >
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">选择用户</h4>
                </div>
                <div class="modal-body" id="orgUserModalBody">

                </div>
                <div class="modal-footer">
                    <button class="btn btn-blue margin" type="button" onclick="saveUserRole()" >确定</button>
                    <button class="btn btn-blue margin" type="button" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
