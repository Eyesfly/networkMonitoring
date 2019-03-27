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
            str.push('<a class="btn btn-primary" href="javascript:addPassageway(\''+row.id+'\')">添加通道</a>&nbsp;&nbsp;');
            return str.join('');
        }
        function addPassageway(id){
            loadRemotePage('${request.contextPath}/passageway/index',{id:id},'监测站-采集设备','添加通道');
        }
        function delCa(value){
            var obj = new Object()
            obj.id = value;
            $.post("${request.contextPath}/measuringPoint/delete",obj,function(data,textStatus){
                if(data.res){
                    alert("删除成功");
                    $("#measuringPointTable").bootstrapTable("refresh",[]);
                }
            },'json');
        }
        function createWord(id){
            $.post("${request.contextPath}/measuringPoint/create",{id:id},function(data,status){
                $("#monContent").html(data);
                $('#feedbackModal').modal('show');
            },"html");
        }
        function editCa(id){
           $.post("${request.contextPath}/measuringPoint/edit",{id:id},function(data,status){
               $("#monContent").html(data);
               $('#feedbackModal').modal('show');
           },"html");
        }
        function saveOrUpdate(){
            if($("#infoForm").valid()){
                $("#infoForm").form('submit', {
                    url: "${request.contextPath}/measuringPoint/saveOrUpdate",
                    success: function (data) {
                        var data = eval('(' + data + ')');
                        $("#messageModalBody").html(data.message);
                        $("#messageModal").modal('show');
                        if (data.res) {
                            $("#measuringPointTable").bootstrapTable("refresh",[]);
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
<table id="measuringPointTable" data-toolbar="#toolbar" data-toggle="table" data-url="${request.contextPath}/measuringPoint/json/${params.id}" data-pagination="true"
       data-id-field="id"  data-unique-id="id" data-sort-name="id" data-sort-order="asc" data-show-columns="false"
       class="table table-striped table-hover bootstrapTable" data-side-pagination="client" data-cache="false"
       data-query-params="queryParams" data-search="true">
    <thead>
    <tr>
        <th data-field="id" data-width="100" data-formatter="indexFormatter">序号</th>
        <th data-field="devid">设备标识</th>
        <th data-field="name">设备名称</th>
        <th data-field="ip">设备IP</th>
        <th data-field="id"  data-width="300" data-formatter="operateFormatter">操作</th>
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