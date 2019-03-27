<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/5/18
  Time: 16:20
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <g:if test="${!request.xhr}">
        <meta name="layout" content="main">
    </g:if>
    <script type="text/javascript">
        function operateFormatter(value, row, index) {
            var str = [];
            str.push('<a class="btn btn-primary" href="javascript:delCa(\''+row.id+'\')">删除</a>&nbsp;&nbsp;');
            str.push('<a class="btn btn-primary" href="javascript:editCa(\''+row.id+'\')">编辑</a>&nbsp;&nbsp;');
            return str.join('');
        }
        function typeFormatter(value, row, index){
            var obj = {"1":"加速度","2":"位移","3":"速度"}
            return obj[value];
        }
        function delCa(value){
            var obj = new Object()
            obj.id = value;
            $.post("${request.contextPath}/passageway/delete",obj,function(data,textStatus){
                if(data.res){
                    alert("删除成功");
                    $("#passagewayTable").bootstrapTable("refresh",[]);
                }
            },'json');
        }
        function createWord(id){
            $.post("${request.contextPath}/passageway/create",{id:id},function(data,status){
                $("#monContent").html(data);
                $('#feedbackModal').modal('show');
            },"html");
        }
        function editCa(id){
           $.post("${request.contextPath}/passageway/edit",{id:id},function(data,status){
               $("#monContent").html(data);
               $('#feedbackModal').modal('show');
           },"html");
        }
        function saveOrUpdate(){
            if($("#infoForm").valid()){
                $("#infoForm").form('submit', {
                    url: "${request.contextPath}/passageway/saveOrUpdate",
                    success: function (data) {
                        var data = eval('(' + data + ')');
                        $("#messageModalBody").html(data.message);
                        $("#messageModal").modal('show');
                        if (data.res) {
                            $("#passagewayTable").bootstrapTable("refresh",[]);
                        }
                        $('#feedbackModal').modal('hide');
                    }
                },"json");
            }
        }

    </script>
</head>
<div id="toolbar">
    <button class="btn btn-primary" type="button" onclick="createWord('${params.id}');">新增</button>
</div>
<table id="passagewayTable" data-toolbar="#toolbar" data-toggle="table" data-url="${request.contextPath}/passageway/json/${params.id}" data-pagination="true"
       data-id-field="id"  data-unique-id="id" data-sort-name="id" data-sort-order="asc" data-show-columns="false"
       class="table table-striped table-hover bootstrapTable" data-side-pagination="client" data-cache="false"
       data-query-params="queryParams" data-search="true">
    <thead>
    <tr>
        <th data-field="id" data-width="100" data-formatter="indexFormatter">序号</th>
        <th data-field="chanCode">通道代码</th>
        <th data-field="chanName">通道名称</th>
        <th data-field="type" data-formatter="typeFormatter">通道类型</th>
        <th data-field="unit">通道单位</th>
        <th data-field="id"  data-width="200" data-formatter="operateFormatter">操作</th>
    </tr>
    </thead>
</table>

<div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-labelledby="feedbackModalHead" aria-hidden="true" >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="feedbackModalHead">采集点（设备）信息</h4>
            </div>
            <div class="modal-body" id="monContent">

            </div>

            <div class="modal-footer">
                <button class="btn btn-default margin" onclick="saveOrUpdate()" type="button">
                    <span class="glyphicon glyphicon-check"></span>
                    确定
                </button>

                <button class="btn btn-default margin" onclick="$('#feedbackModal').modal('hide');" type="button">
                    <span class="glyphicon glyphicon-remove"></span>
                    关闭
                </button>
            </div>
        </div>
    </div>
</div>
<body>

</body>
</html>