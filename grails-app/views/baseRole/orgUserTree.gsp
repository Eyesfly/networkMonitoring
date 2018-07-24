<%@ page import="com.eyesfly.core.BaseUserBaseRole" %>
<script type="text/javascript">
    $(function () {
        $("#orgUserTreeDiv").on('select_node.jstree', function (e, data) {
            var list = $("#permission").val().split(",");
            if($.inArray(data.node.id, list) == -1){
                list.push(data.node.id);
            }
            $("#permission").val(list.join(","));
        }).on('deselect_node.jstree', function (e, data) {
            var list = $("#permission").val().split(",");
            if($.inArray(data.node.id, list) != -1){
                list.splice($.inArray(data.node.id, list),1);
            }
            $("#permission").val(list.join(","));
        }).jstree({
            'core' : {
                'data': {
                    'url': "${request.contextPath}/baseRole/orgUserJson?roleId=${role?.id}",
                    "dataType": "json",
                    'data' : function (node) {
                        return { 'id' : node.id };
                    }
                }
            },
            "types" : {
                "user" : {
                    "icon" : "fa fa-user"
                },
                "org" : {
                    "icon" : "glyphicon glyphicon-folder-open"
                }
            },
            "plugins": ["types","wholerow","checkbox"]
        });
    });
    function saveUserRole(){
        $.post("${request.contextPath}/baseRole/saveUserRole",{roleId:$('#roleId').val(),permission:$("#permission").val()},function(data){
            $("#messageModalBody").html(data.message);
            $("#messageModal").modal('show');
            $("#orgUserModal").modal('hide');
            $("#baseUserTable").bootstrapTable("refresh",[]);
        },"json");
    }
</script>
<input type="hidden" id="roleId" value="${role?.id}"/>
<input type="hidden" id="permission" value="${permission}"/>
<div id="orgUserTreeDiv" style="margin-top: 10px;max-height: 500px;overflow-y: scroll;"></div>
