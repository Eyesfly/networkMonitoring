<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <g:if test="${!request.xhr}">
        <meta name="layout" content="main">
    </g:if>
    <g:include action="js"/>
    %{--<link rel="stylesheet" href="${request.contextPath}/js/bootstrap-table-pageJump/bootstrap-table-pagejump.css">--}%
    %{--<script src="${request.contextPath}/js/bootstrap-table-pageJump/bootstrap-table-pagejump.js"></script>--}%
    <title></title>
    <script type="text/javascript">
        var pageNumber = ${(params.offset?.toLong()?:0)/(params.max?.toLong()?:10)+1};
        $("#newsTable").bootstrapTable({
            pageNumber:pageNumber
        });
    </script>
</head>

<body>
<div class="searchBox mt15">
    <input type="hidden" name="categoryId" id="categoryId" value="${category?.id}"/>
    <form action="" class="inline-form fl">
        <div class="form-group">
            <select class="form-control" id="status" >
                <option value="">选择状态</option>
                <option value="草稿">草稿</option>
                <option value="发布">发布</option>
                <option value="撤回">撤回</option>
            </select>
        </div>
        <div class="form-group">
            <input type="text" id="keywords" placeholder="请输入关键字" class="input" value="${params?.keywords}">
        </div>
        <button type="button" class="btn btn-blue" onclick="doSearch();">搜索</button>
    </form>
    <div class="fr">
        <div class="btn btn-added" onclick="newNews();">新增</div>　
        <div class="btn btn-delete" onclick="ajaxDeletes();">删 除</div>
    </div>
    <div class="clear"></div>
</div>
<table id="newsTable" data-toolbar="#toolbar" data-toggle="table" data-url="${request.contextPath}/news/json" data-pagination="true"
       data-id-field="id"  data-unique-id="id" data-sort-order="desc" data-show-columns="false"
       class="table table-striped table-hover bootstrapTable" data-side-pagination="server" data-cache="false"
       data-query-params="queryParams">
    <thead>
    <tr>
        <th data-checkbox="true"></th>
        <th data-field="id" data-formatter="indexFormatter">序号</th>
        <th data-field="title" data-width="35%" data-formatter="titleFormatter">标题</th>
        <th data-field="publishDate">时间</th>
        <th data-field="status">状态</th>
        <th data-field="id" data-formatter="operateFormatter">操作</th>
    </tr>
    </thead>
</table>


</body>
</html>